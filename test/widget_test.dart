import 'package:flutter_test/flutter_test.dart';
import 'package:gym_store/main.dart';

void main() {
  testWidgets('gymStore app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const GymStoreUygulamasi());
    expect(find.text('gymStore'), findsOneWidget);
  });
}
