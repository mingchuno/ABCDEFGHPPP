/**
  *
  * Created by Ricky on 27/3/2016.
  *  PrimaryChickenMath
  *           AB
  *         - CD
  *       -------------
  *           EF
  *        +  GH
  *       -------------
  *          PPP
  */
object abcdefghppp {
  //recursive permutation
  def permutation(numList: List[Int]): List[List[Int]] = {
    numList match {
      case List() => List(List())
      case _ =>
        for(n <- numList;
            rn <- permutation(numList.filterNot(_==n)))
          yield n +: rn
    }
  }

  def isAbcdefghppp(numbList: List[Int]): Boolean = {
    val A = numbList.head * 10
    val C = numbList(2) * 10
    val E = numbList(4) * 10
    val AB = A + numbList(1)
    val CD = C + numbList(3)
    val EF = E + numbList(5)
    val GH = numbList(6) * 10 + numbList(7)
    val PPP = numbList(8) * 100 + numbList(8) *10 + numbList(8)

    val twoDigit = A > 0 && C > 0 && E > 0
    val abcdef = AB - CD == EF
    val efghppp = EF + GH == PPP

    if(abcdef && efghppp && twoDigit){
      println(numbList)
      println(s"$AB - $CD = $EF + $GH = $PPP")
      println(s">>>>>>>>>>>>>>>>>>>>>")
    }
    abcdef && efghppp && twoDigit
  }

  def main(args: Array[String]): Unit = {
    val numList = (0 to 9).toList
    val charList = ('A' to 'H').toList :+ 'P'

    permutation(numList).filter(isAbcdefghppp)
      .foreach(pls => println (charList zip pls))
  }

}
