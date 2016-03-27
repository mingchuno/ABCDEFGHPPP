<?php
function test($a, $b, $c, $d, $e, $f, $g, $h, $p){
  return (
    ($a*10 + $b) - ($c*10 + $d) == ($e * 10 + $f) &&
    ($e*10 + $f) + ($g*10 + $h) == $p * 100 + $p * 10 + $p
  );
}
//sample 1:
//similar to orignial author
function pure_brute_force(){
    $count = 0;

    for($p=1; $p<=9; $p++){
      for($a = 1; $a<=9 ; $a++){
        if($a == $p)continue;

        for($b = 1; $b<=9 ; $b++){
          if($b == $p || $b == $a)continue;

          for($c = 1; $c<=9 ; $c++){
            if($c == $p || $c == $a || $c == $b)continue;

            for($d = 1; $d<=9 ; $d++){
              if($d == $p || $d == $a || $d == $b || $d == $c)continue;

              for($e = 1; $e<=9 ; $e++){
                if($e == $p || $e == $a || $e == $b || $e == $c || $e == $d)continue;

                for($f = 1; $f<=9 ; $f++){
                  if($f == $p || $f == $a || $f == $b || $f == $c || $f == $d || $f == $e)continue;

                  for($g = 1; $g<=9 ; $g++){
                    if($g == $p || $g == $a || $g == $b || $g == $c || $g == $d || $g == $e || $g == $f)continue;

                    for($h = 1; $h<=9 ; $h++) {
                      if ($h == $p || $h == $a || $h == $b || $h == $c || $h == $d || $h == $e || $h == $f || $h == $g) continue;

                        if (test($a, $b, $c, $d, $e, $f, $g, $h, $p)) {
                          echo 'a=' . $a . ',b=' . $b . ',c=' . $c . ',d=' . $d . ',e=' . $e . ',f=' . $f . ',g=' . $g . ',h=' . $h . ',p=' . $p . '<br>';
                        }
                        $count++;
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    echo 'search '.$count.' times';
}

pure_brute_force();
