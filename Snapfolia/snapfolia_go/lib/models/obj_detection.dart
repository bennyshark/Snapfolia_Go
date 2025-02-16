import 'package:flutter/material.dart';
class TrackedObject {
  Rect boundingBox;
  String label;
  double confidence;
  int trackId;
  int lastUpdateFrame;

  TrackedObject({
    required this.boundingBox,
    required this.label,
    required this.confidence,
    required this.trackId,
    required this.lastUpdateFrame,
  });
}

class TrackedObjectPainter extends CustomPainter {
  final List<TrackedObject> trackedObjects;

  TrackedObjectPainter(this.trackedObjects);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (var trackedObj in trackedObjects) {
      final hue = (trackedObj.trackId * 137.5) % 360;
      paint.color = HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();

      canvas.drawRect(trackedObj.boundingBox, paint);

      final displayText = '${trackedObj.label} ${(trackedObj.confidence * 100).toStringAsFixed(1)}%';
      textPainter.text = TextSpan(
        text: displayText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );

      textPainter.layout(minWidth: 0, maxWidth: size.width);

      final textOffset = Offset(trackedObj.boundingBox.left + 5, trackedObj.boundingBox.top + 5);
      final backgroundRect = Rect.fromLTWH(
        textOffset.dx - 4,
        textOffset.dy - 4,
        textPainter.width + 8,
        textPainter.height + 8,
      );

      final backgroundPaint = Paint()
        ..color = paint.color.withOpacity(0.7);
      canvas.drawRect(backgroundRect, backgroundPaint);

      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
double _calculateIoU(Rect box1, Rect box2) {
  final intersection = box1.intersect(box2);
  if (intersection.isEmpty) return 0.0;

  final intersectionArea = intersection.width * intersection.height;
  final box1Area = box1.width * box1.height;
  final box2Area = box2.width * box2.height;

  return intersectionArea / (box1Area + box2Area - intersectionArea);
}