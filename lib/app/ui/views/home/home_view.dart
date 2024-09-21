import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});
  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.fetchData();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
              onPressed: viewModel.exportDatabase,
              icon: const Icon(
                Icons.save_alt_rounded,
                size: 30,
              )),
        ),
        title: Text(
          "List Of Items",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: viewModel.handleAddItemButtonTap,
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: viewModel.items.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.items[index].itemName,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            Text(
                              viewModel.items[index].description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          viewModel.handleDeleteItemButtonTap(index);
                        },
                        icon: const Icon(
                          Icons.delete_rounded,
                          size: 30,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
