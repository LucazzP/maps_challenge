import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'package:desafio_maps/app/modules/home/home_repository.dart';

class MockClient extends Mock implements Dio {}

void main() {
  HomeRepository repository;
  MockClient client;

  setUp(() {
    repository = HomeRepository(Dio());
    client = MockClient();
  });

  group('HomeRepository Test', () {
    test("First Test", () {
      expect(repository, isInstanceOf<HomeRepository>());
    });
  });
}
