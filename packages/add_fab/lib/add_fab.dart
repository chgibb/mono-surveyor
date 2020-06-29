import 'package:flutter/material.dart';

class AddFab extends StatelessWidget {
  final void Function() onPressed;
  final String tooltip;

  AddFab({
    @required this.onPressed,
    @required this.tooltip,
  });

  @override 
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      child: Icon(Icons.add),
    );
  }
}
