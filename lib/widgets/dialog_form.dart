import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/controllers.dart';
import 'package:flutter_web_dashbard/models/productDetail.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';
import 'package:flutter_web_dashbard/widgets/loading.dart';
import 'package:flutter_web_dashbard/widgets/text_field.dart';
import 'package:get/get.dart';

enum ProductType {
  cpu(id: 1),
  ram(id: 2),
  oCung(id: 3),
  laptop(id: 4);

  const ProductType({required this.id});

  final int id;
}

class DialogForm extends StatelessWidget {
  static const double height = 8;
  static const double width = 16;

  final int idProductType;
  final String idProduct;
  final ProductDetail model;
  final int idTradeMark;

  const DialogForm({
    super.key,
    required this.idProduct,
    required this.model,
    required this.idProductType,
    required this.idTradeMark,
  });

  @override
  Widget build(BuildContext context) {
    switch (idProductType) {
      case 1:
        return FormCpu(
          detail: model,
          idProduct: idProduct,
          idTradeMark: idTradeMark,
          idProductType: idProductType,
        );
      case 2:
        return FormRam(
          idProduct: idProduct,
          detail: model,
          idTradeMark: idTradeMark,
          idProductType: idProductType,
        );
      case 3:
      // return FormOCung(detail: model);
      case 4:
        return FormLaptop(
          detail: model,
          idProduct: idProduct,
        );
      default:
        return const Center(child: Text('error'));
    }
  }
}

class FormRam extends StatelessWidget {
  final ProductDetail detail;
  final int idProductType;
  final int idTradeMark;
  final String idProduct;

  const FormRam({
    super.key,
    required this.idProduct,
    required this.detail,
    required this.idProductType,
    required this.idTradeMark,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            Row(
              children: [
                Expanded(
                  child: TextFieldCustom(
                    text: idProduct,
                    isId: true,
                    titleText: 'Mã sản phẩm',
                  ),
                ),
                const SizedBox(width: DialogForm.width),
                Expanded(
                  child: TextFieldCustom(
                    text: detail.ram,
                    titleText: 'Ram (GB)',
                    hintText: 'Nhập Ram (BG)',
                    label: 'ram (GB)',
                  ),
                ),
              ],
            ),
            const SizedBox(height: DialogForm.height),
            Row(
              children: [
                Expanded(
                  child: TextFieldCustom(
                    text: detail.chuanRam,
                    titleText: 'Chuẩn Ram',
                    hintText: 'Nhập chuẩn ram',
                    label: 'chuẩn ram',
                  ),
                ),
                const SizedBox(width: DialogForm.width),
                Expanded(
                  child: TextFieldCustom(
                    text: detail.bus,
                    titleText: 'Bus Ram',
                    hintText: 'Nhập bus ram',
                    label: 'Bus ram',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 200),
            Row(
              children: [
                const Spacer(
                  flex: 7,
                ),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () async {
                      Loading.startLoading(context);
                      await productController.updateProduct(
                        detail,
                        idProductType,
                        idTradeMark,
                      );
                      Loading.stopLoading();
                    },
                    child: const CustomText(text: 'Edit'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FormCpu extends StatelessWidget {
  final ProductDetail detail;
  final String idProduct;

  final int idProductType;
  final int idTradeMark;
  const FormCpu({
    super.key,
    required this.detail,
    required this.idProduct,
    required this.idProductType,
    required this.idTradeMark,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            Row(
              children: [
                TextFieldCustom(
                  titleText: 'Mã sản phẩm',
                  text: idProduct,
                  isId: true,
                ),
                TextFieldCustom(
                  text: detail.soNhan,
                  titleText: 'Số nhân',
                  hintText: 'Nhập số nhân',
                  label: 'Số nhân',
                ),
              ],
            ),
            const SizedBox(height: DialogForm.height),
            Row(
              children: [
                TextFieldCustom(
                  text: detail.soLuong,
                  titleText: 'Số luồng',
                  hintText: 'Nhập số luồng',
                  label: 'Số luồng',
                ),
                TextFieldCustom(
                  text: detail.xungNhipCoBan,
                  titleText: 'Xung nhịp cơ bản',
                  hintText: 'Nhập xung nhịp cơ bản',
                  label: 'Xung nhịp cơ bản',
                ),
              ],
            ),
            const SizedBox(height: DialogForm.height),
            Row(
              children: [
                TextFieldCustom(
                  text: detail.xungNhipToiDa,
                  titleText: 'Xung nhịp tốt đa',
                  hintText: 'Nhập xung nhịp tối đa',
                  label: 'Xung nhịp tối đa',
                ),
                TextFieldCustom(
                  text: detail.theHe,
                  titleText: 'Thế hệ',
                  hintText: 'Nhập thế hệ',
                  label: 'Thế hệ',
                ),
              ],
            ),
            const SizedBox(height: DialogForm.height),
            Row(
              children: [
                TextFieldCustom(
                  text: detail.tienTrinh,
                  titleText: 'Tiến trình',
                  hintText: 'Nhập tiến trình',
                  label: 'Tiến trình',
                ),
                TextFieldCustom(
                  text: detail.doHoa,
                  titleText: 'Đồ họa',
                  hintText: 'Nhập card đồ họa',
                  label: 'Đồ họa',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class FormOCung extends StatelessWidget {
//   final ProductDetail detail;

//   const FormOCung({
//     super.key,
//     required this.detail,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: CustomText(
//           text: 'Laptop',
//           color: blue,
//         ),
//       ),
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: TextFieldCustom(
//                   text: detail.id,
//                   isId: true,
//                 ),
//               ),
//               Expanded(child: TextFieldCustom(text: detail.ramDetail)),
//             ],
//           ),
//           const SizedBox(height: DialogForm.height),
//           Row(
//             children: [
//               TextFieldCustom(text: detail.xungNhipCoBan),
//               TextFieldCustom(text: detail.oCung),
//             ],
//           ),
//           const SizedBox(height: DialogForm.height),
//           Row(
//             children: [
//               TextFieldCustom(text: detail.manHinh),
//               TextFieldCustom(text: detail.trongLuong),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class FormLaptop extends StatelessWidget {
  final ProductDetail detail;
  final String idProduct;

  const FormLaptop({
    super.key,
    required this.idProduct,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
