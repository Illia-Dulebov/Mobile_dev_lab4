import 'package:edu_books_flutter/styles/text_styles.dart';
import 'package:flutter/material.dart';

import 'book_box.dart';

class BookHorizontalNamedList extends StatelessWidget {
  final String nameCat;
  final List bookList;
  final bool isSale;

  const BookHorizontalNamedList(
      {Key? key,
      required this.nameCat,
      required this.isSale,
      this.onMoreButtonTap,
      required this.bookList})
      : super(key: key);

  final void Function()? onMoreButtonTap;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;

    if (bookList.isNotEmpty) {
      return Column(
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.081,
                  50,
                  MediaQuery.of(context).size.width * 0.09,
                  0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    nameCat,
                    style: isMobile
                        ? TextStyles.headlineMobile1
                        : TextStyles.headlineMobile1.copyWith(
                            fontSize: 24,
                          ),
                  ),
                  InkWell(
                      onTap: () {
                        if (onMoreButtonTap != null) {
                          onMoreButtonTap!();
                        }
                      },
                      child: Text(
                        "Переглянути всі",
                        style: isMobile
                            ? TextStyles.bodyMobile1
                            : TextStyles.bodyMobile1.copyWith(
                                fontSize: 16,
                              ),
                      ))
                ],
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.08,
                          0,
                          MediaQuery.of(context).size.width * 0.1,
                          0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width < 1000 ? 260 : 320,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(bookList.length, (index) {
                              return Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0,
                                      0,
                                      MediaQuery.of(context).size.width < 1000
                                          ? 20
                                          : 44,
                                      0),
                                  child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width < 1000
                                              ? 115
                                              : 160,
                                      child: BookBox(
                                          bookModel: bookList[index],)));
                            })),
                      )))),
        ],
      );
    } else {
      return Container();
    }
  }
}
