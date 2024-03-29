import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/presentation/home/home_page.dart';
import 'package:iverson/presentation/products/products_page.dart';
import 'package:iverson/presentation/settings/settings_page.dart';
import 'package:iverson/presentation/shared/extensions/focus_scope_node_extensions.dart';

import 'history/history.dart';

class MobileScaffold extends StatefulWidget {
  final int defaultIndex;
  final TabController tabController;

  const MobileScaffold({
    Key? key,
    required this.defaultIndex,
    required this.tabController,
  }) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  late int _index;

  @override
  void initState() {
    _index = widget.defaultIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<MainTabBloc, MainTabState>(
          listener: (ctx, state) async {
            state.maybeMap(
              initial: (s) => _changeCurrentTab(s.currentSelectedTab),
              orElse: () => {},
            );
          },
          child: TabBarView(
            controller: widget.tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              HomePage(),
              ProductsPage(),
              HistoryPage(),
              SettingsPage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).dividerColor,
        currentIndex: _index,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.shopping_bag_outlined), activeIcon: Icon(Icons.shopping_bag)),
          BottomNavigationBarItem(label: 'Shop', icon: Icon(Icons.shopify_outlined), activeIcon: Icon(Icons.shopify)),
          BottomNavigationBarItem(label: 'History', icon: Icon(Icons.bubble_chart_outlined), activeIcon: Icon(Icons.bubble_chart)),
          BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings)),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _goToTab(index),
      ),
    );
  }

  void _changeCurrentTab(int index) {
    FocusScope.of(context).removeFocus();
    widget.tabController.index = index;
    setState(() {
      _index = index;
    });
  }

  void _goToTab(int newIndex) => context.read<MainTabBloc>().add(MainTabEvent.goToTab(index: newIndex));
}