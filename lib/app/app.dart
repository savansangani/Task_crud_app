import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_crud_app/app/ui/views/home/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
