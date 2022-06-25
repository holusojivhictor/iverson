import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iverson/domain/models/network/network_exceptions.dart';

part 'result_state.freezed.dart';

@freezed
class ResultState<T> with _$ResultState<T> {
  const factory ResultState.idle() = _IdleState<T>;

  const factory ResultState.loading() = _LoadingState<T>;

  const factory ResultState.data({
    required T data,
  }) = _DataState<T>;

  const factory ResultState.error({
    required NetworkExceptions error,
  }) = _ErrorState<T>;
}