package de.christianzunker.mobilecitygate.utils

import java.io.File
import scala.sys.process._

object OptimizeImages {
  
  def main(args: Array[String]) {
	  val baseDir = args(0)
	  val files = recursiveListFiles(new File(baseDir))
	  val jpegs = files.filter(f => """.*\.je?pg$""".r.findFirstIn(f.getName).isDefined)
	  val pngs = files.filter(f => """.*\.png$""".r.findFirstIn(f.getName).isDefined)
	  
  }
  
  def recursiveListFiles(f: File): Array[File] = {
	  val these = f.listFiles
	  these ++ these.filter(_.isDirectory).flatMap(recursiveListFiles)
  }
}
