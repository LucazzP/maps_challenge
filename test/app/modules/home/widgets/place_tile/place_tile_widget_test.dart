import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/modules/home/widgets/place_tile/place_tile_widget.dart';

main() {
  testWidgets('PlaceTileWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(PlaceTileWidget()));
    final textFinder = find.text('PlaceTile');
    expect(textFinder, findsOneWidget);
  });
}
  