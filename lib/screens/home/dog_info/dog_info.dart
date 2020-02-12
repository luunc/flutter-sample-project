import 'package:dxdart/models/dog_breed_model.dart';
import 'package:dxdart/screens/another_screen/another_screen.dart';
import 'package:flutter/material.dart';

class DogInfo extends StatelessWidget {
  final DogBreed data;

  const DogInfo({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          key: Key('screens_home_dog_info_Container'),
          height: 400,
          width: 400,
          decoration: getDecoration(),
          child: getContainerChild(),
        ),
        SizedBox(height: 10),
        Text(
          '${data?.name ?? ''}',
          style: TextStyle(fontSize: 30),
          key: Key('screens_home_dog_info_NameText'),
        ),
        Text(
          '${data?.origin ?? ''}',
          key: Key('screens_home_dog_info_OriginText'),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AnotherScreen.routeName);
          },
          child: Text(
            'Tap here to move to new screen.',
          ),
        )
      ],
    );
  }

  BoxDecoration getDecoration() {
    if (data?.imgUrl != null && data?.imgUrl != '') {
      return BoxDecoration(
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

    if (data?.imgUrl == '') {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.network_check,
              size: 50,
              color: Colors.red,
            ),
            Text('Please check network connection'),
          ],
        ),
      );
    }

    return null;
  }
}
