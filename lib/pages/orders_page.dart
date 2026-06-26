import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/components/app_drawer.dart';
import 'package:shop_flutter/components/order.dart';
import 'package:shop_flutter/models/order_list.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future<void> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture =
        Provider.of<OrderList>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meus pedidos')),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('Ocorreu um erro!'));
          } else {
            return Consumer<OrderList>(
              builder: (context, orders, child) => ListView.builder(
                itemCount: orders.itemCount,
                itemBuilder: (context, i) =>
                    OrderWidget(order: orders.items[i]),
              ),
            );
          }
        },
      ),
    );
  }
}
