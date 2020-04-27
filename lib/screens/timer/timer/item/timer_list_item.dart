import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/providers/item_provider.dart';
import 'package:kitchentimer/resources/styles.dart';
import 'package:kitchentimer/screens/timer/timer/item/action_icons_column.dart';
import 'package:kitchentimer/screens/timer/timer/item/countdown_watch.dart';
import 'package:provider/provider.dart';

class TimerListItem extends StatelessWidget {
  final CountdownTimer countdownTimer;

  TimerListItem({@required Key key, @required this.countdownTimer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<AppProvider, ItemProvider>(
      create: (BuildContext context) =>
          ItemProvider(countdownTimer: countdownTimer),
      update: (BuildContext context, AppProvider appProvider,
          ItemProvider itemProvider) {
        itemProvider.appProvider = appProvider;
        return itemProvider;
      },
      child: _CardItem(),
    );
  }
}

class _CardItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CountdownTimer countdownTimer =
        Provider.of<ItemProvider>(context, listen: false).countdownTimer;
    return Dismissible(
      key: Key(countdownTimer.creationOrder.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        Provider.of<AppProvider>(context, listen: false)
            .removeTimer(countdownTimer);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _TextColumn(),
                SizedBox(width: 16),
                CountdownWatch(),
                SizedBox(width: 16),
                ActionIconsColumn(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: Colors.black12),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CountdownTimer countdownTimer =
        Provider.of<ItemProvider>(context, listen: false).countdownTimer;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(countdownTimer.title, style: Styles.title),
          Container(
            child: Text(countdownTimer.description, style: Styles.label),
            margin: EdgeInsets.only(top: 4.0),
          )
        ],
      ),
    );
  }
}
