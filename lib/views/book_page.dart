import 'package:edu_books_flutter/bloc/Book/book_bloc.dart';
import 'package:edu_books_flutter/bloc/authorization/auth_bloc.dart';
import 'package:edu_books_flutter/bloc/authorization/auth_state.dart';
import 'package:edu_books_flutter/bloc/comment/comment_bloc.dart';
import 'package:edu_books_flutter/models/book_model.dart';
import 'package:edu_books_flutter/styles/text_styles.dart';
import 'package:edu_books_flutter/widgets/buttons/cart_button.dart';
import 'package:edu_books_flutter/widgets/buttons/primary_buttons.dart';
import 'package:edu_books_flutter/widgets/buttons/secondary_button.dart';
import 'package:edu_books_flutter/widgets/buttons/svg_icon_buttons.dart';
import 'package:edu_books_flutter/widgets/comment_form.dart';
import 'package:edu_books_flutter/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/bucket/bucket_bloc.dart';
import '../bloc/home/home_bloc.dart';
import '../widgets/comment_item.dart';

class BookPage extends StatefulWidget {
  final BookModel bookModel;

  const BookPage({
    Key? key,
    required this.bookModel,
  }) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  void initState() {
    BlocProvider.of<BookBloc>(context)
        .add(BookPublishingHouseLoad(id: widget.bookModel.publishingHouseId));
    BlocProvider.of<CommentBloc>(context)
        .add(LoadComment(bookId: widget.bookModel.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;

    List<Widget> getBook(bool isMobile) {
      return [
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: BookPageBox(
            imagePath: widget.bookModel.image,
            imageMaxHeight: isMobile ? 247 : 396,
          ),
        ),
        SizedBox(
          width: isMobile ? 0 : 70,
        ),
        isMobile
            ? BookDescription(
                bookModel: widget.bookModel,
              )
            : Expanded(
                child: BookDescription(
                  bookModel: widget.bookModel,
                ),
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
                  top: isMobile ? 0.0 : 220.0, bottom: isMobile ? 0 : 0),
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
                          child: Flex(
                            crossAxisAlignment: isMobile
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            direction:
                                isMobile ? Axis.vertical : Axis.horizontal,
                            children: getBook(isMobile),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isMobile
                ? Positioned(
                    bottom: 0,
                    child: BlocBuilder<BucketBloc, BucketState>(
                      builder: (context, state) {
                        if (state is BucketStateSuccess) {
                          return Container(
                            color: Colors.transparent,
                            margin: const EdgeInsets.only(bottom: 25),
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            width: MediaQuery.of(context).size.width,
                            child: state.bucket
                                      .where((element) =>
                                          element.id == widget.bookModel.id)
                                      .toList()
                                      .isNotEmpty ? SizedBox()
                              : PrimaryButtonWithPrice(
                              price:
                                  '${widget.bookModel.sailPrice ?? widget.bookModel.price}',
                              title: 'додати в кошик',
                              onTap: () {
                                BlocProvider.of<BucketBloc>(context).add(
                                    BucketBookPressedAdded(
                                        bucketBook: widget.bookModel));
                              },
                            ),
                          );
                        }
                        else{
                          return SizedBox();
                        }
                      },
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
              child: NavBar(
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
        ),
      ),
    );
  }
}

class BookPageBox extends StatelessWidget {
  final String imagePath;
  final double imageMaxHeight;

  const BookPageBox({
    Key? key,
    required this.imagePath,
    required this.imageMaxHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 9,
            offset: const Offset(7, 7),
          ),
        ],
      ),
      child: LimitedBox(
        maxHeight: imageMaxHeight,
        child: Image.network(imagePath),
      ),
    );
  }
}

class BookDescription extends StatelessWidget {
  final BookModel bookModel;

  const BookDescription({
    Key? key,
    required this.bookModel,
  }) : super(key: key);

  String pluralizeNouns(int number, List<String> nounList) {
    if (nounList.length != 3) {
      throw Exception('Exception in pluralizeNouns');
    }
    int plural = (number % 10 == 1 && number % 100 != 11
        ? 0
        : number % 10 >= 2 &&
                number % 10 <= 4 &&
                (number % 100 < 10 || number % 100 >= 20)
            ? 1
            : 2);
    return nounList[plural];
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          bookModel.name,
          style: isMobile
              ? TextStyles.headlineMobile1
              : TextStyles.headlineDesktop1,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Text(
            bookModel.author,
            style: isMobile
                ? TextStyles.headlineMobile2
                : TextStyles.headlineDesktop2,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Text(
                'Опис',
                style: isMobile
                    ? TextStyles.headlineMobile2.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2B2B2B),
                      )
                    : TextStyles.headlineDesktop2.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2B2B2B),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Text(
                bookModel.description,
                style:
                    isMobile ? TextStyles.bodyMobile1 : TextStyles.bodyDesktop1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Кількість сторінок:',
                    style: isMobile
                        ? TextStyles.subTitleMobile1
                        : TextStyles.subTitleDesktop1,
                  ),
                  Text(
                    '${bookModel.pageNumber}',
                    style: isMobile
                        ? TextStyles.subTitleMobile1.copyWith(
                            fontWeight: FontWeight.w700,
                          )
                        : TextStyles.subTitleDesktop1.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Видавництво:',
                    style: isMobile
                        ? TextStyles.subTitleMobile1
                        : TextStyles.subTitleDesktop1,
                  ),
                  BlocBuilder<BookBloc, BookState>(builder: (context, state) {
                    switch (state.status) {
                      case BookStatus.failure:
                        return Text('-');
                      case BookStatus.loading:
                        return CircularProgressIndicator(
                          color: Color(0xFF6957FE),
                        );
                      case BookStatus.success:
                        return Text(
                          state.publishingHouse,
                          style: isMobile
                              ? TextStyles.subTitleMobile1.copyWith(
                                  fontWeight: FontWeight.w700,
                                )
                              : TextStyles.subTitleDesktop1.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                        );
                    }
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Рік випуску:',
                    style: isMobile
                        ? TextStyles.subTitleMobile1
                        : TextStyles.subTitleDesktop1,
                  ),
                  Text(
                    '${bookModel.publishingYear}',
                    style: isMobile
                        ? TextStyles.subTitleMobile1.copyWith(
                            fontWeight: FontWeight.w700,
                          )
                        : TextStyles.subTitleDesktop1.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                  ),
                ],
              ),
            ),
            isMobile
                ? SizedBox()
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: BlocBuilder<BucketBloc, BucketState>(
                        builder: (context, state) {
                          if (state is BucketStateSuccess) {
                            return SizedBox(
                              width: 340,
                              child: state.bucket
                                      .where((element) =>
                                          element.id == bookModel.id)
                                      .toList()
                                      .isNotEmpty
                                  ? SecondaryButton(
                                      title: "уже в кошику",
                                      onTap: () {},
                                    )
                                  : PrimaryButtonWithPrice(
                                      price:
                                          '${bookModel.sailPrice ?? bookModel.price}',
                                      title: 'додати в кошик',
                                      onTap: () {
                                        BlocProvider.of<BucketBloc>(context)
                                            .add(BucketBookPressedAdded(
                                                bucketBook: bookModel));
                                      },
                                    ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ),
                  ),
            BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
              if (state.status == CommentStatus.success) {
                return Padding(
                  padding: EdgeInsets.only(top: isMobile ? 0 : 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Відгуки',
                        style: isMobile
                            ? TextStyles.headlineMobile2.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2B2B2B),
                              )
                            : TextStyles.headlineDesktop2.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2B2B2B),
                              ),
                      ),
                      Text(
                        '${state.comments.length} ${pluralizeNouns(state.comments.length, [
                              'відгук',
                              'відгуки',
                              'відгуків'
                            ])}',
                        style: isMobile
                            ? TextStyles.bodyMobile1
                            : TextStyles.bodyDesktop1,
                      ),
                      BlocProvider.of<AuthBloc>(context).state.userStatus ==
                              UserStatus.authenticated
                          ? CommentForm(
                              bookId: bookModel.id,
                              allowConfirmOnUpdating: state.comments.length ==
                                  state.comments
                                      .where((element) => !element.isUpdating)
                                      .length,
                            )
                          : SizedBox(),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.comments.length,
                          itemBuilder: (context, index) {
                            return CommentItem(
                                commentModel: state.comments[index]);
                          }),
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            })
          ],
        ),
      ],
    );
  }
}
