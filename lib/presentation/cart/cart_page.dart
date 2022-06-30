import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/injection.dart';
import 'package:iverson/presentation/cart/widgets/clear_all.dart';
import 'package:iverson/theme.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injection.cartBloc..add(const CartEvent.init()),
      child: Scaffold(
        appBar: const _AppBar(),
        body: SafeArea(
          child: Container(),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('My Cart'),
      actions: [
        IconButton(
          splashRadius: Styles.mediumButtonSplashRadius,
          icon: const Icon(Icons.clear_all),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<CartBloc>(),
              child: const ClearAll(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
