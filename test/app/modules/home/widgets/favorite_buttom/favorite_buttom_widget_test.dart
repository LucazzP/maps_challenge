import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/modules/home/widgets/favorite_buttom/favorite_buttom_widget.dart';

main() {
  testWidgets('FavoriteButtomWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(FavoriteButtomWidget()));
    final textFinder = find.text('FavoriteButtom');
    expect(textFinder, findsOneWidget);
  });
}
