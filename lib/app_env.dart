import 'package:get/get.dart';

import 'utilities/env/dotenv.dart';

class AppEnv extends GetxService {
  final env = DotEnv();

  Future<AppEnv> init() async {
    await env.loadFromFile(fileName: "env/.env");
    await env.loadFromFile(fileName: "env/.env.local");
    return this;
  }
}
