import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/cart.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            iconTheme: IconThemeData(color: Colors.black),
            // pinned: true,
            // title: Text(
            //   loadedProduct.title,
            //   style: TextStyle(color: Colors.black),
            // ),

            flexibleSpace: FlexibleSpaceBar(
              // centerTitle: true,
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),

              // stretchModes: [
              //   StretchMode.fadeTitle,
              // ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        loadedProduct.title,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Price: \$${loadedProduct.price}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Quantity:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              cart.removeSingleItem(loadedProduct.id);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              if (cart.itemCount > 0)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Item removed',
                                    ),
                                  ),
                                );
                            },
                            child: Wrap(
                              children: [
                                Icon(
                                  Icons.remove,
                                  color: Colors.purple,
                                )
                              ],
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 202, 201, 201))),
                          ),
                          SizedBox(width: 10),
                          Consumer<Cart>(
                            builder: (_, cart, ch) => Text(
                              cart.totalItemCount.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              cart.addItem(loadedProduct.id,
                                  loadedProduct.price, loadedProduct.title);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Added to the cart',
                                  ),
                                ),
                              );
                            },
                            child: Wrap(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.purple,
                                )
                              ],
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 202, 201, 201))),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(20.0),
                    //   child: Column(
                    //     children: [
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           ScaffoldMessenger.of(context)
                    //               .hideCurrentSnackBar();

                    //           ScaffoldMessenger.of(context).showSnackBar(
                    //             SnackBar(
                    //               content: Text(
                    //                 'Added to the cart',
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //         child: Text(
                    //           'Add to Cart',
                    //         ),
                    //         style: ElevatedButton.styleFrom(
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(15),
                    //           ),
                    //           padding: const EdgeInsets.symmetric(
                    //               horizontal: 30, vertical: 10),
                    //           primary: Colors.purple,
                    //           textStyle: const TextStyle(
                    //               fontSize: 20, fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      // width: double.infinity,
                      child: Text(
                        'Product Description: \n ${loadedProduct.description}',
                        softWrap: true,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
