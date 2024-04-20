import 'package:flutter/material.dart';

/*
https://api.flutter.dev/flutter/widgets/ActionListener-class.html
ActionListener bridge the Action lifecyele to the Widget lifecycle.
*/
class ActionsWidget extends StatefulWidget {
  const ActionsWidget({super.key});

  @override
  _ActionsWidgetState createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends State<ActionsWidget> {
  bool _on = false;
  late final MyAction1 _myAction;

  @override
  void initState() {
    super.initState();
    _myAction = MyAction1();
  }

  void _toggleState() {
    setState(() {
      _on = !_on;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
            onPressed: _toggleState,
            child: Text(_on ? 'Disabled' : 'Enabled'),
          )),
      if (_on)
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: ActionListener(
              listener: (Action<Intent> action) {
                if (action.intentType == MyExtend1) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Action Listener Called'),
                  ));
                }
              },
              action: _myAction,
              child: ElevatedButton(
                onPressed: () {
                  const ActionDispatcher()
                      .invokeAction(_myAction, const MyExtend1());
                },
                child: const Text('Call Action Listener'),
              ),
            ))
      else
        Container()
    ]);
  }
}

class MyExtend1 extends Intent {
  const MyExtend1();
}

class MyAction1 extends Action<MyExtend1> {
  @override
  Object? invoke(covariant MyExtend1 intent) {
    notifyActionListeners();
    return null;
  }
}
