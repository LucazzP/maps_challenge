import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/modules/home/widgets/rating_stars/rating_stars_widget.dart';

main() {
  testWidgets('RatingStarsWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(RatingStarsWidget()));
    final textFinder = find.text('RatingStars');
    expect(textFinder, findsOneWidget);
  });
}
