// ignore_for_file: deprecated_member_use


import 'package:flutter/material.dart';

import '../../styles/text_styles.dart';
import 'apply_button.dart';

class CheckoutButtonPromo extends StatelessWidget {
  const CheckoutButtonPromo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    late TextEditingController emailController = TextEditingController();

    String? validateEmail(String? value) {
      String pattern =
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?)*$";
      RegExp regex = RegExp(pattern);
      if (value == null || value.isEmpty || !regex.hasMatch(value)) {
        return 'Введіть правильний промокод';
      }
      return null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(0, 22, 0, 0),
            child: SizedBox(
                width: 339,
                child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    shadowColor: Color.fromRGBO(165, 165, 165, 1),
                    child: TextFormField(
                      validator: (value) => validateEmail(value),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      cursorColor: const Color(0xff181B19),
                      style: TextStyle(
                        color: Color(0xff181B19),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Промокод',
                        suffixIcon: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                          child: ApplyButton(),
                        ),
                        hintStyle: const TextStyle(
                          color: Color(0xFFA5A5A5),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        filled: true,
                        isDense: true,
                        fillColor: const Color(0xffF2F3F2),
                        contentPadding:
                            EdgeInsets.only(top: 30, left: 20, right: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    )))),
        Padding(
            padding: EdgeInsets.fromLTRB(6, 2, 0, 0),
            child: Text(
              "Використовуйте промо-код тут, щоб отримати знижку",
              style: TextStyles.orderCheckInfo,
            )),
      ],
    );
  }
}
