import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/resources/colors.dart';
import 'package:kitchentimer/resources/styles.dart';

class AppScaffold extends StatelessWidget {
  final Widget action;
  final Widget child;
  final String title;
  final bool useAppBar;
  final bool useGradient;

  AppScaffold(
      {this.child,
      this.title,
      this.action,
      this.useAppBar = true,
      this.useGradient = true});

  Widget _buildAppBar(BuildContext context) => useAppBar
      ? AppBar(
          backgroundColor: AppColors.red400,
          elevation: 0,
          title: Text(
            title ?? '',
            style: Styles.appBar,
          ),
          leading: Center(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.chevron_left,
                color: AppColors.white,
              ),
              iconSize: 32,
            ),
          ),
        )
      : null;

  Widget _buildBody() => useGradient
      ? Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.gradientColor)),
          child: child)
      : child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: action,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFAFAFAFF),
    );
  }
}
