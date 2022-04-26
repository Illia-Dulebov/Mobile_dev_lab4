// ignore_for_file: deprecated_member_use
import 'package:edu_books_flutter/widgets/%D1%81heckout_widget.dart';
import 'package:flutter/material.dart';


class ModalCheckout extends StatelessWidget {
  const ModalCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      content: CheckoutWidget(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    );
  }
}
