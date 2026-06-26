import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/exceptions/http_exception.dart';
import 'package:shop_flutter/models/auth.dart';
import 'package:shop_flutter/models/cart.dart';
import 'package:shop_flutter/models/product.dart';
import 'package:shop_flutter/utils/app_routes.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final msg = ScaffoldMessenger.of(context);
    final auth = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(product.name, textAlign: TextAlign.center),
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Theme.of(context).hintColor,
              onPressed: () async {
                try {
                  await product.toggleFavorite(
                    auth.token ?? '',
                    auth.uid ?? '',
                  );
                } on HttpExceptionExample catch (error) {
                  msg.showSnackBar(SnackBar(content: Text(error.toString())));
                }
              },
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).hintColor,
            onPressed: () {
              cart.addItem(product);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Produto adicionado com sucesso!'),
                  duration: Duration(seconds: 2),
                  persist: false,
                  action: SnackBarAction(
                    label: 'DESFAZER',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(AppRoutes.productDetail, arguments: product);
          },
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
