import 'package:dio/dio.dart';
import 'package:dxdart/core/constants.dart';
import 'package:dxdart/core/network/d_dio.dart';
import 'package:rxdart/rxdart.dart';

import 'package:dxdart/models/dog_breed_model.dart';

class NumberTriviaBloc {
  // DEPENDENCIES
  /////////////////////////////////////////
  final DDio dioClient;

  // CONSTRUCTOR
  /////////////////////////////////////////
  NumberTriviaBloc({this.dioClient}) {
    _subjectDogBreed = BehaviorSubject<DogBreed>();
  }

  // STATES
  /////////////////////////////////////////
  BehaviorSubject<DogBreed> _subjectDogBreed;

  ValueStream<DogBreed> get breedStream => _subjectDogBreed.stream;

  // METHODS
  /////////////////////////////////////////
  Future<void> getBreed() async {
    try {
      final response = await dioClient.get(
        'https://api.thedogapi.com/v1/images/search',
        options: Options(
          headers: {'x-api-key': API_KEY},
        ),
      );

      Map<String, dynamic> breed = response.data[0];
      Map<String, dynamic> breedMap = {
        'name': (breed['breeds'] as List).length > 0
            ? breed['breeds'][0]['name']
            : '',
        'origin': (breed['breeds'] as List).length > 0
            ? breed['breeds'][0]['origin']
            : '',
        'imgUrl': breed['url'],
      };

      final newTrivia = DogBreed.fromMap(breedMap);

      _subjectDogBreed.sink.add(newTrivia);
    } catch (e) {
      _subjectDogBreed.sink.add(DogBreed(imgUrl: '', name: '', origin: ''));
    }
  }

  void dispose() {
    _subjectDogBreed.close();
  }
}
