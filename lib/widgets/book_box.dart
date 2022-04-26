import 'package:edu_books_flutter/bloc/home/home_bloc.dart';
import 'package:edu_books_flutter/models/book_model.dart';
import 'package:edu_books_flutter/views/book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Book/book_bloc.dart';
import '../bloc/bucket/bucket_bloc.dart';

class BookBox extends StatelessWidget {
  const BookBox(
      {Key? key,
      required this.bookModel,
      this.isCatalog = false,
      this.count = 4})
      : super(key: key);

  final BookModel bookModel;
  final bool isCatalog;
  final int count;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;

    return Material(
      color: Colors.transparent,
      child: InkWell(
          splashColor: Color.fromRGBO(105, 87, 254, 1).withOpacity(0.2),
          onTap: () {
            BlocProvider.of<HomeBloc>(context).add(UpdateVisited(bookId: bookModel.id));
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookPage(
                        bookModel: bookModel,
                      )),
            );
          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400]?.withOpacity(0.1),
                          ),
                          child: SizedBox(
                              height: isMobile
                                  ? (isCatalog
                                      ? (((MediaQuery.of(context).size.width -
                                                  50 -
                                                  25 * (count - 1)) /
                                              count) /
                                          0.49 *
                                          0.67)
                                      : 167)
                                  : (isCatalog ? 184 : 227),
                              width: isMobile ? 115 : 156,
                              child: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(bookModel.image),
                              )),
                        ),
                      ],
                    ),
                    Text(
                      "${bookModel.classId} клас, ${bookModel.name}",
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      bookModel.author,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(124, 124, 124, 1)),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: bookModel.sailPrice != null
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          bookModel.sailPrice != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 3, 0),
                                          child: Text(
                                              "${bookModel.price.toStringAsFixed(2)} грн",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      124, 124, 124, 1),
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400,
                                                  decoration: TextDecoration
                                                      .lineThrough))),
                                      Text(
                                          "${bookModel.sailPrice!.toStringAsFixed(2)} грн",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Color.fromRGBO(105, 87, 254, 1),
                                          ))
                                    ])
                              : Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${bookModel.price.toStringAsFixed(2)} грн",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                          BlocBuilder<BucketBloc, BucketState>(
                            builder: (context, state) {
                              if (state is BucketStateSuccess) {
                                return AnimatedCrossFade(
                                  duration: const Duration(microseconds: 500),
                                  firstChild: InkWell(
                                    child: Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 17,
                                    ),
                                    onTap: () {
                                      BlocProvider.of<BucketBloc>(context).add(
                                          BucketBookPressedAdded(
                                              bucketBook: bookModel));
                                    },
                                  ),
                                  secondChild: Icon(
                                    Icons.shopping_cart,
                                    size: 18,
                                  ),
                                  crossFadeState: state.bucket
                                          .where((element) =>
                                              element.id == bookModel.id)
                                          .toList()
                                          .isNotEmpty
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                );
                              } else {
                                return InkWell(
                                  child: Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 17,
                                  ),
                                );
                              }
                            },
                          )
                        ]))
              ])),
    );
  }
}
