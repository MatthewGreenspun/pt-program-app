import "dart:math";
import "package:flutter/material.dart";

class _Button extends StatelessWidget {
  final dynamic Function() onPressed;
  final Icon icon;
  const _Button({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: 20,
        style: IconButton.styleFrom(
          padding: const EdgeInsets.all(0),
          maximumSize: const Size.fromRadius(3),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        icon: icon,
        onPressed: onPressed);
  }
}

class IncrementDecrementButton extends StatelessWidget {
  final num value;
  final double delta;
  final Function(num) onPressed;
  const IncrementDecrementButton(
      {super.key,
      required this.value,
      required this.onPressed,
      this.delta = 1});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      _Button(
        icon: const Icon(Icons.add),
        onPressed: () {
          onPressed(value + delta);
        },
      ),
      _Button(
        icon: const Icon(Icons.remove),
        onPressed: () {
          onPressed(max(0, value - delta));
        },
      )
    ]);
  }
}

class EditButton extends StatelessWidget {
  final Function() onPressed;
  const EditButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Opacity(
          opacity: 0,
          child: _Button(
            icon: const Icon(Icons.remove),
            onPressed: () {},
          )),
      _Button(icon: const Icon(Icons.edit), onPressed: onPressed),
    ]);
  }
}
