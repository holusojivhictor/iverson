// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iverson/domain/enums/enums.dart';
import 'package:iverson/domain/models/models.dart';
import 'package:iverson/domain/services/services.dart';

part 'products_bloc.freezed.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final IversonService _iversonService;

  _LoadedState get currentState => state as _LoadedState;

  ProductsBloc(this._iversonService) : super(const ProductsState.loading()) {
    on<_Init>(_mapInitToState);
    on<_SearchChanged>(_mapSearchChangedToState);
    on<_ProductCategoryTypeChanged>(_mapProductTypeChangedToState);
    on<_ProductFilterTypeChanged>(_mapFilterTypeChangedToState);
    on<_ApplyFilterChanges>(_mapApplyFilterChangesToState);
    on<_SortDirectionTypeChanged>(_mapSortDirectionChangedToState);
    on<_CancelChanges>(_mapCancelChangesToState);
    on<_ResetFilters>(_mapResetFiltersToState);
  }

  ProductsState _buildInitialState({
    String? search,
    List<int> excludeKeys = const [],
    List<ProductCategoryType> productTypes = const [],
    ProductFilterType productFilterType = ProductFilterType.name,
    SortDirectionType sortDirectionType = SortDirectionType.asc,
  }) {
    final isLoaded = state is _LoadedState;
    var data = _iversonService.getProductsForCard();
    if (excludeKeys.isNotEmpty) {
      data = data.where((el) => !excludeKeys.contains(el.id)).toList();
    }

    if (!isLoaded) {
      final selectedProductTypes = ProductCategoryType.values.toList();
      _sortData(data, productFilterType, sortDirectionType);
      return ProductsState.loaded(
        products: data,
        search: search,
        productTypes: selectedProductTypes,
        tempProductTypes: selectedProductTypes,
        productFilterType: productFilterType,
        tempProductFilterType: productFilterType,
        sortDirectionType: sortDirectionType,
        tempSortDirectionType: sortDirectionType,
        excludeKeys: excludeKeys,
      );
    }

    if (search != null && search.isNotEmpty) {
      data = data.where((el) => el.title.toLowerCase().contains(search.toLowerCase())).toList();
    }

    if (productTypes.isNotEmpty) {
      data = data.where((el) => productTypes.contains(el.category)).toList();
    }

    _sortData(data, productFilterType, sortDirectionType);

    final s = currentState.copyWith.call(
      products: data,
      search: search,
      productTypes: productTypes,
      tempProductTypes: productTypes,
      productFilterType: productFilterType,
      tempProductFilterType: productFilterType,
      sortDirectionType: sortDirectionType,
      tempSortDirectionType: sortDirectionType,
      excludeKeys: excludeKeys
    );
    return s;
  }

  void _sortData(List<ProductCardModel> data, ProductFilterType productFilterType, SortDirectionType sortDirectionType) {
    switch (productFilterType) {
      case ProductFilterType.price:
        if (sortDirectionType == SortDirectionType.asc) {
          data.sort((x, y) => x.price.compareTo(y.price));
        } else {
          data.sort((x, y) => y.price.compareTo(x.price));
        }
        break;
      case ProductFilterType.rating:
        if (sortDirectionType == SortDirectionType.asc) {
          data.sort((x, y) => x.rating.compareTo(y.rating));
        } else {
          data.sort((x, y) => y.rating.compareTo(x.rating));
        }
        break;
      case ProductFilterType.ratingCount:
        if (sortDirectionType == SortDirectionType.asc) {
          data.sort((x, y) => x.ratingCount.compareTo(y.ratingCount));
        } else {
          data.sort((x, y) => y.ratingCount.compareTo(x.ratingCount));
        }
        break;
      case ProductFilterType.name:
        if (sortDirectionType == SortDirectionType.asc) {
          data.sort((x, y) => x.title.compareTo(y.title));
        } else {
          data.sort((x, y) => y.title.compareTo(x.title));
        }
        break;
      default:
        break;
    }
  }

  void _mapInitToState(_Init event, Emitter<ProductsState> emit) {
    final state = _buildInitialState(excludeKeys: event.excludeKeys, productTypes: ProductCategoryType.values);
    emit(state);
  }

  void _mapSearchChangedToState(_SearchChanged event, Emitter<ProductsState> emit) {
    final state = _buildInitialState(
      search: event.search,
      productFilterType: currentState.productFilterType,
      sortDirectionType: currentState.sortDirectionType,
      productTypes: currentState.productTypes,
      excludeKeys: currentState.excludeKeys,
    );
    emit(state);
  }

  void _mapProductTypeChangedToState(_ProductCategoryTypeChanged event, Emitter<ProductsState> emit) {
    var types = <ProductCategoryType>[];
    if (currentState.tempProductTypes.contains(event.productCategoryType)) {
      types = currentState.tempProductTypes.where((t) => t != event.productCategoryType).toList();
    } else {
      types = currentState.tempProductTypes + [event.productCategoryType];
    }
    final state = currentState.copyWith.call(tempProductTypes: types);
    emit(state);
  }

  void _mapFilterTypeChangedToState(_ProductFilterTypeChanged event, Emitter<ProductsState> emit) {
    final state = currentState.copyWith.call(tempProductFilterType: event.filterType);
    emit(state);
  }

  void _mapApplyFilterChangesToState(_ApplyFilterChanges event, Emitter<ProductsState> emit) {
    final state = _buildInitialState(
      search: currentState.search,
      productFilterType: currentState.tempProductFilterType,
      sortDirectionType: currentState.tempSortDirectionType,
      productTypes: currentState.tempProductTypes,
      excludeKeys: currentState.excludeKeys,
    );
    emit(state);
  }

  void _mapSortDirectionChangedToState(_SortDirectionTypeChanged event, Emitter<ProductsState> emit) {
    final state = currentState.copyWith.call(tempSortDirectionType: event.sortDirectionType);
    emit(state);
  }

  void _mapCancelChangesToState(_CancelChanges event, Emitter<ProductsState> emit) {
    final state = currentState.copyWith.call(
      tempProductTypes: currentState.productTypes,
      tempProductFilterType: currentState.productFilterType,
      tempSortDirectionType: currentState.sortDirectionType,
      excludeKeys: currentState.excludeKeys,
    );
    emit(state);
  }

  void _mapResetFiltersToState(_ResetFilters event, Emitter<ProductsState> emit) {
    final resetState = _buildInitialState(
      excludeKeys: state.maybeMap(loaded: (state) => state.excludeKeys, orElse: () => []),
      productTypes: ProductCategoryType.values,
    );
    emit(resetState);
  }
}