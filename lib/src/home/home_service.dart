import 'package:bloc_test/src/home/model/post.dart';
import 'package:bloc_test/src/utils/constants.dart';
import 'package:dio/dio.dart';

class HomeService {
  Dio dio = Dio();

  Future<List<Post>> getPosts() async {
    Response response = await dio.get("$urlApi/posts");

    if (response.statusCode == 200) {
      List<Post> posts =
          (response.data as List).map((item) => Post.fromJson(item)).toList();

      return posts;
    }

    throw Exception("Erro na requisição Posts");
  }

  Future<Post> getPost(int id) async {
    Response response = await dio.get("$urlApi/posts/$id");

    if (response.statusCode == 200) return Post.fromJson(response.data);

    throw Exception("Erro na requisição Post");
  }
}
