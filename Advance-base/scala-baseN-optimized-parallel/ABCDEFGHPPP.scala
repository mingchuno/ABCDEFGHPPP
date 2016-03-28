import scala.util.Random

object ABCDEFGHPPP {
  val base = 22
  val p = 1
  val ppp = p * Math.pow(base,2) + p * Math.pow(base,1) + p

  def intToChar(x:Int) = {
    if( x > 9) (x - 10 + 'a'.toInt).toChar
    else (x - 1 + '1'.toInt).toChar
  }

  def possiblePermuatationN(xs: List[Int], n: Int) = {
    xs.combinations(n)
      .flatMap(_.permutations)
      .toStream    // lazy stream
      .par         // parallel collection
  }

  def solveABCDEFGHPPP = {

    val possibleTwoDigitFilter: (List[Int]) => Boolean = {
      case List(leading1, _, leading2, _) =>  leading1 > 0 && leading2 > 0
    }

    val possibleToTry = (0 until base)
      .toList
      .filter(x => x != p)

    // first solve ef + gh = 111
    val efghs =
      possiblePermuatationN(possibleToTry,4)
        .filter(possibleTwoDigitFilter)
        .filter {
          case List(e, f, g, h) => ppp - (g * base + h) ==  e * base + f
        }

    efghs
      .flatMap {
        case efgh @ List(e, f, g, h) =>
          // store the ef for reuse
          val ef = e * base + f

          // solve ab + cd = ef
          possiblePermuatationN(possibleToTry.diff(efgh),4)
            .filter(possibleTwoDigitFilter)
            .filter {
              case List(a, b, c, d) => a * base + b - (c * base + d)  ==  ef
            }
            .map(_ ++ efgh)
      }
  }

  def main(args: Array[String]): Unit = {

    val start = System.currentTimeMillis()
    println("Start Calculation")

    val solutions = solveABCDEFGHPPP

    println(s"Total Time used to solve AB - CD = 111 - GH = EF (Base $base): ${System.currentTimeMillis() - start}ms")
    println(s"Total number of solutions = ${solutions.size}")

    if(solutions.size > 50 ) println(s"Randomly print out 50 solution :")
    
    Random.shuffle(solutions.toList)
      .take(50)
      .map(xs => xs.map(intToChar))
      .foreach {
        case List(a,b,c,d,e,f,g,h) =>
          // Hide printing log in benchmark
          println(s"$a$b - $c$d = $e$f, $e$f + $g$h = $p$p$p")
      }
  }
}
