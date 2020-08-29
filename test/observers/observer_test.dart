import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tools/flutter_tools.dart';

void main() {
  testWidgets('Test if observer is working', (pump) async {
    await pump.pumpWidget(TestApp());
    expect(find.text('0'), findsOneWidget);
    await pump.tap(find.byType(GestureDetector));
    await pump.pump();
    expect(find.text('1'), findsOneWidget);
  });
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  final counter = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Observer((_) => Text('$counter')),
          GestureDetector(
            child: Text('teste'),
            onTap: () {
              counter.value++;
            },
          ),
        ],
      ),
    );
  }
}
