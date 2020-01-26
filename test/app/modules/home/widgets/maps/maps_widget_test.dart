import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/modules/home/widgets/maps/maps_widget.dart';

main() {
  testWidgets('MapsWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(MapsWidget()));
    final textFinder = find.text('Maps');
    expect(textFinder, findsOneWidget);
  });
}
