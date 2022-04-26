import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authorization/auth_bloc.dart';
import '../bloc/authorization/auth_event.dart';
import '../bloc/authorization/auth_state.dart';
import '../styles/text_styles.dart';
import '../views/home_page.dart';
import '../views/sign_up_page.dart';
import 'buttons/primary_buttons.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  bool showVisibilityIcon = false;

  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Text(
          'Вхід',
          style: isMobile
              ? TextStyles.loginHeaderMobile
              : TextStyles.loginHeaderDesctop,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Text(
          'Увійдіть у свій обліковий запис',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff7C7C7C),
          ),
        ),
      ),
      Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
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
                  hintText: 'Email',
                  hintStyle: const TextStyle(
                    color: Color(0xFFA5A5A5),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  filled: true,
                  isDense: true,
                  fillColor: const Color(0xffF2F3F2),
                  contentPadding: EdgeInsets.only(top: 30, left: 20, right: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Введіть пароль';
                } else if (value.length < 8) {
                  return 'Довжина паролю повинна бути не менше 8 символів';
                }
                return null;
              },
              obscureText: showVisibilityIcon ? false : true,
              // autocorrect: false,
              cursorColor: Color(0xff030303),
              style: const TextStyle(
                color: Color(0xff181B19),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 20, left: 20, right: 20),
                hintText: 'Пароль',
                filled: true,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                hintStyle: const TextStyle(
                  color: Color(0xFFA5A5A5),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                fillColor: const Color(0xffF2F3F2),
                suffixIcon: SizedBox(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15.0),
                    onTap: () {
                      if (!showVisibilityIcon) {
                        setState(() {
                          showVisibilityIcon = true;
                        });
                      } else {
                        setState(() {
                          showVisibilityIcon = false;
                        });
                      }
                    },
                    child: Icon(
                      showVisibilityIcon
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(0xff7C7C7C),
                    ),
                  ),
                ),
              ),
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.authRequestStatus == Status.success) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
                }
              },
              builder: (context, state) {
                if (state.authRequestStatus == Status.failure &&
                    state.errorMessages != null) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(state.errorMessages?.join('\n') ?? '',
                        style: TextStyle(color: Colors.red, fontSize: 12)),
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 50, bottom: 25),
        child: PrimaryButton(
          buttonHeight: 42,
          title: 'Увійти',
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if (_formKey.currentState!.validate()) {
              BlocProvider.of<AuthBloc>(context).add(UserLogin(
                email: emailController.text,
                password: passwordController.text,
              ));
            }
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 42),
        child: Center(
          child: RichText(
              text: TextSpan(
            text: 'Забули пароль? ',
            recognizer: TapGestureRecognizer()..onTap = () => {},
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff2B2B2B),
              letterSpacing: 0.7,
            ),
          )),
        ),
      ),
      Center(
        child: RichText(
          text: TextSpan(
            text: 'Ще не створили акаунт? ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff6C6C6C),
              letterSpacing: 0.7,
            ),
            children: [
              TextSpan(
                text: 'Зареєструватися',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6957FE),
                  letterSpacing: 0.7,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    BlocProvider.of<AuthBloc>(context).add(DeleteErrors());
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
