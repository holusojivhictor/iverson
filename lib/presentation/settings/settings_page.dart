import 'package:flutter/material.dart';
import 'package:iverson/presentation/settings/widgets/build_version_card.dart';
import 'package:iverson/presentation/settings/widgets/display_settings_card.dart';
import 'package:iverson/presentation/settings/widgets/log_out_card.dart';
import 'package:iverson/presentation/settings/widgets/view_options_card.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveBuilder(
          builder: (ctx, size) => ListView(
            shrinkWrap: true,
            children: const [
              DisplaySettingsCard(),
              ViewOptionsCard(),
              BuildVersionCard(),
              LogOutCard(),
            ],
          ),
        ),
      ),
    );
  }
}
