import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:task_crud_app/app/model/data_model.dart';
import 'package:task_crud_app/app/ui/views/add_item/add_item_view.dart';

class HomeViewModel extends BaseViewModel {
  List<Data> items = [];

  void handleAddItemButtonTap() async {
    var result = await Get.to(() => const AddItemView());
    if (result != null) {
      fetchData();
      Get.snackbar("Add", "Item Added Successfully.",
          backgroundColor: Colors.green, colorText: Colors.white);
    }
  }

  final dataItems = Hive.box("itemData");

  void fetchData() {
    if (dataItems.get("itemData") != null) {
      items = (dataItems.get("itemData") as List<String>)
          .map((el) => Data.fromMap(jsonDecode(el)))
          .toList();
    }
    notifyListeners();
  }

  void handleDeleteItemButtonTap(int index) async {
    items.removeAt(index);
    await dataItems.put(
        "itemData", items.map((el) => jsonEncode(el.toMap())).toList());

    Get.snackbar(
      "Delete",
      "Item Delete Succesfully",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    notifyListeners();
  }

  void exportDatabase() async {
    // Get the data from the Hive box
    final dataItems = Hive.box("itemData");
    final data = dataItems.get("itemData");

    // Check if data exists
    if (data != null) {
      // Convert the data to a JSON string
      final jsonData = jsonEncode(data);

      // Request permission to access external storage
      final status = await Permission.storage.request();

      if (status.isGranted) {
        // Get the directory path using FilePicker
        final directory = await FilePicker.platform.getDirectoryPath();

        if (directory != null) {
          // Create a file in the selected directory
          final file = File('$directory/exported_data.json');

          // Write the JSON data to the file
          await file.writeAsString(jsonData);

          Get.snackbar(
            "Export",
            "Database exported successfully to $directory/exported_data.json",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            "Export",
            "Failed to get directory path",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Export",
          "Permission denied to access external storage",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        "Export",
        "No data to export",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
