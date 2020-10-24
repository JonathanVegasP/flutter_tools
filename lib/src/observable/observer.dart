part of 'observable_impl.dart';

abstract class ObserverWidget extends StatefulWidget {
  const ObserverWidget() : super();

  @override
  _ObserverState createState() => _ObserverState();

  Widget build(BuildContext context);
}

class _ObserverState extends State<ObserverWidget> {
  final _Observable observable = Observable();

  @override
  void initState() {
    observable.listen((event) {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    observable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getObs = observable;
    final child = widget.build(context);
    _getObs = null;
    assert(
      observable._canUpdate(),
      'Observable: Was not detected any Observable inside this Observer',
    );
    assert(child != null);
    return child;
  }
}
