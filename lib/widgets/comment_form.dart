import 'package:edu_books_flutter/bloc/authorization/auth_bloc.dart';
import 'package:edu_books_flutter/bloc/comment/comment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentForm extends StatefulWidget {
  const CommentForm(
      {Key? key,
      this.initCommentText,
      this.hintText,
      this.rating,
      required this.bookId,
      this.isUpdating = false,
      this.commentId,
      this.afterChange,
      this.allowConfirmOnUpdating = true})
      : super(key: key);

  final bool isUpdating;
  final bool allowConfirmOnUpdating;
  final String? initCommentText;
  final int bookId;
  final int? commentId;
  final String? hintText;
  final int? rating;
  final void Function()? afterChange;

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  TextEditingController newCommentController = TextEditingController();
  late int starRating;
  late bool isNotEmpty;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    starRating = widget.rating ?? 3;
    isNotEmpty = widget.initCommentText != null;
    if (isNotEmpty) {
      isNotEmpty = widget.initCommentText!.isNotEmpty;
    }
    newCommentController.text = widget.initCommentText ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ...[
                          for (var i = 1; i <= 5; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  starRating = i;
                                });
                              },
                              child: Icon(
                                i <= starRating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.orange,
                                size: 15,
                              ),
                            )
                        ],
                      ],
                    ),
                    widget.isUpdating
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                onTap: () {
                                  BlocProvider.of<CommentBloc>(context)
                                      .add(FinishUpdating());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(Icons.close_outlined,
                                      size: 20, color: Colors.grey),
                                )),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Stack(children: [
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        isNotEmpty = value.isNotEmpty;
                      });
                    },
                    controller: newCommentController,
                    autocorrect: false,
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? 'Введіть текст відгуку'
                          : null;
                    },
                    maxLines: null,
                    minLines: 4,
                    keyboardType: TextInputType.multiline,
                    cursorColor: const Color(0xff181B19),
                    style: TextStyle(
                      color: Color(0xff181B19),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.hintText ?? 'Додайте новий відгук',
                      hintStyle: const TextStyle(
                        color: Color(0xFFA5A5A5),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      filled: true,
                      isDense: true,
                      fillColor: const Color(0xffF2F3F2),
                      contentPadding:
                          EdgeInsets.only(top: 30, left: 20, right: 40),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 8,
                      right: 8,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          onTap: () {
                            // ignore: unnecessary_null_comparison
                            if (newCommentController.text != null &&
                                newCommentController.text.isNotEmpty &&
                                widget.allowConfirmOnUpdating) {
                              if (widget.isUpdating) {
                                BlocProvider.of<CommentBloc>(context).add(
                                    UpdateComment(
                                        id: widget.commentId ?? 0,
                                        comment: newCommentController.text,
                                        rating: starRating,
                                        bookId: widget.bookId));
                              } else {
                                BlocProvider.of<CommentBloc>(context).add(
                                    AddComment(
                                        bookId: widget.bookId,
                                        comment: newCommentController.text,
                                        user: BlocProvider.of<AuthBloc>(context)
                                            .state
                                            .user!,
                                        rating: starRating));
                              }
                              _formKey.currentState!.reset();
                              FocusScope.of(context).unfocus();
                              newCommentController.clear();
                              BlocProvider.of<CommentBloc>(context)
                                  .add(FinishUpdating());
                              setState(() {
                                isNotEmpty = false;
                                starRating = widget.rating ?? 3;
                              });
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: widget.allowConfirmOnUpdating &&
                                          isNotEmpty
                                      ? Color(0xFF6957FE).withOpacity(0.8)
                                      : Color.fromARGB(255, 223, 223, 223),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Icon(
                                Icons.arrow_upward_outlined,
                                color:
                                    widget.allowConfirmOnUpdating && isNotEmpty
                                        ? Colors.white.withOpacity(1)
                                        : Color.fromARGB(255, 179, 179, 179),
                              )),
                        ),
                      ))
                ]),
              ),
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
