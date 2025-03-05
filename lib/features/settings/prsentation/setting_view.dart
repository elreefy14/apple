import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:masalriyadh/core/services/data/remote/dio_services.dart';
import 'package:masalriyadh/features/settings/prsentation/reset_pass_view.dart';

import '../../../core/helper_functions/show_delet_dialog.dart';
import '../../../core/services/data/local/shared_helper.dart';
import '../../../core/services/data/local/shared_keys.dart';
import '../../../core/services/register_services.dart';
import '../../../home_layout.dart';
import '../../profile/presentation/widgets/profile_section_widget.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الاعدادات"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
              child: ProfileSectionWidget(
            title: "اعادة تعيين كلمة المرور",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResetPassView(),
                ),
              );
            },
          )),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
              child: ProfileSectionWidget(
            title: "حذف الحساب",
            icon: Icons.delete_forever_rounded,
            onTap: () async {
              showDeleteAccountDialog(
                  context: context,
                  jwtToken: await SharedHelper.get(key: SharedKeys.token),
                  onPressed: () async {
                    bool isDeleted = await deleteAccount();
                    if (isDeleted) {
                      SharedHelper.clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeLayout(),
                        ),
                        (route) => false,
                      );
                    }
                  });
            },
          )),
        ]),
      ),
    );
  }

  Future<bool> deleteAccount() async {
    DioHelper dio = getIt.get<DioHelper>();
    const String url =
        "https://masalriyadh.com/wp-json/custom/v1/delete-account/";

    try {
      Response response = await dio.delete(
        url: url,
        headers: {
          "Authorization":
              "Bearer ${await SharedHelper.get(key: SharedKeys.token)}",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        print("✅ الحساب تم حذفه بنجاح");
        return true;
      } else {
        print("❌ فشل في حذف الحساب: ${response.data}");
        return false;
      }
    } catch (e) {
      print("❌ خطأ أثناء حذف الحساب: $e");
      return false;
    }
  }
}
