import 'package:flutter/material.dart';

import 'utils.dart';

enum HandType { H, M }

class AnimatedHand extends StatelessWidget {
  /// This woudld be either hour or minute
  final double digit;

  /// To decide whether the hand is going to be used for minutes or hours
  final HandType handType;

  const AnimatedHand({Key key, this.digit, this.handType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: digit),
      duration: Duration(seconds: 5),
      child: Transform.translate(
        offset: Offset(0.0, -ClockUtils.sizeOfContext(context) / 2 + 10),
        child: Container(
          width: 11,
          height: ClockUtils.sizeOfContext(context) - 10,
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Constants.paleGold
                  : Colors.black,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0))),
        ),
      ),
      builder: (_, value, handWidget) {
        return ClockHand(
            size: 0.55,
            color: Colors.transparent,
            angleRadians: handType == HandType.H
                ? value * ClockUtils.radiansPerHour
                : value * ClockUtils.radiansPerTick,
            child: handWidget);
      },
    );
  }
}

class ClockHand extends StatelessWidget {
  final double size;
  final Color color;
  final double angleRadians;
  final Widget child;

  ClockHand(
      {@required this.size,
      @required this.color,
      @required this.angleRadians,
      this.child})
      : assert(size != null),
        assert(color != null),
        assert(angleRadians != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: Transform.rotate(
          angle: angleRadians,
          alignment: Alignment.center,
          child: Transform.scale(
            scale: size,
            alignment: Alignment.center,
            child: Container(
              color: color,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
