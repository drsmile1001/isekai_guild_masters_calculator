import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _counter = 0.obs;
  int get counter => _counter.value;
  set counter(int value) => _counter.value = value;

  void increment() {
    counter++;
  }
}

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Obx(() => Text(controller.counter.toString())),
          ElevatedButton(
              onPressed: controller.increment, child: const Text("increment"))
        ]),
      ),
    );
  }
}
