import 'package:edu_books_flutter/widgets/buttons/svg_icon_buttons.dart';
import 'package:edu_books_flutter/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/authorization/auth_bloc.dart';
import '../bloc/authorization/auth_event.dart';
import '../widgets/login_widget.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
                                  maxHeight: MediaQuery.of(context).size.height * 0.33,
                                  child: SvgPicture.asset(
                                      'assets/images/background.svg',
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.fill,
                                    ),
                                )
                                : Container(),
                            NavBar(
                              isTransparent: true,
                              withAccountIcon: false,
                              withDesktopMenu: false,
                              svgIconButton: SvgIconButton(
                                width: isMobile ? 20 : 34,
                                height: isMobile ? 20 : 34,
                                assetName: 'assets/icons/arrow_back.svg',
                                onTap: () {
                                  BlocProvider.of<AuthBloc>(context).add(DeleteErrors());
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            !isMobile ?
                            Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: SizedBox(
                                width: 470,
                                height: 470,
                                child: Image.asset('assets/images/books_image.png'),
                              ),
                            ) : Container(),
                            Expanded(
                              child: Padding(
                                padding: isMobile
                                    ? EdgeInsets.fromLTRB(50, 10, 50, 70)
                                    : EdgeInsets.fromLTRB(0, 45, 0, 100),
                                child: LoginWidget()
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

