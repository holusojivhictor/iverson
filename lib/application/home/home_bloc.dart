// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iverson/domain/enums/enums.dart';
import 'package:iverson/domain/models/models.dart';
import 'package:iverson/domain/services/services.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IversonService _iversonService;

  _LoadedState get currentState => state as _LoadedState;

  HomeBloc(this._iversonService) : super(const HomeState.loading()) {
    on<_Init>(_mapInitToState);
    on<_SearchChanged>(_mapSearchChangedToState);
    on<_ProductTypeChanged>(_mapProductTypeChanged);
    on<_ApplyFilterChanges>(_mapApplyFilterChangesToState);
  }

  HomeState _buildInitialState({
    String? search,
    ProductCategoryType? productType,
  }) {
    final isLoaded = state is _LoadedState;
    var data = _iversonService.getPopularProductsForCard();

    if (!isLoaded) {
      return HomeState.loaded(
        products: data,
        search: search,
        productType: productType,
        tempProductType: productType,
      );
    }

    if (search != null && search.isNotEmpty) {
      data = data.where((el) => el.title.toLowerCase().contains(search.toLowerCase())).toList();
    }

    switch (productType) {
      case ProductCategoryType.clothing:
        data = data.where((el) => el.category == ProductCategoryType.clothing).toList();
        break;
      case ProductCategoryType.footwear:
        data = data.where((el) => el.category == ProductCategoryType.footwear).toList();
        break;
      case ProductCategoryType.jewelery:
        data = data.where((el) => el.category == ProductCategoryType.jewelery).toList();
        break;
      case ProductCategoryType.electronics:
        data = data.where((el) => el.category == ProductCategoryType.electronics).toList();
        break;
      case ProductCategoryType.gaming:
        data = data.where((el) => el.category == ProductCategoryType.gaming).toList();
        break;
      default:
        break;
    }

    final s = currentState.copyWith.call(
      products: data,
      search: search,
      productType: productType,
      tempProductType: productType,
    );
    return s;
  }

  void _mapInitToState(_Init event, Emitter<HomeState> emit) {
    emit(_buildInitialState());
  }

  void _mapSearchChangedToState(_SearchChanged event, Emitter<HomeState> emit) {
    final state = _buildInitialState(search: event.search, productType: currentState.productType);
    emit(state);
  }

  void _mapProductTypeChanged(_ProductTypeChanged event, Emitter<HomeState> emit) {
    final state = currentState.copyWith.call(tempProductType: event.productType);
    emit(state);
  }

  void _mapApplyFilterChangesToState(_ApplyFilterChanges event, Emitter<HomeState> emit) {
    final state = _buildInitialState(search: currentState.search, productType: currentState.tempProductType);
    emit(state);
  }
}