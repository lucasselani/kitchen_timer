import 'package:flutter/material.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/resources/colors.dart';
import 'package:kitchentimer/resources/routes.dart';
import 'package:kitchentimer/resources/strings.dart';
import 'package:kitchentimer/resources/styles.dart';
import 'package:kitchentimer/screens/timer/item/timer_list_item.dart';
import 'package:kitchentimer/widgets/rounded_button.dart';
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
              _NoTimers(listLength: provider.timers.length),
              _TimersList(timers: provider.timers),
              _AddButton(),
            ],
          ),
          backgroundColor: AppColors.backgroundColor,
          floatingActionButton: _FavoriteFab(),
        );
      },
    );
  }
}

class _FavoriteFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Provider.of<AppProvider>(context, listen: false).hasFavorites,
      child: Padding(
        padding: EdgeInsets.only(bottom: 56.0),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.red,
          child: Icon(Icons.favorite, color: Colors.white),
          onPressed: () => print('FAB'),
        ),
      ),
    );
  }
}

class _TimersList extends StatelessWidget {
  final List<CountdownTimer> timers;

  _TimersList({@required this.timers});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 24.0),
        ListView.builder(
          shrinkWrap: true,
          itemCount: timers.length,
          itemBuilder: (BuildContext context, int index) {
            return TimerListItem(countdownTimer: timers[index]);
          },
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
        child: RoundedButton(
            title: Strings.addButton,
            onClick: () =>
                Navigator.pushNamed(context, Routes.addTimerScreen)));
  }
}

class _NoTimers extends StatelessWidget {
  final int listLength;

  _NoTimers({@required this.listLength});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(Strings.noTimers,
              style: Styles.watch, textAlign: TextAlign.center),
        ),
      ),
      visible: listLength <= 0,
    );
  }
}
