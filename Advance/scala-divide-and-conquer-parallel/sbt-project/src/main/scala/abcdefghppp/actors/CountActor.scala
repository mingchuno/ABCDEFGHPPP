package abcdefghppp.actors

import akka.actor.Actor
import akka.event.Logging

/**
  * Created by Gaplo917 on 3/4/2016.
  */
class CountActor extends Actor {
  val log = Logging(context.system, this)

  var count = 0
  var solutions = List[List[Int]]()

  def receive = {

    case saveSolution: CountActor.SaveSolution =>
      // count the solution
      count += 1

      if(solutions.size < 50){
        solutions :+= saveSolution.xs
      }

    case CountActor.PrintSolutions =>
      println(s"Total number of solutions = $count")
      solutions.foreach(printEqu)
      sender() ! "Done"

    case _ => log.info("received unknown message")
  }

  def intToChar(x:Int) = if( x > 9) (x - 10 + 'a'.toInt).toChar else (x - 1 + '1'.toInt).toChar

  def printEqu(xs: List[Int]) = {
    val listWithIndex = xs.map(intToChar).zipWithIndex
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
    val yyyyyyy = List(1,1,1,1,1,1,1,1,1,1).take(xs.length/4 + 1).mkString("")

    println(s"$abcdef - $ghijkl = $mnopqr,  $mnopqr + $stuvwx = $yyyyyyy")
  }
}
object CountActor {
  case object PrintSolutions
  case class SaveSolution(xs: List[Int])
  case class Solutions(count: Int, results: List[List[Int]])
}