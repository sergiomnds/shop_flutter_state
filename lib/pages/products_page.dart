import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/components/app_drawer.dart';
import 'package:shop_flutter/components/product_item.dart';
import 'package:shop_flutter/models/product_list.dart';
import 'package:shop_flutter/utils/app_routes.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductList>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductList productList = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.productForm);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: ListView.builder(
            itemCount: productList.itemsCount,
            itemBuilder: (ctx, i) => Column(
              children: [
                ProductItem(product: productList.items[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
