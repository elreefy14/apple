import 'package:flutter/foundation.dart';
import 'package:masalriyadh/core/models/banners_model.dart';
import 'package:masalriyadh/core/models/product_model.dart';
import 'package:masalriyadh/core/services/data/remote/dio_services.dart';
import 'package:masalriyadh/core/services/register_services.dart';

import '../models/all_catigories_model.dart';
import 'data/remote/end_points.dart';

class BannersService {
  DioHelper dio = getIt.get<DioHelper>();
  List<BannersModel> mainBanners = [];
  List<BannersModel> secondBanners = [];
  List<BannersModel> thirdBanners = [];

  Future<List<BannersModel>> getMainBanners() async {
    mainBanners = [];
    try {
      // استدعاء API
      var response = await dio.get(url: EndPoints.mainBannersUrl, headers: {});

      // التحقق من أن البيانات المستلمة هي قائمة
      var allData = response.data;
      for (var item in allData) {
        var bannerData = item['ams_acf']; // الوصول إلى الـ ACF
        if (bannerData is List) {
          for (var banner in bannerData) {
            // إضافة البنرات إلى القائمة
            mainBanners.add(
              BannersModel.fromJson(banner['value'] // الوصول إلى الهدف
                  ),
            );
          }
        }
      }

      return mainBanners;
    } catch (e, stackTrace) {
      // طباعة تفاصيل الخطأ أثناء التطوير
      print('Error fetching categories: $e');
      print('Stack trace: $stackTrace');
      // إعادة رمي الخطأ
      rethrow;
    }
  }


  Future<List<BannersModel>> getSecondBanners() async {
    secondBanners = [];
    try {
      // استدعاء API
      var response = await dio.get(url: EndPoints.secondBannersUrl, headers: {});

      // التحقق من أن البيانات المستلمة هي قائمة
      var allData = response.data;
      print(allData);
      for (var item in allData) {
        var bannerData = item['ams_acf']; // الوصول إلى الـ ACF
        if (bannerData is List) {
          for (var banner in bannerData) {
            // إضافة البنرات إلى القائمة
            secondBanners.add(
              BannersModel.fromJson(banner['value'] // الوصول إلى الهدف
              ),
            );
          }
        }
      }

      return secondBanners;
    } catch (e, stackTrace) {
      // طباعة تفاصيل الخطأ أثناء التطوير
      print('Error fetching categories: $e');
      print('Stack trace: $stackTrace');
      // إعادة رمي الخطأ
      rethrow;
    }
  }

  Future<List<BannersModel>> getThirdBanners() async {
    thirdBanners = [];
    try {
      // استدعاء API
      var response = await dio.get(url: EndPoints.thirdBannersUrl, headers: {});

      // التحقق من أن البيانات المستلمة هي قائمة
      var allData = response.data;
      print(allData);
      for (var item in allData) {
        var bannerData = item['ams_acf']; // الوصول إلى الـ ACF
        if (bannerData is List) {
          for (var banner in bannerData) {
            // إضافة البنرات إلى القائمة
            thirdBanners.add(
              BannersModel.fromJson(banner['value'] // الوصول إلى الهدف
              ),
            );
          }
        }
      }

      return thirdBanners;
    } catch (e, stackTrace) {
      // طباعة تفاصيل الخطأ أثناء التطوير
      print('Error fetching categories: $e');
      print('Stack trace: $stackTrace');
      // إعادة رمي الخطأ
      rethrow;
    }
  }


}
