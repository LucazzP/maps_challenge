import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/modules/login/widgets/facebook_button/facebook_button_widget.dart';

main() {
  testWidgets('FacebookButtonWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(FacebookButtonWidget()));
    final textFinder = find.text('FacebookButton');
    expect(textFinder, findsOneWidget);
  });
}
