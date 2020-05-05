import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/resources/colors.dart';
import 'package:provider/provider.dart';

class ActionIconsColumn extends StatelessWidget {
  final CountdownTimer countdownTimer;

  ActionIconsColumn(this.countdownTimer);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _PlayPauseButton(countdownTimer),
        SizedBox(height: 2.0),
        _FavoriteButton(countdownTimer),
      ],
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  final CountdownTimer countdownTimer;

  _PlayPauseButton(this.countdownTimer);

  @override
  Widget build(BuildContext context) {
    return _IconButton(
      icon: Icon(countdownTimer.isPlaying ? Icons.pause : Icons.play_arrow,
          color: AppColors.black45, size: 24),
      onPressed: () => Provider.of<AppProvider>(context, listen: false)
          .playPauseTimer(countdownTimer),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final CountdownTimer countdownTimer;

  _FavoriteButton(this.countdownTimer);

  @override
  Widget build(BuildContext context) {
    return _IconButton(
      icon: Icon(
          countdownTimer.favoriteId != null
              ? Icons.favorite
              : Icons.favorite_border,
          color: countdownTimer.favoriteId != null
              ? AppColors.red400
              : AppColors.black45,
          size: 24),
      onPressed: () async =>
          await Provider.of<AppProvider>(context, listen: false)
              .favoriteTimer(countdownTimer),
    );
  }
}

class _IconButton extends StatelessWidget {
  final Icon icon;
  final Function onPressed;

  _IconButton({@required this.icon, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      child: Padding(padding: EdgeInsets.all(4.0), child: Center(child: icon)),
      onTap: onPressed,
    );
  }
}
