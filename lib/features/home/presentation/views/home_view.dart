import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/services/register_services.dart';
import 'package:masalriyadh/features/home/manager/home_cubit/home_cubit.dart';
import 'package:masalriyadh/features/home/presentation/widgets/home_view_body.dart';
import 'package:masalriyadh/features/home/presentation/widgets/category_widget.dart';

import '../../../../core/constants/app_styles.dart';
import '../../../../core/services/banners_service.dart';
import '../../../../core/services/categories_services.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeViewBody(),
    );
  }
}
