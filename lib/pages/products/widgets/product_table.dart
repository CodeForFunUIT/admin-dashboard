import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/controllers.dart';
import 'package:flutter_web_dashbard/constants/style.dart';
import 'package:flutter_web_dashbard/controllers/product_controller.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';
import 'package:flutter_web_dashbard/widgets/dialog_form.dart';
import 'package:flutter_web_dashbard/widgets/loading.dart';
import 'package:get/get.dart';

class ProductTable extends StatelessWidget {
  const ProductTable({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      initState: (state) => productController.getProduct(),
      builder: (controller) => controller.products.isEmpty
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
                    label: Text("ID"),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text('Name'),
                    size: ColumnSize.L,
                  ),
                  DataColumn(
                    label: Text('Action'),
                  ),
                ],
                rows: List<DataRow>.generate(
                  controller.products.length,
                  (index) => DataRow(
                    cells: [
                      DataCell(CustomText(text: '$index')),
                      DataCell(CustomText(text: controller.products[index].id)),
                      DataCell(
                        CustomText(text: controller.products[index].name),
                      ),
                      DataCell(action(context, controller, index))
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget action(
    BuildContext context,
    ProductController controller,
    int index,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          onPressed: () async {
            Loading.startLoading(context);
            await controller.getProductDetail(
              controller.products[index].id ?? '0',
            );
            Loading.stopLoading();
            Get.dialog(
              Dialog(
                child: DialogForm(
                  idProduct: controller.products[index].id!,
                  model: controller.detail,
                  idProductType: int.parse(
                    controller.products[index].idProductType ?? '0',
                  ),
                  idTradeMark: int.parse(
                    controller.products[index].idTradeMark ?? '0',
                  ),
                ),
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: blue),
            fixedSize: Size(MediaQuery.of(context).size.width * 0.08, 32),
          ),
          child: CustomText(text: 'Update', color: blue),
        ),
        const SizedBox(width: 4),
        ElevatedButton(
          onPressed: () async {
            Loading.startLoading(context);
            await controller.deleteProduct(
              controller.products[index].id!,
            );
            Loading.stopLoading();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            fixedSize: Size(
              MediaQuery.of(context).size.width * 0.06,
              32,
            ),
          ),
          child: const CustomText(
            text: 'Delete',
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
