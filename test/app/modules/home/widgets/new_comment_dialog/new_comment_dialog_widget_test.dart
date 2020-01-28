import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:desafio_maps/app/modules/home/widgets/new_comment_dialog/new_comment_dialog_widget.dart';

main() {
  testWidgets('NewCommentDialogWidget has message',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(NewCommentDialogWidget()));
    final textFinder = find.text('NewCommentDialog');
    expect(textFinder, findsOneWidget);
  });
}