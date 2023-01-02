import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/controllers.dart';
import 'package:flutter_web_dashbard/controllers/product_controller.dart';
import 'package:flutter_web_dashbard/pages/overview/widgets/info_card_small.dart';
import 'package:get/get.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  const OverviewCardsSmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 400,
      child: GetBuilder<ProductController>(
        initState: (_) => productController.getOrder(),
        builder: (controller) => Column(
          children: [
            InfoCardSmall(
              title: "Order in Progress",
              value: controller.lengthOrderProgress.toString(),
              onTap: () {},
              isActive: true,
            ),
            SizedBox(width: width / 64),
            InfoCardSmall(
              title: "Order delivered",
              value: "0",
              onTap: () {},
            ),
            SizedBox(width: width / 64),
            InfoCardSmall(
              title: "Order approve",
              value: controller.lengthOrderApprove.toString(),
              onTap: () {},
            ),
            SizedBox(width: width / 64),
            InfoCardSmall(
              title: "Order decline",
              value: controller.lengthOrderDecline.toString(),
              onTap: () {},
            ),
            SizedBox(height: width / 64),
          ],
        ),
      ),
    );
  }
}
