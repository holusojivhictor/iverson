import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/domain/enums/enums.dart';
import 'package:iverson/domain/models/models.dart';
import 'package:iverson/domain/services/services.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IversonService _iversonService;
  final DataService _dataService;

  final CartBloc _cartBloc;

  ProductBloc(this._iversonService, this._dataService, this._cartBloc) : super(const ProductState.loading()) {
   on<_LoadProductFromKey>(_mapLoadFromKeyToState);
   on<_AddToInventory>(_mapAddToInventoryToState);
   on<_DeleteFromInventory>(_mapDeleteFromInventoryToState);
   on<_AddToCart>(_mapAddToCartToState);
   on<_DeleteFromCart>(_mapDeleteFromCartToState);
  }

  ProductState _buildInitialState(ProductFileModel product) {
    final isInInventory = _dataService.isProductInInventory(product.id, ItemType.product);
    final isInCart = _dataService.isProductInCart(product.id, ItemType.product);
    var relatedProducts = _iversonService.getProductsForCard().where((el) => el.category == product.category && el.id != product.id).toList();
    final isASmallImage = product.category == ProductCategoryType.footwear;

    return ProductState.loaded(
      id: product.id,
      title: product.title,
      price: product.price,
      description: product.description,
      category: product.category,
      image: product.image,
      rating: product.rating.rate,
      ratingCount: product.rating.count,
      isInInventory: isInInventory,
      isInCart: isInCart,
      relatedProducts: relatedProducts,
      isASmallImage: isASmallImage,
    );
  }

  Future<void> _mapLoadFromKeyToState(_LoadProductFromKey event, Emitter<ProductState> emit) async {
    final product = _iversonService.getProduct(event.key);
    emit(_buildInitialState(product));
  }

  Future<void> _mapAddToInventoryToState(_AddToInventory event, Emitter<ProductState> emit) async {
    await state.map(
      loading: (state) async => emit(state),
      loaded: (state) async {
        await _dataService.addProductToInventory(event.key);
        emit(state.copyWith.call(isInInventory: true));
      },
    );
  }

  Future<void> _mapDeleteFromInventoryToState(_DeleteFromInventory event, Emitter<ProductState> emit) async {
    await state.map(
      loading: (state) async => emit(state),
      loaded: (state) async {
        await _dataService.deleteProductFromInventory(event.key);
        emit(state.copyWith.call(isInInventory: false));
      },
    );
  }

  Future<void> _mapAddToCartToState(_AddToCart event, Emitter<ProductState> emit) async {
    await state.map(
      loading: (state) async => emit(state),
      loaded: (state) async {
        await _dataService.addProductToCart(event.key, event.quantity);
        _cartBloc.add(const CartEvent.init());
        emit(state.copyWith.call(isInCart: true));
      },
    );
  }

  Future<void> _mapDeleteFromCartToState(_DeleteFromCart event, Emitter<ProductState> emit) async {
    await state.map(
      loading: (state) async => emit(state),
      loaded: (state) async {
        await _dataService.deleteProductFromCart(event.key);
        _cartBloc.add(const CartEvent.init());
        emit(state.copyWith.call(isInCart: false));
      },
    );
  }
}