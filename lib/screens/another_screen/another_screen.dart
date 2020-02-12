import 'package:dxdart/screens/another_screen/dog_info_circle/dog_info_circle.dart';
import 'package:flutter/material.dart';

import 'package:dxdart/models/dog_breed_model.dart';
import 'package:dxdart/blocs/dog_breed_bloc.dart';

import '../../injection.dart';

class AnotherScreen extends StatelessWidget {
  static const routeName = '/another-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
                stream: getIt<NumberTriviaBloc>().breedStream,
                builder: (BuildContext ctx, AsyncSnapshot<DogBreed> snapShot) =>
                    DogInfoCircle(data: snapShot.data)),
            RaisedButton(
              onPressed: getIt<NumberTriviaBloc>().getBreed,
              child: Text("+"),
            )
          ],
        ),
      ),
    );
  }
}
