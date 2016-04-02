package Main

import scala.collection.parallel.ParSeq

/**
  * Created by Gaplo917 on 2/4/2016.
  */
object Main {

  val BASE = 17

  val WIDTH = 2
  //  val WIDTH = 4

  val baseAnd1 = BASE + 1
  val possibleToTry = (0 until BASE).toVector.filter(x => x != 1)

  def intToChar(x:Int) = if( x > 9) (x - 10 + 'a'.toInt).toChar else (x - 1 + '1'.toInt).toChar

  object BranchState extends Enumeration {
    type BranchState = Value
    val Initial,State_1, State_11,State_0,State_10 = Value
  }

  import BranchState._

  def leadingDigitPossibleSolution(possibleToTry: Vector[Int], result:Int, lastLending:Int) = {
    possiblePermuatationN(possibleToTry,3)
      .filter {
        case xs@Vector(a,c,g) =>
          val na = a - lastLending
          val e = result - g
          na > 1 && na > c && c > 1 && g > 1 && na - c + g == result && e != 1 &&  !xs.contains(e)
      }
      .map{
        case xs@Vector(a,c,g) =>
          Vector(a, c, result - g, g)
      }.toStream.par
  }

  def innerDigitPossibleSolution(possibleToTry: Vector[Int], result:Int, lending:Int, lastLending:Int) = {
    possiblePermuatationN(possibleToTry,3)
      .filter {
        case xs@Vector(b,d,h) =>
          val f = result - h
          f != 1 && f >= 0  && f < BASE && (b + lending * BASE) - lastLending - d + h == result && f < BASE && !xs.contains(f)
      }
      .map{
        case xs@Vector(b,d,h) =>
          Vector(b, d, result - h, h)
      }.toStream.par
  }


  val InnerDigitPossibleSolutionMap  =
    Map(
      (State_11,1,1) -> innerDigitPossibleSolution(possibleToTry,baseAnd1,1,1),
      (State_11,1,0) -> innerDigitPossibleSolution(possibleToTry,baseAnd1,1,0),
      (State_11,0,1) -> innerDigitPossibleSolution(possibleToTry,baseAnd1,0,1),
      (State_11,0,0) -> innerDigitPossibleSolution(possibleToTry,baseAnd1,0,0),
      (State_10,1,1) -> innerDigitPossibleSolution(possibleToTry,BASE,1,1),
      (State_10,1,0) -> innerDigitPossibleSolution(possibleToTry,BASE,1,0),
      (State_10,0,1) -> innerDigitPossibleSolution(possibleToTry,BASE,0,1),
      (State_10,0,0) -> innerDigitPossibleSolution(possibleToTry,BASE,0,0)
    )


  val leadingDigitPossibleSolutionMap =
    Map(
      (State_11,1) -> leadingDigitPossibleSolution(possibleToTry,baseAnd1,1),
      (State_11,0) -> leadingDigitPossibleSolution(possibleToTry,baseAnd1,0),
      (State_10,1) -> leadingDigitPossibleSolution(possibleToTry,BASE,1),
      (State_10,0) -> leadingDigitPossibleSolution(possibleToTry,BASE,0)
    )

  def mainRecur() = {
    func(
      possibleToTry = possibleToTry,
      branchState = State_11,
      lending = 1
    ) ++ func(
      possibleToTry = possibleToTry,
      branchState = State_11,
      lending = 0
    )
  }

  def func(possibleToTry: Vector[Int], branchState: BranchState = Initial, pos: Int = 1, lending:Int = 0, lastLending: Int = 0, possibleSolutions: ParSeq[Vector[Int]] = ParSeq()):  ParSeq[Vector[Int]] = {

    if(pos == WIDTH) {
      val leadingDigitPossibleSolutions = leadingDigitPossibleSolutionMap(branchState,lastLending)

      if(pos > 1) leadingDigitPossibleSolutions.flatMap {
        case ps => possibleSolutions.filter(xs => !xs.contains(ps(0)) && !xs.contains(ps(1)) && !xs.contains(ps(2)) && !xs.contains(ps(3)) ).map(ps ++ _)
      } else possibleSolutions

    } else {

      val innerDigitPossibleSolutions = InnerDigitPossibleSolutionMap(branchState,lending,lastLending)

      val newPossibleSolutions = if(pos > 1) InnerDigitPossibleSolutionMap(branchState,lending,lastLending).flatMap {
        case ps => possibleSolutions.filter(xs => !xs.contains(ps(0)) && !xs.contains(ps(1)) && !xs.contains(ps(2)) && !xs.contains(ps(3)) ).map(ps ++ _)
      } else innerDigitPossibleSolutions

      branchState match {
        case State_1 | State_0 =>
          // due to the fact that 1 - h > 0
          ParSeq()

        case State_11 if pos + 1 == WIDTH =>
          // lending is not possible if the next position is the leading digit
          func(
            possibleToTry = possibleToTry,
            branchState = State_10,
            lending = 0,
            lastLending = lending,
            pos = pos + 1,
            possibleSolutions = newPossibleSolutions
          )

        case State_11 =>
          func(
            possibleToTry = possibleToTry,
            branchState = State_10,
            lending = 0,
            lastLending = lending,
            pos = pos + 1,
            possibleSolutions = newPossibleSolutions
          ) ++
            func(
              possibleToTry = possibleToTry,
              branchState = State_10,
              lending = 1,
              lastLending = lending,
              pos = pos + 1,
              possibleSolutions = newPossibleSolutions
            )

        case State_10 if pos + 1 == WIDTH  =>
            // lending is not possible if the next position is the leading digit
            func(
              possibleToTry = possibleToTry,
              branchState = State_10,
              lending = 0,
              lastLending = lending,
              pos = pos + 1,
              possibleSolutions = newPossibleSolutions
            )
        case State_10  =>
          func(
            possibleToTry = possibleToTry,
            branchState = State_10,
            lending = 0,
            lastLending = lending,
            pos = pos + 1,
            possibleSolutions = newPossibleSolutions
          ) ++
            func(
              possibleToTry = possibleToTry,
              branchState = State_10,
              lending = 1,
              lastLending = lending,
              pos = pos + 1,
              possibleSolutions = newPossibleSolutions
            )


      }

    }

  }

  def possiblePermuatationN(xs: Vector[Int], n: Int) = {
    xs.combinations(n)
      .flatMap(_.permutations)
  }

  def main(args: Array[String]): Unit = {

    val start = System.currentTimeMillis()
    println("Start Calculation")

    val solutions = mainRecur()

    println(s"Total number of solutions = ${solutions.size}")

    println(s"Total Time used to solve (Base $BASE, Width $WIDTH): ${System.currentTimeMillis() - start}ms")

    // too lazy for make it generic
    solutions
      .take(50)
      .map(xs => xs.map(intToChar))
      .foreach {
        case xs =>
          val listWithIndex = xs.zipWithIndex
          // abcdef - ghijkl =  mnopqr,  mnopqr  + stuvwx = 111111
          val abcdef = listWithIndex.collect {
            case (x,i) if i % 4 == 0 => x
          }.mkString("")
          val ghijkl = listWithIndex.collect {
            case (x,i) if i % 4 == 1 => x
          }.mkString("")
          val mnopqr = listWithIndex.collect {
            case (x,i) if i % 4 == 2 => x
          }.mkString("")
          val stuvwx = listWithIndex.collect {
            case (x,i) if i % 4 == 3 => x
          }.mkString("")

          // don't learn this, too lazy to use for-loop only lol
          val yyyyyyy = List(1,1,1,1,1,1,1,1,1,1).take(WIDTH + 1).mkString("")

          println(s"$abcdef - $ghijkl = $mnopqr,  $mnopqr + $stuvwx = $yyyyyyy")
      }
  }
}
