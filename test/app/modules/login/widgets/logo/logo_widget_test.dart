import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/modules/login/widgets/logo/logo_widget.dart';

main() {
  testWidgets('LogoWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(LogoWidget()));
    final textFinder = find.text('Logo');
    expect(textFinder, findsOneWidget);
  });
}
