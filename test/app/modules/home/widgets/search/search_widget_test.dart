import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/modules/home/widgets/search/search_widget.dart';

main() {
  testWidgets('SearchWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(SearchWidget()));
    final textFinder = find.text('Search');
    expect(textFinder, findsOneWidget);
  });
}
  