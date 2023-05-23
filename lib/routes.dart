import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/feautres/admin/screen/add_product_screen.dart';
import 'package:amazon_clone/feautres/auth/screens/auth_screen.dart';
import 'package:amazon_clone/feautres/home/screens/category_deals_page.dart';
import 'package:amazon_clone/feautres/home/screens/home_screen.dart';
import 'package:amazon_clone/feautres/home/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );

    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );

    case CategoryDealsPage.routeName:
    var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsPage(
          category: category,
        ),
      );
    
    case SearchScreen.routeName:
    var query = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: query,
        ),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
