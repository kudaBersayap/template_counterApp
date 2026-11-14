import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:counter_app/main.dart';
import 'package:counter_app/tampil_angka.dart';

void main() {
  testWidgets('Counter App and Navigation test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const Main());
    await tester.pumpAndSettle();

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Tampil Angka'), findsOneWidget);
    expect(find.text('Nilai terakhir adalah'), findsOneWidget);
    expect(find.text('Menunggu...'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1499));
    expect(find.text('Menunggu...'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1));

    expect(find.text('Menunggu...'), findsNothing);
    expect(
      find.descendant(of: find.byType(TampilAngka), matching: find.text('1')),
      findsOneWidget,
    );
  });

  testWidgets('Counter value is restored after reopening the app', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const Main());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(const Main());
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);
  });
}
