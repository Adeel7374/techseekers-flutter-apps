import 'package:flutter_test/flutter_test.dart';

import 'package:northern_fork/main.dart';

void main() {
  testWidgets('Northern Fork menu renders and basket flow works',
      (WidgetTester tester) async {
    await tester.pumpWidget(const NorthernForkApp());

    // Menu screen: app title and at least one dish category chip.
    expect(find.text('The Northern Fork'), findsWidgets);
    expect(find.text('Mains'), findsOneWidget);

    // Add the first dish, then open the basket.
    await tester.tap(find.text('Add').first);
    await tester.pump();
    expect(find.textContaining('View basket'), findsOneWidget);

    await tester.tap(find.textContaining('View basket'));
    await tester.pumpAndSettle();
    expect(find.text('Your basket'), findsOneWidget);
    expect(find.text('Place order'), findsOneWidget);

    // Place the order and confirm the confirmation screen appears.
    await tester.tap(find.text('Place order'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Thanks'), findsOneWidget);
  });
}
