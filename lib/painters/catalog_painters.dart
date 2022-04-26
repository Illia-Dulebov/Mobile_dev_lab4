import 'package:flutter/material.dart';

class CatalogMobileBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();
    paint.color = const Color(0xffF9DF64);
    if (size.width < 1000) {
      path.lineTo(0, 0);
      path.cubicTo(0, 0, size.width, 0, size.width, 0);
      path.cubicTo(size.width, 0, size.width, size.height * 0.72, size.width,
          size.height * 0.72);
      path.cubicTo(size.width, size.height * 0.8, size.width,
          size.height * 0.88, size.width * 0.96, size.height * 0.93);
      path.cubicTo(size.width * 0.78, size.height * 1.19, size.width * 0.57,
          size.height * 0.63, size.width * 0.18, size.height * 0.78);
      path.cubicTo(size.width * 0.1, size.height * 0.81, 0, size.height * 0.72,
          0, size.height * 0.56);
      path.cubicTo(0, size.height * 0.56, 0, 0, 0, 0);
      path.cubicTo(0, 0, 0, 0, 0, 0);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CatalogDesktopBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();
    paint.color = const Color(0xffF9DF64);
    double maxWidth = size.width / 2;
    double heigh = 1000;
    if (size.width >= 1000) {
      path.cubicTo(0, heigh, 0, 0, 0, 0);
      path.cubicTo(0, 0, maxWidth * 0.68, 0, maxWidth * 0.68, 0);
      path.cubicTo(maxWidth * 0.83, 0, maxWidth * 0.96, heigh * 0.08, maxWidth,
          heigh * 0.18);
      path.cubicTo(maxWidth, heigh / 4, maxWidth, heigh * 0.32, maxWidth * 0.93,
          heigh * 0.37);
      path.cubicTo(maxWidth * 0.93, heigh * 0.37, maxWidth * 0.8, heigh * 0.51,
          maxWidth * 0.8, heigh * 0.51);
      path.cubicTo(maxWidth * 0.74, heigh * 0.56, maxWidth * 0.7, heigh * 0.63,
          maxWidth * 0.7, heigh * 0.69);
      path.cubicTo(maxWidth * 0.7, heigh * 0.69, maxWidth * 0.68, heigh * 0.8,
          maxWidth * 0.68, heigh * 0.8);
      path.cubicTo(maxWidth * 0.67, heigh * 0.91, maxWidth * 0.53, heigh,
          maxWidth * 0.37, heigh);
      path.cubicTo(maxWidth * 0.37, heigh, 0, heigh, 0, heigh);
      path.cubicTo(0, heigh, 0, heigh, 0, heigh);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HomeScreenMobileBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();
    paint.color = Color(0xffF9DF64);
    path = Path();

    if (size.width < 1000) {
      path.lineTo(0, 0);
      path.cubicTo(0, 0, size.width, 0, size.width, 0);
      path.cubicTo(size.width, 0, size.width, size.height * 0.74, size.width,
          size.height * 0.74);
      path.cubicTo(size.width, size.height * 0.85, size.width * 0.95,
          size.height * 0.95, size.width * 0.88, size.height);
      path.cubicTo(size.width * 0.77, size.height * 1.02, size.width * 0.66,
          size.height, size.width * 0.58, size.height * 0.9);
      path.cubicTo(size.width * 0.58, size.height * 0.9, size.width * 0.52,
          size.height * 0.84, size.width * 0.52, size.height * 0.84);
      path.cubicTo(size.width * 0.45, size.height * 0.76, size.width * 0.36,
          size.height * 0.71, size.width * 0.27, size.height * 0.7);
      path.cubicTo(size.width * 0.12, size.height * 0.68, 0, size.height * 0.49,
          0, size.height * 0.27);
      path.cubicTo(0, size.height * 0.27, 0, 0, 0, 0);
      path.cubicTo(0, 0, 0, 0, 0, 0);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HomeScreenDesktopBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();
    paint.color = const Color(0xffF9DF64);
    double maxWidth = size.width / 2;
    double heigh = 1000;
    if (size.width >= 1000) {
      path.cubicTo(0, heigh, 0, 0, 0, 0);
      path.cubicTo(0, 0, maxWidth * 0.68, 0, maxWidth * 0.68, 0);
      path.cubicTo(maxWidth * 0.83, 0, maxWidth * 0.96, heigh * 0.08, maxWidth,
          heigh * 0.18);
      path.cubicTo(maxWidth, heigh / 4, maxWidth, heigh * 0.32, maxWidth * 0.93,
          heigh * 0.37);
      path.cubicTo(maxWidth * 0.93, heigh * 0.37, maxWidth * 0.8, heigh * 0.51,
          maxWidth * 0.8, heigh * 0.51);
      path.cubicTo(maxWidth * 0.74, heigh * 0.56, maxWidth * 0.7, heigh * 0.63,
          maxWidth * 0.7, heigh * 0.69);
      path.cubicTo(maxWidth * 0.7, heigh * 0.69, maxWidth * 0.68, heigh * 0.8,
          maxWidth * 0.68, heigh * 0.8);
      path.cubicTo(maxWidth * 0.67, heigh * 0.91, maxWidth * 0.53, heigh,
          maxWidth * 0.37, heigh);
      path.cubicTo(maxWidth * 0.37, heigh, 0, heigh, 0, heigh);
      path.cubicTo(0, heigh, 0, heigh, 0, heigh);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
