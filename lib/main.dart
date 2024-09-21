import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_crud_app/app/app.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('itemData');
  runApp(const MyApp());
}
