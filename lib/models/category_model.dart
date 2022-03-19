class Category {
  late String categories;
  Category({required this.categories});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(categories: json['category']);
  }
}
