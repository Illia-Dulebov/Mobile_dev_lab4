import 'package:edu_books_flutter/styles/text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final double buttonHeight;

  const PrimaryButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.buttonHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: buttonHeight,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: gradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[1].withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
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
                    style: TextStyles.primaryButton,
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

class PrimaryButtonWithPrice extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final String price;

  const PrimaryButtonWithPrice({
    Key? key,
    required this.onTap,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: gradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[1].withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
                onTap: onTap,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          child: Text(
                            '$price грн',
                            style: TextStyles.primaryButton,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyles.primaryButton,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PrimaryButtonWithIcon extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final Icon icon;

  const PrimaryButtonWithIcon({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: gradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[1].withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: icon,
                    ),
                    Text(
                      title.toUpperCase(),
                      style: TextStyles.primaryButton,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
