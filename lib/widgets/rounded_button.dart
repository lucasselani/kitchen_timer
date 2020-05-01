import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/resources/colors.dart';
import 'package:kitchentimer/resources/styles.dart';

class RoundedButton extends StatelessWidget {
  final Icon icon;
  final String title;
  final Function onClick;

  RoundedButton({@required this.title, @required this.onClick, this.icon});

  List<Widget> _buildRow() {
    List<Widget> row = [];
    if (icon != null) {
      row..add(icon)..add(SizedBox(width: 12));
    }
    return row..add(Text(title, style: Styles.button()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      height: 48.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: AppColors.white,
        onPressed: () {
          onClick();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildRow(),
        ),
      ),
    );
  }
}
