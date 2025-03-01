import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/models/banners_model.dart';
import 'package:masalriyadh/core/services/banners_service.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/all_catigories_model.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/services/categories_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.categoriesServices, required this.bannersService})
      : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  final CategoriesServices categoriesServices;
  final BannersService bannersService;
  List<CategoryModel> mainCategories = [];
  List<BannersModel> mainBanners = [];
  List<BannersModel> secondBanners = [];
  List<BannersModel> thirdBanners = [];
  List<ProductModel> featuredProducts = [];
  List<ProductModel> newProducts = [];
  List<ProductModel> epoxy = [];
  List<ProductModel> azlHamam = [];

  Future<void> getEpoxyProducts() async {
    emit(GetEpoxyProductsLoadingState());
    epoxy.clear();
    await categoriesServices.getEpoxyProducts().then(
      (value) {
        epoxy = value;
        emit(GetEpoxyProductsSuccessState());
      },
    ).catchError((error) {
      if (error is DioException) {
        print(error.message);
      }
      emit(GetEpoxyProductsErrorState(error: error));
    });
  }

  Future<void> getAzlHamamProducts() async {
    emit(GetAzlHamamProductsLoadingState());
    azlHamam.clear();
    await categoriesServices.getAzlHamamProducts().then(
      (value) {
        azlHamam = value;
        emit(GetAzlHamamProductsSuccessState());
      },
    ).catchError((error) {
      if (error is DioException) {
        print(error.message);
      }
      emit(GetAzlHamamProductsErrorState(error: error));
    });
  }

  Future<void> getMainCategories() async {
    emit(GetCategoriesLoading());
    await categoriesServices.getMainCategories().then(
      (value) async {
        mainCategories = value;

        emit(GetCategoriesSuccess());
      },
    ).catchError((error) {
      emit(GetCategoriesError(
        error: error.toString(),
      ));
    });
  }

  Future<void> getNewProducts() async {
    emit(GetNewProductsLoading());
    await categoriesServices.fetchLatestProducts().then(
      (value) {
        newProducts = value;
        emit(GetNewProductsSuccess());
      },
    ).catchError((error) {
      emit(GetNewProductsError(
        error: error.toString(),
      ));
    });
  }

  Future<void> getFeaturedProducts() async {
    emit(GetProductsLoading());
    await categoriesServices.getFeaturedProducts().then(
      (value) {
        featuredProducts = value;
        emit(GetProductsSuccess());
      },
    ).catchError((error) {
      emit(GetProductsError(
        error: error.toString(),
      ));
    });
  }

  Future<void> getBanners() async {
    secondBanners.clear();
    mainBanners.clear();
    thirdBanners.clear();
    emit(GetBannersLoading());
    await bannersService.getMainBanners().then(
      (value) {
        mainBanners = value;
        emit(GetBannersSuccess());
      },
    ).catchError((error) {
      emit(GetBannersError(
        error: error.toString(),
      ));
    });
    await bannersService.getSecondBanners().then(
      (value) {
        print('Second Banners');
        print(value.length);
        print('Second Banners');
        secondBanners = value;
        emit(GetBannersSuccess());
      },
    ).catchError((error) {
      emit(GetBannersError(
        error: error.toString(),
      ));
    });
    await bannersService.getThirdBanners().then(
      (value) {
        print('Second Banners');
        print(value.length);
        print('Second Banners');
        thirdBanners = value;
        emit(GetBannersSuccess());
      },
    ).catchError((error) {
      emit(GetBannersError(
        error: error.toString(),
      ));
    });
  }
}
