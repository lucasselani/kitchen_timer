import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:provider/provider.dart';

class ActionIconsColumn extends StatefulWidget {
  final CountdownTimer countdownTimer;

  ActionIconsColumn({@required this.countdownTimer});

  @override
  State<StatefulWidget> createState() {
    return _ActionIconState(countdownTimer: countdownTimer);
  }
}

class _ActionIconState extends State<ActionIconsColumn> {
  CountdownTimer countdownTimer;

  _ActionIconState({@required this.countdownTimer});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider provider, Widget child) {
        return Column(
          children: <Widget>[
            Center(
              child: InkWell(
                  child: Icon(
                      countdownTimer.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.black),
                  onTap: () => provider.playPauseTimer(countdownTimer)),
            ),
            SizedBox(height: 8.0),
            Center(
              child: InkWell(
                  child: Icon(
                      countdownTimer.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          countdownTimer.isFavorite ? Colors.red : Colors.black,
                      size: 24),
                  onTap: () => provider.favoriteTimer(countdownTimer)),
            ),
          ],
        );
      },
    );
  }
}
