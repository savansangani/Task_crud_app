import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_crud_app/app/custom/custom_text_form_field.dart';

import 'add_item_viewmodel.dart';

class AddItemView extends StackedView<AddItemViewModel> {
  const AddItemView({super.key});

  @override
  AddItemViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddItemViewModel();

  @override
  Widget builder(
    BuildContext context,
    AddItemViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Item",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            CustomTextFormField(
              hintText: "Item Name",
              controller: viewModel.itemController,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              hintText: "Item Discription",
              controller: viewModel.descriptionController,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: viewModel.handelAddButtonTap,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Add",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
