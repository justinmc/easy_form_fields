import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_form_fields/easy_form_fields.dart';

void main() {
  testWidgets('Error can only be shown after focus', (WidgetTester tester) async {
    const String errorMessage = 'Cannot be empty.';
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Center(
            child: EasyTextFormFieldFocus(
              validator: (value) => value.isEmpty ? errorMessage : null,
            ),
          ),
        ),
      ),
    );

    // After rendering, no error is shown.
    expect(find.text(errorMessage), findsNothing);

    // Focusing the field causes the error to show.
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();
    expect(find.text(errorMessage), findsOneWidget);

    // Entering a valid value hides the error.
    await tester.enterText(find.byType(TextField), 'asdf');
    await tester.pumpAndSettle();
    expect(find.text(errorMessage), findsNothing);
  });
}
