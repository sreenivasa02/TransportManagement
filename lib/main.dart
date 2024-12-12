import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/modules/FilteredListScreen/views/filtered_list_screen_view.dart';
import 'app/modules/ItemTransationScreen/views/item_transaction_screen_view.dart';

void main() => runApp(TransportManagementApp());

class TransportManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transport Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          FilteredListScreenView(),
          ItemTransactionScreenView(),

        ],
      ),
    );
  }
}

