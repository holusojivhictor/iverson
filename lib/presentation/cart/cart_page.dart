import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/injection.dart';
import 'package:iverson/presentation/shared/default_button.dart';

import 'widgets/products_cart_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injection.cartBloc..add(const CartEvent.init()),
      child: const Scaffold(
        appBar: _AppBar(),
        body: SafeArea(
          child: ProductsCartPage(),
        ),
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }
}

class CustomBottomBar extends StatelessWidget {
  final void Function()? onPressed;
  const CustomBottomBar({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
      ),
      child: DefaultButton(
        isPrimary: true,
        text: "Checkout",
        onPressed: onPressed,
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}