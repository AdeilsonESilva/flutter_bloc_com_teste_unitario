import 'package:bloc_test/src/home/home_service.dart';
import 'package:bloc_test/src/home/model/post.dart';
import 'package:bloc_test/src/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ClientMockito extends Mock implements Dio {}

void main() {
  group("HomeService", () {
    test("teste de service", () async {
      HomeService service = HomeService();
      service.dio = ClientMockito();

      when(service.dio.get("$urlApi/posts/1")).thenAnswer((_) async =>
          Response(statusCode: 200, data: {"id": 1, "title": "test"}));

      expect(await service.getPost(1), isInstanceOf<Post>());
    });

    test("teste de service quando da erro", () {
      HomeService service = HomeService();
      service.dio = ClientMockito();

      when(service.dio.get("$urlApi/posts/1")).thenAnswer(
          (_) async => Response(statusCode: 404, data: "Not found"));

      expect(service.getPost(1), throwsException);
    });
  });
}
