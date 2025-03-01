class CustomerDetailsModel {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? role;
  final String? username;
  final Billing? billing;
  final Shipping? shipping;
  final bool? isPayingCustomer;
  final DateTime? dateCreated;
  final DateTime? dateModified;

  CustomerDetailsModel({
     this.id,
     this.email,
     this.firstName,
     this.lastName,
     this.role,
     this.username,
     this.billing,
     this.shipping,
     this.isPayingCustomer,
    this.dateCreated,
    this.dateModified,
  });

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      role: json['role'] ?? '',
      username: json['username'] ?? '',
      billing: Billing.fromJson(json['billing'] ?? {}),
      shipping: Shipping.fromJson(json['shipping'] ?? {}),
      isPayingCustomer: json['is_paying_customer'] ?? false,
      dateCreated: json['date_created'] != null
          ? DateTime.parse(json['date_created'])
          : null,
      dateModified: json['date_modified'] != null
          ? DateTime.parse(json['date_modified'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'role': role,
      'username': username,
      'billing': billing?.toJson(),
      'shipping': shipping?.toJson(),
      'is_paying_customer': isPayingCustomer,
      'date_created': dateCreated?.toIso8601String(),
      'date_modified': dateModified?.toIso8601String(),
    };
  }
}

class Billing {
  final String firstName;
  final String lastName;
  final String? company;
  final String address1;
  final String? address2;
  final String city;
  final String state;
  final String postcode;
  final String country;
  final String email;
  final String phone;

  Billing({
    required this.firstName,
    required this.lastName,
    this.company, // اختيارية
    required this.address1,
    this.address2, // اختيارية
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.email,
    required this.phone,
  });

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      company: json['company'], // اختيارية
      address1: json['address_1'] ?? '',
      address2: json['address_2'], // اختيارية
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postcode: json['postcode'] ?? '',
      country: json['country'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      if (company != null) 'company': company, // لو null مش هنضيفها
      'address_1': address1,
      if (address2 != null) 'address_2': address2, // لو null مش هنضيفها
      'city': city,
      'state': state,
      'postcode': postcode,
      'country': country,
      'email': email,
      'phone': phone,
    };
  }
}

class Shipping {
  final String firstName;
  final String lastName;
  final String? company;
  final String address1;
  final String? address2;
  final String city;
  final String state;
  final String postcode;
  final String country;

  Shipping({
    required this.firstName,
    required this.lastName,
    this.company, // اختيارية
    required this.address1,
    this.address2, // اختيارية
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      company: json['company'], // اختيارية
      address1: json['address_1'] ?? '',
      address2: json['address_2'], // اختيارية
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postcode: json['postcode'] ?? '',
      country: json['country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      if (company != null) 'company': company, // لو null مش هنضيفها
      'address_1': address1,
      if (address2 != null) 'address_2': address2, // لو null مش هنضيفها
      'city': city,
      'state': state,
      'postcode': postcode,
      'country': country,
    };
  }
}

