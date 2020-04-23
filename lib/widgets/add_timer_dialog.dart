import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/models/timer.dart';
import 'package:kitchentimer/providers/timer_provider.dart';

class AddTimerDialog extends StatelessWidget {
  final TimerProvider provider;

  AddTimerDialog({@required this.provider});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(content: _FormState(provider: provider));
  }
}

class _FormState extends StatefulWidget {
  final TimerProvider provider;

  _FormState({@required this.provider});

  @override
  _TimerForm createState() {
    return _TimerForm(provider: provider);
  }
}

class _TimerForm extends State<_FormState> {
  final _formKey = GlobalKey<FormState>();
  final TimerProvider provider;

  _TimerForm({@required this.provider});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                maxLength: 255,
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty) return 'Please enter some text';
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      this
                          .provider
                          .addTimer(Timer(this.provider.timers.length));
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ]));
  }
}
