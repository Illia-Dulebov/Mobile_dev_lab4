import 'package:edu_books_flutter/views/catalog_page.dart';
import 'package:edu_books_flutter/views/home_page.dart';
import 'package:edu_books_flutter/widgets/buttons/svg_icon_buttons.dart';
import 'package:edu_books_flutter/widgets/menu_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/catalog/catalog_bloc.dart';
import '../bloc/home/home_bloc.dart';

class DrawerMenu extends StatelessWidget {
  final int currentIndex;

  const DrawerMenu({
    Key? key,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white.withOpacity(0.82),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
          child: Stack(
            children: [
              Positioned(
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 54, 25, 0),
                  child: SvgIconButton(
                      assetName: 'assets/icons/close.svg',
                      width: 25,
                      height: 25,
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: MenuTextBox(
                        isPressed: currentIndex == 0,
                        text: "Головна",
                        onTap: () {
                          BlocProvider.of<HomeBloc>(context)
                              .add(LoadAllToHome());
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              (route) => false);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: MenuTextBox(
                        isPressed: currentIndex == 1,
                        text: "Каталог",
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
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
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
            ],
          ),
        ),
      ),
    );
  }
}
