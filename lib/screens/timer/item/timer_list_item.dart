import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/resources/colors.dart';
import 'package:kitchentimer/resources/styles.dart';
import 'package:kitchentimer/screens/timer/item/action_icons_column.dart';
import 'package:kitchentimer/screens/timer/item/countdown_watch.dart';
import 'package:provider/provider.dart';

class TimerListItem extends StatelessWidget {
  final CountdownTimer countdownTimer;

  TimerListItem({key, @required this.countdownTimer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(countdownTimer),
      direction: DismissDirection.endToStart,
      onDismissed: (_) async {
        await Provider.of<AppProvider>(context, listen: false)
            .removeTimer(countdownTimer);
      },
      child: Card(
        color: AppColors.white,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CountdownWatch(countdownTimer),
              SizedBox(width: 16),
              Expanded(
                child: Text(countdownTimer.title, style: Styles.title()),
              ),
              SizedBox(width: 16),
              ActionIconsColumn(countdownTimer),
            ],
          ),
        ),
      ),
    );
  }
}
