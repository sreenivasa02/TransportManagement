import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../../../db_services/database_service.dart';
import '../../../models/item.dart';

class ItemTransactionController extends GetxController {
  final textController = TextEditingController();
  final items = <Item>[].obs;
  final categories = ['Category 1', 'Category 2', 'Category 3'];
  var selectedCategory = 'Category 1';
  var pickedFileName = ''.obs;

  final dbService = DatabaseService();
  var isEditing = false.obs;
  int? editingIndex;

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }

  void updateSelectedCategory(String? value) {
    if (value != null) {
      selectedCategory = value;
    }
  }

  Future<void> loadItems() async {
    try {
      final data = await dbService.fetchItems();
      items.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load items: $e');
    }
  }

  Future<void> addItem() async {
    try {
      if (textController.text.isNotEmpty) {
        final newItem = Item(
          category: selectedCategory,
          text: textController.text,
          fileName: pickedFileName.value,
        );

        if (isEditing.value && editingIndex != null) {

          items[editingIndex!] = newItem;
          isEditing.value = false;
          editingIndex = null;
        } else {

          await dbService.insertItem(newItem);
          items.add(newItem);
        }
        textController.clear();
        pickedFileName.value = '';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add/update item: $e');
    }
  }

  Future<void> deleteItem(int index) async {
    try {
      final item = items[index];
      await dbService.deleteItem(item.id!);
      items.removeAt(index); // Use removeAt for reactive list
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete item: $e');
    }
  }

  void editItem(int index) {
    final item = items[index];
    textController.text = item.text;
    selectedCategory = item.category;
    pickedFileName.value = item.fileName ?? '';
    isEditing.value = true;
    editingIndex = index;
  }

  void pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null) {
        final file = result.files.single;
        pickedFileName.value = file.name;
        Get.snackbar('File Selected', file.name);
      } else {
        pickedFileName.value = '';
        Get.snackbar('Error', 'No file selected');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick file: $e');
    }
  }
}
