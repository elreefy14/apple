class ProductModel {
  final int id;
  final String name;
  final String? price;
  final String? regularPrice;
  final String? salePrice;
  final String description;
  final String shortDescription;
  final List<ProductImage?>? images;
  final String stockStatus;
  final List<Category> categories;
  final double averageRating;
  final int ratingCount;
  final List<Tag> tags;

  ProductModel({
    required this.id,
    required this.name,
    this.price,
    this.regularPrice,
    this.salePrice,
    required this.description,
    required this.shortDescription,
    required this.images,
    required this.stockStatus,
    required this.categories,
    required this.averageRating,
    required this.ratingCount,
    required this.tags,
  });

  /// Factory method to parse JSON data into a Product instance
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      price: json['price']?.toString(),
      regularPrice: json['regular_price']?.toString(),
      salePrice: json['sale_price']?.toString(),
      description: json['description'] ?? '',
      shortDescription: json['short_description'] ?? '',
      images: (json['images'] as List<dynamic>?)
          ?.map((image) => ProductImage.fromJson(image))
          .toList() ??
          [],
      stockStatus: json['stock_status'] ?? 'outofstock',
      categories: (json['categories'] as List<dynamic>?)
          ?.map((category) => Category.fromJson(category))
          .toList() ??
          [],
      averageRating: double.tryParse(json['average_rating']?.toString() ?? '0') ?? 0.0,
      ratingCount: json['rating_count'] ?? 0,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((tag) => Tag.fromJson(tag))
          .toList() ??
          [],
    );
  }
}

class ProductImage {
  final String? src;

  ProductImage({required this.src});

  /// Factory method to parse JSON data into a ProductImage instance
  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      src: json['src'] ?? '', // Default empty string if image is missing
    );
  }
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  /// Factory method to parse JSON data into a Category instance
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
    );
  }
}

class Tag {
  final int id;
  final String name;

  Tag({required this.id, required this.name});

  /// Factory method to parse JSON data into a Tag instance
  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
    );
  }
}
