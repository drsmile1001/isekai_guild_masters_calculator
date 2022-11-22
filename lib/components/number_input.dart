import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberInput extends StatelessWidget {
  final RxInt rxValue;
  final Function(int) onChanged;
  final int? min;
  final int? max;

  const NumberInput(
      {super.key,
      required this.rxValue,
      required this.onChanged,
      this.min,
      this.max});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            onPressed: () => {onChanged(rxValue.value - 1)},
            child: const Text("-")),
        Obx(() => Text(rxValue.value.toString())),
        ElevatedButton(
            onPressed: () => {onChanged(rxValue.value + 1)},
            child: const Text("+"))
      ],
    );
  }
}
