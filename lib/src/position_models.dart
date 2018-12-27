import 'package:flutter/material.dart';
import 'package:custom_utils/custom_utils.dart';

class Point2d {
  double x;
  double y;

  Point2d(double x, double y) {
    this.x = x;
    this.y = y;
  }
}

class Pointrd2d {
  double right;
  double down;

  Point2d(double right, double down) {
    this.right = right;
    this.down = down;
  }
}

// Easier to keep positive axis straight with this syntax
class Pointrdo3d {
  double right, down, out;
  Pointrdo3d({
    @required this.right,
    @required this.down,
    @required this.out,
  });
}

// For the Line Segment, It will either be a single node or part of a group of connected lines
// if it is part of a group, it needs to know it's connection node,
// In order to have a list of non-connected lines can have multiple roots in which the location is passed in
// When building, list will be sorted by node number then
class LineSegment2d {
  final int node;
  final Color lineColor;
  int connectionNode;
  final double length;
  double freqMultiplier;
  Offset nodeLocation;
  Offset endNodeLocation;
  // For the fourier example, length represents both amplitude of the wave and radius of the circle
  bool absoluteProgress;
  bool root;
  // if true, progress angle is based on the screen and not the nodes before it
  double progress;

  LineSegment2d({
    this.node = 0,
    @required this.length,
    this.lineColor = Colors.black,
    this.progress = 0.0,
    this.connectionNode = -1,
    this.absoluteProgress = false,
    this.root = false,
    this.nodeLocation = const Offset(0.0, 0.0),
    this.freqMultiplier = 1.0,
  });

  // This is was made for fourier transform code
  List<Offset> setPosition({Offset startlocation, double stepPerUpdate}) {
    if (stepPerUpdate != null) progress += stepPerUpdate * freqMultiplier;
    if (startlocation != null) nodeLocation = startlocation;
    double x = nodeLocation.dx + Z(progress) * length;
    double y = nodeLocation.dy + K(progress) * length;
    endNodeLocation = Offset(nodeLocation.dx + Z(progress) * length,
        nodeLocation.dy + K(progress) * length);
    return [nodeLocation, endNodeLocation];
  }
  // line will move directly right of the point at 0% progress, down at 100% left at 200% and up at 300% (goes down first to match fluttr)
}
