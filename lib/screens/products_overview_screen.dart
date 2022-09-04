import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';

enum FiltersOption {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  // static const routeName = '/product-overview';

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  // var _isInit = false;
  var _isLoading = false;

  // @override
  // void didChangeDependencies() {
  //   var items = Provider.of<Products>(context).items;

  //   if (items.isEmpty) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     Provider.of<Products>(context, listen: false)
  //         .fetchAndSetProducts()
  //         .then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   }
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    Provider.of<Products>(context).fetchAndSetProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pro-Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FiltersOption selectedVal) {
              setState(() {
                if (selectedVal == FiltersOption.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: const Text('Only Favorites'),
                value: FiltersOption.Favorites,
              ),
              PopupMenuItem(
                child: const Text('Show All'),
                value: FiltersOption.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.totalItemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
