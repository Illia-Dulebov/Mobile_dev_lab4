import 'package:edu_books_flutter/models/book_model.dart';
import 'package:edu_books_flutter/widgets/checkout_modal_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authorization/auth_bloc.dart';
import '../bloc/authorization/auth_state.dart';
import '../bloc/bucket/bucket_bloc.dart';
import '../styles/text_styles.dart';
import '../views/login_page.dart';
import 'bucket_item.dart';
import 'buttons/primary_buttons.dart';

class MobileBucket extends StatelessWidget {
  const MobileBucket({Key? key, required this.bookList}) : super(key: key);
  final List<BookModel> bookList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BucketBloc, BucketState>(builder: (context, state) {
      if (state is BucketStateLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is BucketStateSuccess) {
        double? summary = state.bucket
            .map((e) => e.sailPrice ?? e.price)
            .toList()
            .reduce((a, b) => a + b);
        return Column(
          children: [
            Column(
              children: List.generate(bookList.length, (index) {
                return Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: BucketBox(
                          book: bookList[index],
                        )));
              }),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 59,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Інформація про замовлення',
                        textAlign: TextAlign.start,
                        style: TextStyles.bucketPageInfoHeaderMobile),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Проміжна сума',
                              textAlign: TextAlign.start,
                              style: TextStyles.bucketPageInfoPriceMobile),
                          Text(summary.toStringAsFixed(1) + 'грн',
                              textAlign: TextAlign.start,
                              style: TextStyles.bucketPageInfoHeaderMobile),
                        ]),
                  ],
                )),
            BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              return Padding(
                padding: EdgeInsets.fromLTRB(30, 58, 25, 0),
                child: SizedBox(
                    height: 56,
                    child: PrimaryButton(
                      buttonHeight: 56,
                      onTap: () {
                        if (state.userStatus == UserStatus.authenticated) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ModalCheckout();
                              });
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }
                      },
                      title: "Оформити замовлення",
                    )),
              );
            })
          ],
        );
      } else {
        return Center(
          child: Text("summary problem"),
        );
      }
    });
  }
}
