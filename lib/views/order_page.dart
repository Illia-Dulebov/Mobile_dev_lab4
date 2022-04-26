import 'package:edu_books_flutter/bloc/myorders/myorders_bloc.dart';
import 'package:edu_books_flutter/models/book_model.dart';
import 'package:edu_books_flutter/styles/text_styles.dart';
import 'package:edu_books_flutter/views/home_page.dart';
import 'package:edu_books_flutter/views/payment_page.dart';
import 'package:edu_books_flutter/widgets/buttons/cart_button.dart';
import 'package:edu_books_flutter/widgets/buttons/primary_buttons.dart';
import 'package:edu_books_flutter/widgets/buttons/svg_icon_buttons.dart';
import 'package:edu_books_flutter/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/order_model.dart';
import '../widgets/payment_widget.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key, required this.order}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;

    List<Widget> getOrderMobile() {
      return [
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Замовлення #${order.id}',
                style: TextStyles.bucketPageInfoHeaderMobile,
              ),
              Container(
                decoration: BoxDecoration(
                  color: primaryColors[0].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  child: Center(
                    child: Text(
                      order.orderStatus.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColors[0],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: OrderItemsList(),
        ),
        OrderDescription(
          order: order,
        ),
      ];
    }

    List<Widget> getOrderDesktop() {
      return [
        Expanded(child: OrderItemsList()),
        SizedBox(
          width: 70,
        ),
        Expanded(
            child: OrderDescription(
          order: order,
        )),
      ];
    }

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
              padding: EdgeInsets.only(
                top: isMobile ? 0.0 : 220.0,
              ),
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
                          ? EdgeInsets.fromLTRB(25, 130, 25, 100)
                          : EdgeInsets.fromLTRB(0, 0, 0, 100),
                      child: Center(
                        child: SizedBox(
                          width: isMobile ? double.infinity : 1000,
                          child: Column(
                            children: [
                              isMobile
                                  ? SizedBox()
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 65),
                                      child: Text(
                                        'Мої замовлення',
                                        style: TextStyles.logoTextMobile1,
                                      ),
                                    ),
                              Flex(
                                crossAxisAlignment: isMobile
                                    ? CrossAxisAlignment.center
                                    : CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                direction:
                                    isMobile ? Axis.vertical : Axis.horizontal,
                                children: isMobile
                                    ? getOrderMobile()
                                    : getOrderDesktop(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            order.orderStatus == 'Не оплачено'
                ? isMobile
                    ? Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 25),
                            color: Colors.transparent,
                            width: 340,
                            child: PrimaryButton(
                              buttonHeight: 56,
                              title: 'оплатити замовлення',
                              onTap: () {
                                if (isMobile) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PaymentPage(orderiD: order.id, sum: order.sum)));
                                } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Center(child: PaymentWidget(orderiD: order.id, sum: order.sum)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                      );
                                    }
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      )
                    : SizedBox()
                : isMobile
                    ? Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 25),
                            color: Colors.transparent,
                            width: 340,
                            child: PrimaryButton(
                              buttonHeight: 56,
                              title: 'повернутися на головну',
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                    (route) => false);
                              },
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
            Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height / 1.7,
              child: CartButton(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: isMobile
                  ? NavBar(
                      title: 'Мої замовлення',
                      svgIconButton: SvgIconButton(
                        width: isMobile ? 20 : 34,
                        height: isMobile ? 20 : 34,
                        assetName: 'assets/icons/arrow_back.svg',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      withAccountIcon: false,
                    )
                  : NavBar(
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

class OrderItemsList extends StatelessWidget {
  const OrderItemsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyOrdersBloc, MyOrdersState>(
      builder: (context, state) {
        if (state is MyOrdersSuccess) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: state.orderBooks.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: InkWell(
                  highlightColor: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {},
                  child: OrderItemBox(book: state.orderBooks[index]),
                ),
              );
            },
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

class OrderItemBox extends StatelessWidget {
  const OrderItemBox({Key? key, required this.book}) : super(key: key);

  final BookModel book;

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
                      SizedBox(
                          width: isMobile
                              ? MediaQuery.of(context).size.width * 0.5
                              : MediaQuery.of(context).size.width * 0.2,
                          child: Text(
                            '${book.classId} клас, ${book.name}',
                            style: isMobile
                                ? TextStyles.bucketBoxheaderMobile
                                : TextStyles.bucketBoxheaderDesktop,
                          )),
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
                            '${book.price.toStringAsFixed(2)} грн',
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

class OrderDescription extends StatelessWidget {
  const OrderDescription({Key? key, required this.order}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isMobile
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  'Замовлення #' + order.id.toString(),
                  style: TextStyles.bucketPageInfoHeaderMobile.copyWith(
                    fontSize: 24,
                  ),
                ),
              ),
        isMobile
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.only(bottom: 75),
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColors[0].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    child: Center(
                      child: Text(
                        order.orderStatus.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primaryColors[0],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Інформація про замовлення',
            style: TextStyles.bucketPageInfoHeaderMobile,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Проміжна сума:',
                style: TextStyles.subTitleMobile1,
              ),
              Text(
                '${order.sum?.toStringAsFixed(2) ?? 0} грн',
                style: TextStyles.orderCheckPrice,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Заощаджено за кодом:',
                style: TextStyles.subTitleMobile1,
              ),
              Text(
                '1 грн',
                style: TextStyles.orderCheckPrice,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'загальна сума'.toUpperCase(),
                style: TextStyles.bucketBoxPriceMobile,
              ),
              Text(
                '${order.sum?.toStringAsFixed(2) ?? 0} грн',
                style: TextStyles.orderCheckPriceViolet,
              )
            ],
          ),
        ),
        order.orderStatus == 'Не оплачено'
            ? isMobile
                ? SizedBox()
                : Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      color: Colors.transparent,
                      width: 340,
                      child: PrimaryButton(
                        buttonHeight: 56,
                        title: 'оплатити замовлення',
                        onTap: () {
                          if (isMobile) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PaymentPage(orderiD: order.id, sum: order.sum,)));
                          } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Center(child: PaymentWidget(orderiD: order.id, sum: order.sum,)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25)),
                                );
                              }
                            );
                          }
                        },
                      ),
                    ),
                  )
            : isMobile
                ? SizedBox()
                : Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      color: Colors.transparent,
                      width: 340,
                      child: PrimaryButton(
                        buttonHeight: 56,
                        title: 'повернутися на головну',
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              (route) => false);
                        },
                      ),
                    ),
                  ),
      ],
    );
  }
}
