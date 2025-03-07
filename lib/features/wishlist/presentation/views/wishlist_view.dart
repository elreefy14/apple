import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/services/register_services.dart';
import 'package:masalriyadh/features/wishlist/presentation/widgets/wishlist_view_body.dart';

import '../../../../core/services/wishlist_service.dart';
import '../../manager/wishlist_cubit/wishlist_cubit.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const WishlistViewBody()
    );
  }
}
