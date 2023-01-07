import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/controllers.dart';
import 'package:flutter_web_dashbard/controllers/product_controller.dart';
import 'package:flutter_web_dashbard/models/order_detai.dart';
import 'package:flutter_web_dashbard/pages/orders/order_table.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';
import 'package:flutter_web_dashbard/widgets/dialog_form.dart';
import 'package:get/get.dart';

class DialogOrderDetail extends StatelessWidget {
  static const double height = 8;
  static const double width = 16;

  final int idOrder;
  const DialogOrderDetail({
    super.key,
    required this.idOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                IconButton(
                  onPressed: Get.back,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: DialogForm.height),
            GetBuilder<ProductController>(
              initState: (_) =>
                  productController.getOrderDetail(orderId: idOrder),
              builder: (controller) {
                final List<OrderDetail> list = controller.orderDetail;
                return controller.orderDetail.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Expanded(
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
                              label: Text('ID Order'),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Text('Name'),
                              size: ColumnSize.L,
                            ),
                            DataColumn2(
                              size: ColumnSize.S,
                              label: Text('Price'),
                              // onSort: (index, ascending) {
                              //   if (ascending) {
                              //     list.sort(
                              //       (first, second) => int.parse(first.price!)
                              //           .compareTo(int.parse(second.price!)),
                              //     );
                              //   } else {
                              //     list.clear();
                              //     list.addAll(controller.orderDetail);
                              //   }
                              // },
                            ),
                            DataColumn2(
                              size: ColumnSize.S,
                              label: Text('Number'),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            list.length,
                            (index) => DataRow(
                              cells: [
                                DataCell(CustomText(text: '$index')),
                                DataCell(
                                  CustomText(
                                    text: list[index].idOrder,
                                  ),
                                ),
                                DataCell(
                                  CustomText(
                                    text: controller
                                        .orderDetail[index].nameProduct,
                                  ),
                                ),
                                DataCell(
                                  CustomText(
                                    text: int.parse(
                                      list[index].price!,
                                    ).toVND(),
                                  ),
                                ),
                                DataCell(
                                  CustomText(
                                    text: list[index].number,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
