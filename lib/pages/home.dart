import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isekai_guild_masters_calculator/components/number_input.dart';

class HomeController extends GetxController {
  final eventCardScores = 0.obs;
  final mapScores = 0.obs;
  final mapBoardScores = 0.obs;
  final treasureScores = 0.obs;
  final kanbanGirlScores = 0.obs;
  final regaliaScores = 0.obs;
  int get sum =>
      eventCardScores.value +
      mapScores.value +
      mapBoardScores.value +
      treasureScores.value +
      kanbanGirlScores.value;
}

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("地圖分數"),
          NumberInput(
              rxValue: controller.mapScores,
              onChanged: (value) => {controller.mapScores.value = value}),
          const Text("地圖板塊分數"),
          NumberInput(
              rxValue: controller.mapBoardScores,
              onChanged: (value) => {controller.mapBoardScores.value = value}),
          const Text("事件卡分數"),
          NumberInput(
              rxValue: controller.eventCardScores,
              onChanged: (value) => {controller.eventCardScores.value = value}),
          const Text("寶藏分數"),
          NumberInput(
              rxValue: controller.treasureScores,
              onChanged: (value) => {controller.treasureScores.value = value}),
          const Text("看板娘分數"),
          NumberInput(
              rxValue: controller.kanbanGirlScores,
              onChanged: (value) =>
                  {controller.kanbanGirlScores.value = value}),
          const Text("王權分數"),
          NumberInput(
              rxValue: controller.regaliaScores,
              onChanged: (value) => {controller.regaliaScores.value = value}),
          const Text("總分"),
          Obx(() => Text(controller.sum.toString())),
        ],
      ),
    );
  }
}
