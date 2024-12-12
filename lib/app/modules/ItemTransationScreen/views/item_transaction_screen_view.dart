import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:transportmngment/app/modules/FilteredListScreen/controllers/filtered_list_screen_controller.dart';
import 'package:transportmngment/app/modules/FilteredListScreen/views/filtered_list_screen_view.dart';
import 'package:transportmngment/app/utils/constants.dart';

import '../controllers/item_transation_screen_controller.dart';

class ItemTransactionScreenView extends StatelessWidget {
  final ItemTransactionController crudOperationsController =
      Get.put(ItemTransactionController());

  ItemTransactionScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: const Text('Add Items'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(FilteredListScreenView());
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField(
              value: crudOperationsController.selectedCategory,
              items: crudOperationsController.categories
                  .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category),
              ))
                  .toList(),
              onChanged: (value) => crudOperationsController.updateSelectedCategory(value),
              decoration: InputDecoration(
                labelText: 'Select Category',
                labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: crudOperationsController.textController,
              decoration: InputDecoration(
                labelText: 'Enter Complaint',
                labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      crudOperationsController.pickFile(); // Ensure this is not overridden
                    },
                    child: Text('Pick File'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Obx(
                  () => Text(
                crudOperationsController.pickedFileName.value.isNotEmpty
                    ? 'Selected File: ${crudOperationsController.pickedFileName.value}'
                    : 'No file selected',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700]),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(

                    onPressed: () {
                      if (crudOperationsController.pickedFileName.value.isEmpty) {

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please pick a file before submitting')),
                        );
                      } else {
                        crudOperationsController.addItem();
                      }
                    },
                    child: Text('Add Item'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: crudOperationsController.items.length,
                  itemBuilder: (context, index) {
                    final item = crudOperationsController.items[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      elevation: 2,
                      child: ListTile(
                        title: Text(item.text, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                        subtitle: Text(item.category, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blueAccent)),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => crudOperationsController.deleteItem(index),
                        ),
                        onTap: () => crudOperationsController.editItem(index),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}