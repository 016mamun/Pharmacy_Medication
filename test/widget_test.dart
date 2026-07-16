import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pharmacy_medication/main.dart';

void main() {
  testWidgets('App launches and shows shop selection screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: PharmacyApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Choose Your Store'), findsOneWidget);
  });
}
