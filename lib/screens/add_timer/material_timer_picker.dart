import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/resources/styles.dart';

typedef OnTimeSelected = void Function(Duration duration);

class MaterialTimerPicker extends StatelessWidget {
  final OnTimeSelected onTimeSelected;

  MaterialTimerPicker({@required this.onTimeSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 6.0,
        child: CupertinoTheme(
          data: CupertinoThemeData(
            textTheme:
                CupertinoTextThemeData(dateTimePickerTextStyle: Styles.watch),
          ),
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            onTimerDurationChanged: (Duration value) {
              onTimeSelected(value);
            },
          ),
        ),
      ),
    );
  }
}
