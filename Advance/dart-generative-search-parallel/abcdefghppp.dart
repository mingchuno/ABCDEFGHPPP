import 'dart:isolate';

const OUTPUT_SIZE = 50;

enum Msg {
  hello,
  task,
  result,
  kill
}

// helper
class Comm {
  ReceivePort self = new ReceivePort();

  send(SendPort port, Msg msg, data){
    port.send([self.sendPort, msg, data]);
  }

  listen(callback){
    self.listen((data) => callback(data[0], data[1], data[2]));
  }

  close() => self.close();

  get sendPort => self.sendPort;
}

abcdefghppp(poolLen, id, base, width, [size=OUTPUT_SIZE]){
  var ansCnt = 0, batchCnt = 0, ans = [];

  var used1 = new List<bool>(base);
  var used2 = new List<bool>(base);
  for(int i=0; i<used1.length; i++) used1[i] = false;
  used1[1] = true;


  var table = new List.generate(base, (i) => new List(base));
  var tableLen = new List(base);
  var sp = new List(width);

  // for storing candidate of digits of a and b
  var N = base-2*width-1;
  var vs = new List(N);

  var N2 = N*(N-1);
  var va = new List(N2);
  var vb = new List(N2);
  var br = new List(N2);

  // EXP[i] = base^i
  var EXP = new List(width);
  EXP[0] = 1;
  for(int i=1; i<width; i++) EXP[i] = base*EXP[i-1];

  // value of e
  var e = 1;
  for(int i=0; i<width; i++) e = base*e+1;

  // just to make sure b has at least width digits
  var MIN=1;
  for(int i=1; i<width; i++) MIN = MIN*base;

  // helpers
  checkWrite(List used, int a){
    // mutable check
    for(var i=width; i-- > 0;){
      var t = a%base;
      if( used[t] ) return false;
      used[t] = true;
      a ~/= base;
    }
    return true;
  }

  solveAB(c){
    var d = e - c;
    for(var i=0; i<base; i++) used2[i] = used1[i];
    if( !checkWrite(used2, d) ) return;

    // possible digits in a and b
    for(var i=0,j=0; i<used2.length; i++) if( !used2[i] ) vs[j++] = i;

    // clear table
    for(var i=0; i<base; i++) tableLen[i] = 0;

    // O( B*B )
    var t=0;
    for(var i=0; i<vs.length; i++){
      for(var j=i+1; j<vs.length; j++){
        var v1 = vs[i], v2 = vs[j];
        var i1 = v2-v1, i2 = base+v1-v2;

        table[i1][tableLen[i1]++] = t;
        va[t] = v2; vb[t] = v1; br[t] = 0;
        t++;

        table[i2][tableLen[i2]++] = t;
        va[t] = v1; vb[t] = v2; br[t] = 1;
        t++;
      }
    }

    search(i, borrow, a, b){
      if( i == width ){
        if( a > b && b > MIN ) if( ansCnt++ < size ) ans.add([a,b,c,e-c]);
        return;
      }
      var di = sp[i] + borrow;
      if( di == base ) return;    // this implies that a0 = b0 = 0, so not a solution
      var vec = table[di], len = tableLen[di];
      for(var j=0; j<len; j++){
        var t = vec[j], a0 = va[t], b0 = vb[t];
        if( used2[a0] || used2[b0] ) continue;
        used2[a0] = used2[b0] = true;
        search(i+1, br[t], a+a0*EXP[i], b+b0*EXP[i]);
        used2[a0] = used2[b0] = false;
      }
    }

    for(var i=0, t=c; i<width; i++, t ~/= base ) sp[i] = t%base;
    search(0, 0, 0, 0);
    // due to symmetry of c and d
    c = e - c;
    for(var i=0, t=c; i<width; i++, t ~/= base ) sp[i] = t%base;
    search(0, 0, 0, 0);
  }

  // return true to break
  // generate take ~1.5sec for base=25 width=6
  // generate take ~1min30sec for base=29 width=7
  generate(w,c){
    if( w == width ){
      var d = e - c;
      if( d < c ) return true;    // due to symmetry of c and d
      // divide space
      if( batchCnt++ == id ) solveAB(c);
      if( batchCnt == poolLen ) batchCnt -= poolLen;
      return false;
    }

    // left-most digit cannot start with zero and one is used
    var start = w == 0 ? 2 : 0;
    for(int i=start; i<base; i++){
      if( used1[i] ) continue;
      used1[i] = true;
      if( generate(w+1, base*c+i) ) return true;
      used1[i] = false;
    }
    return false;
  }

  generate(0,0);

  return [ansCnt, ans];
}


void abcdefghpppTask(parent){
  var comm = new Comm();
  comm.listen((opponent, type, data){
    switch(type){
      case Msg.kill:
        comm.close();
        break;
      case Msg.task:
        var res = abcdefghppp(data['pool'], data['id'], data['base'], data['width']);
        comm.send(opponent, Msg.result, res);
        break;
    }
  });
  comm.send(parent, Msg.hello, null);
}

void abcdefghpppParallel(pool, base, width, callback){
  var comm = new Comm();
  var id = 0, killed = 0;
  var ansCnt = 0;
  var ans = [];

  comm.listen((opponent, type, data){
    switch(type){
      case Msg.hello:
        comm.send(opponent, Msg.task, {
          'pool' : pool,
          'id' : id++,
          'base' : base,
          'width' : width
        });
        break;
      case Msg.result:
        ansCnt += data[0];
        ans.addAll(data[1]);
        comm.send(opponent, Msg.kill, null);
        if( ++killed == pool ){
          callback(ansCnt, ans.take(OUTPUT_SIZE));
          comm.close();
        }
        break;
    }
  });

  // slaves
  for(var i=pool; i-- > 0;) Isolate.spawn(abcdefghpppTask, comm.sendPort);
}

dynamic elapsed(action){
  var start = new DateTime.now();
  var res = action();
  var end = new DateTime.now();
  print('Time Elapsed: ${end.difference(start)}');
  return res;
}

String formula(int base, List<int> ans){
  var sa = ans[0].toRadixString(base);
  var sb = ans[1].toRadixString(base);
  var sc = ans[2].toRadixString(base);
  var sd = ans[3].toRadixString(base);
  var se = (ans[0]-ans[1]+ans[3]).toRadixString(base);
  return [sa,'-',sb,'=',sc,', ',sc,'+',sd,'=',se].join('');
}

main(List args){
  if( args.length < 2 ){
    print('usage: <base> <width> [<pool_size=4>]');
  }
  else {
    var base = int.parse(args[0]), width = int.parse(args[1]);
    var pool = args.length > 2 ? int.parse(args[2]) : 4;

    var start = new DateTime.now();
    abcdefghpppParallel(pool, base, width, (cnt, ans){
      var end = new DateTime.now();
      var s = ans.map((x) => formula(base, x)).take(OUTPUT_SIZE).join('\n');
      print(s);
      print('result of base=$base width=$width');
      print('time elapsed: ${end.difference(start).inMicroseconds/1e6} sec');
      print('number of solution: $cnt\n');
    });

  }
}
