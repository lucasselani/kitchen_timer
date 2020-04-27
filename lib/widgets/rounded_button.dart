import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/resources/colors.dart';
import 'package:kitchentimer/resources/styles.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Function onClick;

  RoundedButton({@required this.title, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      height: 48.0,
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: AppColors.primaryColor,
        onPressed: () {
          onClick();
        },
        child: Center(
          child: Text(title, style: Styles.button),
        ),
      ),
    );
  }
}
