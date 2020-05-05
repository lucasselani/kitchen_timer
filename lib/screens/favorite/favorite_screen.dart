import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kitchentimer/models/favorite.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/resources/colors.dart';
import 'package:kitchentimer/resources/heroes.dart';
import 'package:kitchentimer/resources/strings.dart';
import 'package:kitchentimer/widgets/app_scaffold.dart';
import 'package:kitchentimer/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

import 'favorite_list_item.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider provider, Widget child) {
        return AppScaffold(
          useGradient: false,
          title: Strings.favoritesTitle,
          child: _FavoritesList(favorites: provider.favorites),
        );
      },
    );
  }
}

class _FavoritesList extends StatefulWidget {
  final List<Favorite> favorites;

  _FavoritesList({@required this.favorites});

  @override
  State<StatefulWidget> createState() {
    return _FavoritesState(favorites: favorites);
  }
}

class _FavoritesState extends State<_FavoritesList> {
  List<Favorite> favorites;
  List<Favorite> selectedFavorites = [];

  _FavoritesState({@required this.favorites});

  void _onSelected(Favorite favorite) {
    setState(() {
      selectedFavorites.contains(favorite)
          ? selectedFavorites.remove(favorite)
          : selectedFavorites.add(favorite);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              SizedBox(height: 24.0),
              ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  return FavoriteListItem(
                      favorite: favorites[index],
                      onSelected: _onSelected,
                      isSelected: selectedFavorites.contains(favorites[index]));
                },
              ),
              SizedBox(height: 48.0),
            ],
          ),
          _SelectButton(selectedFavorites: selectedFavorites),
        ],
      ),
    );
  }
}

class _SelectButton extends StatelessWidget {
  final List<Favorite> selectedFavorites;

  _SelectButton({@required this.selectedFavorites});

  void _onClick(BuildContext context) async {
    await Provider.of<AppProvider>(context, listen: false)
        .addTimers(selectedFavorites);
    await Fluttertoast.showToast(msg: Strings.timerAdded);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Hero(
        tag: Heroes.fabFavorite,
        child: RoundedButton(
          color: AppColors.red400,
          icon: Icon(Icons.add, color: AppColors.white),
          title: Strings.addButton,
          onClick: selectedFavorites.isEmpty ? null : () => _onClick(context),
        ),
      ),
    );
  }
}
