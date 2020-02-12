import 'dart:io';

import 'package:dxdart/models/dog_breed_model.dart';
import 'package:dxdart/screens/home/dog_info/dog_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../make_testable_widget.dart';

void main() {
  setUpAll(
      () => HttpOverrides.global = null); // Need this for Image.Network to work

  testWidgets("#1 DogInfo Widget with data", (WidgetTester tester) async {
    HttpOverrides.runZoned(
      () async {
        final imgUrl =
            'https://images.dog.ceo/breeds/borzoi/n02090622_6106.jpg';
        final name = "Phu Quoc";
        final origin = "Vietnam";

        final data = DogBreed(origin: origin, name: name, imgUrl: imgUrl);

        final dogInfoWidget = makeTestableWidget(DogInfo(data: data));

        await tester.pumpWidget(dogInfoWidget);

        Finder imageContainer =
            find.byKey(Key('screens_home_dog_info_Container'));
        Container imageContainerWidget = tester.widget(imageContainer);
        expect(
            ((imageContainerWidget.decoration as BoxDecoration).image.image
                    as NetworkImage)
                .url,
            imgUrl);
        expect(imageContainerWidget.child, null);

        Finder nameText = find.byKey(Key('screens_home_dog_info_NameText'));
        Text nameTextWidget = tester.widget(nameText);
        expect(nameTextWidget.data, name);

        Finder originText = find.byKey(Key('screens_home_dog_info_OriginText'));
        Text originTextWidget = tester.widget(originText);
        expect(originTextWidget.data, origin);
      },
    );
  });

  testWidgets("#2 DogInfo Widget with null data", (WidgetTester tester) async {
    HttpOverrides.runZoned(
      () async {
        final dogInfoWidget = makeTestableWidget(DogInfo(data: null));

        await tester.pumpWidget(dogInfoWidget);

        Finder imageContainer =
            find.byKey(Key('screens_home_dog_info_Container'));
        Container imageContainerWidget = tester.widget(imageContainer);
        expect(imageContainerWidget.decoration, null);
        expect(imageContainerWidget.child, isNotNull);

        Finder loading = find.byType(CircularProgressIndicator);
        expect(loading, findsOneWidget);

        Finder nameText = find.byKey(Key('screens_home_dog_info_NameText'));
        Text nameTextWidget = tester.widget(nameText);
        expect(nameTextWidget.data, '');

        Finder originText = find.byKey(Key('screens_home_dog_info_OriginText'));
        Text originTextWidget = tester.widget(originText);
        expect(originTextWidget.data, '');
      },
    );
  });
}
