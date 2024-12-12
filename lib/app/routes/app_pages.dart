import 'package:get/get.dart';
import '../modules/FilteredListScreen/bindings/filtered_list_screen_binding.dart';
import '../modules/FilteredListScreen/views/filtered_list_screen_view.dart';
import '../modules/ItemTransationScreen/bindings/item_transaction_screen_binding.dart';
import '../modules/ItemTransationScreen/views/item_transaction_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CRUD_OPERATIONS_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.CRUD_OPERATIONS_SCREEN,
      page: () =>  ItemTransactionScreenView(),
      binding: ItemTransactionScreenBinding(),
    ),
    GetPage(
      name: _Paths.FILTERED_LIST_SCREEN,
      page: () =>  FilteredListScreenView(),
      binding: FilteredListScreenBinding(),
    ),
  ];
}
