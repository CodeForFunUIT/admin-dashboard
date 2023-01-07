import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/controllers.dart';
import 'package:flutter_web_dashbard/constants/style.dart';
import 'package:flutter_web_dashbard/controllers/product_controller.dart';
import 'package:flutter_web_dashbard/models/product.dart';
import 'package:flutter_web_dashbard/models/productDetail.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';
import 'package:flutter_web_dashbard/widgets/drop_trademark.dart';
import 'package:flutter_web_dashbard/widgets/drop_type_product.dart';
import 'package:flutter_web_dashbard/widgets/loading.dart';
import 'package:flutter_web_dashbard/widgets/pick_image.dart';
import 'package:flutter_web_dashbard/widgets/snack_bar.dart';
import 'package:flutter_web_dashbard/widgets/text_field.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DialogAddProduct extends StatelessWidget {
  DialogAddProduct({super.key});

  ValueNotifier<int> id = ValueNotifier(2);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 24),
        child: Column(
          children: [
            Row(
              children: [
                CustomText(text: 'Add Product', size: 48, color: blue),
                const SizedBox(width: 124),
                Expanded(
                  child: DropTypeProduct(
                    callBack: (idProd) {
                      id.value = idProd;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            ValueListenableBuilder(
              valueListenable: id,
              builder: (context, i, child) => DialogFormAdd(
                idProductType: id.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DialogFormAdd extends StatelessWidget {
  static const double height = 24;
  static const double width = 48;

  final int idProductType;

  const DialogFormAdd({
    super.key,
    required this.idProductType,
  });

  @override
  Widget build(BuildContext context) {
    switch (idProductType) {
      case 1:
        return FormCpu();
      case 2:
        return FormRam();
      // case 3:
      //   return const FormHardDrive();
      case 6:
        return FormLaptop();
      default:
        return const Center(child: Text('error'));
    }
  }
}

class FormRam extends StatelessWidget {
  FormRam({super.key});

  ProductDetail detail = ProductDetail();
  Product product = Product();
  List<int> list = [];
  final _itemKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _itemKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GroupTextField(
            callBackName: (name) => detail.name = name,
            callBackStock: (stock) => detail.stock = stock,
            callBackPrice: (price) => detail.price = price,
          ),
          const SizedBox(height: DialogFormAdd.height),
          Row(
            children: [
              Expanded(
                child: DropTrademark(
                  callBack: (id, name) {
                    detail.idTradeMark = id.toString();
                    detail.trademark = name;
                  },
                  items: const ['kingSton', 'crucial', 'kingMax'],
                ),
              ),
              const SizedBox(width: DialogFormAdd.width),
              TextFieldCustom(
                titleText: 'Ram',
                hintText: 'Enter Ram (BG)',
                label: 'ram (GB)',
                callBack: (data) => detail.ram = data,
              ),
            ],
          ),
          const SizedBox(height: DialogFormAdd.height),
          Row(
            children: [
              TextFieldCustom(
                titleText: 'Standard ram',
                hintText: 'Enter Standard ram',
                label: 'Standard ram',
                callBack: (data) => detail.chuanRam = data,
              ),
              const SizedBox(width: DialogFormAdd.width),
              TextFieldCustom(
                titleText: 'Bus ram',
                hintText: 'Enter bus ram',
                label: 'bus ram',
                callBack: (data) => detail.bus = data,
              ),
            ],
          ),
          const SizedBox(height: DialogFormAdd.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PickImage(
                callBack: (data, name) {
                  list.addAll(data!);
                  detail.imageName = name;
                },
              ),
            ],
          ),
          ButtonAdd(
            itemKey: _itemKey,
            detail: detail,
            list: list,
            idProductType: 2,
          ),
        ],
      ),
    );
  }
}

class FormCpu extends StatelessWidget {
  FormCpu({super.key});

  ProductDetail detail = ProductDetail();
  Product product = Product();
  List<int> list = [];
  final _itemKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _itemKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GroupTextField(
            callBackName: (name) => detail.name = name,
            callBackStock: (stock) => detail.stock = stock,
            callBackPrice: (price) => detail.price = price,
          ),
          const SizedBox(height: DialogFormAdd.height),
          Row(
            children: [
              Expanded(
                child: DropTrademark(
                  callBack: (id, name) {
                    detail.idTradeMark = id.toString();
                    detail.trademark = name;
                  },
                  items: const ['Intel'],
                ),
              ),
              const SizedBox(width: DialogFormAdd.width),
              TextFieldCustom(
                titleText: 'Card',
                hintText: 'Enter Card',
                label: 'Card',
                callBack: (data) => detail.doHoa = data,
              ),
            ],
          ),
          const SizedBox(height: DialogFormAdd.height),
          Row(
            children: [
              TextFieldCustom(
                titleText: 'base clock',
                hintText: 'Enter base clock',
                label: 'base clock',
                callBack: (data) => detail.xungNhipCoBan = data,
              ),
              const SizedBox(width: DialogFormAdd.width),
              TextFieldCustom(
                titleText: 'max clock',
                hintText: 'Enter max clock',
                label: 'max clock',
                callBack: (data) => detail.xungNhipToiDa = data,
              ),
            ],
          ),
          const SizedBox(height: DialogFormAdd.height),
          Row(
            children: [
              TextFieldCustom(
                titleText: 'generation chip ',
                hintText: 'Enter generation chip',
                label: 'generation chip',
                callBack: (data) => detail.theHe = data,
              ),
              const SizedBox(width: DialogFormAdd.width),
              TextFieldCustom(
                titleText: 'Process',
                hintText: 'Enter Process',
                label: 'Process',
                callBack: (data) => detail.tienTrinh = data,
              ),
            ],
          ),
          const SizedBox(height: DialogFormAdd.height),
          Row(
            children: [
              TextFieldCustom(
                titleText: 'chip multiplier',
                hintText: 'Enter chip multiplier',
                label: 'chip multiplier',
                callBack: (data) => detail.soNhan = data,
              ),
              const SizedBox(width: DialogFormAdd.width),
              TextFieldCustom(
                titleText: 'Threads',
                hintText: 'Enter threads',
                label: 'Threads',
                callBack: (data) => detail.soLuong = data,
              ),
            ],
          ),
          const SizedBox(height: DialogFormAdd.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PickImage(
                callBack: (data, name) {
                  list.addAll(data!);
                  detail.imageName = name;
                },
              ),
            ],
          ),
          ButtonAdd(
            itemKey: _itemKey,
            detail: detail,
            list: list,
            idProductType: 1,
          ),
        ],
      ),
    );
  }
}

class FormLaptop extends StatelessWidget {
  FormLaptop({super.key});

  ProductDetail detail = ProductDetail();
  Product product = Product();
  final List<int> list = [];
  final _itemKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _itemKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GroupTextField(
            callBackName: (name) => detail.name = name,
            callBackStock: (stock) => detail.stock = stock,
            callBackPrice: (price) => detail.price = price,
          ),
          const SizedBox(height: DialogFormAdd.height),
          Row(
            children: [
              Expanded(
                child: DropTrademark(
                  callBack: (id, name) {
                    detail.idTradeMark = id.toString();
                    detail.trademark = name;
                  },
                  items: const ['HP', 'Lenovo', 'Dell', 'MSI'],
                ),
              ),
              const SizedBox(width: DialogFormAdd.width),
              TextFieldCustom(
                titleText: 'Detail Ram',
                hintText: 'Enter Detail Ram',
                label: 'Detail Ram',
                callBack: (data) => detail.ramDetail = data,
              ),
            ],
          ),
          const SizedBox(height: DialogFormAdd.height),
          Row(
            children: [
              TextFieldCustom(
                titleText: 'CPU',
                hintText: 'Enter CPU',
                label: 'CPU',
                callBack: (data) => detail.cpu = data,
              ),
              const SizedBox(width: DialogFormAdd.width),
              TextFieldCustom(
                titleText: 'detail screen',
                hintText: 'Enter detail screen',
                label: 'detail screen',
                callBack: (data) => detail.manHinh = data,
              ),
            ],
          ),
          const SizedBox(height: DialogFormAdd.height),
          Row(
            children: [
              TextFieldCustom(
                titleText: 'hard drive',
                hintText: 'Enter hard drive',
                label: 'hard drive',
                callBack: (data) => detail.oCung = data,
              ),
              const SizedBox(width: DialogFormAdd.width),
              TextFieldCustom(
                titleText: 'Weight',
                hintText: 'Enter weight',
                label: 'Weight (kg)',
                callBack: (data) => detail.trongLuong = data,
              ),
            ],
          ),
          const SizedBox(height: DialogFormAdd.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PickImage(
                callBack: (data, name) {
                  list.addAll(data!);
                  detail.imageName = name;
                },
              ),
            ],
          ),
          const SizedBox(height: DialogFormAdd.height),
          ButtonAdd(
            detail: detail,
            itemKey: _itemKey,
            list: list,
            idProductType: 6,
          ),
        ],
      ),
    );
  }
}

class GroupTextField extends StatelessWidget {
  final void Function(String? name) callBackName;
  final void Function(String? name) callBackStock;
  final void Function(String? name) callBackPrice;
  final String? id;
  final double? width;

  final String? name;
  final String? stock;
  final String? price;
  const GroupTextField({
    super.key,
    required this.callBackName,
    required this.callBackStock,
    required this.callBackPrice,
    this.id,
    this.width,
    this.name,
    this.stock,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextFieldCustom(
              titleText: 'ID',
              text: id ?? 'id',
              isId: true,
            ),
            SizedBox(width: width ?? DialogFormAdd.width),
            TextFieldCustom(
              titleText: 'Name Product',
              hintText: 'Enter Name Product',
              label: 'Name Product',
              text: name,
              callBack: (data) => callBackName(data),
            ),
          ],
        ),
        const SizedBox(height: DialogFormAdd.height),
        Row(
          children: [
            TextFieldCustom(
              titleText: 'Stock',
              hintText: 'Enter Stock',
              label: 'Stock',
              text: stock,
              callBack: (data) => callBackStock(data),
            ),
            SizedBox(width: width ?? DialogFormAdd.width),
            TextFieldCustom(
              titleText: 'Price',
              hintText: 'Enter price',
              label: 'price',
              text: price,
              callBack: (data) => callBackPrice(data),
            ),
          ],
        ),
      ],
    );
  }
}

class ButtonAdd extends StatelessWidget {
  final ProductDetail detail;
  final List<int> list;
  final int idProductType;
  final GlobalKey<FormState> itemKey;
  const ButtonAdd({
    super.key,
    required this.detail,
    required this.list,
    required this.idProductType,
    required this.itemKey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 8,
        ),
        Expanded(
          flex: 1,
          child: GetBuilder<ProductController>(
            builder: (controller) => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(30, 50),
              ),
              onPressed: () async {
                if (itemKey.currentState!.validate()) {
                  Get.dialog(
                    const Dialog(
                      backgroundColor: Colors.transparent,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                  // Loading.startLoading(context);
                  await productController.addProduct(
                    detail: detail,
                    idProductType: idProductType,
                    image: list,
                  );
                  Loading.stopLoading();
                  if (controller.statusAddProduct) {
                    Get.back();
                    CustomSnackBar.showCustomSnackBar(
                      text: 'Add Produc successs',
                      color: Colors.green,
                    );
                  } else {
                    CustomSnackBar.showCustomSnackBar(
                      text: 'Add Produc failed',
                      color: Colors.red,
                    );
                  }
                }
              },
              child: const CustomText(
                text: 'Add',
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
