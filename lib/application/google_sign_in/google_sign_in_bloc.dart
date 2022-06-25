import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/application/result_state/result_state.dart';
import 'package:iverson/domain/models/network/api_result.dart';
import 'package:iverson/domain/models/network/network_exceptions.dart';
import 'package:iverson/domain/services/auth_service.dart';

part 'google_sign_in_bloc.freezed.dart';
part 'google_sign_in_event.dart';

class GoogleSignInBloc extends Bloc<GoogleSignInEvent, ResultState<String>> {
  final AuthService _authService;
  final SessionBloc _sessionBloc;

  GoogleSignInBloc(this._authService, this._sessionBloc) : super(const ResultState.idle()) {
    on<_GoogleSignIn>((event, emit) async {
      emit(const ResultState.loading());
      ApiResult<String> apiResult = await _authService.signInWithGoogle();
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