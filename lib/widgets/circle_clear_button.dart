import 'package:flutter/material.dart';

class CircleClearButton extends StatelessWidget {
  final double size;
  final void Function() onPressed;
  final IconData icon;

  const CircleClearButton(
      {Key? key,
        this.size = 20.0,
        this.icon = Icons.clear,
        required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: onPressed,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center, // all centered
          children: [
            Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffB3B3B3)),
            ),
            Icon(
              icon,
              size: size * 0.7, // 60% width for icon
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}