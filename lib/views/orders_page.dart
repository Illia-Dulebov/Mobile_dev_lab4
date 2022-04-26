import 'package:edu_books_flutter/bloc/myorders/myorders_bloc.dart';
import 'package:edu_books_flutter/styles/text_styles.dart';
import 'package:edu_books_flutter/views/home_page.dart';
import 'package:edu_books_flutter/views/order_page.dart';
import 'package:edu_books_flutter/widgets/buttons/cart_button.dart';
import 'package:edu_books_flutter/widgets/buttons/primary_buttons.dart';
import 'package:edu_books_flutter/widgets/buttons/svg_icon_buttons.dart';
import 'package:edu_books_flutter/widgets/navigation_bar.dart';
import 'package:edu_books_flutter/widgets/order_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'catalog_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;

    List<Widget> getEmptyOrder(bool isMobile) {
      return [
        Padding(
          padding: const EdgeInsets.only(bottom: 25, top: 50),
          child: EmptyOrdersImage(
            imageSize: isMobile ? 240 : 550,
          ),
        ),
        SizedBox(
          width: isMobile ? 0 : 70,
        ),
        isMobile
            ? EmptyOrdersInfo()
            : Expanded(
                child: EmptyOrdersInfo(),
              ),
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
                          ? EdgeInsets.fromLTRB(25, 130, 25, 75)
                          : EdgeInsets.fromLTRB(0, 0, 0, 100),
                      child: Center(
                        child: SizedBox(
                          width: isMobile ? double.infinity : 700,
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
                              BlocBuilder<MyOrdersBloc, MyOrdersState>(
                                builder: (context, state) {
                                  if(state is MyOrdersLoading){
                                    return Center(child: CircularProgressIndicator(),);
                                  }
                                  else if(state is MyOrdersSuccess){
                                    if(state.orders.isEmpty){
                                      return Flex(
                                        crossAxisAlignment: isMobile
                                            ? CrossAxisAlignment.center
                                            : CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        direction:
                                            isMobile ? Axis.vertical : Axis.horizontal,
                                        children: getEmptyOrder(isMobile));
                                    }
                                    else{
                                      return ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: state.orders.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 20),
                                            child: InkWell(
                                              highlightColor:
                                                  Colors.white.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              onTap: () {
                                                BlocProvider.of<MyOrdersBloc>(context).add(LoadOrderDetail(id: state.orders[index].id));
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderPage(order: state.orders[index]),
                                                  ),
                                                );
                                              },
                                              child: OrderBox(order: state.orders[index]),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }
                                  else{
                                    return Center(
                                      child: Text(
                                        'Упс!\n Не вдалося завантажити ваші замовлення.',
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyles.errorMessage,
                                      ),
                                    );
                                  }
                                  
                                },
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
            Positioned.fill(
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
            ),
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


class EmptyOrdersInfo extends StatelessWidget {
  const EmptyOrdersInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Text(
            "Ви ще не зробили жодного замовлення",
            style: TextStyles.emptyBucketFirstText,
            textAlign: TextAlign.center,
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Перейдіть до ',
            style: TextStyles.bucketPageInfoPriceMobile,
            children: <TextSpan>[
              TextSpan(
                  text: 'Каталогу',
                  style: TextStyles.emptyBucketCatalog,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CatalogPage(),
                        ),
                      );
                    }),
              TextSpan(text: ', щоб зробити замовлення'),
            ],
          ),
        ),
        SizedBox(
          height: isMobile ? 60 : 100,
        ),
        // Container(
        //   margin: const EdgeInsets.only(bottom: 25),
        //   color: Colors.transparent,
        //   width: 340,
        //   child: PrimaryButton(
        //     buttonHeight: 56,
        //     title: 'повернутися на головну',
        //     onTap: () {
        //       Navigator.of(context).pushAndRemoveUntil(
        //           MaterialPageRoute(
        //             builder: (context) => HomePage(),
        //           ),
        //           (route) => false);
        //     },
        //   ),
        // ),
      ],
    );
  }
}

class EmptyOrdersImage extends StatelessWidget {
  final double imageSize;

  const EmptyOrdersImage({
    Key? key,
    required this.imageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: imageSize,
      height: imageSize,
      child: Image.asset('assets/images/books_image.png'),
    );
  }
}
