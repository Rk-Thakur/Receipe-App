import 'package:flutter/material.dart';

class receipe_model {
  late String title;
  late String category;
  late String url;
  late String image_url;
  receipe_model(
      {required this.title,
      required this.category,
      required this.url,
      required this.image_url});

  factory receipe_model.fromJson(Map<String, dynamic> json) {
    return receipe_model(
        title: json['title'],
        category: json['category'],
        url: json['url'],
        image_url: json['img'] ?? '');
  }
}
