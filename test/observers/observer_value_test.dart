import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tools/flutter_tools.dart';

void main() {
  testWidgets('Test if observer value is working', (pump) async {
    await pump.pumpWidget(TestApp());
    expect(find.text(''), findsOneWidget);
    await pump.tap(find.byType(GestureDetector));
    await pump.pump();
    expect(find.text('1'), findsOneWidget);
  });
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ObserverValue<String>(
      initial: '',
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ObserverValueState<String> value = ObserverValue.of(context);
    return Scaffold(
      body: Column(
        children: [
          Text(value.value),
          GestureDetector(
            child: Text('teste'),
            onTap: () {
              value.value = '1';
            },
          ),
        ],
      ),
    );
  }
}
