import 'package:flutter/material.dart';

import '../../styles/text_styles.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(20),
            child: Container(
                height: 35,
                width: 88,
                child: Align(
                    alignment: Alignment.center,
                    child: Text("Застосувати",
                        style: TextStyles.orderCheckApply,
                        textAlign: TextAlign.center)),
                decoration: BoxDecoration(
                    color: Color(0x006957fe).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20)))));
  }
}
