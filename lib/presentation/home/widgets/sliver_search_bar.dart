import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/presentation/cart/cart_page.dart';
import 'package:iverson/presentation/shared/icon_button_with_counter.dart';
import 'package:iverson/presentation/shared/search_field.dart';

class SliverSearchBar extends StatelessWidget {
  const SliverSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) => state.map(
                loading: (_) => const SizedBox.shrink(),
                loaded: (state) {
                  return SearchField(
                    value: state.search,
                    searchChanged: (v) => context.read<HomeBloc>().add(HomeEvent.searchChanged(search: v)),
                  );
                },
              ),
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (ctx, state) => IconBtnWithCounter(
                numOfItems: state.products.length,
                icon: Icons.shopping_cart_outlined,
                onTap: () => _goToCartPage(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToCartPage(BuildContext context) async {
    final route = MaterialPageRoute(builder: (c) => const CartPage());
    await Navigator.push(context, route);
    await route.completed;
  }
}
