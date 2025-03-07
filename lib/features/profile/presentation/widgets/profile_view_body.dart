import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/helper_functions/show_login_dialog.dart';
import 'package:masalriyadh/features/profile/manager/profile_cubit/profile_cubit.dart';
import 'package:masalriyadh/features/profile/manager/profile_cubit/profile_cubit.dart';
import 'package:masalriyadh/features/profile/presentation/widgets/profile_section_widget.dart';
import 'package:masalriyadh/features/profile/presentation/widgets/shipping_and_billing_view.dart';
import 'package:masalriyadh/home_layout.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/models/customer_details_model.dart';
import '../../../../core/services/data/local/shared_helper.dart';
import '../../../../core/services/data/local/shared_keys.dart';
import '../../../settings/prsentation/reset_pass_view.dart';
import '../../../settings/prsentation/setting_view.dart';
import 'customer_orders_view.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key, required this.isGesture});

  final bool isGesture;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: ProfileSectionWidget(
                    height: isGesture ? 150 : 100,
                    title: SharedHelper.get(key: SharedKeys.userName) ?? 'زائر',
                    onTap: () {
                      if (isGesture) showLoginDialog(context);
                    },
                    showButton: isGesture,
                  ),
                ),
                buildSizeBox(),
                SliverToBoxAdapter(
                  child: ProfileSectionWidget(
                    icon: Icons.favorite_border,
                    title: 'المفضلة',
                    onTap: () {
                      if (isGesture) {
                        showLoginDialog(context);
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeLayout(
                              index: 2,
                            ),
                          ),
                          (route) => false,
                        );
                      }
                      ;
                    },
                  ),
                ),
                buildSizeBox(),
                SliverToBoxAdapter(
                  child: ProfileSectionWidget(
                    icon: Icons.card_travel_rounded,
                    title: 'الطلبات',
                    onTap: () {
                      if (isGesture) {
                        showLoginDialog(context);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomerOrdersView(
                              customerId: cubit.customerId ?? '',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                buildSizeBox(),
                SliverToBoxAdapter(
                  child: ProfileSectionWidget(
                    icon: Icons.location_on_outlined,
                    title: 'العناوين',
                    onTap: () {
                      if (isGesture) {
                        showLoginDialog(context);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ShippingAndBillingView(),
                          ),
                        );
                      }
                    },
                  ),
                ),
                buildSizeBox(),
                SliverToBoxAdapter(
                  child: ProfileSectionWidget(
                    icon: Icons.settings,
                    title: 'الاعدادات',
                    onTap: () {
                      if (isGesture) {
                        showLoginDialog(context);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingView()),
                        );
                      }
                    },
                  ),
                ),
                buildSizeBox(),
                SliverToBoxAdapter(
                  child: ProfileSectionWidget(
                    onTap: () {
                      openEmail();
                    },
                    icon: Icons.mail,
                    title: 'راسلنا على Info@masalryadh.com',
                  ),
                ),
                if (!isGesture) buildSizeBox(),
                if (!isGesture)
                  SliverToBoxAdapter(
                    child: ProfileSectionWidget(
                      onTap: () {
                        SharedHelper.clear();
                        cubit.getCustomerId();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeLayout(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icons.logout,
                      title: 'تسجيل الخروج',
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void openEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'Info@masalryadh.com',
      queryParameters: {
        'subject': 'استفسار من التطبيق',
        'body': 'مرحبًا، لدي استفسار بخصوص ...'
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print("لا يمكن فتح البريد الإلكتروني");
    }
  }

  SliverToBoxAdapter buildSizeBox() {
    return const SliverToBoxAdapter(
      child: SizedBox(height: 16),
    );
  }
}
