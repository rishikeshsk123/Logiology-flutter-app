import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/controllers/product/product_controller.dart';
import 'package:logiology/core/colors.dart';
import 'package:logiology/core/constants.dart';

class ProductFilterSheetWidget extends StatelessWidget {
  const ProductFilterSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    final minPriceController = TextEditingController();
    final maxPriceController = TextEditingController();

    return SafeArea(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      child: Column(
        children: [
          // Clear all and close
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close),
              )
            ],
          ),

          kHeight10,

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  kHeight10,
                  Obx(
                    () => Wrap(
                      spacing: 10,
                      children: controller.categories.map((e) {
                        final isSelected =
                            controller.selectedCategories.contains(e);
                        return FilterChip(
                          label: Text(e),
                          selected: isSelected,
                          onSelected: (selected) {
                            // handle seletiiion
                            if (selected) {
                              controller.selectedCategories.add(e);
                            } else {
                              controller.selectedCategories.remove(e);
                            }
                            controller.filteredProducts();
                          },
                        );
                      }).toList(),
                    ),
                  ),

                  kHeight20,
                  // Rating
                  Text(
                    "Rating",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Obx(
                    () => Wrap(
                      spacing: 12,
                      children: [4.0, 3.0, 2.0].map((star) {
                        return ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('$star⭐ & above'),
                            ],
                          ),
                          selected: controller.selectedRatings.contains(star),
                          onSelected: (selected) {
                            if (selected) {
                              controller.selectedRatings.add(star);
                            } else {
                              controller.selectedRatings.remove(star);
                            }
                            controller.filteredProducts();
                          },
                        );
                      }).toList(),
                    ),
                  ),

                  kHeight20,
                  Text(
                    "Price",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: minPriceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Min',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      kHeight10,
                      Expanded(
                        child: TextField(
                          controller: maxPriceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Max',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  kHeight10,
                ],
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  // apply clear filter
                  controller.removeFilter();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(12)),
                  // backgroundColor: Colors.grey,
                ),
                child: const Text(
                  "Clear Filters",
                  style: TextStyle(color: kBlackColor),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // apply filter
                  final min = double.tryParse(minPriceController.text);
                  final max = double.tryParse(maxPriceController.text);
                  controller.minPrice = min;
                  controller.maxPrice = max;
                  controller.filteredProducts();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Colors.teal,
                ),
                child: const Text(
                  "Apply Filters",
                  style: TextStyle(color: kWhiteColor),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
