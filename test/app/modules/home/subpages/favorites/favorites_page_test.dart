import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/modules/home/subpages/favorites/favorites_page.dart';

main() {
  testWidgets('FavoritesPage has title', (WidgetTester tester) async {
    await tester
        .pumpWidget(buildTestableWidget(FavoritesPage(title: 'Favorites')));
    final titleFinder = find.text('Favorites');
    expect(titleFinder, findsOneWidget);
  });
}
