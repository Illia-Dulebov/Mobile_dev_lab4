import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bucket/bucket_bloc.dart';
import '../../views/bucket_page.dart';

class CartButton extends StatelessWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BucketBloc, BucketState>(builder: (context, state) {
      if (state is BucketStateLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is BucketStateSuccess) {
        return Badge(
          showBadge: state.bucket.isEmpty ? false : true,
          position: BadgePosition.topEnd(top: -5, end: 43),
          badgeColor: Color(0xFF6957FE),
          badgeContent: Text(
            state.bucket.length.toStringAsFixed(0),
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          child: Container(
            width: 60,
            height: 43,
            decoration: BoxDecoration(
              color: Color(0xFFF9DF64),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(43),
                topLeft: Radius.circular(82),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(43),
                  topLeft: Radius.circular(82),
                ),
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BucketPage()),
                  );
                },
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Color(0xFF2B2B2B),
                  size: 24.0,
                ),
              ),
            ),
          ),
        );
      } else {
        return Center(
          child: Container(
            width: 60,
            height: 43,
            decoration: BoxDecoration(
              color: Color(0xFFF9DF64),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(43),
                topLeft: Radius.circular(82),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(43),
                  topLeft: Radius.circular(82),
                ),
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BucketPage()),
                  );
                },
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Color(0xFF2B2B2B),
                  size: 24.0,
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}
