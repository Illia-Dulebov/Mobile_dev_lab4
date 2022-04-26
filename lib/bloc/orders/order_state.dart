part of "order_bloc.dart";

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final int orderId;

  const OrderSuccess({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class OrderFailure extends OrderState {}
