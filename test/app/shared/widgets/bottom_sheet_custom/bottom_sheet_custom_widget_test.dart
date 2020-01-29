import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/shared/widgets/bottom_sheet_custom/bottom_sheet_custom_widget.dart';

main() {
  testWidgets('BottomSheetCustomWidget has message',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(BottomSheetCustomWidget()));
    final textFinder = find.byWidgetPredicate((widget) => widget is Card);
    expect(textFinder, findsOneWidget);
  });
}
