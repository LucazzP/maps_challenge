import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/shared/widgets/button_expanded/button_expanded_widget.dart';

main() {
  testWidgets('ButtonExpandedWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(ButtonExpandedWidget()));
    final textFinder = find.text('ButtonExpanded');
    expect(textFinder, findsOneWidget);
  });
}
