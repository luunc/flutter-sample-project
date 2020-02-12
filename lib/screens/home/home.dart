import 'package:dxdart/blocs/dog_breed_bloc.dart';
import 'package:dxdart/injection.dart';
import 'package:dxdart/models/dog_breed_model.dart';
import 'package:dxdart/screens/home/dog_info/dog_info.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      getIt<NumberTriviaBloc>().getBreed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: Key("screens_home_AppBar"),
        title: Text("Home"),
      ),
      body: Center(
        child: StreamBuilder(
          key: Key("screens_home_StreamBuilder"),
          stream: getIt<NumberTriviaBloc>().breedStream,
          builder: (BuildContext ctx, AsyncSnapshot<DogBreed> snapShot) =>
              DogInfo(data: snapShot.data),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key("screens_home_floatingActionButton"),
        onPressed: getIt<NumberTriviaBloc>().getBreed,
        tooltip: 'Decrement',
        child: Icon(Icons.compare_arrows),
      ),
    );
  }
}
