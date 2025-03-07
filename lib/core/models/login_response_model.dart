class LoginResponseModel {
  final String token;
  final String userEmail;
  final String userNicename;
  final String userDisplayName;

  LoginResponseModel({
    required this.token,
    required this.userEmail,
    required this.userNicename,
    required this.userDisplayName,
  });

  // لتحويل استجابة JSON إلى كائن Dart
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] ?? '',
      userEmail: json['user_email'] ?? '',
      userNicename: json['user_nicename'] ?? '',
      userDisplayName: json['user_display_name'] ?? '',
    );
  }

  // لتحويل الكائن إلى JSON (اختياري إذا كنت بحاجة لإرساله لاحقًا)
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user_email': userEmail,
      'user_nicename': userNicename,
      'user_display_name': userDisplayName,
    };
  }
}
