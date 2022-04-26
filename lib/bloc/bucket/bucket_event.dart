part of 'bucket_bloc.dart';

abstract class BucketEvent extends Equatable {
  const BucketEvent();

  @override
  List<Object> get props => [];
}

class BucketBookPressedAdded extends BucketEvent {
  final BookModel bucketBook;
  const BucketBookPressedAdded({required this.bucketBook});

  @override
  List<Object> get props => [bucketBook];
}

class BucketBookPressedDeleted extends BucketEvent {
  final BookModel bucketBook;
  const BucketBookPressedDeleted({required this.bucketBook});

  @override
  List<Object> get props => [bucketBook];
}

class BucketBookReading extends BucketEvent {}

class BucketDeleteOnPressed extends BucketEvent {}

class BucketOnLogout extends BucketEvent {}
