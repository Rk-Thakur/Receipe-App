import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receipe/models/category_model.dart';

final catergoryProvider =
    StateNotifierProvider<CatergoryProvider, List<Category>>(
        (ref) => CatergoryProvider());

class CatergoryProvider extends StateNotifier<List<Category>> {
  CatergoryProvider() : super([]) {
    getCategory();
  }

  Future<void> getCategory() async {
    final dio = Dio();

    try {
      final response = await dio.get(
          'https://cooking-recipe2.p.rapidapi.com/category',
          options: Options(headers: {
            'x-rapidapi-host': 'cooking-recipe2.p.rapidapi.com',
            'x-rapidapi-key': 'api key'
          }));
      final data =
          (response.data as List).map((e) => Category.fromJson(e)).toList();
      state = data;
    } on DioError catch (e) {
      print(e.error);
    }
  }

  Future<void> searchCategory(String receipeCatergory) async {
    final dio = Dio();

    try {
      final response = await dio.get(
          'https://cooking-recipe2.p.rapidapi.com/category',
          options: Options(headers: {
            'x-rapidapi-host': 'cooking-recipe2.p.rapidapi.com',
            'x-rapidapi-key': 'apikey'
          }));
      final data =
          (response.data as List).map((e) => Category.fromJson(e)).toList();
      state = data;
    } on DioError catch (e) {
      print(e.error);
    }
  }
}
