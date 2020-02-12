import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dxdart/core/network/d_dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:dxdart/blocs/dog_breed_bloc.dart';
import 'package:dxdart/models/dog_breed_model.dart';

import '../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements DDio {}

void main() {
  MockHttpClient mockHttpClient;
  NumberTriviaBloc numberTriviaBloc;

  setUp(() {
    mockHttpClient = MockHttpClient();
    numberTriviaBloc = NumberTriviaBloc(dioClient: mockHttpClient);
  });

  test('#1 Init with the right states', () {
    expect(numberTriviaBloc.breedStream.value, null);
  });

  group('#2 getBreed()', () {
    test('#2.1 fetch breed successfully', () async {
      final expectedJson = await fixture('breeds.json');
      final jsonMap = json.decode(expectedJson);

      Map<String, dynamic> breed = jsonMap[0];
      Map<String, dynamic> breedMap = {
        'name': (breed['breeds'] as List).length > 0
            ? breed['breeds'][0]['name']
            : '',
        'origin': (breed['breeds'] as List).length > 0
            ? breed['breeds'][0]['origin']
            : '',
        'imgUrl': breed['url'],
      };

      final expectedNumberTrivia = DogBreed.fromMap(breedMap);

      when(mockHttpClient.get(any, options: anyNamed('options')))
          .thenAnswer((_) async => Response(data: jsonMap, statusCode: 200));

      final expected1 = [
        expectedNumberTrivia,
      ];

      expectLater(numberTriviaBloc.breedStream, emitsInOrder(expected1));

      numberTriviaBloc.getBreed();
    });

    test('#2.2 fetch breed failed', () async {
      final expectedNumberTrivia = DogBreed(imgUrl: '', name: '', origin: '');

      when(mockHttpClient.get(any, options: anyNamed('options')))
          .thenThrow(Exception);

      final expected2 = [
        expectedNumberTrivia,
      ];

      expectLater(numberTriviaBloc.breedStream, emitsInOrder(expected2));

      numberTriviaBloc.getBreed();
    });
  });

  test('#3 dispose()', () {
    numberTriviaBloc.dispose();
    expect(numberTriviaBloc.isClosed, true);
  });
}
