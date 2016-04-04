package abcdefghppp

import abcdefghppp.actors.CountActor
import akka.actor.FSM.Failure
import akka.pattern.ask
import akka.actor.{Props, Actor}
import akka.event.Logging
import akka.actor.ActorSystem
import akka.util.Timeout
import scala.concurrent.duration._
import scala.collection.parallel.ParSeq

import scala.concurrent.ExecutionContext.Implicits.global
import scala.util.Success

/**
  * Created by Gaplo917 on 2/4/2016.
  */



object Main {

  val BASE = 25

  val WIDTH = 4
  //  val WIDTH = 2

  implicit val timeout: Timeout = 30 minutes

  val system = ActorSystem("actorSystem")

  val countActor = system.actorOf(Props[CountActor], "countActor")

  system.scheduler.schedule(0 second, 10 seconds, new Runnable {
    override def run(): Unit = {
      val totalMemory = BigDecimal(Runtime.getRuntime().totalMemory() / (1024 * 1024 * 1024.0)).setScale(2, BigDecimal.RoundingMode.HALF_UP)
      val freeMemory = BigDecimal(Runtime.getRuntime().freeMemory() / (1024 * 1024 * 1024.0)).setScale(2, BigDecimal.RoundingMode.HALF_UP)
      println(s"[DEBUG] Total memory(${totalMemory.toString()})GB, Free memory:${freeMemory.toString()}GB")
    }
  })

  val baseAnd1 = BASE + 1
  val possibleToTry = (0 until BASE).filter(x => x != 1).toList

  object BranchState extends Enumeration {
    type BranchState = Value
    val Initial,State_1, State_11,State_0,State_10 = Value
  }

  import BranchState._

  def leadingDigitPossibleSolution(possibleToTry: List[Int], result:Int, lastLending:Int) = {
    possiblePermuatationN(possibleToTry,3)
      .withFilter {
        case xs@List(a,c,g) =>
          val na = a - lastLending
          val e = result - g
          na > 1 && na > c && c > 1 && g > 1 && e != 1 && e != a && e != c && e != g && na - c + g == result
      }
      .map{
        case xs@List(a,c,g) =>
          List(a, c, result - g, g)
      }.toStream.par
  }

  def innerDigitPossibleSolution(possibleToTry: List[Int], result:Int, lending:Int, lastLending:Int) = {
    possiblePermuatationN(possibleToTry,3)
      .withFilter {
        case xs@List(b,d,h) =>
          val f = result - h
          f != 1 && f >= 0  && f < BASE && f != b && f != d && f != h && (b + lending * BASE) - lastLending - d + h == result
      }
      .map{
        case xs@List(b,d,h) =>
          List(b, d, result - h, h)
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
      branchState = State_11,
      lending = 1
    )
    func(
      branchState = State_11,
      lending = 0
    )
  }

  def func(branchState: BranchState = Initial, pos: Int = 1, lending:Int = 0, lastLending: Int = 0, possibleSolutions: ParSeq[List[Int]] = ParSeq()):  Unit= {

    if(pos == WIDTH) {
      leadingDigitPossibleSolutionMap(branchState,lastLending).foreach { case ps@List(ps0,ps1,ps2,ps3) =>
        possibleSolutions.withFilter(xs => !xs.contains(ps0) && !xs.contains(ps1) && !xs.contains(ps2) && !xs.contains(ps3)).foreach { xs =>
          countActor ! CountActor.SaveSolution(ps ++ xs)
        }
      }

    } else {

      val innerDigitPossibleSolutions = InnerDigitPossibleSolutionMap(branchState,lending,lastLending)

      val newPossibleSolutions = if(pos > 1) InnerDigitPossibleSolutionMap(branchState,lending,lastLending).flatMap {
        case ps@List(ps0,ps1,ps2,ps3) => possibleSolutions.withFilter(xs => !xs.contains(ps0) && !xs.contains(ps1) && !xs.contains(ps2) && !xs.contains(ps3)).map(ps ++ _)
      } else innerDigitPossibleSolutions

      branchState match {
        case State_11 if pos + 1 == WIDTH =>
          // lending is not possible if the next position is the leading digit
          func(
            branchState = State_10,
            lending = 0,
            lastLending = lending,
            pos = pos + 1,
            possibleSolutions = newPossibleSolutions
          )

        case State_11 =>
          func(
            branchState = State_10,
            lending = 0,
            lastLending = lending,
            pos = pos + 1,
            possibleSolutions = newPossibleSolutions
          )
          func(
            branchState = State_10,
            lending = 1,
            lastLending = lending,
            pos = pos + 1,
            possibleSolutions = newPossibleSolutions
          )

        case State_10 if pos + 1 == WIDTH  =>
          // lending is not possible if the next position is the leading digit
          func(
            branchState = State_10,
            lending = 0,
            lastLending = lending,
            pos = pos + 1,
            possibleSolutions = newPossibleSolutions
          )
        case State_10  =>
          func(
            branchState = State_10,
            lending = 0,
            lastLending = lending,
            pos = pos + 1,
            possibleSolutions = newPossibleSolutions
          )
          func(
            branchState = State_10,
            lending = 1,
            lastLending = lending,
            pos = pos + 1,
            possibleSolutions = newPossibleSolutions
          )

      }

    }

  }

  def possiblePermuatationN(xs: List[Int], n: Int) = {
    xs.combinations(n)
      .flatMap(_.permutations)
  }

  def main(args: Array[String]): Unit = {

    val start = System.currentTimeMillis()
    println("Start Calculation")

    val solutions = mainRecur()

    // Ask the count Actor for the result
    (countActor ? CountActor.PrintSolutions).onSuccess{
      case Success(_) =>
        // shutdown the actor system
        system.terminate()
      case Failure(e) =>
        println("Fail to print solution")

    }

    println(s"Total Time used to solve (Base $BASE, Width $WIDTH): ${System.currentTimeMillis() - start}ms")
  }

}
