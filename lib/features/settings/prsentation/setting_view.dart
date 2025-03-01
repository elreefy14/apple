import 'package:flutter/material.dart';
import 'package:masalriyadh/features/settings/prsentation/reset_pass_view.dart';

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
          ))
        ]),
      ),
    );
  }
}
