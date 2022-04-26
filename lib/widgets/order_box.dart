import 'package:edu_books_flutter/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../models/order_model.dart';

class OrderBox extends StatelessWidget {
  const OrderBox({Key? key, required this.order}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;

    return Container(
      height: isMobile ? 86 : 105,
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            child: Image(
              fit: BoxFit.fill,
              image: NetworkImage('https://picsum.photos/250?image=9'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      'Замовлення #${order.id}',
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 14,
                        fontWeight: FontWeight.w700,
                        color: primaryColors[1],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      '${order.sum?.toStringAsFixed(2) ?? 0} грн',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 14,
                        fontWeight: FontWeight.w700,
                        color: primaryColors[1],
                      ),
                    ),
                  ),
                  Container(
                    width: isMobile ? 72 : 88,
                    height: isMobile ? 19 : 23,
                    decoration: BoxDecoration(
                      color: primaryColors[0].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                       order.orderStatus.toUpperCase(),
                        style: TextStyle(
                          fontSize: isMobile ? 10 : 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColors[0],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
