import 'package:bloc/bloc.dart';
import 'package:edu_books_flutter/models/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/network_repository.dart';

part 'bucket_state.dart';
part 'bucket_event.dart';

class BucketBloc extends Bloc<BucketEvent, BucketState> {
  BucketBloc() : super(BucketStateInitial()) {
    on<BucketBookPressedAdded>(_onBucketProcessAdded);
    on<BucketBookPressedDeleted>(_onBucketProcessDeleted);
    on<BucketBookReading>(_onBucketProcessReading);
    on<BucketOnLogout>(_onBucketOnLogout);
  }

  void _onBucketOnLogout(
      BucketOnLogout event, Emitter<BucketState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');

    emit(BucketStateSuccess(bucket: []));
  }

  void _onBucketProcessAdded(
      BucketBookPressedAdded event, Emitter<BucketState> emit) async {
    try {
      List<BookModel> booksList =
          List.from((state as BucketStateSuccess).bucket);

      booksList.removeWhere((element) => element.id == event.bucketBook.id);
      booksList.add(event.bucketBook);

      List<String> booksListId = booksList.map((e) => e.id.toString()).toList();

      emit(BucketStateSuccess(bucket: booksList));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('cart', booksListId);

      // List<BookModel> booksList =
      //     List.from((state as BucketStateSuccess).bucket);
      // booksList.removeWhere((element) => element.id == event.bucketBook.id);
      // booksList.add(event.bucketBook);

      // emit(BucketStateSuccess(bucket: booksList));
      // NetworkRepository()
      //     .updateCart({"product_id": event.bucketBook.id, "quantity": 1});
    } catch (e) {
      print(e);
      throw ("Book adding failed");
    }
  }

  void _onBucketProcessDeleted(
      BucketBookPressedDeleted event, Emitter<BucketState> emit) async {
    try {
      List<BookModel> booksList =
          List.from((state as BucketStateSuccess).bucket);

      booksList.removeWhere((element) => element.id == event.bucketBook.id);

      List<String> booksListId = booksList.map((e) => e.id.toString()).toList();

      emit(BucketStateSuccess(bucket: booksList));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('cart', booksListId);

      //NetworkRepository().deleteBucketBook(event.bucketBook.id);
    } catch (e) {
      throw ("Book adding failed");
    }
  }

  void _onBucketProcessReading(
      BucketBookReading event, Emitter<BucketState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> cart = prefs.getStringList('cart') ?? [];

      List<BookModel> bookList = [];

      if (cart.isNotEmpty) {
        for (var element in cart) {
          List<dynamic> bookData =
              await NetworkRepository().getBook(int.parse(element));
          bookList.add(BookModel.fromJson(bookData[0]));
        }
      }

      emit(BucketStateSuccess(bucket: bookList));
    } catch (e) {
      throw ("Reading bucket failed");
    }
  }
}
