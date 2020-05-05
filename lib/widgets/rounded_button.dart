import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/resources/colors.dart';
import 'package:kitchentimer/resources/styles.dart';

class RoundedButton extends StatelessWidget {
  final Icon icon;
  final String title;
  final Function onClick;
  final Color color;

  RoundedButton(
      {@required this.title, @required this.onClick, this.icon, this.color});

  List<Widget> _buildRow() {
    List<Widget> row = [];
    if (icon != null) {
      row..add(icon)..add(SizedBox(width: 12));
    }
    return row
      ..add(Flexible(
        child: Text(title,
            style: Styles.button(
                color:
                    color != null ? AppColors.white : AppColors.primaryColor)),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      height: 48.0,
      child: RaisedButton(
        disabledColor: AppColors.black26,
        disabledTextColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: color ?? AppColors.white,
        onPressed: onClick != null ? () => onClick() : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildRow(),
        ),
      ),
    );
  }
}
