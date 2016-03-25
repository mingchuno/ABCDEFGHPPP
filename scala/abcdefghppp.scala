object ABCDEFGHPPP { 
  def main(args: Array[String]): Unit = {
    (0 to 9)
      .toList
      .permutations
      .filter {
        case List(a, b, c, d, e, f, g, h, p, _) if a > 0 && c > 0 && e > 0 && p > 0 && g > 0 && p == 1 =>
          lazy val r1 = a * 10 + b - (c * 10 + d)
          lazy val r2 = e * 10 + f
          lazy val r3 = p * 100 + p * 10 + p - (g * 10 + h)
          r1 == r2 && r2 == r3

        case _ =>
          false
      }
      .foreach { 
        case List(a, b, c, d, e, f, g, h, p, _) =>
          println(s"a=$a,b=$b,c=$c,d=$d,e=$e,f=$f,g=$g,h=$h,p=$p")
      }
  }
}
