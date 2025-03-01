part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetCategoriesLoading extends HomeState {}

final class GetCategoriesSuccess extends HomeState {}

final class GetCategoriesError extends HomeState {
  final String error;

  GetCategoriesError({required this.error});
}

final class GetBannersLoading extends HomeState {}

final class GetBannersSuccess extends HomeState {}

final class GetBannersError extends HomeState {
  final String error;

  GetBannersError({required this.error});
}

final class GetProductsLoading extends HomeState {}

final class GetProductsSuccess extends HomeState {}

final class GetProductsError extends HomeState {
  final String error;

  GetProductsError({required this.error});
}

final class GetNewProductsLoading extends HomeState {}

final class GetNewProductsSuccess extends HomeState {}

final class GetNewProductsError extends HomeState {
  final String error;

  GetNewProductsError({required this.error});
}

final class GetEpoxyProductsLoadingState extends HomeState {}

final class GetEpoxyProductsSuccessState extends HomeState {}

final class GetEpoxyProductsErrorState extends HomeState {
  final String error;

  GetEpoxyProductsErrorState({required this.error});
}

final class GetAzlHamamProductsLoadingState extends HomeState {}

final class GetAzlHamamProductsSuccessState extends HomeState {}

final class GetAzlHamamProductsErrorState extends HomeState {
  final String error;

  GetAzlHamamProductsErrorState({required this.error});
}
