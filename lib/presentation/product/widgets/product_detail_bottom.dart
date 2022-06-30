import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/presentation/shared/details/detail_bottom_layout.dart';
import 'package:iverson/presentation/shared/expandable_text.dart';
import 'package:iverson/presentation/shared/loading.dart';
import 'package:iverson/theme.dart';

class ProductDetailBottom extends StatelessWidget {
  const ProductDetailBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(useScaffold: false),
        loaded: (state) => DetailBottomLayout(
          color: theme.scaffoldBackgroundColor,
          children: [
            Padding(
              padding: Styles.edgeInsetAll10,
              child: Text(
                state.title,
                style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  const SizedBox(width: 5),
                  Text(
                    '${state.rating}',
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '(${state.ratingCount} Reviews)'
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'Description',
                style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: Styles.edgeInsetAll10,
              child: ExpandableText(
                state.description,
                trimLines: 4,
                trimMode: TrimMode.line,
                trimCollapsedText: '...Read More',
                trimExpandedText: ' Less',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
