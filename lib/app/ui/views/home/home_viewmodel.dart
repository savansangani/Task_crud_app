import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
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
    try {
      // Get the directory path for saving the file
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/data_dump.json';

      // Get all data from Hive
      final dataItems = Hive.box("itemData");
      final items = (dataItems.get("itemData") as List<String>)
          .map((el) => Data.fromMap(jsonDecode(el)))
          .toList();

      // Create a map to store all data
      final dataMap = {
        "items": items.map((el) => el.toMap()).toList(),
      };

      // Encode the data to JSON
      final jsonData = jsonEncode(dataMap);

      // Write the data to a file
      final file = File(filePath);
      await file.writeAsString(jsonData);

      // Open the file picker to select the download location
      final filePicker = FilePicker.platform;
      final filePathSelected = await filePicker.saveFile(
        type: FileType.any,
        allowedExtensions: ['json'],
      );

      if (filePathSelected != null) {
        // Copy the file to the selected location
        final fileToCopy = File(filePath);
        final fileCopied = await fileToCopy.copy(filePathSelected);
        Get.snackbar(
            "Export", "Data exported successfully to ${fileCopied.path}",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Export", "Data export cancelled",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print(e);
    }
  }
}
