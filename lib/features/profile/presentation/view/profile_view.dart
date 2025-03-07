import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/services/customer_details_service.dart';
import 'package:masalriyadh/core/services/data/local/shared_helper.dart';
import 'package:masalriyadh/core/services/data/local/shared_keys.dart';
import 'package:masalriyadh/features/auth/presentation/view/login_view.dart';
import 'package:masalriyadh/features/profile/manager/profile_cubit/profile_cubit.dart';

import '../../../../core/services/order_service.dart';
import '../../../../core/services/register_services.dart';
import '../widgets/profile_view_body.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    ProfileCubit.get(context).getCustomerId();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return ProfileViewBody(
          isGesture:
              ProfileCubit.get(context).customerId == null ? true : false,
        );
      }),
    );
  }
}
