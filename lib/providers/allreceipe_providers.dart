import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receipe/models/receipe_mode.dart';

final allreceipeProvider =
    StateNotifierProvider<AllReceipeProvider, List<receipe_model>>(
        (ref) => AllReceipeProvider());

class AllReceipeProvider extends StateNotifier<List<receipe_model>> {
  AllReceipeProvider() : super([]) {
    getallreceipe();
  }

  Future<void> getallreceipe() async {
    final dio = Dio();
    try {
      final response = await dio.get('https://cooking-recipe2.p.rapidapi.com/',
          // final response = await dio.get(
          //     'https://cooking-recipe2.p.rapidapi.com/getbycat/Indian Desserts',
          options: Options(headers: {
            'x-rapidapi-host': 'cooking-recipe2.p.rapidapi.com',
            'x-rapidapi-key':
                'e7db4f58a9msh38c61008b84e869p1960f1jsn61164c8d1a95'
          }));
      final data = (response.data as List)
          .map((e) => receipe_model.fromJson(e))
          .toList();
      state = data;
    } on DioError catch (e) {
      print(e.error);
    }
  }

  Future<void> selectedRecipe(String category) async {
    final dio = Dio();
    try {
      final response = await dio.get(
          'https://cooking-recipe2.p.rapidapi.com/getbycat/$category',
          options: Options(headers: {
            'x-rapidapi-host': 'cooking-recipe2.p.rapidapi.com',
            'x-rapidapi-key':
                'e7db4f58a9msh38c61008b84e869p1960f1jsn61164c8d1a95'
          }));
      final data = (response.data as List)
          .map((e) => receipe_model.fromJson(e))
          .toList();
      state = data;
    } on DioError catch (e) {
      print(e.error);
    }
  }
}
