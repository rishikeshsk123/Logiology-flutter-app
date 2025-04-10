import 'package:flutter/material.dart';
import 'package:logiology/core/colors.dart';
import 'package:logiology/core/constants.dart';
import 'package:logiology/models/product/product_model.dart';

class ScreenProductDetails extends StatelessWidget {
  final ProductModel product;
  
  const ScreenProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.images![0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            kHeight20,
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            kHeight20,

            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            kHeight20,
            Text(
              product.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.justify,
            ),

            kHeight20,
            Text(
              '\$${product.price}',
              style: TextStyle(
                fontSize: 20,
                color: kBlackColor,
                fontWeight: FontWeight.w600,
              ),
            ),

            

            kHeight10,
            
          ],
        ),
      ),
    );
  }
}
