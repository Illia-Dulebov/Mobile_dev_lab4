import 'dart:math';

import 'package:edu_books_flutter/bloc/catalog/catalog_bloc.dart';
import 'package:edu_books_flutter/painters/catalog_painters.dart';
import 'package:edu_books_flutter/styles/text_styles.dart';
import 'package:edu_books_flutter/widgets/book_box.dart';
import 'package:edu_books_flutter/widgets/buttons/cart_button.dart';
import 'package:edu_books_flutter/widgets/buttons/filter_button.dart';
import 'package:edu_books_flutter/widgets/buttons/svg_icon_buttons.dart';
import 'package:edu_books_flutter/widgets/drawer_menu.dart';
import 'package:edu_books_flutter/widgets/filters_widget.dart';
import 'package:edu_books_flutter/widgets/buttons/primary_buttons.dart';
import 'package:edu_books_flutter/widgets/navigation_bar.dart';
import 'package:edu_books_flutter/widgets/search_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'home_page.dart';

class CatalogPage extends StatelessWidget {
  CatalogPage({Key? key, this.header, this.searchIsFocused = false})
      : super(key: key);

  final bool searchIsFocused;
  final String? header;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
        return false;
      },
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Scaffold(
          key: _key,
          drawer: DrawerMenu(currentIndex: 1),
          drawerEnableOpenDragGesture: false,
          endDrawer: Drawer(
            child: Stack(children: [
              SingleChildScrollView(
                primary: false,
                controller: ScrollController(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25, bottom: 50, top: 50, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 13),
                        child: SvgIconButton(
                            assetName: 'assets/icons/close.svg',
                            width: 14,
                            height: 14,
                            onTap: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      FiltersWidget()
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 0.0,
                  right: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 63),
                    child: BlocBuilder<CatalogBloc, CatalogState>(
                      builder: (context, state) {
                        return state is CatalogSuccess
                            ? PrimaryButton(
                                buttonHeight: 42,
                                onTap: () {
                                  BlocProvider.of<CatalogBloc>(context)
                                      .add(ConfirmFilters());
                                  BlocProvider.of<CatalogBloc>(context).add(
                                      SearchFromCatalog(
                                          input: state.currentInput));
                                  Navigator.of(context).pop();
                                },
                                title: "Застосувати")
                            : Container();
                      },
                    ),
                  ))
            ]),
          ),
          endDrawerEnableOpenDragGesture: false,
          body: Stack(children: [
            isMobile
                ? Container()
                : SvgPicture.asset(
                    'assets/images/background_desktop.svg',
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill,
                  ),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: min(1000.0, MediaQuery.of(context).size.width),
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      physics: const ClampingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          children: [
                            !isMobile
                                ? Column(
                                    children: [
                                      NavBar(
                                        currentIndex: 1,
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 30, 0, 59),
                                          child: SizedBox(
                                              width: 300,
                                              height: 50,
                                              child: SearchForm(
                                                searchIsFocused:
                                                    searchIsFocused,
                                              ))),
                                    ],
                                  )
                                : Container(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: BlocBuilder<CatalogBloc, CatalogState>(
                                    builder: (context, state) {
                                      if (state is CatalogFailure) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              top: isMobile ? 220 : 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    'Упс!\n Не вдалося завантажити книги каталогу.',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        TextStyles.errorMessage,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (state is CatalogSuccess) {
                                        return state.filteredBookList.isEmpty
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                    top: isMobile ? 240 : 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          'По вашому запиту не знайдено жодної книжки.',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyles
                                                              .errorMessage,
                                                        ),
                                                      ),
                                                    ),
                                                    !isMobile
                                                        ? Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 20),
                                                            width: 300,
                                                            child: Column(
                                                              children: [
                                                                FiltersWidget(),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right: 28,
                                                                      left: 28),
                                                                  child:
                                                                      PrimaryButton(
                                                                          buttonHeight:
                                                                              42,
                                                                          onTap:
                                                                              () {
                                                                            BlocProvider.of<CatalogBloc>(context).add(ConfirmFilters());
                                                                            BlocProvider.of<CatalogBloc>(context).add(SearchFromCatalog(input: state.currentInput));
                                                                          },
                                                                          title:
                                                                              "Застосувати"),
                                                                )
                                                              ],
                                                            ))
                                                        : Container()
                                                  ],
                                                ),
                                              )
                                            : Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: LayoutBuilder(
                                                      builder: (context,
                                                          constraints) {
                                                        int count = min(
                                                            max(
                                                                (constraints.maxWidth /
                                                                        200.0)
                                                                    .round(),
                                                                1),
                                                            5);
                                                        return GridView.builder(
                                                            shrinkWrap: true,
                                                            primary: false,
                                                            padding: isMobile
                                                                ? EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25,
                                                                        top:
                                                                            220,
                                                                        right:
                                                                            25)
                                                                : EdgeInsets
                                                                    .only(
                                                                        top: 20,
                                                                        right:
                                                                            86),
                                                            physics: isMobile
                                                                ? const ClampingScrollPhysics()
                                                                : const NeverScrollableScrollPhysics(),
                                                            itemCount: state
                                                                .filteredBookList
                                                                .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return LimitedBox(
                                                                  maxHeight:
                                                                      300,
                                                                  child:
                                                                      BookBox(
                                                                    bookModel:
                                                                        state.filteredBookList[
                                                                            index],
                                                                    isCatalog:
                                                                        true,
                                                                    count:
                                                                        count,
                                                                  ));
                                                            },
                                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    count,
                                                                mainAxisSpacing:
                                                                    30,
                                                                crossAxisSpacing:
                                                                    25,
                                                                childAspectRatio:
                                                                    156 / 316));
                                                      },
                                                    ),
                                                  ),
                                                  !isMobile
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 20),
                                                          width: 300,
                                                          child: Column(
                                                            children: [
                                                              FiltersWidget(),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            28,
                                                                        left:
                                                                            28),
                                                                child:
                                                                    PrimaryButton(
                                                                        buttonHeight:
                                                                            42,
                                                                        onTap:
                                                                            () {
                                                                          BlocProvider.of<CatalogBloc>(context)
                                                                              .add(ConfirmFilters());
                                                                          BlocProvider.of<CatalogBloc>(context)
                                                                              .add(SearchFromCatalog(input: state.currentInput));
                                                                        },
                                                                        title:
                                                                            "Застосувати"),
                                                              )
                                                            ],
                                                          ))
                                                      : Container()
                                                ],
                                              );
                                      } else {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              top: isMobile ? 220 : 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: Color(0xFF6957FE),
                                              )),
                                            ],
                                          ),
                                        );
                                      }
                                    },
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
            isMobile
                ? Container(
                    color: Colors.transparent,
                    height: 205,
                    child: CustomPaint(
                      painter: CatalogMobileBackgroundPainter(),
                      child: Column(
                        children: [
                          NavBar(
                            svgIconButton: SvgIconButton(
                              assetName: 'assets/icons/menu.svg',
                              onTap: () {
                                _key.currentState?.openDrawer();
                              },
                            ),
                            title: header == null ? 'Каталог' : header!,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 18, left: 25, right: 25),
                            child: SearchForm(
                              searchIsFocused: searchIsFocused,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 25),
                                  child: FilterButton(
                                    onTap: () {
                                      _key.currentState?.openEndDrawer();
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(),
            Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height / 1.7,
              child: CartButton(),
            ),
          ]),
        ),
      ),
    );
  }
}
