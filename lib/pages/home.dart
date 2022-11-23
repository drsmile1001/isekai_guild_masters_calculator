import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isekai_guild_masters_calculator/components/number_input.dart';

import '../dynamic_scoring.dart';

class HomeController extends GetxController {
  final eventCardScores = 0.obs;
  final mapScores = 0.obs;
  final mapBoardScores = 0.obs;
  final treasureScores = 0.obs;
  final kanbanGirlScores = 0.obs;
  final regaliaScores = 0.obs;
  final dynamicScorings = RxList<Rx<DynamicScoring>>.empty(growable: true);
  int get dynamicScoringTotal =>
      dynamicScorings.fold(0, (sum, item) => sum + item.value.getScore());
  int get sum =>
      eventCardScores.value +
      mapScores.value +
      mapBoardScores.value +
      treasureScores.value +
      kanbanGirlScores.value +
      regaliaScores.value +
      dynamicScoringTotal;

  void handleAddDynamicScoring() {
    dynamicScorings.add(DynamicScoring().obs);
  }

  void handleDeleteDynamicScoring() {
    dynamicScorings.removeLast();
  }
}

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('異世界公會長計算機'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          staticScoring("事件卡", controller.eventCardScores),
          staticScoring("地圖", controller.mapScores),
          staticScoring("地圖板塊", controller.mapBoardScores),
          staticScoring("寶藏", controller.treasureScores),
          staticScoring("看板娘", controller.kanbanGirlScores),
          staticScoring("王權", controller.regaliaScores),
          Container(
              margin: const EdgeInsets.only(top: 4), child: const Divider()),
          Obx(() => Column(
                children: controller.dynamicScorings
                    .map((s) => DynamicScoringWidget(
                          rxValue: s,
                        ))
                    .toList(),
              )),
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: controller.handleAddDynamicScoring,
                    child: const Text("新增動態分數")),
                ElevatedButton(
                    onPressed: controller.handleDeleteDynamicScoring,
                    child: const Text("刪除動態分數"))
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 4), child: const Divider()),
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                const Expanded(
                  flex: 1,
                  child: Text("總分"),
                ),
                Expanded(
                    flex: 5, child: Obx(() => Text(controller.sum.toString())))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget staticScoring(String title, RxInt value) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(flex: 1, child: Text(title)),
          Expanded(
              flex: 4,
              child: Obx(() => NumberInput(
                    value: value.value,
                    onChanged: (v) => {value.value = v},
                    min: 0,
                  )))
        ],
      ),
    );
  }
}

class DynamicScoringWidget extends StatelessWidget {
  final Rx<DynamicScoring> rxValue;
  late final TextEditingController controller;

  DynamicScoringWidget({super.key, required this.rxValue}) {
    controller = TextEditingController(text: rxValue.value.name);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("動態分數"),
          Container(
            padding: const EdgeInsets.only(left: 6),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Wrap(
                direction: Axis.horizontal,
                children: [
                  "生活",
                  "商業",
                  "廢品",
                  "地圖板塊",
                  "深淵板塊",
                  "據點",
                  "戰力",
                  "密藥",
                  "其他"
                ]
                    .map((t) => Row(mainAxisSize: MainAxisSize.min, children: [
                          Radio(
                              value: t,
                              groupValue: rxValue.value.name,
                              onChanged: (v) {
                                rxValue.update((val) {
                                  val!.name = v!;
                                });
                              }),
                          Text(t),
                        ]))
                    .toList(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text("個數"),
                    ),
                    Expanded(
                        flex: 4,
                        child: NumberInput(
                          value: rxValue.value.index,
                          onChanged: (v) =>
                              {rxValue.update((val) => val!.index = v)},
                          min: 0,
                        ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text("幾個1分"),
                    ),
                    Expanded(
                        flex: 4,
                        child: NumberInput(
                          value: rxValue.value.indexesPerPoint,
                          onChanged: (v) => {
                            rxValue.update((val) => val!.indexesPerPoint = v)
                          },
                          min: 1,
                        ))
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
