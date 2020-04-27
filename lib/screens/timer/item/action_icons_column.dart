import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/providers/item_provider.dart';
import 'package:provider/provider.dart';

class ActionIconsColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _PlayPauseButton(),
        SizedBox(height: 2.0),
        _FavoriteButton(),
      ],
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<ItemProvider, bool>(
      builder: (BuildContext context, bool isPlaying, Widget child) {
        return _IconButton(
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.black, size: 24),
            onTap: () => Provider.of<ItemProvider>(context, listen: false)
                .playPauseTimer());
      },
      selector: (_, ItemProvider provider) => provider.countdownTimer.isPlaying,
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<ItemProvider, bool>(
      builder: (BuildContext context, bool isFavorite, Widget child) {
        return _IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.black, size: 24),
            onTap: () => Provider.of<ItemProvider>(context, listen: false)
                .favoriteTimer());
      },
      selector: (_, ItemProvider provider) =>
          provider.countdownTimer.isFavorite,
    );
  }
}

class _IconButton extends StatelessWidget {
  final Icon icon;
  final Function onTap;

  _IconButton({@required this.icon, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      child: Padding(padding: EdgeInsets.all(4.0), child: Center(child: icon)),
      onTap: onTap,
    );
  }
}
