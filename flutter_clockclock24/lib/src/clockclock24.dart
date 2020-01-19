import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

import 'clock_element.dart';
import 'utils.dart';

class ClockClock24 extends StatelessWidget {
  final ClockModel model;

  const ClockClock24(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Container(
                height: MediaQuery.of(context).size.height - 5,
                width: MediaQuery.of(context).size.width - 5,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black12
                    : Colors.white,
                child: _Clock(model))));
  }
}

class _Clock extends StatefulWidget {
  final ClockModel model;

  const _Clock(this.model);

  @override
  State<StatefulWidget> createState() => _ClockState();
}

class _ClockState extends State<_Clock> {
  /// This clock will show the time and every 15min will show the temperature
  /// if the temperature is between 0 and 99
  var _now = DateTime.now();
  var _timer;

  /// The numbers that are going to show by the clock
  /// It's either to show time or to show temperature
  /// for example for 23:22 the array would be [2, 3, 2, 2]
  var _numbers = <int>[0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(4, (index) {
          return _ClockRow(
            number: _numbers[index],
          );
        }));
  }

  @override
  void initState() {
    super.initState();
    // Set the initial values.
    _updateTime();
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update every minute
      // And if the minute is 15 and the temperature is between 0 and 99 degrees
      // The clock will show the temperature
      _numbers = (_now.minute % 5 == 0 && _canShowWeather())
          ? _getWeather()
          : _getTime();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<int> _getTime() => <int>[
        DateTime.now().hourFirstDigit(),
        DateTime.now().hourSecondDigit(),
        DateTime.now().minuteFirstDigit(),
        DateTime.now().minuteSecondDigit()
      ];

  List<int> _getWeather() {
    var weather = <int>[0, 0, 12, 0];
    weather[3] = (widget.model.unit == TemperatureUnit.celsius) ? 11 : 10;
    var temperature = widget.model.temperature.toString().split("");
    weather[0] = int.parse(temperature[0]);
    weather[1] = int.parse(temperature[1]);
    return weather;
  }

  bool _canShowWeather() =>
      widget.model.temperature >= 0 && widget.model.temperature < 100;
}

class _ClockRow extends StatelessWidget {
  final int number;

  const _ClockRow({Key key, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(3, (int i) {
          return _ClockColumn(
            columnIndex: i,
            number: number,
          );
        }));
  }
}

class _ClockColumn extends StatelessWidget {
  final int columnIndex;
  final int number;

  const _ClockColumn({Key key, this.columnIndex, this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ClockElement(
          index: _index(columnIndex, 0),
          number: number,
        ),
        ClockElement(
          index: _index(columnIndex, 1),
          number: number,
        )
      ],
    );
  }

  /// Gets the clocks elements index
  int _index(int i, int j) => 2 * i + j;
}
