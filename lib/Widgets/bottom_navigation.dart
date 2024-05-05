import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../Theme/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../Theme/colors.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60, // Set the height to match CPainter's size
      color: AppColors.crimson,
      child: CustomPaint(
        size: Size(MediaQuery.of(context).size.width, 80),
        painter: CPainter(),
        child: SizedBox.expand(
          child: Container(
            height: 60,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}


class CPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color= AppColors.crimson..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0, size.height - 60); // Start at bottom left corner
    path.quadraticBezierTo(
        size.width / 2, -100, size.width, size.height - 60); // Curve to bottom right corner
    path.lineTo(size.width, size.height - 60);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}