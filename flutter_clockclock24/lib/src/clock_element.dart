import 'package:flutter/material.dart';

import 'clock_hand.dart';
import 'utils.dart';

class ClockElement extends StatelessWidget {
  /// The index of the clock element
  final int index;

  /// Number to be rendered by the small clock elements
  final int number;

  const ClockElement({Key key, this.index, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark)
      return _buildDarkThemeClock(context);
    else
      return _buildBrightThemeClock(context);
  }

  _buildBrightThemeClock(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                offset: const Offset(0.0, 0.0),
                blurRadius: 0),
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              spreadRadius: -4.5,
              blurRadius: 6.0,
            ),
          ],
        ),
        height: ClockUtils.sizeOfContext(context),
        width: ClockUtils.sizeOfContext(context),
        child: Stack(
          children: <Widget>[
            AnimatedHand(
              digit: ClockUtils.getHourOfIndex(number, index),
              handType: HandType.H,
            ),
            AnimatedHand(
              digit: ClockUtils.getMinuteOfIndex(number, index),
              handType: HandType.M,
            )
          ],
        ),
      ),
    );
  }

  _buildDarkThemeClock(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Constants.black,
          shape: BoxShape.circle,
        ),
        height: ClockUtils.sizeOfContext(context),
        width: ClockUtils.sizeOfContext(context),
        child: Stack(
          children: <Widget>[
            AnimatedHand(
              digit: ClockUtils.getHourOfIndex(number, index),
              handType: HandType.H,
            ),
            AnimatedHand(
              digit: ClockUtils.getMinuteOfIndex(number, index),
              handType: HandType.M,
            )
          ],
        ),
      ),
    );
  }
}
