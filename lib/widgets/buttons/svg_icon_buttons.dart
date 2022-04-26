import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconButton extends StatelessWidget{
  const SvgIconButton({Key? key, required this.assetName, this.width = 20, this.height = 20, required this.onTap}) : super(key: key);

  final String assetName;
  final double width;
  final double height;
  final void Function() onTap;


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: SvgPicture.asset(
            assetName,
            width: width,
            height: height,
            ),
        ),
      ),
    );
  }



}