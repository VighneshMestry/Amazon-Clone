import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/feautres/admin/screen/add_product_screen.dart';
import 'package:amazon_clone/feautres/admin/services/admin_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProduct(context);
    setState(() {});  // A DUMMY SETSTATE TO REFRESH THE PAGE TO CHECK AGAIN IF THE LIST HAS PRODUCTS OR NOT
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: const Center(
              child: Text('Products Page'),
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Add a Product',
              onPressed: () {
                Navigator.pushNamed(context, AddProductScreen.routeName);
              },
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
