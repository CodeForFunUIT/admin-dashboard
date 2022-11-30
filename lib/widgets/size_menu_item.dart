import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/helpers/responsiveness.dart';
import 'package:flutter_web_dashbard/widgets/horizontal_menu_item.dart';
import 'package:flutter_web_dashbard/widgets/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final void Function() onTap;
  final bool isAddProd;

  const SideMenuItem({
    Key? key,
    required this.itemName,
    required this.onTap,
    this.isAddProd = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomSize(context)) {
      return VerticalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    } else {
      return HorizontalMenuItem(
        itemName: itemName,
        onTap: onTap,
        isAddProd: isAddProd,
      );
    }
  }
}
