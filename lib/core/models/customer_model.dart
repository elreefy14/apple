class CustomerModel {
  int? id; // ID العميل (للتحديث)
  String? email; // البريد الإلكتروني
  String? firstName; // الاسم الأول
  String? lastName; // اسم العائلة
  String? username; // اسم المستخدم
  String? password; // كلمة المرور (عند الإنشاء فقط)
  String? phone; // رقم الهاتف
  String? billingAddress; // عنوان الفوترة
  String? shippingAddress; // عنوان الشحن
  String? avatarUrl; // صورة المستخدم
  bool? isPayingCustomer; // إذا كان يدفع
  String? token; // التوكن (اختياري)

  // Constructor
  CustomerModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.password,
    this.phone,
    this.billingAddress,
    this.shippingAddress,
    this.avatarUrl,
    this.isPayingCustomer,
    this.token,
  });

  // لتحويل بيانات العميل من JSON
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      phone: json['billing']?['phone'],
      billingAddress: json['billing']?['address_1'],
      shippingAddress: json['shipping']?['address_1'],
      avatarUrl: json['avatar_url'],
      isPayingCustomer: json['is_paying_customer'],
      token: json['token'], // إذا كان التوكن موجودًا في استجابة API
    );
  }

  // لتحويل بيانات العميل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'password': password,
      'billing': {
        'phone': phone ?? "",
        'address_1': billingAddress ?? "",
      },
      'shipping': {
        'address_1': shippingAddress ?? "",
      },
    };
  }

  // التحقق من صحة البيانات
  bool isValid() {
    // التحقق من جميع الحقول الأساسية
    return email != null &&
        email!.isNotEmpty &&
        firstName != null &&
        firstName!.isNotEmpty &&
        lastName != null &&
        lastName!.isNotEmpty &&
        username != null &&
        username!.isNotEmpty &&
        password != null &&
        password!.isNotEmpty;
  }

  // التحقق من صحة البريد الإلكتروني باستخدام RegExp
  bool isEmailValid() {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return email != null && emailRegex.hasMatch(email!);
  }
}
