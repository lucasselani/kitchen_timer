import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/resources/colors.dart';
import 'package:kitchentimer/resources/heroes.dart';
import 'package:kitchentimer/resources/strings.dart';
import 'package:kitchentimer/resources/styles.dart';
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
  Duration _time;

  CountdownTimer _createTimer() {
    return _time != null
        ? CountdownTimer(
            title: _titleController.text,
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
              Padding(
                  padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  child: Text(Strings.title, style: Styles.form)),
              _FormField(
                icon: Icons.title,
                hint: Strings.timerTitleHint,
                controller: _titleController,
                error: Strings.timerTitleError,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                  child: Text(Strings.time, style: Styles.form)),
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
  final String hint;
  final TextEditingController controller;
  final bool validate;
  final TextInputType inputType;

  _FormField(
      {@required this.icon,
      @required this.hint,
      @required this.controller,
      this.error,
      this.validate = true,
      this.inputType = TextInputType.text,
      Key key})
      : super(key: key);

  InputDecoration _buildInputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      fillColor: AppColors.white,
      hintStyle: Styles.label(biggerFont: true),
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
        elevation: 6.0,
        child: Container(
          padding: EdgeInsets.only(bottom: 4.0),
          child: TextFormField(
            style: Styles.title(biggerFont: true),
            controller: controller,
            decoration: _buildInputDecoration(hint, icon),
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

  Future<void> _onClick(BuildContext context) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      var timer = createTimer();
      if (timer == null) {
        await Fluttertoast.showToast(msg: Strings.noTimeSelected);
      } else {
        await provider.addTimer(timer);
        await Fluttertoast.showToast(msg: Strings.timerCreated);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: Heroes.fabAdd,
      child: RoundedButton(
        color: AppColors.red400,
        icon: Icon(Icons.add, color: AppColors.white),
        title: Strings.createButton,
        onClick: () => _onClick(context),
      ),
    );
  }
}
