import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/feautres/account/services/account_services.dart';
import 'package:amazon_clone/feautres/account/widgets/single_product.dart';
import 'package:amazon_clone/feautres/order_details/screens/order_details.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/cupertino.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    print(orders.toString() + '+_+))()&*(&&&&&&&&&&&&&)');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        :  orders!.isEmpty ? const Text('No orders') : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'Your Orders',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      'See all',
                      style:
                          TextStyle(color: GlobalVariables.selectedNavBarColor),
                    ),
                  ),
                ],
              ),
              // Displaying orders with ListView Builder if the container height is not specified then it will give renderbox overflow error
              Container(
                height: 170,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 0,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    // print('____________________________________index');
                    // print(index);
                    // print(orders![index].products[0].toString());
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, OrderDetailScreen.routeName, arguments: orders![index]);
                      },
                      child: SingleProduct(
                        image: orders![index].products[0].images[0],
                      ),
                    );
                  },
                ),
              )
            ],
          );
  }
}
