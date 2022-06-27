import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/domain/enums/enums.dart';
import 'package:iverson/presentation/main_tab_page.dart';
import 'package:iverson/presentation/shared/extensions/app_theme_type_extensions.dart';
import 'package:iverson/presentation/shared/loading.dart';
import 'package:iverson/theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (ctx, state) => state.map<Widget>(
        loading: (_) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: IversonTheme.light(),
            home: const Loading(),
          );
        },
        loaded: (s) {
          final autoThemeModeOn = s.autoThemeMode == AutoThemeModeType.on;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: s.appTitle,
            theme: autoThemeModeOn ? IversonTheme.light() : s.theme.getThemeData(s.theme),
            darkTheme: autoThemeModeOn ? IversonTheme.dark() : null,
            home: const MainTabPage(),
          );
        },
      ),
    );
  }
}

