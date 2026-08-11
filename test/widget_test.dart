import 'package:flutter_test/flutter_test.dart';
import 'package:startup/main.dart';

void main() {
  testWidgets('Studio Proof smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StudioProofApp());
    expect(find.byType(StudioProofApp), findsOneWidget);
  });
}
