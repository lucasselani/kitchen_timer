import 'package:flutter/cupertino.dart';
import 'package:kitchentimer/models/timer.dart';

class TimerListItem extends StatelessWidget {
  final Timer timer;

  TimerListItem({Key key, @required this.timer})
      : super(key: ValueKey(timer.creationOrder));

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Item ${timer.creationOrder}'),
    );
  }
}
