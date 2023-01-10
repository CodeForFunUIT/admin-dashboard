import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/controllers.dart';
import 'package:flutter_web_dashbard/constants/style.dart';
import 'package:flutter_web_dashbard/controllers/product_controller.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';
import 'package:flutter_web_dashbard/widgets/dialog_order_detail.dart';
import 'package:flutter_web_dashbard/widgets/loading.dart';
import 'package:flutter_web_dashbard/widgets/snack_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
                    label: Text('Status'),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text('Price'),
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
                      DataCell(
                        InkWell(
                          onTap: () {
                            Get.dialog(
                              DialogOrderDetail(
                                idOrder:
                                    int.parse(controller.orders[index].id!),
                              ),
                            );
                          },
                          child: CustomText(
                            text: controller.orders[index].id,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      DataCell(
                        CustomText(text: controller.orders[index].idUser),
                      ),
                      DataCell(
                        CustomText(
                          text: double.parse(controller.orders[index].price!)
                              .toVND(),
                        ),
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
                                          "outDate" ||
                                      controller.orders[index].status ==
                                          "decline"
                                  ? null
                                  : () async {
                                      Loading.startLoading(context);
                                      await controller.updateOrder(
                                        order: controller.orders[index],
                                        status:
                                            controller.orders[index].status ==
                                                    "approve"
                                                ? "outDate"
                                                : "approve",
                                      );
                                      Loading.stopLoading();
                                      CustomSnackBar.showCustomSnackBar(
                                        text: controller.orders[index].status ==
                                                "approve"
                                            ? "Update status order to outDate!"
                                            : "Update status order to approve!",
                                        color: Colors.green,
                                      );
                                    },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: controller.orders[index].status ==
                                              "outDate" ||
                                          controller.orders[index].status ==
                                              "decline"
                                      ? Colors.grey
                                      : blue,
                                ),
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.08,
                                  32,
                                ),
                              ),
                              child: CustomText(
                                text: controller.orders[index].status ==
                                            "pending" ||
                                        controller.orders[index].status ==
                                            "decline"
                                    ? 'Approve'
                                    : "Out Date",
                                color: controller.orders[index].status ==
                                            "outDate" ||
                                        controller.orders[index].status ==
                                            "decline"
                                    ? Colors.grey
                                    : blue,
                              ),
                            ),
                            const SizedBox(width: 4),
                            ElevatedButton(
                              onPressed: controller.orders[index].status ==
                                          "approve" ||
                                      controller.orders[index].status ==
                                          "decline" ||
                                      controller.orders[index].status ==
                                          "outDate"
                                  ? null
                                  : () async {
                                      Loading.startLoading(context);
                                      await controller.updateOrder(
                                        order: controller.orders[index],
                                        status: "decline",
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

extension FormatCurrencyExt on num {
  String toVND({String locale = 'vi_VN', String symbol = '₫'}) {
    return NumberFormat.currency(
      locale: locale,
      customPattern: '#,##0\u00a4',
      symbol: symbol,
    ).format(this);
  }

  String rutGonTien({String locale = 'vi_VN'}) {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(0)}Tr';
    }
    return '${(this / 1000).toStringAsFixed(0)}K';
  }
}
