import 'package:edu_books_flutter/bloc/authorization/auth_bloc.dart';
import 'package:edu_books_flutter/bloc/authorization/auth_state.dart';
import 'package:edu_books_flutter/bloc/comment/comment_bloc.dart';
import 'package:edu_books_flutter/models/comment_model.dart';
import 'package:edu_books_flutter/widgets/comment_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({Key? key, required this.commentModel}) : super(key: key);

  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30),
        child: !commentModel.isUpdating ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      width: 46,
                      height: 46,
                      child: Image.network(commentModel.avatar),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Text(
                            commentModel.user.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Row(
                          children: [
                            ...[
                              for (var i = 1; i <= 5; i++)
                                Icon(
                                  i <= commentModel.rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.orange,
                                  size: 13,
                                )
                            ]
                          ],
                        )
                      ],
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if(state.userStatus == UserStatus.authenticated){
                          return state.user!.id ==  commentModel.user.id ? Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                InkWell(
                                    borderRadius: BorderRadius.circular(40),
                                    onTap: () {
                                      BlocProvider.of<CommentBloc>(context).add(StartUpdating(id: commentModel.id));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.edit_outlined,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                    )),
                                InkWell(
                                    borderRadius: BorderRadius.circular(40),
                                    onTap: () {
                                      BlocProvider.of<CommentBloc>(context).add(DeleteComment(id:  commentModel.id));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(Icons.delete_outline,
                                          size: 20, color: Colors.grey),
                                    )),
                              ],
                            ),
                          ) : SizedBox();
                        }
                        else{
                          return SizedBox();
                        }
                        
                      },
                    ),
                  ],
                ),
                Container()
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 5),
              child: Text(
                 commentModel.comment,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
            ),
            commentModel.createdAt != commentModel.updatedAt ?
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                  '(Ред.)',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                ),
            ) : SizedBox()
          ],
        ) : CommentForm(
          rating:  commentModel.rating,
          initCommentText:  commentModel.comment,
          hintText: 'Введіть новий відгук',
          commentId:  commentModel.id,
          bookId:  commentModel.bookId,
          isUpdating: true,
          

          )
    );
  }
}
