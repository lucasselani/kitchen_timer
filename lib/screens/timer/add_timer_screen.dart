import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/timer_provider.dart';
import 'package:provider/provider.dart';

class AddTimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _FormState());
  }
}

class _FormState extends StatefulWidget {
  @override
  _TimerForm createState() {
    return _TimerForm();
  }
}

class _TimerForm extends State<_FormState> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();

  Widget _createFormField(IconData icon, String label, String hint,
      TextEditingController controller,
      {bool validate = true, TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          icon: Icon(icon),
        ),
        maxLength: 255,
        keyboardType: inputType,
        validator: (value) {
          if (!validate) return null;
          if (value.isEmpty) return 'Please enter some text';
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TimerProvider>(context);
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _createFormField(
                  Icons.title, 'Título', 'Arroz, Bolo, etc', _titleController),
              _createFormField(Icons.description, 'Descrição',
                  'Olhar o forno 5min antes, etc', _descriptionController,
                  validate: false),
              _createFormField(Icons.timer, 'Tempo em segundos', '60s = 1min',
                  _timeController,
                  inputType: TextInputType.number),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      final timer = CountdownTimer(
                          creationOrder: provider.nextCreationOrder,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          duration: Duration(
                              seconds: int.parse(_timeController.text)));
                      provider.addTimer(timer);
                      Fluttertoast.showToast(
                          msg: 'Temporizador adicionado '
                              'com suceso!');
                      Navigator.pop(context);
                    }
                  },
                  child: Center(child: Text('Criar')),
                ),
              ),
            ]));
  }
}
