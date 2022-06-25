import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'session_bloc.freezed.dart';
part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc() : super(const SessionState.unInitialized()) {
    on<_AppStarted>((event, emit) async {
      emit(const SessionState.unAuthenticated());
    });

    on<_LogOut>((event, emit) async {
      emit(const SessionState.unAuthenticated());
    });

    on<_SignUp>((event, emit) async {
      emit(const SessionState.signUpState());
    });

    on<_SignIn>((event, emit) async {
      emit(const SessionState.signUpState());
    });

    on<_InitStartup>((event, emit) async {
      emit(const SessionState.authenticated());
    });
  }
}