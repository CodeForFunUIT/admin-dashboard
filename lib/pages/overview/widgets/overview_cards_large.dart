import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/controllers.dart';
import 'package:flutter_web_dashbard/controllers/product_controller.dart';
import 'package:flutter_web_dashbard/pages/overview/widgets/info_card.dart';
import 'package:get/get.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  const OverviewCardsLargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<ProductController>(
      initState: (_) => productController.getOrder(),
      builder: (controller) => Row(
        children: [
          InfoCard(
            title: "Order in Progress",
            value: controller.lengthOrderProgress.toString(),
            onTap: () {},
            topColor: Colors.orange,
          ),
          SizedBox(width: width / 64),
          InfoCard(
            title: "Order delivered",
            value: "0",
            topColor: Colors.lightGreen,
            onTap: () {},
          ),
          SizedBox(width: width / 64),
          InfoCard(
            title: "Order approve",
            value: controller.lengthOrderApprove.toString(),
            onTap: () {},
            topColor: Colors.redAccent,
          ),
          SizedBox(width: width / 64),
          InfoCard(
            title: "Order decline",
            value: controller.lengthOrderDecline.toString(),
            onTap: () {},
            // topColor: ,
          ),
          SizedBox(width: width / 64),
        ],
      ),
    );
  }
}
