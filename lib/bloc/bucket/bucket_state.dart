part of 'bucket_bloc.dart';

abstract class BucketState extends Equatable {
  const BucketState();

  @override
  List<Object> get props => [];
}

class BucketStateInitial extends BucketState {}

class BucketStateLoading extends BucketState {}

class BucketStateFailed extends BucketState {}

class BucketStateSuccess extends BucketState {
  final List<BookModel> bucket;

  const BucketStateSuccess({required this.bucket});

  @override
  List<Object> get props => [bucket];
}
