class CategoryModel {
  final num id; // تم تغيير int إلى num
  final String name;
  final String slug;
  final num parent; // تم تغيير int إلى num
  final String description;
  final String display;
  final String? imageUrl;
  final String? imageAlt;
  final num menuOrder; // تم تغيير int إلى num
  final num count; // تم تغيير int إلى num

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.parent,
    required this.description,
    required this.display,
    this.imageUrl,
    this.imageAlt,
    required this.menuOrder,
    required this.count,
  });

  /// دالة لتحويل JSON إلى كائن CategoryModel
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as num? ?? 0,
      // حماية ضد القيم الفارغة
      name: json['name'] as String? ?? 'Unknown',
      slug: json['slug'] as String? ?? '',
      parent: json['parent'] as num? ?? 0,
      description: json['description'] as String? ?? '',
      display: json['display'] as String? ?? 'default',
      imageUrl: json['image'] != null ? json['image']['src'] as String : null,
      imageAlt: json['image'] != null ? json['image']['alt'] as String : null,
      menuOrder: json['menu_order'] as num? ?? 0,
      count: json['count'] as num? ?? 0,
    );
  }

  /// دالة لتحويل كائن CategoryModel إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'parent': parent,
      'description': description,
      'display': display,
      'image': imageUrl != null
          ? {
              'src': imageUrl,
              'alt': imageAlt,
            }
          : null,
      'menu_order': menuOrder,
      'count': count,
    };
  }
}
