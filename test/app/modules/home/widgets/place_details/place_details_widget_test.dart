import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/modules/home/widgets/place_details/place_details_widget.dart';

main() {
  testWidgets('PlaceDetailsWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(PlaceDetailsWidget()));
    final textFinder = find.text('PlaceDetails');
    expect(textFinder, findsOneWidget);
  });
}
