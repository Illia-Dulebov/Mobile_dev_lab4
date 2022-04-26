import 'package:edu_books_flutter/widgets/payment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/buttons/svg_icon_buttons.dart';
import '../widgets/navigation_bar.dart';

class PaymentPage extends StatelessWidget{
  const PaymentPage({Key? key, this.orderiD, this.sum}) : super(key: key);
  final int? orderiD;
  final double? sum;
  
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              isMobile
                  ? Container()
                  : SvgPicture.asset(
                      'assets/images/background_desktop.svg',
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.fill,
                    ),
              SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: isMobile ? MediaQuery.of(context).size.width : 1000,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            isMobile
                                ? LimitedBox(
                                  maxHeight: MediaQuery.of(context).size.height * 0.33,
                                  child: SvgPicture.asset(
                                      'assets/images/background.svg',
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.fill,
                                    ),
                                )
                                : Container(),
                            NavBar(
                              title: 'Оплата',
                              isTransparent: true,
                              withAccountIcon: false,
                              svgIconButton: SvgIconButton(
                                width: isMobile ? 20 : 34,
                                height: isMobile ? 20 : 34,
                                assetName: 'assets/icons/arrow_back.svg',
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            !isMobile ?
                            Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: SizedBox(
                                width: 470,
                                height: 470,
                              ),
                            ) : Container(),
                            Expanded(
                              child: Padding(
                                padding: isMobile
                                    ? EdgeInsets.fromLTRB(25, 10, 25, 70)
                                    : EdgeInsets.fromLTRB(0, 45, 0, 100),
                                child: PaymentWidget(orderiD: orderiD, sum: sum,)
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

}