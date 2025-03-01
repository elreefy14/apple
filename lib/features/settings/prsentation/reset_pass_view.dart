import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/constants/colors.dart';

class ResetPassView extends StatefulWidget {
  const ResetPassView({super.key});

  @override
  State<ResetPassView> createState() => _ResetPassViewState();
}

class _ResetPassViewState extends State<ResetPassView> {
  late final WebViewController _controller;
  bool _isLoading = true; // متغير للتحكم في عرض اللودر

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true; // بدأ التحميل، أظهر الخلفية البيضاء
            });
          },
          onPageFinished: (String url) {
            // عند اكتمال تحميل الصفحة، نخفي الخلفية البيضاء ونحقن CSS
            setState(() {
              _isLoading = false;
            });

            _controller.runJavaScript('''
              var style = document.createElement('style');
              style.innerHTML = '.whb-general-header-inner, .main-footer { display: none !important; }';
              document.head.appendChild(style);
            ''');
          },
        ),
      )
      ..clearCache()
      ..loadRequest(
          Uri.parse("https://masalriyadh.com/my-account/lost-password/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "إعادة تعيين كلمة المرور",
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller), // عرض الصفحة
          if (_isLoading)
            Container(
              color: Colors.white, // الخلفية البيضاء
              child: const Center(
                child: CircularProgressIndicator(
                  color:  AppColors.primaryColor,
                ), // اللودر في المنتصف
              ),
            ),
        ],
      ),
    );
  }
}
