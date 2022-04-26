import 'package:edu_books_flutter/bloc/authorization/auth_bloc.dart';
import 'package:edu_books_flutter/bloc/authorization/auth_event.dart';
import 'package:edu_books_flutter/bloc/authorization/auth_state.dart';
import 'package:edu_books_flutter/bloc/home/home_bloc.dart';
import 'package:edu_books_flutter/bloc/myorders/myorders_bloc.dart';
import 'package:edu_books_flutter/styles/text_styles.dart';
import 'package:edu_books_flutter/views/account_edit_page.dart';
import 'package:edu_books_flutter/views/home_page.dart';
import 'package:edu_books_flutter/views/orders_page.dart';
import 'package:edu_books_flutter/widgets/buttons/cart_button.dart';
import 'package:edu_books_flutter/widgets/buttons/primary_buttons.dart';
import 'package:edu_books_flutter/widgets/buttons/svg_icon_buttons.dart';
import 'package:edu_books_flutter/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/bucket/bucket_bloc.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            isMobile
                ? SizedBox()
                : SvgPicture.asset(
                    'assets/images/background_desktop.svg',
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill,
                  ),
            Padding(
              padding: EdgeInsets.only(top: isMobile ? 0.0 : 220.0),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    isMobile
                        ? SvgPicture.asset(
                            'assets/images/background.svg',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          )
                        : SizedBox(),
                    Padding(
                      padding: isMobile
                          ? EdgeInsets.fromLTRB(0, 130, 0, 50)
                          : EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Center(
                        child: SizedBox(
                          width: isMobile ? double.infinity : 1000,
                          child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                            switch (state.userStatus) {
                              case UserStatus.authenticated:
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 10),
                                      child: Container(
                                        width: isMobile ? 95 : 115,
                                        height: isMobile ? 95 : 115,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: primaryColors[0],
                                            width: 3.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              isMobile ? 3.0 : 4.0),
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              state.user?.avatar as String,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 10),
                                      child: RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: "Привіт, ",
                                              style: TextStyle(
                                                color: primaryColors[1],
                                                fontFamily: 'Manrope',
                                                fontSize: isMobile ? 18 : 20,
                                              ),
                                            ),
                                            TextSpan(
                                              text: state.user?.name,
                                              style: TextStyle(
                                                color: primaryColors[1],
                                                fontSize: isMobile ? 18 : 20,
                                                fontFamily: 'Manrope',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 45),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AccountEditPage(),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.create,
                                              color: primaryColors[2],
                                            ),
                                            Text(
                                              'Редагувати дані',
                                              style: TextStyle(
                                                fontSize: isMobile ? 12 : 15,
                                                color: primaryColors[2],
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: isMobile ? double.infinity : 475,
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        children: [
                                          Divider(
                                            height: 1,
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.person_outline,
                                              color: primaryColors[1],
                                            ),
                                            title: Text(
                                              state.user?.name as String,
                                              style: TextStyle(
                                                fontSize: isMobile ? 14 : 18,
                                                color: primaryColors[1],
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AccountEditPage(),
                                                ),
                                              );
                                            },
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 25),
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.mail_outline,
                                              color: primaryColors[1],
                                            ),
                                            title: Text(
                                              state.user?.email as String,
                                              style: TextStyle(
                                                fontSize: isMobile ? 14 : 18,
                                                color: primaryColors[1],
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AccountEditPage(),
                                                ),
                                              );
                                            },
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 25),
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.shopping_bag_outlined,
                                              color: primaryColors[1],
                                            ),
                                            title: Text(
                                              'Мої замовлення',
                                              style: TextStyle(
                                                fontSize: isMobile ? 14 : 18,
                                                color: primaryColors[1],
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            onTap: () {
                                              BlocProvider.of<MyOrdersBloc>(
                                                      context)
                                                  .add(LoadOrdersList());
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrdersPage(),
                                                ),
                                              );
                                            },
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 25),
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.menu_book_rounded,
                                              color: primaryColors[1],
                                            ),
                                            title: Text(
                                              'Контакти',
                                              style: TextStyle(
                                                fontSize: isMobile ? 14 : 18,
                                                color: primaryColors[1],
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            onTap: () {},
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 25),
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 55),
                                      child: SizedBox(
                                        width: 181,
                                        height: 42,
                                        child: PrimaryButton(
                                          buttonHeight: 42,
                                          title: 'вийти',
                                          onTap: () {
                                            BlocProvider.of<AuthBloc>(context)
                                                .add(Logout());
                                            BlocProvider.of<HomeBloc>(context)
                                                .add(DeleteVisited());
                                            BlocProvider.of<BucketBloc>(context)
                                                .add(BucketOnLogout());

                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage()),
                                                    (route) => false);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                );

                              case UserStatus.loading:
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF6957FE),
                                  ),
                                );
                              case UserStatus.unauthenticated:
                                return SizedBox();
                            }
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height / 1.7,
              child: CartButton(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: NavBar(
                currentIndex: -1,
                svgIconButton: SvgIconButton(
                  width: isMobile ? 20 : 34,
                  height: isMobile ? 20 : 34,
                  assetName: 'assets/icons/arrow_back.svg',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                withAccountIcon: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
