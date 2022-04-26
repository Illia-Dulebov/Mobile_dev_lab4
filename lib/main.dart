import 'dart:ui';

import 'package:edu_books_flutter/bloc/Book/book_bloc.dart';
import 'package:edu_books_flutter/bloc/authorization/auth_bloc.dart';
import 'package:edu_books_flutter/bloc/authorization/auth_event.dart';
import 'package:edu_books_flutter/bloc/catalog/catalog_bloc.dart';
import 'package:edu_books_flutter/bloc/comment/comment_bloc.dart';
import 'package:edu_books_flutter/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bucket/bucket_bloc.dart';
import 'bloc/home/home_bloc.dart';
import 'bloc/orders/order_bloc.dart';
import 'bloc/myorders/myorders_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => CommentBloc()),
      BlocProvider(create: (context) => AuthBloc()..add(LoadUser())),
      BlocProvider(create: (context) => CatalogBloc()),
      BlocProvider(create: (context) => BookBloc()),
      BlocProvider(create: (context) => OrderBloc()),
      BlocProvider(create: (context) => MyOrdersBloc()),
      BlocProvider(create: (context) => HomeBloc()..add(LoadAllToHome())),
      BlocProvider(create: (context) => BucketBloc()..add(BucketBookReading())),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookShelf',
      scrollBehavior: CustomScrollBehavior(),
      theme: ThemeData(
        backgroundColor: Colors.white,
        fontFamily: 'Manrope',
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}