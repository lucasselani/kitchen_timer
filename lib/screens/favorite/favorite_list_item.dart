import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/models/favorite.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/resources/colors.dart';
import 'package:kitchentimer/resources/styles.dart';
import 'package:kitchentimer/utils/timeUtils.dart';
import 'package:provider/provider.dart';

typedef OnSelected = void Function(Favorite favorite);

class FavoriteListItem extends StatelessWidget {
  final Favorite favorite;
  final OnSelected onSelected;
  final bool isSelected;

  FavoriteListItem(
      {key,
      @required this.favorite,
      @required this.onSelected,
      @required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(favorite),
      direction: DismissDirection.endToStart,
      onDismissed: (_) async {
        await Provider.of<AppProvider>(context, listen: false)
            .deleteFavorite(favorite);
      },
      child: Card(
        color: AppColors.white,
        elevation: 6.0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: CheckboxListTile(
            value: isSelected,
            onChanged: (_) {
              onSelected(favorite);
            },
            title: Row(
              children: <Widget>[
                Text(
                  formatTime(favorite.duration.inSeconds),
                  style: Styles.title(),
                ),
                SizedBox(width: 24),
                Text(
                  favorite.title,
                  style: Styles.title(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
