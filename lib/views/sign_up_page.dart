import 'package:edu_books_flutter/bloc/authorization/auth_bloc.dart';
import 'package:edu_books_flutter/bloc/authorization/auth_event.dart';
import 'package:edu_books_flutter/bloc/authorization/auth_state.dart';
import 'package:edu_books_flutter/styles/text_styles.dart';
import 'package:edu_books_flutter/views/login_page.dart';
import 'package:edu_books_flutter/widgets/buttons/primary_buttons.dart';
import 'package:edu_books_flutter/widgets/buttons/svg_icon_buttons.dart';
import 'package:edu_books_flutter/widgets/navigation_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController passwordConfirmController =
      TextEditingController();

  bool showPasswordVisibilityIcon = false;
  bool showConfirmVisibilityIcon = false;

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

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<AuthBloc>(context).add(DeleteErrors());
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              isMobile
                  ? Container()
                  : SvgPicture.asset(
                      'assets/images/background_desktop.svg',
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.fill,
                    ),
              SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: isMobile ? MediaQuery.of(context).size.width : 1000,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            isMobile
                                ? LimitedBox(
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.33,
                                    child: SvgPicture.asset(
                                      'assets/images/background.svg',
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : Container(),
                            NavBar(
                              withDesktopMenu: false,
                              isTransparent: true,
                              withAccountIcon: false,
                              svgIconButton: SvgIconButton(
                                width: isMobile ? 20 : 34,
                                height: isMobile ? 20 : 34,
                                assetName: 'assets/icons/arrow_back.svg',
                                onTap: () {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(DeleteErrors());
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            !isMobile
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 40),
                                    child: SizedBox(
                                      width: 470,
                                      height: 470,
                                      child: Image.asset(
                                          'assets/images/books_image.png'),
                                    ),
                                  )
                                : Container(),
                            Expanded(
                              child: Padding(
                                padding: isMobile
                                    ? EdgeInsets.fromLTRB(50, 10, 50, 70)
                                    : EdgeInsets.fromLTRB(0, 45, 0, 100),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Text(
                                          'Реєстрація',
                                          style: isMobile
                                              ? TextStyles.loginHeaderMobile
                                              : TextStyles.loginHeaderDesctop,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 40),
                                        child: Text(
                                          'Усі твої улюблені книжки на одній полиці',
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 25),
                                                  child: TextFormField(
                                                    validator: (value) {
                                                      if (value ==null || value.isEmpty) {
                                                        return 'Введіть ім\'я';
                                                      } else if (value
                                                              .length <
                                                          2) {
                                                        return 'Довжина імені повинна бути не менше 2 символів';
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        nameController,
                                                    autocorrect: false,
                                                    cursorColor: const Color(
                                                        0xff181B19),
                                                    style: TextStyle(
                                                      color:
                                                          Color(0xff181B19),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                    ),
                                                    decoration:
                                                        InputDecoration(
                                                      hintText: 'Ім\'я',
                                                      hintStyle:
                                                          const TextStyle(
                                                        color:
                                                            Color(0xFFA5A5A5),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      ),
                                                      filled: true,
                                                      isDense: true,
                                                      fillColor: const Color(
                                                          0xffF2F3F2),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 30,
                                                              left: 20,
                                                              right: 20),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    15.0),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 0,
                                                          style: BorderStyle
                                                              .none,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 25),
                                                  child: TextFormField(
                                                    validator: (value) =>
                                                        validateEmail(value),
                                                    controller:
                                                        emailController,
                                                    keyboardType: TextInputType.emailAddress,
                                                    autocorrect: false,
                                                    cursorColor: const Color(
                                                        0xff181B19),
                                                    style: TextStyle(
                                                      color:
                                                          Color(0xff181B19),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                    ),
                                                    decoration:
                                                        InputDecoration(
                                                      hintText: 'Email',
                                                      hintStyle:
                                                          const TextStyle(
                                                        color:
                                                            Color(0xFFA5A5A5),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      ),
                                                      filled: true,
                                                      isDense: true,
                                                      fillColor: const Color(
                                                          0xffF2F3F2),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 30,
                                                              left: 20,
                                                              right: 20),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    15.0),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 0,
                                                          style: BorderStyle
                                                              .none,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 25),
                                                  child: TextFormField(
                                                    controller:
                                                        passwordController,
                                                    validator: (value) {
                                                      
                                                      if (value ==null ||
                                                          value.isEmpty) {
                                                        return 'Введіть пароль';
                                                      } else if (value
                                                              .length <
                                                          8) {
                                                        return 'Довжина паролю повинна бути не менше 8 символів';
                                                      }
                                                      return null;
                                                    },
                                                    obscureText:
                                                        showPasswordVisibilityIcon
                                                            ? false
                                                            : true,
                                                    // autocorrect: false,
                                                    cursorColor:
                                                        Color(0xff030303),
                                                    style: const TextStyle(
                                                      color:
                                                          Color(0xff181B19),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                    ),
                                                    decoration:
                                                        InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 20,
                                                              left: 20,
                                                              right: 20),
                                                      hintText: 'Пароль',
                                                      filled: true,
                                                      isDense: true,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    15.0),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 0,
                                                          style: BorderStyle
                                                              .none,
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          const TextStyle(
                                                        color:
                                                            Color(0xFFA5A5A5),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      ),
                                                      fillColor: const Color(
                                                          0xffF2F3F2),
                                                      suffixIcon: SizedBox(
                                                        child: InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                          onTap: () {
                                                            if (!showPasswordVisibilityIcon) {
                                                              setState(() {
                                                                showPasswordVisibilityIcon =
                                                                    true;
                                                              });
                                                            } else {
                                                              setState(() {
                                                                showPasswordVisibilityIcon =
                                                                    false;
                                                              });
                                                            }
                                                          },
                                                          child: Icon(
                                                            showPasswordVisibilityIcon
                                                                ? Icons
                                                                    .visibility
                                                                : Icons
                                                                    .visibility_off,
                                                            color: Color(
                                                                0xff7C7C7C),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      passwordConfirmController,
                                                  validator: (value) {
                                                    if (value ==
                                                            null ||
                                                        value.isEmpty) {
                                                      return 'Підтвердіть пароль';
                                                    } else if (value !=
                                                        passwordController
                                                            .text) {
                                                      return 'Ваш пароль та підтвердження паролю відрізняються';
                                                    }
                                                    return null;
                                                  },
                                                  obscureText:
                                                      showConfirmVisibilityIcon
                                                          ? false
                                                          : true,
                                                  // autocorrect: false,
                                                  cursorColor:
                                                      Color(0xff030303),
                                                  style: const TextStyle(
                                                    color: Color(0xff181B19),
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 20,
                                                            left: 20,
                                                            right: 20),
                                                    hintText:
                                                        'Підтвердження паролю',
                                                    filled: true,
                                                    isDense: true,
                                                    border:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(15.0),
                                                      borderSide:
                                                          const BorderSide(
                                                        width: 0,
                                                        style:
                                                            BorderStyle.none,
                                                      ),
                                                    ),
                                                    hintStyle:
                                                        const TextStyle(
                                                      color:
                                                          Color(0xFFA5A5A5),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                    ),
                                                    fillColor: const Color(
                                                        0xffF2F3F2),
                                                    suffixIcon: SizedBox(
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    15.0),
                                                        onTap: () {
                                                          if (!showConfirmVisibilityIcon) {
                                                            setState(() {
                                                              showConfirmVisibilityIcon =
                                                                  true;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              showConfirmVisibilityIcon =
                                                                  false;
                                                            });
                                                          }
                                                        },
                                                        child: Icon(
                                                          showConfirmVisibilityIcon
                                                              ? Icons
                                                                  .visibility
                                                              : Icons
                                                                  .visibility_off,
                                                          color: Color(
                                                              0xff7C7C7C),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                BlocConsumer<AuthBloc, AuthState>(
                                                  listener: (context, state) {
                                                    if(state.authRequestStatus == Status.success){
                                                      Navigator
                                                      .of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                                                    }
                                                  },
                                                  builder: (context, state){
                                                    if(state.authRequestStatus == Status.failure && state.errorMessages != null){
                                                      return Padding(
                                                        padding: const EdgeInsets.only(top: 10),
                                                        child: Text(state.errorMessages?.join('\n').replaceFirst('The email has already been taken', 'Користувач з таким email уже існує') ?? '', style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12
                                                        )),
                                                      );
                                                    }
                                                    else {
                                                      return Container();
                                                    }
                                                  },
                                                )
                                                
                                              ],
                                            ),
                                          

                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50, bottom: 30),
                                        child: PrimaryButton(
                                          buttonHeight: 42,
                                          title: 'Увійти',
                                          onTap: () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            if (_formKey.currentState!
                                                .validate()) {
                                              BlocProvider.of<AuthBloc>(context)
                                                  .add(UserRegistration(
                                                      name: nameController.text,
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                      passwordConfirm:
                                                          passwordConfirmController
                                                              .text));
                                            }
                                          },
                                        ),
                                      ),
                                      Center(
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Уже маєте акаунт? ',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff6C6C6C),
                                              letterSpacing: 0.7,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'Увійти',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF6957FE),
                                                  letterSpacing: 0.7,
                                                ),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        BlocProvider.of<
                                                                    AuthBloc>(
                                                                context)
                                                            .add(
                                                                DeleteErrors());
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        LoginPage()));
                                                      },
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
