import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../../utils/constants.dart';
import '../../ItemTransationScreen/views/item_transaction_screen_view.dart';
import '../controllers/filtered_list_screen_controller.dart';

class FilteredListScreenView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Get.delete();
    final FilteredListScreenController filteredListController =
    Get.put(FilteredListScreenController());
    return Scaffold(
      appBar: AppBar(title: Text('Items'),centerTitle: true,backgroundColor: AppColor.primaryColor,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(
                  () => DropdownButtonFormField(
                value: filteredListController.selectedFilter.value,
                items: filteredListController.filters
                    .map(
                      (filter) => DropdownMenuItem(
                    value: filter,
                    child: Text(filter),
                  ),
                )
                    .toList(),
                onChanged: (value) =>
                    filteredListController.updateSelectedFilter(value),
                decoration: InputDecoration(
                  labelText: 'Filter By',
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                      width: 2.0,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                dropdownColor: Colors.white,
                icon: Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: filteredListController.filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredListController.filteredItems[index];
                    final borderColor = _getBorderColor(item.category);

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: borderColor, width: 2),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              item.text,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: Text(
                              item.category,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: borderColor,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.download, color:Colors.indigo),
                              onPressed: () =>
                                  filteredListController.downloadPDF(item),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.delete<FilteredListScreenController>();
          Get.to(ItemTransactionScreenView());},
        label: Text('Add Items'),
        icon: Icon(Icons.add),
          backgroundColor: AppColor.primaryColor,
      ),
    );
  }

  // Function to determine border color dynamically based on the category
  Color _getBorderColor(String category) {
    switch (category) {
      case 'Category 1':
        return Colors.green;
      case 'Category 2':
        return Colors.orange;
      case 'Category 3':
        return Colors.purple;
      default:
        return Colors.blueAccent; // Default color
    }
  }
}



