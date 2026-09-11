import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cueme/presentation/widgets/empty_state.dart';
import 'package:cueme/presentation/widgets/progress_summary.dart';

void main() {
  testWidgets('EmptyState displays icon, title, and description', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyState(
            icon: Icons.spa_outlined,
            title: 'Build your routine',
            description: 'Vitamins, creams, pills, skincare — keep everything in one calm place.',
          ),
        ),
      ),
    );

    expect(find.text('Build your routine'), findsOneWidget);
    expect(
      find.text('Vitamins, creams, pills, skincare — keep everything in one calm place.'),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.spa_outlined), findsOneWidget);
  });

  testWidgets('ProgressSummary calculates percentage correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProgressSummary(
            completed: 2,
            total: 4,
          ),
        ),
      ),
    );

    expect(find.text('50%'), findsOneWidget);
    expect(find.text('2 of 4 routines completed'), findsOneWidget);
  });
}
