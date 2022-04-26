import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/book_model.dart';
import '../../network/network_repository.dart';
import '../bucket/bucket_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<MakeOrderOnClick>(_onMakingOrderFromBucket);
    on<PayForOrder>(_onPayForOrder);
    // on<RenewOrder>(_onRenewOrder);
  }

  void _onPayForOrder(
    PayForOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderInitial());
    try{
      Map<String, dynamic> data = {
        'order_id' : event.orderId,
        'numbers' : event.cardNumber,
        'date' : event.date,
        'cvv' : event.cvv,
      };

      await NetworkRepository().payForOrder(data);
      emit(OrderSuccess(orderId: event.orderId));

    }
    catch(_){
      emit(OrderFailure());
    }
  }

  void _onMakingOrderFromBucket(
    MakeOrderOnClick event,
    Emitter<OrderState> emit,
  ) async {
    try {
      emit(OrderInitial());

      final prefs = await SharedPreferences.getInstance();
      final List<String> cart = prefs.getStringList('cart') ?? [];

      Map<String, dynamic> map = {};
      for (var element in cart) {
        map[element] = 1;
      }

      var order = await NetworkRepository().makerOrderFromBucket(map);

      emit(OrderSuccess(orderId: order['order_id']));
    } catch (_) {
      emit(OrderFailure());
    }
  }
}
