import 'package:get/get.dart';

import '../controllers/filtered_list_screen_controller.dart';

class FilteredListScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilteredListScreenController>(
      () => FilteredListScreenController(),
    );
  }
}
