import 'package:bloc/bloc.dart';
import 'package:edu_books_flutter/models/book_model.dart';
import 'package:edu_books_flutter/models/order_model.dart';
import 'package:edu_books_flutter/network/network_repository.dart';
import 'package:equatable/equatable.dart';

part 'myorders_event.dart';
part 'myorders_state.dart';

class MyOrdersBloc extends Bloc<MyOrdersEvent, MyOrdersState> {
  MyOrdersBloc() : super(MyOrdersInitial()) {
    on<LoadOrdersList>(_onLoadOrdersList);
    on<LoadOrderDetail>(_onLoadOrderDetail);
    
  }

  void _onLoadOrdersList(
    LoadOrdersList event,
    Emitter<MyOrdersState> emit,
  ) async {
    emit(MyOrdersLoading());
    try{
      List<OrderModel> orders = await NetworkRepository().getMyOrders();
      emit(MyOrdersSuccess(orders: orders.reversed.toList()));
    }
    catch(_){
      emit(MyOrdersFailure());
    }
    

  }



  void _onLoadOrderDetail(
    LoadOrderDetail event,
    Emitter<MyOrdersState> emit,
  ) async {
    try{
      List<BookModel> orderBooks = await NetworkRepository().getMyOrderBook(event.id);
      emit((state as MyOrdersSuccess).copyWith(orderBooks: orderBooks));
    }
    catch(_){
      emit(MyOrdersFailure());
    }
    
  }


}
