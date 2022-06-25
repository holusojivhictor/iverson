import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/presentation/app_widget.dart';
import 'package:iverson/theme.dart';

class SessionWrapper extends StatelessWidget {
  const SessionWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp(Widget? home) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: IversonTheme.light(),
        darkTheme: IversonTheme.dark(),
        home: home,
      );
    }
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) => state.map(
        unInitialized: (_) => materialApp(Container(color: Colors.blue)),
        unAuthenticated: (_) => materialApp(Container(color: Colors.orange)),
        signUpState: (_) => materialApp(Container()),
        signInState: (_) => materialApp(Container()),
        authenticated: (_) => const AppWidget(),
      ),
    );
  }
}
