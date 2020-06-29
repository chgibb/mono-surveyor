import 'package:flutter/material.dart';
import 'package:increment/increment.dart';

mixin CounterMixin<T extends StatefulWidget> on State<T> {
  int _counter = 0;
  int get counter => _counter;
}

void incrementCounter<T extends CounterMixin>(
    {@required T widget, @required void Function(void Function()) setState}) {
  setState(() {
    widget._counter = increment(widget._counter);
  });
}
