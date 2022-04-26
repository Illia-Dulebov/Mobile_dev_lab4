import 'package:edu_books_flutter/bloc/authorization/auth_bloc.dart';
import 'package:edu_books_flutter/bloc/authorization/auth_state.dart';
import 'package:edu_books_flutter/bloc/catalog/catalog_bloc.dart';
import 'package:edu_books_flutter/styles/text_styles.dart';
import 'package:edu_books_flutter/views/account_page.dart';
import 'package:edu_books_flutter/views/catalog_page.dart';
import 'package:edu_books_flutter/views/home_page.dart';
import 'package:edu_books_flutter/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/authorization/auth_event.dart';
import 'buttons/svg_icon_buttons.dart';
import 'menu_text.dart';

class NavBar extends StatelessWidget {
  final String? title;
  final SvgIconButton? svgIconButton;
  final int currentIndex;
  final bool withAccountIcon;
  final bool withDesktopMenu;
  final bool isTransparent;

  const NavBar({
    Key? key,
    this.title,
    this.currentIndex = 0,
    this.isTransparent = false,
    this.withAccountIcon = true,
    this.withDesktopMenu = true,
    this.svgIconButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;

    return Column(
      children: [
        SizedBox(
          width: isMobile ? double.infinity : 1000,
          child: Container(
            color: isMobile
                ? isTransparent
                    ? Colors.transparent
                    : Color(0xFFF9DF64)
                : Colors.transparent,
            child: Padding(
              padding: isMobile
                  ? EdgeInsets.fromLTRB(25, 45, 25, 5)
                  : EdgeInsets.fromLTRB(0, 48, 0, 30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: svgIconButton ?? SizedBox()),
                  ),
                  isMobile
                      ? withAccountIcon
                          ? Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    return SvgIconButton(
                                      assetName: 'assets/icons/account.svg',
                                      width: 20,
                                      height: 20,
                                      onTap: () {
                                        BlocProvider.of<AuthBloc>(context)
                                            .add(DeleteErrors());
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => state
                                                          .userStatus ==
                                                      UserStatus.authenticated
                                                  ? AccountPage()
                                                  : LoginPage()),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                          : SizedBox()
                      : withAccountIcon
                          ? Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    return SvgIconButton(
                                      assetName: 'assets/icons/account.svg',
                                      width: 34,
                                      height: 34,
                                      onTap: () {
                                        BlocProvider.of<AuthBloc>(context)
                                            .add(DeleteErrors());
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                state.userStatus == UserStatus.authenticated
                                                ? AccountPage()
                                                : LoginPage()),
                
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                          : SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      title == null
                          ? RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Book",
                                    style: isMobile
                                        ? TextStyles.logoTextMobile1
                                        : TextStyles.logoTextDesktop1,
                                  ),
                                  TextSpan(
                                    text: "Shelf",
                                    style: isMobile
                                        ? TextStyles.logoTextMobile2
                                        : TextStyles.logoTextDesktop2,
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              title!,
                              style: TextStyles.logoTextMobile1,
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        isMobile
            ? SizedBox()
            : withDesktopMenu
                ? Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: SizedBox(
                      width: 1000,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 77, 0),
                            child: MenuTextBox(
                              text: "Головна",
                              isPressed: currentIndex == 0,
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                    (route) => false);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 77, 0),
                            child: MenuTextBox(
                              text: "Каталог",
                              isPressed: currentIndex == 1,
                              onTap: () {
                                BlocProvider.of<CatalogBloc>(context)
                                    .add(LoadAllToCatalog());
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => CatalogPage()),
                                    (route) => false);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 77, 0),
                            child: MenuTextBox(
                              isPressed: currentIndex == 2,
                              text: "Оплата",
                            ),
                          ),
                          MenuTextBox(
                            isPressed: currentIndex == 3,
                            text: "Контакти",
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
      ],
    );
  }
}
