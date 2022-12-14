const rootRoute = "/";

const overviewPageDisplayName = "Overview";
const overviewPageRoute = "/overview";

const productsPageDisplayName = "Products";
const productsPageRoute = "/products";

const ordersPageDisplayName = "Orders";
const ordersPageRoute = "/orders";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(overviewPageDisplayName, overviewPageRoute),
  MenuItem(productsPageDisplayName, productsPageRoute),
  MenuItem(ordersPageDisplayName, ordersPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
