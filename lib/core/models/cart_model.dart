class CartModel {
  final String cartHash;
  final String cartKey;
  final Currency currency;
  final Customer customer;
  final List<CartItem> items;
  final int itemCount;
  final Totals totals;

  CartModel({
    required this.cartHash,
    required this.cartKey,
    required this.currency,
    required this.customer,
    required this.items,
    required this.itemCount,
    required this.totals,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartHash: json['cart_hash'] ?? '',
      cartKey: json['cart_key'] ?? '',
      currency: Currency.fromJson(json['currency']),
      customer: Customer.fromJson(json['customer']),
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => CartItem.fromJson(item))
          .toList() ??
          [],
      itemCount: json['item_count'] is int
          ? json['item_count']
          : int.tryParse(json['item_count']?.toString() ?? '0') ?? 0,
      totals: Totals.fromJson(json['totals'] ?? {}),
    );
  }
}

class Currency {
  final String currencyCode;
  final String currencySymbol;

  Currency({
    required this.currencyCode,
    required this.currencySymbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      currencyCode: json['currency_code'] ?? '',
      currencySymbol: json['currency_symbol'] ?? '',
    );
  }
}

class Customer {
  final BillingAddress billingAddress;
  final ShippingAddress shippingAddress;

  Customer({
    required this.billingAddress,
    required this.shippingAddress,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      billingAddress: BillingAddress.fromJson(json['billing_address'] ?? {}),
      shippingAddress: ShippingAddress.fromJson(json['shipping_address'] ?? {}),
    );
  }
}

class BillingAddress {
  final String billingFirstName;
  final String billingLastName;

  BillingAddress({
    required this.billingFirstName,
    required this.billingLastName,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> json) {
    return BillingAddress(
      billingFirstName: json['billing_first_name'] ?? '',
      billingLastName: json['billing_last_name'] ?? '',
    );
  }
}

class ShippingAddress {
  final String shippingFirstName;
  final String shippingLastName;

  ShippingAddress({
    required this.shippingFirstName,
    required this.shippingLastName,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      shippingFirstName: json['shipping_first_name'] ?? '',
      shippingLastName: json['shipping_last_name'] ?? '',
    );
  }
}

class CartItem {
  final int id;
  final String itemKey;
  final String name;
  final double price;
  final int quantity;
  final Totals totals;
  final String featuredImage;
  final double salesPrice;

  CartItem({
    required this.id,
    required this.itemKey,
    required this.name,
    required this.price,
    required this.quantity,
    required this.totals,
    required this.featuredImage,
    required this.salesPrice,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      itemKey: json['item_key'] ?? '',
      name: json['name'] ?? '',
      price: double.tryParse(json['price_regular']?.toString() ?? '0') ?? 0.0,
      quantity: json['quantity'] is Map
          ? int.tryParse(json['quantity']['value']?.toString() ?? '0') ?? 0
          : int.tryParse(json['quantity']?.toString() ?? '0') ?? 0,
      totals: Totals.fromJson(json['totals'] ?? {}),
      featuredImage: json['featured_image'] ?? '',
      salesPrice: double.tryParse(json['price_sale']?.toString() ?? '0') ?? 0.0,
    );
  }
}

class Totals {
  final double subtotal;
  final double subtotalTax;
  final double feeTotal;
  final double feeTax;
  final double discountTotal;
  final double discountTax;
  final double shippingTotal;
  final double shippingTax;
  final double total;
  final double totalTax;

  Totals({
    required this.subtotal,
    required this.subtotalTax,
    required this.feeTotal,
    required this.feeTax,
    required this.discountTotal,
    required this.discountTax,
    required this.shippingTotal,
    required this.shippingTax,
    required this.total,
    required this.totalTax,
  });

  factory Totals.fromJson(Map<String, dynamic> json) {
    return Totals(
      subtotal: double.tryParse(json['subtotal']?.toString() ?? '0') ?? 0.0,
      subtotalTax:
      double.tryParse(json['subtotal_tax']?.toString() ?? '0') ?? 0.0,
      feeTotal: double.tryParse(json['fee_total']?.toString() ?? '0') ?? 0.0,
      feeTax: double.tryParse(json['fee_tax']?.toString() ?? '0') ?? 0.0,
      discountTotal:
      double.tryParse(json['discount_total']?.toString() ?? '0') ?? 0.0,
      discountTax:
      double.tryParse(json['discount_tax']?.toString() ?? '0') ?? 0.0,
      shippingTotal:
      double.tryParse(json['shipping_total']?.toString() ?? '0') ?? 0.0,
      shippingTax:
      double.tryParse(json['shipping_tax']?.toString() ?? '0') ?? 0.0,
      total: double.tryParse(json['total']?.toString() ?? '0') ?? 0.0,
      totalTax: double.tryParse(json['total_tax']?.toString() ?? '0') ?? 0.0,
    );
  }
}
