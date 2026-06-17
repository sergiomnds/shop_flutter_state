import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/components/app_drawer.dart';
import 'package:shop_flutter/components/order.dart';
import 'package:shop_flutter/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orderList = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Meus pedidos')),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderList.itemCount,
        itemBuilder: (ctx, i) => OrderWidget(order: orderList.orders[i]),
      ),
    );
  }
}
