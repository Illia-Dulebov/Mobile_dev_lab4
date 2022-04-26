import 'package:edu_books_flutter/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bucket/bucket_bloc.dart';
import '../styles/text_styles.dart';
import 'buttons/svg_icon_buttons.dart';

class BucketBox extends StatelessWidget {
  final BookModel book;
  const BucketBox({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;

    return Container(
      width: isMobile
          ? MediaQuery.of(context).size.width * 0.85
          : MediaQuery.of(context).size.width * 0.4,
      height: isMobile ? 86 : 105,
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(book.image),
              )),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 4, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: isMobile
                                  ? MediaQuery.of(context).size.width * 0.5
                                  : MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                book.classId.toString() +
                                    " класс, " +
                                    book.name,
                                style: isMobile
                                    ? TextStyles.bucketBoxheaderMobile
                                    : TextStyles.bucketBoxheaderDesktop,
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 4, 8, 0),
                              child: SvgIconButton(
                                assetName: 'assets/icons/cancel_black.svg',
                                width: isMobile ? 14 : 17,
                                height: isMobile ? 14 : 17,
                                onTap: () {
                                  BlocProvider.of<BucketBloc>(context).add(
                                      BucketBookPressedDeleted(
                                          bucketBook: book));
                                },
                              ))
                        ],
                      ),
                      Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Text(
                            book.author,
                            textAlign: TextAlign.start,
                            style: isMobile
                                ? TextStyles.bucketBoxAuthorMobile
                                : TextStyles.bucketBoxAuthorDesktop,
                          )),
                      Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Text(
                            book.sailPrice != null
                                ? book.sailPrice!.toStringAsFixed(1)
                                : book.price.toString(),
                            textAlign: TextAlign.start,
                            style: isMobile
                                ? TextStyles.bucketBoxPriceMobile
                                : TextStyles.bucketBoxPriceDesktop,
                          )),
                    ],
                  ))),
        ],
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
