import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tools/flutter_tools.dart';

void main() {
  testWidgets('Test if observer value is working', (pump) async {
    await pump.pumpWidget(TestApp());
    expect(find.text('0'), findsOneWidget);
    await pump.tap(find.byType(FloatingActionButton));
    await pump.pump();
    expect(find.text('1'), findsOneWidget);
  });
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ObserverValue<int>(
      initial: 0,
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  void _incrementCounter(ObserverValueState<int> state) {
    state.value++;
  }

  @override
  Widget build(BuildContext context) {
    final ObserverValueState<int> counter = ObserverValue.of(context);
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tools'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: text.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _incrementCounter(counter),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
