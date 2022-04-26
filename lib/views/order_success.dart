import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/text_styles.dart';
import '../widgets/buttons/primary_buttons.dart';
import 'home_page.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;
    return Scaffold(
        body: Stack(
      children: [
        isMobile
            ? SizedBox()
            : SvgPicture.asset(
                'assets/images/background_desktop.svg',
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
        SingleChildScrollView(
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
                    ? EdgeInsets.fromLTRB(25, 80, 25, 50)
                    : EdgeInsets.fromLTRB(0, 0, 0, 80),
                child: Center(
                  child: SizedBox(
                    width: isMobile ? double.infinity : 1000,
                    child: Flex(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        direction: isMobile ? Axis.vertical : Axis.horizontal,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: 240,
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 22, 0, 25),
                                    child: Text(
                                      "Дякуємо!",
                                      style: TextStyles.emptyBucketFirstText,
                                      textAlign: TextAlign.center,
                                    )),
                                Text(
                                  'Ваше замовлення успішно оформлене!\nНезабаром ви отримаєте замовлення електронною поштою.',
                                  textAlign: TextAlign.center,
                                  style: TextStyles.subTitleMobile1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: SizedBox(
                                    width: 67,
                                    child: Image.asset(
                                        'assets/images/order_success.png'),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        25,
                                        MediaQuery.of(context).size.height *
                                            0.2,
                                        25,
                                        0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            width: 400,
                                            child: Column(
                                              children: [
                                                PrimaryButton(
                                                  buttonHeight: 56,
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        HomePage()),
                                                            (route) => false);
                                                  },
                                                  title:
                                                      "Повернутись на головну",
                                                ),
                                              ],
                                            )),
                                      ],
                                    )),
                              ])
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
