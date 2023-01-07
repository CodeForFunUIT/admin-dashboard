import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/controllers.dart';
import 'package:flutter_web_dashbard/models/productDetail.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';
import 'package:flutter_web_dashbard/widgets/dialog_add_product.dart';
import 'package:flutter_web_dashbard/widgets/loading.dart';
import 'package:flutter_web_dashbard/widgets/snack_bar.dart';
import 'package:flutter_web_dashbard/widgets/text_field.dart';
import 'package:get/get.dart';

String? validateEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return 'Do not empty!';
  }

  return null;
}

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
      case 6:
        return FormLaptop(
          idProduct: idProduct,
          detail: model,
          idTradeMark: idTradeMark,
          idProductType: idProductType,
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FormRam({
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
              const SizedBox(height: DialogForm.height),
              GroupTextField(
                id: idProduct,
                callBackName: (String? name) => detail.name = name,
                callBackPrice: (String? price) => detail.price = price,
                callBackStock: (String? stock) => detail.stock = stock,
                width: DialogForm.width,
                name: detail.name,
                stock: detail.stock,
                price: detail.price,
              ),
              const SizedBox(height: DialogForm.height),
              Row(
                children: [
                  TextFieldCustom(
                    text: detail.bus,
                    titleText: 'Bus Ram',
                    hintText: 'Enter bus ram',
                    label: 'Bus ram',
                    callBack: (data) => detail.bus = data,
                  ),
                  const SizedBox(width: DialogForm.width),
                  TextFieldCustom(
                    text: detail.ram,
                    titleText: 'Ram (GB)',
                    hintText: 'Enter Ram (BG)',
                    label: 'ram (GB)',
                    callBack: (data) => detail.ram = data,
                  ),
                ],
              ),
              const SizedBox(height: DialogForm.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldCustom(
                    text: detail.chuanRam,
                    titleText: 'Chuẩn Ram',
                    hintText: 'Enter chuẩn ram',
                    label: 'chuẩn ram',
                    callBack: (data) => detail.chuanRam = data,
                  ),
                ],
              ),
              const SizedBox(height: 200),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Loading.startLoading(context);
                          await productController.updateProduct(
                            detail,
                            idProductType,
                            idTradeMark,
                          );
                          Loading.stopLoading();
                          CustomSnackBar.showCustomSnackBar(
                            text: 'Update successfull',
                            color: Colors.green,
                          );
                        }
                      },
                      child: const CustomText(text: 'Update'),
                    ),
                  ),
                ],
              )
            ],
          ),
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
  final _itemKey = GlobalKey<FormState>();
  FormCpu({
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _itemKey,
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
              const SizedBox(height: DialogForm.height),
              GroupTextField(
                id: idProduct,
                callBackName: (String? name) => detail.name = name,
                callBackPrice: (String? price) => detail.price = price,
                callBackStock: (String? stock) => detail.stock = stock,
                width: DialogForm.width,
                name: detail.name,
                stock: detail.stock,
                price: detail.price,
              ),
              const SizedBox(height: DialogForm.height),
              Row(
                children: [
                  TextFieldCustom(
                    text: detail.doHoa,
                    titleText: 'Đồ họa',
                    hintText: 'Enter card đồ họa',
                    label: 'Đồ họa',
                    callBack: (data) => detail.doHoa = data,
                  ),
                  const SizedBox(width: DialogForm.width),
                  TextFieldCustom(
                    text: detail.soNhan,
                    titleText: 'chip multiplier',
                    hintText: 'Enter chip multiplier',
                    label: 'chip multiplier',
                    callBack: (data) => detail.soNhan = data,
                  ),
                ],
              ),
              const SizedBox(height: DialogForm.height),
              Row(
                children: [
                  TextFieldCustom(
                    text: detail.soLuong,
                    titleText: 'threads',
                    hintText: 'Enter threads',
                    label: 'threads',
                    callBack: (data) => detail.soLuong = data,
                  ),
                  const SizedBox(width: DialogForm.width),
                  TextFieldCustom(
                    text: detail.xungNhipCoBan,
                    titleText: 'base clock',
                    hintText: 'Enter base clock',
                    label: 'base clock',
                    callBack: (data) => detail.xungNhipCoBan = data,
                  ),
                ],
              ),
              const SizedBox(height: DialogForm.height),
              Row(
                children: [
                  TextFieldCustom(
                    text: detail.xungNhipToiDa,
                    titleText: 'Xung nhịp tốt đa',
                    hintText: 'Enter max clock',
                    label: 'max clock',
                    callBack: (data) => detail.xungNhipToiDa = data,
                  ),
                  const SizedBox(width: DialogForm.width),
                  TextFieldCustom(
                    text: detail.theHe,
                    titleText: 'generation chip',
                    hintText: 'Enter generation chip',
                    label: 'generation chip',
                    callBack: (data) => detail.theHe = data,
                  ),
                ],
              ),
              const SizedBox(height: DialogForm.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldCustom(
                    text: detail.tienTrinh,
                    titleText: 'Process',
                    hintText: 'Enter Process',
                    label: 'Process',
                    callBack: (data) => detail.tienTrinh = data,
                  ),
                ],
              ),
              const SizedBox(height: 200),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      fixedSize: const Size(80, 40),
                    ),
                    onPressed: () async {
                      if (_itemKey.currentState!.validate()) {
                        Loading.startLoading(context);
                        await productController.updateProduct(
                          detail,
                          idProductType,
                          idTradeMark,
                        );
                        Loading.stopLoading();
                        CustomSnackBar.showCustomSnackBar(
                          text: 'Update success',
                          color: Colors.green,
                        );
                      }
                    },
                    child: const CustomText(
                      text: 'Update Enter',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
  final int idProductType;
  final int idTradeMark;
  final _itemKey = GlobalKey<FormState>();
  FormLaptop({
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
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _itemKey,
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
                GroupTextField(
                  id: idProduct,
                  callBackName: (String? name) => detail.name = name,
                  callBackPrice: (String? price) => detail.price = price,
                  callBackStock: (String? stock) => detail.stock = stock,
                  width: DialogForm.width,
                  name: detail.name,
                  stock: detail.stock,
                  price: detail.price,
                ),
                const SizedBox(height: DialogForm.height),
                Row(
                  children: [
                    TextFieldCustom(
                      text: detail.oCung,
                      titleText: 'hard drive',
                      hintText: 'Enter hard drive',
                      label: 'Enter hard drive',
                      callBack: (data) => detail.oCung = data,
                    ),
                    const SizedBox(width: DialogForm.width),
                    TextFieldCustom(
                      text: detail.ramDetail,
                      titleText: 'detail ram',
                      hintText: 'Enter detail ram',
                      label: 'detail ram',
                      callBack: (data) => detail.ramDetail = data,
                    ),
                  ],
                ),
                const SizedBox(height: DialogForm.height),
                Row(
                  children: [
                    TextFieldCustom(
                      text: detail.cpu,
                      titleText: 'CPU',
                      hintText: 'Enter cpu',
                      label: 'CPU',
                      callBack: (data) => detail.cpu = data,
                    ),
                    const SizedBox(width: DialogForm.width),
                    TextFieldCustom(
                      text: detail.manHinh,
                      titleText: 'detail screen',
                      hintText: 'Enter detail screen',
                      label: 'detail screen',
                      callBack: (data) => detail.manHinh = data,
                    ),
                  ],
                ),
                const SizedBox(height: DialogForm.height),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldCustom(
                      text: detail.trongLuong,
                      titleText: 'Weight',
                      hintText: 'Enter Weight',
                      label: 'Weight',
                      callBack: (data) => detail.trongLuong = data,
                    ),
                  ],
                ),
                const SizedBox(height: 200),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        fixedSize: const Size(80, 40),
                      ),
                      onPressed: () async {
                        if (_itemKey.currentState!.validate()) {
                          Loading.startLoading(context);
                          await productController.updateProduct(
                            detail,
                            idProductType,
                            idTradeMark,
                          );
                          Loading.stopLoading();
                          CustomSnackBar.showCustomSnackBar(
                            text: 'Update success',
                            color: Colors.green,
                          );
                        }
                      },
                      child:
                          const CustomText(text: 'Update', color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
