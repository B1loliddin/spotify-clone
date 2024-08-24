import 'package:spotify_clone/core/errors/failure.dart';

abstract interface class DataState<T> {
  final T? data;
  final Failure? failure;

  const DataState({this.data, this.failure});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T? data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(Failure failure) : super(failure: failure);
}
