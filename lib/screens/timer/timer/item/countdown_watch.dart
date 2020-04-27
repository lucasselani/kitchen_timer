import 'package:flutter/material.dart';
import 'package:kitchentimer/providers/item_provider.dart';
import 'package:kitchentimer/resources/styles.dart';
import 'package:kitchentimer/utils/timeUtils.dart';
import 'package:provider/provider.dart';

class CountdownWatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<ItemProvider, int>(
      builder: (BuildContext context, int value, Widget child) {
        return Container(
          child: Text(
            formatTime(value),
            style: Styles.watch,
          ),
        );
      },
      selector: (BuildContext _, ItemProvider provider) =>
          provider.countdownTimer.remainingSeconds,
    );
  }
}
