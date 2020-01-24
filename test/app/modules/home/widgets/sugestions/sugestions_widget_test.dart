import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/modules/home/widgets/sugestions/sugestions_widget.dart';

main() {
  testWidgets('SugestionsWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(SugestionsWidget()));
    final textFinder = find.text('Sugestions');
    expect(textFinder, findsOneWidget);
  });
}
  