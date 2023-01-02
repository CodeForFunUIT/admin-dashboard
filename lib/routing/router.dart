import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/pages/authentication/authentication.dart';
import 'package:flutter_web_dashbard/pages/orders/orders.dart';
import 'package:flutter_web_dashbard/pages/products/product.dart';
import 'package:flutter_web_dashbard/pages/overview/overview.dart';
import 'package:flutter_web_dashbard/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(const OverviewPage());
    case productsPageRoute:
      return _getPageRoute(const ProductsPage());
    case ordersPageRoute:
      return _getPageRoute(const OrdersPage());
    case authenticationPageRoute:
      return _getPageRoute(const AuthenticationPage());
    default:
      return _getPageRoute(const OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
