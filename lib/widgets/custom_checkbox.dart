import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCheckboxListTile extends StatefulWidget {
  final bool isChecked;
  final double size;
  final Color selectedColor;
  final Color selectedIconColor;
  final String text;
  final void Function() onTap;

  const CustomCheckboxListTile({
    Key? key,
    this.isChecked = false,
    this.size = 24,
    this.selectedColor = const Color(0xff6957FE),
    this.selectedIconColor = Colors.white,
    required this.text,
    required this.onTap
  }) : super(key: key);

  @override
  _CustomCheckboxListTileState createState() => _CustomCheckboxListTileState();
}

class _CustomCheckboxListTileState extends State<CustomCheckboxListTile> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            widget.onTap();
            setState(() {
              _isSelected = !_isSelected;
            });
          },
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.fastLinearToSlowEaseIn,
            decoration: BoxDecoration(
                color: _isSelected ? widget.selectedColor : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: _isSelected
                    ? null
                    : Border.all(
                        color: Color(0xff7C7C7C),
                        width: 1.72,
                      )),
            width: widget.size,
            height: widget.size,
            child: _isSelected
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.asset(
                      'assets/icons/apply.svg',
                      color: widget.selectedIconColor,
                    ),
                  )
                : null,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isSelected = !_isSelected;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12,
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: _isSelected ? widget.selectedColor : Color(0xff7C7C7C),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
