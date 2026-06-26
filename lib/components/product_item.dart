import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/exceptions/http_exception.dart';
import 'package:shop_flutter/models/product.dart';
import 'package:shop_flutter/models/product_list.dart';
import 'package:shop_flutter/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed(AppRoutes.productForm, arguments: product);
              },
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () {
                final productList = Provider.of<ProductList>(
                  context,
                  listen: false,
                );

                showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Excluir Produto'),
                    content: Text('Tem certeza?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Não'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Sim'),
                      ),
                    ],
                  ),
                ).then((answer) async {
                  if (answer ?? false) {
                    try {
                      await productList.removeProduct(product);
                    } on HttpExceptionExample catch (error) {
                      msg.showSnackBar(
                        SnackBar(content: Text(error.toString())),
                      );
                    }
                  }
                });
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
