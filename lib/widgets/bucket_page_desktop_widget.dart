import 'package:edu_books_flutter/models/book_model.dart';

import 'package:edu_books_flutter/widgets/%D1%81heckout_widget.dart';
import 'package:edu_books_flutter/widgets/login_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authorization/auth_bloc.dart';
import '../bloc/authorization/auth_state.dart';
import 'bucket_item.dart';

class DesktopBucket extends StatelessWidget {
  const DesktopBucket({Key? key, required this.bookList}) : super(key: key);
  final List<BookModel> bookList;

  @override
  Widget build(BuildContext context) {

    return Expanded(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 6,
            child: Column(
              children: List.generate(bookList.length, (index) {
                return Padding(
                    padding: EdgeInsets.fromLTRB(0, index == 0 ? 45 : 25, 0, 0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: BucketBox(
                          book: bookList[index],
                        )));
              }),
            )),
        BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          return Padding(
              padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
              child: Column(
                children: [
                  state.userStatus == UserStatus.authenticated
                      ? CheckoutWidget()
                      : SizedBox(height: 500, width: 380, child: LoginWidget())
                ],
              ));
        })
      ],
    ));
  }
}
