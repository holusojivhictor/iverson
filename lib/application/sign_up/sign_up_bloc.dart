import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/application/result_state/result_state.dart';
import 'package:iverson/domain/models/network/api_result.dart';
import 'package:iverson/domain/models/network/network_exceptions.dart';
import 'package:iverson/domain/services/auth_service.dart';

part 'sign_up_bloc.freezed.dart';
part 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, ResultState<String>> {
  final AuthService _authService;
  final SessionBloc _sessionBloc;

  SignUpBloc(this._authService, this._sessionBloc) : super(const ResultState.idle()) {
    on<_SignUp>((event, emit) async {
      emit(const ResultState.loading());
      ApiResult<String> apiResult = await _authService.signUp(event.emailAddress, event.password);
      apiResult.when(
        success: (String response) async {
          _sessionBloc.add(const SessionEvent.initStartup());
          emit(ResultState.data(data: response));
        },
        failure: (NetworkExceptions error) async* {
          emit(ResultState.error(error: error));
        },
      );
    });
  }
}