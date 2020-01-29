import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'package:desafio_maps/app/app_repository.dart';

class MockClient extends Mock implements Dio {}

void main() {
  AppRepository repository;
  MockClient client;

  setUp(() {
    repository = AppRepository();
    client = MockClient();
  });

  group('AppRepository Test', () {
    test("First Test", () {
      expect(repository, isInstanceOf<AppRepository>());
    });
  });
}
