import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/resources/colors.dart';
import 'package:kitchentimer/resources/heroes.dart';
import 'package:kitchentimer/resources/strings.dart';
import 'package:kitchentimer/screens/add_timer/material_timer_picker.dart';
import 'package:kitchentimer/widgets/app_scaffold.dart';
import 'package:kitchentimer/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class AddTimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      useGradient: false,
      title: Strings.addTimerTitle,
      child:
          Container(padding: EdgeInsets.only(top: 16.0), child: _TimerForm()),
    );
  }
}

class _TimerForm extends StatefulWidget {
  @override
  _TimerFormState createState() {
    return _TimerFormState();
  }
}

class _TimerFormState extends State<_TimerForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  Duration _time;

  CountdownTimer _createTimer() {
    return _time != null
        ? CountdownTimer(
            title: _titleController.text,
            description: _descriptionController.text,
            duration: _time,
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context, listen: false);
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _FormField(
                icon: Icons.title,
                label: 'Título',
                hint: 'Arroz, Bolo, etc',
                controller: _titleController,
                error: 'O título é obrigatório',
              ),
              _FormField(
                  icon: Icons.description,
                  label: 'Descrição',
                  hint: 'Olhar o forno 5min antes, etc',
                  controller: _descriptionController,
                  validate: false),
              MaterialTimerPicker(onTimeSelected: (Duration duration) {
                setState(() {
                  _time = duration;
                });
              }),
              Spacer(),
              _FormButton(
                  provider: provider,
                  formKey: _formKey,
                  createTimer: _createTimer),
            ]));
  }
}

class _FormField extends StatelessWidget {
  final String error;
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
      this.error,
      this.validate = true,
      this.inputType = TextInputType.text,
      Key key})
      : super(key: ValueKey(label));

  InputDecoration _buildInputDecoration(
      String hint, String label, IconData icon) {
    return InputDecoration(
      hintText: hint,
      labelText: label,
      //icon: Icon(icon),
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextFormField(
            controller: controller,
            decoration: _buildInputDecoration(hint, label, icon),
            keyboardType: inputType,
            validator: (value) {
              if (!validate) return null;
              if (value.isEmpty) return error;
              return null;
            },
          ),
        ),
      ),
    );
  }
}

typedef CreateTimer = CountdownTimer Function();

class _FormButton extends StatelessWidget {
  final AppProvider provider;
  final CreateTimer createTimer;
  final GlobalKey<FormState> formKey;

  _FormButton(
      {@required this.provider,
      @required this.createTimer,
      @required this.formKey});

  void _onClick(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      var timer = createTimer();
      if (timer == null) {
        Fluttertoast.showToast(msg: Strings.noTimeSelected);
      } else {
        provider.addTimer(timer);
        Fluttertoast.showToast(msg: Strings.timerCreated);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: Heroes.fabAdd,
      child: RoundedButton(
        icon: Icon(Icons.add, color: AppColors.primaryColor),
        title: Strings.createButton,
        onClick: () => _onClick(context),
      ),
    );
  }
}
