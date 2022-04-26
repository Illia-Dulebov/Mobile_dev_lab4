import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authorization/auth_bloc.dart';
import '../../bloc/authorization/auth_state.dart';
import '../../styles/text_styles.dart';

class CheckoutButtonEmail extends StatelessWidget {
  const CheckoutButtonEmail({Key? key}) : super(key: key);

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
        return 'Введіть правильну електронну адресу';
      }
      return null;
    }

    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state.userStatus == UserStatus.authenticated) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 64, 0, 0),
                child: SizedBox(
                    width: 339,
                    child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(15),
                        shadowColor: Color.fromRGBO(165, 165, 165, 1),
                        child: TextFormField(
                          validator: (value) => validateEmail(value),
                          controller: emailController
                            ..text = state.user!.email.toString(),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          cursorColor: const Color(0xff181B19),
                          style: TextStyle(
                            color: Color(0xff181B19),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Color.fromRGBO(43, 43, 43, 1),
                            ),
                            prefixIconColor: Color.fromRGBO(43, 43, 43, 1),
                            hintStyle: const TextStyle(
                              color: Color(0xFFA5A5A5),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            filled: true,
                            isDense: true,
                            fillColor: const Color(0xffF2F3F2),
                            contentPadding: EdgeInsets.only(
                                top: 22, left: 20, right: 20, bottom: 22),
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
                padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                child: Text(
                  "На цю електронну пошту надійде ваше замовлення",
                  style: TextStyles.orderCheckInfo,
                )),
          ],
        );
      } else {
        return Center(
          child: Text("Order Problem"),
        );
      }
    });
  }
}
