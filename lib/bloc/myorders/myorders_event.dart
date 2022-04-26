part of 'myorders_bloc.dart';

abstract class MyOrdersEvent extends Equatable {
  const MyOrdersEvent();

  @override
  List<Object> get props => [];
}


class LoadOrdersList extends MyOrdersEvent{}


class LoadOrderDetail extends MyOrdersEvent{
  final int id;
 
  const LoadOrderDetail({required this.id});  
}

