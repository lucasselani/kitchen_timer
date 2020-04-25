import 'package:flutter/material.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/resources/routes.dart';
import 'package:kitchentimer/resources/strings.dart';
import 'package:kitchentimer/widgets/timer_list_item.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider provider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(Strings.timerTitle),
          ),
          body: Stack(
            children: <Widget>[
              _TimersList(provider: provider),
              _AddButton(),
            ],
          ),
        );
      },
    );
  }
}

class _TimersList extends StatelessWidget {
  final AppProvider provider;

  _TimersList({@required this.provider});

  List<Widget> _createItemList() => provider.timers
      .map((CountdownTimer timer) => TimerListItem(countdownTimer: timer))
      .toList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 24.0),
        ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: _createItemList(),
        ),
        SizedBox(height: 48.0),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.all(16.0),
        height: 48.0,
        child: RaisedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.addTimerScreen);
          },
          child: Center(
            child: Text('Adicionar'.toUpperCase()),
          ),
        ),
      ),
    );
  }
}
