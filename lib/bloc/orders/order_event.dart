part of "order_bloc.dart";

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class MakeOrderOnClick extends OrderEvent {
  @override
  List<Object> get props => [];
}

class RenewOrder extends OrderEvent {}


class PayForOrder extends OrderEvent{
  final int orderId;
  final String cardNumber;
  final String cvv;
  final String date;

  const PayForOrder({required this.orderId, required this.cardNumber, required this.cvv, required this.date});
}