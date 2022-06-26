import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/presentation/animated_text_splash/animated_text_splash.dart';
import 'package:iverson/presentation/app_widget.dart';
import 'package:iverson/presentation/auth/auth_screen.dart';
import 'package:iverson/presentation/sign_in/sign_in_page.dart';
import 'package:iverson/presentation/sign_up/sign_up_page.dart';
import 'package:iverson/theme.dart';

class SessionWrapper extends StatelessWidget {
  const SessionWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp(Widget? home) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: IversonTheme.light(),
        darkTheme: IversonTheme.light(),
        home: home,
      );
    }
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) => state.map(
        unInitialized: (_) => materialApp(const AnimatedTextSplash()),
        unAuthenticated: (_) => materialApp(const AuthScreen()),
        signUpState: (_) => materialApp(const SignUpPage()),
        signInState: (_) => materialApp(const SignInPage()),
        authenticated: (_) => const AppWidget(),
      ),
    );
  }
}
