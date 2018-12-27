import 'package:flutter/material.dart';
import 'package:custom_utils/custom_utils.dart';

class LinePainter extends CustomPainter {
  final List<LineSegment2d> points;
  double xRootFromCenter;
  double yRootFromCenter;
  final double thickness;
  LinePainter({
    @required this.points,
    this.thickness = 10.0,
    this.xRootFromCenter = 0.0,
    this.yRootFromCenter = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    points.sort((ls1, ls2) => ls1.node.compareTo(ls2.node));
    points.forEach((lineNode) {
      List<Offset> nodepoints = lineNode.root
          ? lineNode.setPosition(
              startlocation: Offset(size.width / 2 + xRootFromCenter,
                  size.height / 2 + yRootFromCenter))
          : lineNode.setPosition(
              startlocation: points
                  .firstWhere((ls) => ls.node == lineNode.connectionNode)
                  .endNodeLocation);
      Paint p = Paint()
        ..color = lineNode.lineColor
        ..strokeWidth = thickness
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      canvas.drawLine(nodepoints[0], nodepoints[1], p);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

//   Oscilloscope code from https://github.com/magnatronus/oscilloscope

class LinePainterWOscilloscope extends CustomPainter {
  final List<LineSegment2d> points;
  final double thickness;
  double stepPerUpdate;
  final List trace;
  final double xScale;
  final Color traceColor;
  final Color yAxisColor;
  final bool showYAxis;
  LinePainterWOscilloscope(
      {this.points,
      this.thickness,
      this.trace,
      this.showYAxis,
      this.yAxisColor,
      this.xScale = 1.0,
      this.stepPerUpdate = 2.0,
      this.traceColor = Colors.blue});

  @override
  void paint(Canvas canvas, Size size) {
    final tracePaint = Paint()
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 2.0
      ..color = traceColor
      ..style = PaintingStyle.stroke;

    final axisPaint = Paint()
      ..strokeWidth = 1.0
      ..color = yAxisColor;

    double totalLen = 0.0;
    points.sort((ls1, ls2) => ls1.node.compareTo(ls2.node));
    points.forEach((lineNode) {
      List<Offset> nodepoints = lineNode.root
          ? lineNode.setPosition(
              startlocation: Offset(size.width / 2, size.height / 4),
              stepPerUpdate: stepPerUpdate)
          : lineNode.setPosition(
              startlocation: points
                  .firstWhere((ls) => ls.node == lineNode.connectionNode)
                  .endNodeLocation,
              stepPerUpdate: stepPerUpdate);
      Paint p = Paint()
        ..color = lineNode.lineColor
        ..strokeWidth = thickness
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      canvas.drawLine(nodepoints[0], nodepoints[1], p);
      totalLen += lineNode.length;
      if (lineNode == points.last) {
        trace.add((lineNode.endNodeLocation.dy - (size.height / 4)) / totalLen);
      }

      // only start plot if dataset has data
      int length = trace.length;
      if (length > 0) {
        // transform data set to just what we need if bigger than the width(otherwise this would be a memory hog)
        if (length > size.width) {
          trace.removeAt(0);
          length = trace.length;
        }

        // Create Path and set Origin to first data point
        Path tracePath = Path();
        tracePath.moveTo(
            0.0, 3 * size.height / 4 + trace[0].toDouble() * size.height / 4);

        // generate trace path
        for (int p = 0; p < length; p++) {
          double plotPoint =
              3 * size.height / 4 + trace[p].toDouble() * size.height / 4;
          tracePath.lineTo(p.toDouble() * xScale, plotPoint);
        }
        // display the trace
        canvas.drawPath(tracePath, tracePaint);

        // if yAxis required draw it here
        if (showYAxis) {
          Offset yStart = Offset(0.0, 3 * size.height / 4);
          Offset yEnd = Offset(size.width, 3 * size.height / 4);
          canvas.drawLine(yStart, yEnd, axisPaint);
        }
      }
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
