import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';

import '../../../db_services/database_service.dart';
import '../../../models/item.dart';

class FilteredListScreenController extends GetxController {
  final filters = ['All', 'Category 1', 'Category 2', 'Category 3'].obs;
  var selectedFilter = 'All'.obs;
  final allItems = <Item>[].obs;
  final filteredItems = <Item>[].obs;
  final dbService = DatabaseService();

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }

  void updateSelectedFilter(String? value) {
    if (value != null) {
      selectedFilter.value = value;
      filterItems();
    }
  }

  Future<void> filterItems() async {
    try {
      if (selectedFilter.value == 'All') {
        filteredItems.assignAll(allItems);
      } else {
        filteredItems.assignAll(
          allItems
              .where((item) => item.category == selectedFilter.value)
              .toList(),
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to filter items: $e');
    }
  }

  Future<void> loadItems() async {
    try {
      final data = await dbService.fetchItems();
      allItems.assignAll(data);
      filterItems(); // Initialize filteredItems with allItems
    } catch (e) {
      Get.snackbar('Error', 'Failed to load items: $e');
    }
  }

  void downloadPDF(Item item) async {
    try {
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (context) => pw.Center(
            child: pw.Text('Item: ${item.text}\nCategory: ${item.category}'),
          ),
        ),
      );

      final output = await getTemporaryDirectory();
      final file = File('${output.path}/${item.text}.pdf');
      await file.writeAsBytes(await pdf.save());
      OpenFile.open(file.path);
      Get.snackbar('Success', 'PDF downloaded: ${file.path}');
    } catch (e) {
      Get.snackbar('Error', 'Failed to download PDF: $e');
    }
  }
}
