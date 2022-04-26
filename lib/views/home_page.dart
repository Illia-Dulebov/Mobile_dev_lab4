import 'package:edu_books_flutter/views/catalog_page.dart';
import 'package:edu_books_flutter/widgets/buttons/cart_button.dart';
import 'package:edu_books_flutter/widgets/buttons/svg_icon_buttons.dart';
import 'package:edu_books_flutter/widgets/drawer_menu.dart';
import 'package:edu_books_flutter/widgets/named_horizontal_list.dart';
import 'package:edu_books_flutter/widgets/navigation_bar.dart';
import 'package:edu_books_flutter/widgets/search_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/catalog/catalog_bloc.dart';
import '../bloc/home/home_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;

    //NetworkRepository().getCart();

    return Scaffold(
      key: _key,
      drawer: DrawerMenu(
        currentIndex: 0,
      ),
      drawerEnableOpenDragGesture: false,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeSuccess) {
            return Stack(
              children: [
                isMobile
                    ? Container()
                    : SvgPicture.asset(
                        'assets/images/background_desktop.svg',
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.fill,
                      ),
                Column(
                  children: [
                    NavBar(
                      svgIconButton: isMobile
                          ? SvgIconButton(
                              assetName: 'assets/icons/burger_menu.svg',
                              width: isMobile ? 20 : 34,
                              height: isMobile ? 20 : 34,
                              onTap: () {
                                _key.currentState?.openDrawer();
                              },
                            )
                          : null,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            isMobile
                                ? SvgPicture.asset(
                                    'assets/images/background.svg',
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                  )
                                : Container(),
                            Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                            width: 258,
                                            height: 41,
                                            child: SearchForm()),
                                        Positioned.fill(
                                            child: GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<CatalogBloc>(
                                                    context)
                                                .add(LoadAllToCatalog());
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CatalogPage(
                                                          searchIsFocused: true,
                                                        )),
                                                (route) => false);
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                          ),
                                        ))
                                      ],
                                    )),
                                BookHorizontalNamedList(
                                  nameCat: "Популярні",
                                  isSale: false,
                                  bookList: state.bookMap['popular'] as List,
                                  onMoreButtonTap: () {
                                    BlocProvider.of<CatalogBloc>(context)
                                        .add(LoadPopularToCatalog());
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => CatalogPage(
                                                  header: "Популярні",
                                                )),
                                        (route) => false);
                                  },
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        state.bookMap['visited']!.isEmpty
                                            ? 30
                                            : 0),
                                    child: BookHorizontalNamedList(
                                      nameCat: "Акційні пропозиції",
                                      isSale: true,
                                      bookList: state.bookMap['sale'] as List,
                                      onMoreButtonTap: () {
                                        BlocProvider.of<CatalogBloc>(context)
                                            .add(LoadShareToCatalog());
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CatalogPage(
                                                          header: "Акції",
                                                        )),
                                                (route) => false);
                                      },
                                    )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                                    child: BookHorizontalNamedList(
                                      nameCat: "Відвідані товари",
                                      isSale: false,
                                      bookList:
                                          state.bookMap['visited'] as List,
                                      onMoreButtonTap: () {
                                        BlocProvider.of<CatalogBloc>(context)
                                            .add(LoadRecentToCatalog());
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CatalogPage(
                                                          header: "Відвідані",
                                                        )),
                                                (route) => false);
                                      },
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  top: MediaQuery.of(context).size.height / 1.3,
                  child: CartButton(),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Error loading home"),
            );
          }
        }),
      ),
    );
  }
}
