class WishlistProductModel {
  final int itemId;
  final int productId;
  final int variationId;
  final List<Map<String, dynamic>> meta; // تحديد نوع الحقل
  final DateTime dateAdded; // تغيير النوع إلى DateTime
  final double price; // تغيير النوع إلى double
  final bool inStock;

  WishlistProductModel({
    required this.itemId,
    required this.productId,
    required this.variationId,
    required this.meta,
    required this.dateAdded,
    required this.price,
    required this.inStock,
  });

  // إنشاء factory لتحليل JSON إلى كائن Dart
  factory WishlistProductModel.fromJson(Map<String, dynamic> json) {
    return WishlistProductModel(
      itemId: json['item_id'],
      productId: json['product_id'],
      variationId: json['variation_id'],
      meta: (json['meta'] as List<dynamic>)
          .map((e) => Map<String, dynamic>.from(e))
          .toList(),
      dateAdded: DateTime.parse(json['date_added']),
      price: double.parse(json['price']),
      inStock: json['in_stock'],
    );
  }

  // تحويل الكائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'product_id': productId,
      'variation_id': variationId,
      'meta': meta,
      'date_added': dateAdded.toIso8601String(),
      'price': price.toStringAsFixed(2),
      'in_stock': inStock,
    };
  }

  @override
  String toString() {
    return 'WishlistProduct(itemId: $itemId, productId: $productId, price: $price, inStock: $inStock)';
  }
}
