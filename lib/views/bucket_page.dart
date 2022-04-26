import 'package:edu_books_flutter/widgets/bucket_page_mobile.dart';
import 'package:edu_books_flutter/widgets/buttons/svg_icon_buttons.dart';
import 'package:edu_books_flutter/widgets/empty_bucket_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/bucket/bucket_bloc.dart';
import '../bloc/home/home_bloc.dart';
import '../widgets/bucket_page_desktop_widget.dart';
import '../widgets/navigation_bar.dart';

class BucketPage extends StatelessWidget {
  const BucketPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;
    return Scaffold(body: SafeArea(
        child: BlocBuilder<BucketBloc, BucketState>(builder: (context, state) {
      if (state is BucketStateLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is BucketStateSuccess) {
        return Stack(
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
              padding: EdgeInsets.only(top: isMobile ? 0.0 : 220.0),
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
                          ? EdgeInsets.fromLTRB(25, 130, 25, 50)
                          : EdgeInsets.fromLTRB(0, 0, 0, 100),
                      child: Center(
                        child: SizedBox(
                          width: isMobile ? double.infinity : 1000,
                          child: Flex(
                            crossAxisAlignment: isMobile
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            direction:
                                isMobile ? Axis.vertical : Axis.horizontal,
                            children: isMobile
                                ? [
                                    state.bucket.isEmpty
                                        ? EmptyBucket()
                                        : MobileBucket(bookList: state.bucket)
                                  ]
                                : [
                                    state.bucket.isEmpty
                                        ? EmptyBucket()
                                        : DesktopBucket(
                                            bookList: state.bucket,
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: NavBar(
                title: "Кошик",
                currentIndex: -1,
                svgIconButton: SvgIconButton(
                  width: isMobile ? 20 : 34,
                  height: isMobile ? 20 : 34,
                  assetName: 'assets/icons/arrow_back.svg',
                  onTap: () {
                    BlocProvider.of<HomeBloc>(context).add(LoadAllToHome());
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        );
      } else {
        return Center(child: Text("bucket Problem"));
      }
    })));
  }
}
