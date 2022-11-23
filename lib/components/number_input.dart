import 'package:flutter/material.dart';

class NumberInput extends StatelessWidget {
  final int value;
  final Function(int) onChanged;
  final int? min;
  final int? max;

  const NumberInput(
      {super.key,
      required this.value,
      required this.onChanged,
      this.min,
      this.max});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            onPressed: () {
              if (min != null && value - 1 < min!) return;
              onChanged(value - 1);
            },
            child: const Text("-")),
        Text(value.toString()),
        ElevatedButton(
            onPressed: () {
              if (max != null && value + 1 > max!) return;
              onChanged(value + 1);
            },
            child: const Text("+"))
      ],
    );
  }
}
