import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/controllers.dart';
import 'package:flutter_web_dashbard/constants/style.dart';
import 'package:flutter_web_dashbard/controllers/product_controller.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';
import 'package:flutter_web_dashbard/widgets/loading.dart';
import 'package:get/get.dart';

class OrderTable extends StatelessWidget {
  const OrderTable({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      initState: (state) {
        if (productController.orders.isEmpty) {
          productController.getOrder();
        }
      },
      builder: (controller) => controller.orders.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: active.withOpacity(.4), width: .5),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 6),
                    color: lightGrey.withOpacity(.1),
                    blurRadius: 12,
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              // padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 30),
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: const [
                  DataColumn2(
                    label: Text("STT"),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text("ID order"),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text('ID user'),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text('Price'),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text('Status'),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text('Date'),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text('Action'),
                    size: ColumnSize.L,
                  ),
                ],
                rows: List<DataRow>.generate(
                  controller.orders.length,
                  (index) => DataRow(
                    cells: [
                      DataCell(CustomText(text: '$index')),
                      DataCell(CustomText(text: controller.orders[index].id)),
                      DataCell(
                        CustomText(text: controller.orders[index].idUser),
                      ),
                      DataCell(
                        CustomText(text: controller.orders[index].price),
                      ),
                      DataCell(CustomText(text: controller.orders[index].date)),
                      DataCell(
                        CustomText(
                          text: controller.orders[index].status,
                          color: controller.orders[index].status == "approve"
                              ? Colors.blue
                              : controller.orders[index].status == "decline"
                                  ? Colors.red
                                  : null,
                        ),
                      ),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OutlinedButton(
                              onPressed: controller.orders[index].status ==
                                          "approve" ||
                                      controller.orders[index].status ==
                                          "decline"
                                  ? null
                                  : () async {
                                      Loading.startLoading(context);
                                      await controller.updateOrder(
                                        order: controller.orders[index],
                                      );
                                      Loading.stopLoading();

                                      final snackBar = GetSnackBar(
                                        backgroundColor:
                                            Colors.green.withOpacity(.6),
                                        message:
                                            "Update status order to approve!",
                                        duration: const Duration(seconds: 2),
                                      );
                                      Get.showSnackbar(snackBar);
                                    },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: blue,
                                ),
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.08,
                                  32,
                                ),
                              ),
                              child: CustomText(
                                text: 'Approve',
                                color: blue,
                              ),
                            ),
                            const SizedBox(width: 4),
                            ElevatedButton(
                              onPressed: controller.orders[index].status ==
                                          "approve" ||
                                      controller.orders[index].status ==
                                          "decline"
                                  ? null
                                  : () async {
                                      Loading.startLoading(context);
                                      await controller.updateOrder(
                                        order: controller.orders[index],
                                        isApprove: false,
                                      );
                                      Loading.stopLoading();

                                      final snackBar = GetSnackBar(
                                        backgroundColor:
                                            Colors.green.withOpacity(.6),
                                        message:
                                            "Update status order to decline!",
                                        duration: const Duration(seconds: 2),
                                      );
                                      Get.showSnackbar(snackBar);
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.08,
                                  32,
                                ),
                              ),
                              child: const CustomText(
                                text: 'Decline',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
