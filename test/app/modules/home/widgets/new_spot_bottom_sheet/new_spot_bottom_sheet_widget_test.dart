import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/modules/home/widgets/new_spot_bottom_sheet/new_spot_bottom_sheet_widget.dart';

main() {
  testWidgets('NewSpotBottomSheetWidget has message',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(NewSpotBottomSheetWidget()));
    final textFinder = find.text('NewSpotBottomSheet');
    expect(textFinder, findsOneWidget);
  });
}
