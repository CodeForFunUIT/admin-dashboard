import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/style.dart';
import 'package:flutter_web_dashbard/controllers/product_controller.dart';
import 'package:flutter_web_dashbard/pages/orders/order_table.dart';
import 'package:flutter_web_dashbard/pages/overview/widgets/bar_chart.dart';
import 'package:flutter_web_dashbard/pages/overview/widgets/revenue_info.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';
import 'package:get/get.dart';

class RevenueSectionLarge extends StatelessWidget {
  const RevenueSectionLarge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            color: lightGrey.withOpacity(.1),
            blurRadius: 12,
          )
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Revenue Chart",
                  size: 20,
                  weight: FontWeight.bold,
                  color: lightGrey,
                ),
                const SizedBox(
                  width: 600,
                  height: 200,
                  child: SimpleBarChart(animate: true),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 140,
            color: lightGrey,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GetBuilder<ProductController>(
              builder: (controller) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      RevenueInfo(
                        title: "Today's revenue",
                        amount: controller.salaryToday.toVND(),
                      ),
                      RevenueInfo(
                        title: "Last 7 days",
                        amount: controller.salaryLast7Day.toVND(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      RevenueInfo(
                        title: "Last 30 days",
                        amount: controller.salaryLastMonth.toVND(),
                      ),
                      RevenueInfo(
                        title: "Last 12 months",
                        amount: controller.salaryLastYear.toVND(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
