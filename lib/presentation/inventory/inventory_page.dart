import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/injection.dart';
import 'package:iverson/presentation/inventory/widgets/clear_all_dialog.dart';
import 'package:iverson/presentation/inventory/widgets/products_inventory_page.dart';
import 'package:iverson/theme.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injection.inventoryBloc..add(const InventoryEvent.init()),
      child: const Scaffold(
        appBar: _AppBar(),
        body: SafeArea(
          child: ProductsInventoryPage(),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget{
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('My Inventory'),
      actions: [
        IconButton(
          splashRadius: Styles.mediumButtonSplashRadius,
          icon: const Icon(Icons.clear_all),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<InventoryBloc>(),
              child: const ClearAllDialog(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
