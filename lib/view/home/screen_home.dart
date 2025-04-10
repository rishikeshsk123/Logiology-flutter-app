import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logiology/controllers/product/product_controller.dart';
import 'package:logiology/core/colors.dart';
import 'package:logiology/core/constants.dart';
import 'package:logiology/view/home/screen_product_details.dart';
import 'package:logiology/view/home/widgets/product_filter_sheet_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final productCtrl = Get.put(ProductController());

    return Scaffold(
        // backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: kPurpleColor,
          title: Text(
            "Logiology",
            style: GoogleFonts.poppins(
              fontSize: 26,
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const ProductFilterSheetWidget(),
                );
              },
              icon: const Icon(
                Icons.filter_alt_outlined,
                color: kWhiteColor,
                size: 40,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.5), width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: CupertinoSearchTextField(
                      controller: productCtrl.searchController,
                      itemSize: 30,
                      backgroundColor: kWhiteColor,
                      placeholder: "What are you looking for?",
                    ),
                  ),
                ),
                kHeight10,
              ],
            ),
          ),
        ),
        body: Obx(() {
          final products = productCtrl.filteredProductsList;
          if (productCtrl.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 0.56,
            ),
            itemBuilder: (context, index) {
              final product = products[index];

              return GestureDetector(
                onTap: () {
                  Get.to(() => ScreenProductDetails(product: product));
                },
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          MainCard(imageUrl: product.thumbnail),
                          Positioned(
                            left: 10,
                            bottom: 0,
                            child: RatingBarIndicator(
                              rating: product.rating,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber[400],
                              ),
                              itemCount: 5,
                              itemSize: 20,
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          product.title,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kBlackColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          product.description,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "\$${product.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: kBlackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }));
  }
}

class MainCard extends StatelessWidget {
  final String imageUrl;
  const MainCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
