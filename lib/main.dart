import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/session_wrapper.dart';

import 'domain/services/services.dart';
import 'firebase_options.dart';
import 'injection.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Injection.init();
  runApp(const Iverson());
}

class Iverson extends StatelessWidget {
  const Iverson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) {
            return SessionBloc()..add(const SessionEvent.appStarted(init: true));
          },
        ),
        BlocProvider(
          create: (ctx) {
            final authService = getIt<AuthService>();
            return SignInBloc(authService, ctx.read<SessionBloc>());
          },
        ),
        BlocProvider(
          create: (ctx) {
            final authService = getIt<AuthService>();
            return SignUpBloc(authService, ctx.read<SessionBloc>());
          },
        ),
        BlocProvider(
          create: (ctx) {
            final authService = getIt<AuthService>();
            return GoogleSignInBloc(authService, ctx.read<SessionBloc>());
          },
        ),
        BlocProvider(
          create: (ctx) {
            final loggingService = getIt<LoggingService>();
            final settingsService = getIt<SettingsService>();
            final deviceInfoService = getIt<DeviceInfoService>();
            return MainBloc(
              loggingService,
              settingsService,
              deviceInfoService,
            )..add(const MainEvent.init());
          },
        ),
      ],
      child: BlocBuilder<SessionBloc, SessionState>(
        builder: (ctx, state) => const SessionWrapper(),
      ),
    );
  }
}
