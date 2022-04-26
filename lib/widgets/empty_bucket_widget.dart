import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/catalog/catalog_bloc.dart';
import '../styles/text_styles.dart';
import '../views/catalog_page.dart';
import '../views/home_page.dart';
import 'buttons/primary_buttons.dart';

class EmptyBucket extends StatelessWidget {
  const EmptyBucket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image(
        height: 240,
        width: 240,
        fit: BoxFit.fill,
        image: AssetImage("assets/images/books_image.png"),
      ),
      Padding(
          padding: EdgeInsets.fromLTRB(0, 22, 0, 25),
          child: Text(
            "Ви ще не додали жодного товару",
            style: TextStyles.emptyBucketFirstText,
            textAlign: TextAlign.center,
          )),
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
                      BlocProvider.of<CatalogBloc>(context)
                          .add(LoadAllToCatalog());
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => CatalogPage()),
                          (route) => false);
                    }),
              TextSpan(text: ', щоб додати товар до кошику'),
            ],
          )),
      Padding(
          padding: EdgeInsets.fromLTRB(
              25, MediaQuery.of(context).size.height * 0.2, 25, 0),
          child: SizedBox(
              height: 56,
              width: 400,
              child: PrimaryButton(
                buttonHeight: 56,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                title: "ПОВЕРНУТИСЯ НА ГОЛОВНУ",
              ))),
    ]);
  }
}
