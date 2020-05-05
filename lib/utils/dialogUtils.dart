import 'package:flutter/material.dart';
import 'package:kitchentimer/resources/colors.dart';
import 'package:kitchentimer/resources/strings.dart';
import 'package:kitchentimer/resources/styles.dart';

Future<bool> showExitDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      title:
          Text(Strings.exitDialogTitle, style: Styles.title(biggerFont: true)),
      content:
          Text(Strings.exitDialogLabel, style: Styles.label(biggerFont: true)),
      actions: <Widget>[
        InkWell(
          onTap: () => Navigator.of(context).pop(true),
          customBorder: CircleBorder(),
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Text(Strings.yes,
                  style: Styles.button(color: AppColors.black))),
        ),
        InkWell(
          onTap: () => Navigator.of(context).pop(false),
          customBorder: CircleBorder(),
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Text(Strings.no, style: Styles.button())),
        ),
        SizedBox(width: 8),
      ],
    ),
  );
}
