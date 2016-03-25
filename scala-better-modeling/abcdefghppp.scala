object ABCDEFGHPPP { 
   // Helper Class Just for clarity, it is not necessary
  type Digit = Int

  case class TwoDigit(x: Digit, y: Digit) {
    val value = x * 10 + y
    def - (that: TwoDigit) = {
      this.value - that.value
    }
    def == (that: TwoDigit) = {
      this.value == that.value
    }

    def == (that: Int) = {
      this.value == that
    }
  }
  case class PPP(x: Digit) {
    val value = x * 100 + x * 10 + x
    def - (that: TwoDigit) = {
      this.value - that.value
    }
  }

  case class ABCEDFGHP(a: Digit, b: Digit, c: Digit, d: Digit, e: Digit, f: Digit, g: Digit, h: Digit, p: Digit)

  def main(args: Array[String]): Unit = {
    (0 to 9)
      .toList
      .permutations
      .filter {
        case List(a, b, c, d, e, f, g, h, p, _) => a > 0 && c > 0 && e > 0 && p > 0 && g > 0 && p == 1
      }
      .filter {
        case List(a, b, c, d, e, f, g, h, p, _) => TwoDigit(e, f) == PPP(p) - TwoDigit(g,h)
      }
      .filter {
        case List(a, b, c, d, e, f, g, h, p, _) => TwoDigit(e, f) == TwoDigit(a, b) - TwoDigit(c, d)
      }
      .map {
        case List(a, b, c, d, e, f, g, h, p, _) => ABCEDFGHP(a,b,c,d,e,f,g,h,p)
      }
      .foreach(println)
  }
}
