import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/modules/home/widgets/star/star_widget.dart';

main() {
  testWidgets('StarWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(StarWidget()));
    final textFinder = find.text('Star');
    expect(textFinder, findsOneWidget);
  });
}
