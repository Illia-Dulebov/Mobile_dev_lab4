part of 'myorders_bloc.dart';

abstract class MyOrdersState extends Equatable {
  const MyOrdersState();
  
  @override
  List<Object> get props => [];
}

class MyOrdersInitial extends MyOrdersState {}

class MyOrdersLoading extends MyOrdersState {}

class MyOrdersSuccess extends MyOrdersState {
  final List<OrderModel> orders;
  final List<BookModel> orderBooks;

  const MyOrdersSuccess({required this.orders, this.orderBooks = const []});

  MyOrdersSuccess copyWith({
    List<OrderModel>? orders,
    List<BookModel>? orderBooks,
  }){
    return MyOrdersSuccess(
      orders: orders ?? this.orders,
      orderBooks: orderBooks ?? this.orderBooks,
      );
  }

  @override
  List<Object> get props => [orders, orderBooks];
}

class MyOrdersFailure extends MyOrdersState {}
