import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_form_fields/easy_form_fields.dart';

void main() {
  testWidgets('Error can only be shown after unfocus', (WidgetTester tester) async {
    const String errorMessage = 'Cannot be empty.';
    final UniqueKey key1 = UniqueKey();
    final UniqueKey key2 = UniqueKey();
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Center(
            child: Column(
              children: <Widget>[
                EasyTextFormFieldUnfocus(
                  key: key1,
                  validator: (value) => value.isEmpty ? errorMessage : null,
                ),
                TextFormField(
                  key: key2,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // After rendering, no error is shown.
    expect(find.text(errorMessage), findsNothing);

    // Focusing the field does not cause the error to show.
    await tester.tap(find.byKey(key1));
    await tester.pumpAndSettle();
    expect(find.text(errorMessage), findsNothing);

    // Unfocusing the field shows the error.
    await tester.tap(find.byKey(key2));
    await tester.pumpAndSettle();
    expect(find.text(errorMessage), findsOneWidget);

    // Focusing the field again continues to show the error.
    await tester.tap(find.byKey(key1));
    await tester.pumpAndSettle();
    expect(find.text(errorMessage), findsOneWidget);

    // Entering a valid value continues to show the error.
    await tester.enterText(find.byKey(key1), 'asdf');
    await tester.pumpAndSettle();
    expect(find.text(errorMessage), findsOneWidget);

    // Unfocusing the field while valid hides the error.
    await tester.tap(find.byKey(key2));
    await tester.pumpAndSettle();
    expect(find.text(errorMessage), findsNothing);
  });
}
