import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/domain/assets.dart';
import 'package:iverson/domain/enums/enums.dart';
import 'package:iverson/presentation/popular/popular_products.dart';
import 'package:iverson/presentation/shared/choice/choice_bar_with_icon.dart';
import 'package:iverson/presentation/shared/sliver_loading.dart';
import 'package:iverson/presentation/shared/sliver_nothing_found.dart';

class SliverPopularProducts extends StatelessWidget {
  const SliverPopularProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.map(
          loading: (_) => const SliverLoading(),
          loaded: (state) {
            return SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: ChoiceBarWithIconWithAllValue(
                      values: ProductCategoryType.values.map((e) => e.index).toList(),
                      selectedValue: state.tempProductType?.index,
                      onAllOrValueSelected: (v) {
                        context.read<HomeBloc>().add(HomeEvent.productTypeChanged(v != null ? ProductCategoryType.values[v] : null));
                        context.read<HomeBloc>().add(const HomeEvent.applyFilterChanges());
                      },
                      choiceText: (val, _) => Assets.translateProductCategoryType(ProductCategoryType.values[val]),
                      iconData: (val, _) => Assets.translateProductCategoryTypeIcon(ProductCategoryType.values[val]),
                    ),
                  ),
                  if (state.products.isNotEmpty) PopularProducts(popularProducts: state.products) else const SliverNothingFound(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
