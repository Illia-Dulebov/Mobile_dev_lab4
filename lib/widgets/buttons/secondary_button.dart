import 'package:edu_books_flutter/styles/text_styles.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({Key? key, required this.onTap, required this.title})
      : super(key: key);

  final Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      
      children: [
        Expanded(
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(25),
            shadowColor: Color.fromRGBO(165, 165, 165, 1),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: gradientColors[0].withOpacity(0.12),
                borderRadius: BorderRadius.circular(25),
                
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  highlightColor: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                  onTap: onTap,
                  child: Center(
                    child: Text(
                      title.toUpperCase(),
                      style: TextStyles.primaryButton.copyWith(color: gradientColors[0]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}