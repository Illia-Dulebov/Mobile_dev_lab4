import 'package:edu_books_flutter/styles/text_styles.dart';
import 'package:flutter/material.dart';

class MenuTextBox extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MenuTextBox({
    Key? key,
    required this.text,
    this.onTap,
    this.isPressed = false
  }) : super(key: key);

  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if(!isPressed){
            if(onTap != null){
              onTap!();
            }
          }
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: isPressed ? TextStyles.menuTapped : TextStyles.menu,
        ),
      ),
    );
  }
}
