import 'package:get/get.dart';

import '../controllers/item_transation_screen_controller.dart';

class ItemTransactionScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemTransactionController>(
      () => ItemTransactionController(),
    );
  }
}
