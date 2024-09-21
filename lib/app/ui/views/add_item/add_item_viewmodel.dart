import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:task_crud_app/app/model/data_model.dart';

class AddItemViewModel extends BaseViewModel {
  List<Data> items = [];
  final dataItems = Hive.box("itemData");
  TextEditingController itemController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  AddItemViewModel() {
    if (dataItems.get("itemData") != null) {
      items = (dataItems.get("itemData") as List<String>).map((e) {
        return Data.fromMap(jsonDecode(e));
      }).toList();
    }
  }
  String? validateForm() {
    if (itemController.text.isEmpty) {
      return 'Please enter item name.';
    }
    if (descriptionController.text.isEmpty) {
      return 'Please enter description.';
    }
    return null; // Form is valid
  }

  Future<void> handelAddButtonTap() async {
    final validationError = validateForm();
    if (validationError != null) {
      Get.snackbar("Error", validationError,
          backgroundColor: Colors.red, colorText: Colors.white,);
      return;
    }

    try {
      items.add(Data(
        itemName: itemController.text,
        description: descriptionController.text,
      ));

      await dataItems.put(
          "itemData", items.map((el) => jsonEncode(el.toMap())).toList());

      handleBackButtonTap();
      itemController.clear();
      descriptionController.clear();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void handleBackButtonTap() {
    Get.back(result: items);
  }
}
