import 'package:dxdart/models/dog_breed_model.dart';
import 'package:flutter/material.dart';

class DogInfoCircle extends StatelessWidget {
  final DogBreed data;

  const DogInfoCircle({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '${data?.name ?? ''}',
          style: TextStyle(fontSize: 30),
        ),
        Text('${data?.origin ?? ''}'),
        SizedBox(height: 10),
        Container(
          height: 400,
          width: 400,
          decoration: getDecoration(),
          child: getContainerChild(),
        ),
      ],
    );
  }

  BoxDecoration getDecoration() {
    if (data?.imgUrl != null) {
      return BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(data.imgUrl),
        ),
      );
    }

    return null;
  }

  Widget getContainerChild() {
    if (data?.imgUrl == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return null;
  }
}
