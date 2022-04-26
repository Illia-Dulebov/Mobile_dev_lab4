import 'package:edu_books_flutter/views/payment_page.dart';
import 'package:edu_books_flutter/widgets/payment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bucket/bucket_bloc.dart';
import '../bloc/orders/order_bloc.dart';
import '../styles/text_styles.dart';
import 'buttons/email_checkout_button.dart';
import 'buttons/primary_buttons.dart';
import 'buttons/promo_checkout_button.dart';

class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;

    return BlocBuilder<BucketBloc, BucketState>(
        builder: (context, bucketState) {
      if (bucketState is BucketStateLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (bucketState is BucketStateSuccess) {
        double summary = bucketState.bucket.isNotEmpty
            ? bucketState.bucket
                .map((e) => e.sailPrice ?? e.price)
                .toList()
                .reduce((a, b) => a + b)
            : 0.0;
        return SizedBox(
          height: 650,
          width: 390,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                    child: Text(
                      "Оформити замовлення",
                      style: TextStyles.errorMessage,
                    )),
                CheckoutButtonEmail(),
                CheckoutButtonPromo(),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 31, 0, 0),
                    child: SizedBox(
                        height: 150,
                        width: 339,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Text(
                                      "Інформація про замовлення",
                                      style:
                                          TextStyles.bucketPageInfoHeaderMobile,
                                    )
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Проміжна сума:",
                                      style: TextStyles.subTitleMobile1,
                                    ),
                                    Text(
                                      summary.toStringAsFixed(1) + "грн",
                                      style: TextStyles.orderCheckPrice,
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Заощаджено за кодом:",
                                      style: TextStyles.subTitleMobile1,
                                    ),
                                    Text(
                                      "1 грн",
                                      style: TextStyles.orderCheckPrice,
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "ЗАГАЛЬНА СУМА",
                                      style: TextStyles.bucketBoxPriceMobile,
                                    ),
                                    Text(
                                      summary.toStringAsFixed(1) + "ГРН",
                                      style: TextStyles.orderCheckPriceViolet,
                                    )
                                  ],
                                ))
                          ],
                        ))),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 65),
                    child: SizedBox(
                      width: 340,
                      child: PrimaryButtonWithPrice(
                        price: summary.toStringAsFixed(1),
                        title: 'Перейти до оплати',
                        onTap: () {
                          if (isMobile) {
                            BlocProvider.of<OrderBloc>(context)
                                .add(MakeOrderOnClick());
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PaymentPage()));
                            const snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 5),
                              content: Text('Ваше замовлення збережено! Для підтвердження замовлення необхідно провести оплату зараз або в будь-який зручний час в списку ваших замовлень в особистому акаунті',),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else {
                            BlocProvider.of<OrderBloc>(context)
                                .add(MakeOrderOnClick());
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Center(child: PaymentWidget(showSnackBar: true)),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                  );
                                });
                            const snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 5),
                              content: Text('Ваше замовлення збережено! Для підтвердження замовлення необхідно провести оплату зараз або в будь-який зручний час в списку ваших замовлень в особистому акаунті',),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Center(
          child: Text("Chechout problem"),
        );
      }
    });
  }
}
