import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/modules/home/subpages/maps/maps_page.dart';

main() {
  testWidgets('MapsPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(MapsPage(title: 'Maps')));
    final titleFinder = find.text('Maps');
    expect(titleFinder, findsOneWidget);
  });
}
