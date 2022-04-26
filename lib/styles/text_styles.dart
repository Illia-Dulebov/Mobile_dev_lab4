import 'package:flutter/material.dart';

const primaryColors = [
  Color(0xFF6957FE),
  Color(0xFF2B2B2B),
  Color(0xFF7C7C7C),
  Color(0x00a5a5a5),
];

const gradientColors = [Color(0xFF6957FE), Color(0xFF7B98FF)];

class TextStyles {
  static TextStyle logoTextMobile1 = TextStyle(
    fontSize: 24,
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w700,
    color: primaryColors[1],
  );

  static TextStyle logoTextDesktop1 = TextStyles.logoTextMobile1.copyWith(
    fontSize: 56,
  );

  static TextStyle logoTextMobile2 = TextStyle(
    fontSize: 24,
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w300,
    color: primaryColors[1],
  );

  static TextStyle logoTextDesktop2 = TextStyles.logoTextMobile2.copyWith(
    fontSize: 56,
  );

  static TextStyle menu = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: primaryColors[1],
  );

  static TextStyle menuTapped = TextStyles.menu.copyWith(
    color: primaryColors[0],
  );

  static TextStyle headlineMobile1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: primaryColors[1],
  );

  static TextStyle headlineDesktop1 = TextStyles.headlineMobile1.copyWith(
    fontSize: 30,
  );

  static TextStyle headlineMobile2 = TextStyle(
    fontSize: 18,
    color: primaryColors[2],
  );

  static TextStyle headlineDesktop2 = TextStyles.headlineMobile2.copyWith(
    fontSize: 24,
  );

  static TextStyle bodyMobile1 = TextStyle(
    fontSize: 12,
    color: primaryColors[2],
  );

  static TextStyle bodyDesktop1 = TextStyles.bodyMobile1.copyWith(
    fontSize: 17,
  );

  static TextStyle subTitleMobile1 = TextStyle(
    fontSize: 14,
    color: primaryColors[2],
  );

  static TextStyle subTitleDesktop1 = TextStyles.subTitleMobile1.copyWith(
    fontSize: 20,
  );

  static TextStyle primaryButton = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w800,
  );

  static TextStyle errorMessage = TextStyle(
    color: primaryColors[1],
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static TextStyle loginMobile1 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: primaryColors[1],
  );

  static TextStyle loginMobile2 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w300,
    color: primaryColors[1],
  );

  static TextStyle loginHeaderMobile = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w500,
    color: primaryColors[1],
  );

  static TextStyle loginHeaderDesctop = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w500,
    color: primaryColors[1],
  );

  static TextStyle bucketBoxheaderMobile = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: primaryColors[1],
  );

  static TextStyle bucketBoxheaderDesktop = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: primaryColors[1],
  );

  static TextStyle bucketBoxAuthorMobile = TextStyle(
    fontSize: 11,
    color: primaryColors[2],
  );

  static TextStyle bucketBoxAuthorDesktop = TextStyle(
    fontSize: 14,
    color: primaryColors[2],
  );

  static TextStyle bucketBoxPriceMobile = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: primaryColors[1],
  );

  static TextStyle bucketBoxPriceDesktop = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: primaryColors[1],
  );

  static TextStyle bucketPageInfoHeaderMobile = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: primaryColors[1],
  );

  static TextStyle bucketPageInfoPriceMobile = TextStyle(
    fontSize: 16,
    color: primaryColors[2],
    fontFamily: 'Manrope',
  );

  static TextStyle orderCheckInfo = TextStyle(
    fontSize: 12,
    color: Color.fromRGBO(165, 165, 165, 1),
  );

  static TextStyle orderCheckApply = TextStyle(
      fontSize: 12,
      color: Color(0x006957fe).withOpacity(1.0),
      fontWeight: FontWeight.w500);

  static TextStyle orderCheckPrice = TextStyle(
      fontSize: 14, color: primaryColors[2], fontWeight: FontWeight.w700);

  static TextStyle orderCheckPriceViolet = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Color(0x006957fe).withOpacity(1),
  );

  static TextStyle emptyBucketFirstText = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    fontFamily: 'Manrope',
    color: primaryColors[1],
  );

  static TextStyle emptyBucketCatalog = TextStyle(
    fontSize: 16,
    color: primaryColors[0],
    fontFamily: 'Manrope',
  );
}
