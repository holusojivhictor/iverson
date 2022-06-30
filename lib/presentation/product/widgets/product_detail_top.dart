import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/domain/assets.dart';
import 'package:iverson/presentation/shared/details/detail_top_layout.dart';
import 'package:iverson/presentation/shared/loading.dart';
import 'package:iverson/presentation/shared/utils/toast_utils.dart';
import 'package:iverson/theme.dart';

class ProductDetailTop extends StatelessWidget {
  const ProductDetailTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(useScaffold: false),
        loaded: (state) => DetailTopLayout(
          isASmallImage: state.isASmallImage,
          image: state.image,
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            iconTheme: IconThemeData(color: theme.indicatorColor),
            title: Text(
              Assets.translateProductCategoryType(state.category),
              style: theme.textTheme.bodyLarge!.copyWith(color: theme.primaryColor, fontSize: 20),
            ),
            actions: [
              IconButton(
                icon: Icon(state.isInInventory ? Icons.favorite : Icons.favorite_border),
                color: const Color(0xFFDB4E5A),
                splashRadius: Styles.mediumButtonSplashRadius,
                onPressed: () => _favoriteSoldier(state.id, state.isInInventory, context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _favoriteSoldier(int key, bool isInInventory, BuildContext context) {
    final fToast = ToastUtils.of(context);
    final event = !isInInventory ? ProductEvent.addToInventory(key: key) : ProductEvent.deleteFromInventory(key: key);
    context.read<ProductBloc>().add(event);
    !isInInventory ? ToastUtils.showSucceedToast(fToast, 'Added to inventory') : ToastUtils.showInfoToast(fToast, 'Removed from inventory');
  }
}
