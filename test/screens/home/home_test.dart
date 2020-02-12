import 'package:dxdart/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dxdart/screens/home/home.dart';

import '../make_testable_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("#1 Home Widget", (WidgetTester tester) async {
    await tester.runAsync(() async {
      await configureInjection();

      final Widget homeWidget = makeTestableWidget(Home());

      await tester.pumpWidget(homeWidget);

      Finder appBar = find.byKey(Key('screens_home_AppBar'));
      Finder appBarText =
          find.descendant(of: appBar, matching: find.text('Home'));
      expect(appBar, findsOneWidget);
      expect(appBarText, findsOneWidget);

      Finder streamBuilder = find.byKey(Key('screens_home_StreamBuilder'));
      expect(streamBuilder, findsOneWidget);

      Finder floatingButton =
          find.byKey(Key('screens_home_floatingActionButton'));
      expect(floatingButton, findsOneWidget);
    });
  });
}
