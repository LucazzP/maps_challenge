import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/modules/home/widgets/place_details_bottom_sheet/place_details_bottom_sheet_widget.dart';

main() {
  testWidgets('PlaceDetailsWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(PlaceDetailsBottomSheetWidget()));
    final textFinder = find.text('PlaceDetails');
    expect(textFinder, findsOneWidget);
  });
}
