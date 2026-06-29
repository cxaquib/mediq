import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mediq/main.dart';

void main() {
  testWidgets('MediQ app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const MediQApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}