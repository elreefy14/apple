import 'package:flutter/material.dart';
import 'package:masalriyadh/core/constants/colors.dart';

class AuthImageSection extends StatelessWidget {
  const AuthImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/app_background.png'),
              fit: BoxFit.cover,
              opacity: 0.3,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/app_logo.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
