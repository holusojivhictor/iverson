part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.init() = _Init;

  const factory HomeEvent.searchChanged({
    required String search,
  }) = _SearchChanged;

  const factory HomeEvent.productTypeChanged(ProductCategoryType? productType) = _ProductTypeChanged;

  const factory HomeEvent.applyFilterChanges() = _ApplyFilterChanges;
}