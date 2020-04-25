import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/app_provider.dart';
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

  CountdownTimer _createTimer(AppProvider provider) {
    return CountdownTimer(
        creationOrder: provider.nextCreationOrder,
        title: _titleController.text,
        description: _descriptionController.text,
        duration: Duration(seconds: int.parse(_timeController.text)));
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _FormField(
                  icon: Icons.title,
                  label: 'Título',
                  hint: 'Arroz, Bolo, etc',
                  controller: _titleController),
              _FormField(
                  icon: Icons.description,
                  label: 'Descrição',
                  hint: 'Olhar o forno 5min antes, etc',
                  controller: _descriptionController,
                  validate: false),
              _FormField(
                  icon: Icons.timer,
                  label: 'Tempo em segundos',
                  hint: '60s = 1min',
                  controller: _timeController,
                  inputType: TextInputType.number),
              _FormButton(
                  provider: provider,
                  formKey: _formKey,
                  createTimer: _createTimer),
            ]));
  }
}

class _FormField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool validate;
  final TextInputType inputType;

  _FormField(
      {@required this.icon,
      @required this.label,
      @required this.hint,
      @required this.controller,
      this.validate = true,
      this.inputType = TextInputType.text,
      Key key})
      : super(key: ValueKey(label));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
}

typedef CreateTimer = CountdownTimer Function(AppProvider provider);

class _FormButton extends StatelessWidget {
  final AppProvider provider;
  final CreateTimer createTimer;
  final GlobalKey<FormState> formKey;

  _FormButton(
      {@required this.provider,
      @required this.createTimer,
      @required this.formKey});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: RaisedButton(
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              provider.addTimer(createTimer(provider));
              Fluttertoast.showToast(
                  msg: 'Temporizador adicionado '
                      'com suceso!');
              Navigator.pop(context);
            }
          },
          child: Center(child: Text('Criar')),
        ));
  }
}
