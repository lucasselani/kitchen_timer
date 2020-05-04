import 'package:flutter/material.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/resources/colors.dart';
import 'package:kitchentimer/resources/heroes.dart';
import 'package:kitchentimer/resources/routes.dart';
import 'package:kitchentimer/resources/strings.dart';
import 'package:kitchentimer/resources/styles.dart';
import 'package:kitchentimer/screens/timer/item/timer_list_item.dart';
import 'package:kitchentimer/utils/dialogUtils.dart';
import 'package:kitchentimer/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitDialog(context),
      child: FutureBuilder(
          future: Provider.of<AppProvider>(context, listen: false).initDb(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? AppScaffold()
                : _TimerScaffold();
          }),
    );
  }
}

class _TimerScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider provider, Widget child) {
        return AppScaffold(
          useAppBar: false,
          child: Stack(
            children: <Widget>[
              _TimersList(timers: provider.timers),
              _NoTimers(listLength: provider.timers.length),
            ],
          ),
          action: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[_AddButton(), _FavoriteFab()],
          ),
        );
      },
    );
  }
}

class _AddButton extends StatelessWidget {
  _AddButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        backgroundColor: AppColors.white,
        icon: Icon(Icons.add, color: AppColors.primaryColor),
        heroTag: Heroes.fabAdd,
        label: Text(Strings.newButton, style: Styles.button()),
        onPressed: () => Navigator.pushNamed(context, Routes.addTimerScreen));
  }
}

class _FavoriteFab extends StatelessWidget {
  _FavoriteFab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible:
          Provider.of<AppProvider>(context, listen: false).favorites.isNotEmpty,
      child: Padding(
        padding: EdgeInsets.only(left: 8),
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.red400,
          icon: Icon(Icons.favorite, color: AppColors.white),
          heroTag: Heroes.fabFavorite,
          label: Text(Strings.favoriteButton,
              style: Styles.button(color: AppColors.white)),
          onPressed: () => () async {
            var list = await Provider.of<AppProvider>(context, listen: false)
                .favorites;
            print(list);
          },
        ),
      ),
    );
  }
}

class _TimerBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.access_alarm,
          size: 32,
          color: AppColors.white,
        ),
        SizedBox(width: 16.0),
        Text(Strings.timerTitle, style: Styles.appBar)
      ],
    );
  }
}

class _TimersList extends StatelessWidget {
  final List<CountdownTimer> timers;

  _TimersList({@required this.timers});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: timers.isNotEmpty,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 24.0),
          _TimerBar(),
          SizedBox(height: 24.0),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: timers.length,
            itemBuilder: (BuildContext context, int index) {
              return TimerListItem(countdownTimer: timers[index]);
            },
          ),
          SizedBox(height: 48.0),
        ],
      ),
    );
  }
}

class _NoTimers extends StatelessWidget {
  final int listLength;

  _NoTimers({@required this.listLength});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: Padding(
        padding: const EdgeInsets.all(64.0),
        child: Center(
          child: Text(
              Strings.noTimers(Provider.of<AppProvider>(context, listen: false)
                  .favorites
                  .isNotEmpty),
              style: Styles.button(color: AppColors.white),
              textAlign: TextAlign.center),
        ),
      ),
      visible: listLength <= 0,
    );
  }
}
