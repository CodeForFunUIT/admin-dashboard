import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/controllers.dart';
import 'package:flutter_web_dashbard/constants/style.dart';
import 'package:flutter_web_dashbard/models/product.dart';
import 'package:flutter_web_dashbard/models/productDetail.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';
import 'package:flutter_web_dashbard/widgets/drop_trademark.dart';
import 'package:flutter_web_dashbard/widgets/drop_type_product.dart';
import 'package:flutter_web_dashbard/widgets/loading.dart';
import 'package:flutter_web_dashbard/widgets/pick_image.dart';
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
      case 3:
        return const FormHardDrive();
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
  String imageName = '';
  int idTrademark = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GroupTextField(
          callBack: (name, stock, price) {
            detail.name = name;
            detail.stock = stock;
            detail.price = price;
          },
        ),
        const SizedBox(height: DialogFormAdd.height),
        Row(
          children: [
            Expanded(
              child: DropTrademark(
                callBack: (id) => idTrademark = id,
                items: const ['kingSton', 'crucial', 'kingMax'],
              ),
            ),
            const SizedBox(width: DialogFormAdd.width),
            TextFieldCustom(
              titleText: 'Ram',
              hintText: 'Nhập Ram (BG)',
              label: 'ram (GB)',
              callBack: (data) => detail.ram = data,
            ),
          ],
        ),
        const SizedBox(height: DialogFormAdd.height),
        Row(
          children: [
            TextFieldCustom(
              titleText: 'Chuẩn ram',
              hintText: 'Nhập chuẩn ram',
              label: 'chuẩn ram',
              callBack: (data) => detail.chuanRam = data,
            ),
            const SizedBox(width: DialogFormAdd.width),
            TextFieldCustom(
              titleText: 'Bus ram',
              hintText: 'Nhập bus ram',
              label: 'bus ram',
              callBack: (data) => detail.bus = data,
            ),
          ],
        ),
        const SizedBox(height: DialogFormAdd.height),
        PickImage(
          callBack: (data, name) {
            list = [...data!];
            imageName = name;
          },
        ),
        ButtonAdd(
          detail: detail,
          list: list,
          imageName: imageName,
          idProductType: 2,
          idTradeMark: idTrademark,
        ),
      ],
    );
  }
}

class FormCpu extends StatelessWidget {
  FormCpu({super.key});

  ProductDetail detail = ProductDetail();
  Product product = Product();
  List<int> list = [];
  String imageName = '';
  int idTrademark = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GroupTextField(
          callBack: (name, stock, price) {
            detail.name = name;
            detail.stock = stock;
            detail.price = price;
          },
        ),
        const SizedBox(height: DialogFormAdd.height),
        Row(
          children: [
            Expanded(
              child: DropTrademark(
                callBack: (id) => idTrademark = id,
                items: const ['Intel'],
              ),
            ),
            const SizedBox(width: DialogFormAdd.width),
            const TextFieldCustom(
              titleText: 'Đồ họa ',
              hintText: 'Nhập card đồ họa',
              label: 'Đồ họa',
            ),
          ],
        ),
        const SizedBox(height: DialogFormAdd.height),
        Row(
          children: const [
            TextFieldCustom(
              titleText: 'Xung nhịp cơ bản',
              hintText: 'Nhập xung nhịp cơ bản',
              label: 'Xung nhịp cơ bản',
            ),
            SizedBox(width: DialogFormAdd.width),
            TextFieldCustom(
              titleText: 'Xung nhịp tối đa',
              hintText: 'Nhập xung nhịp tối đa',
              label: 'Xung nhịp tối đa',
            ),
          ],
        ),
        const SizedBox(height: DialogFormAdd.height),
        Row(
          children: const [
            TextFieldCustom(
              titleText: 'Thế hệ ',
              hintText: 'Nhập thế hệ',
              label: 'Thế hệ',
            ),
            SizedBox(width: DialogFormAdd.width),
            TextFieldCustom(
              titleText: 'Tiến trình',
              hintText: 'Nhập tiến trình',
              label: 'Tiến trình',
            ),
          ],
        ),
        const SizedBox(height: DialogFormAdd.height),
        Row(
          children: const [
            TextFieldCustom(
              titleText: 'Số nhân',
              hintText: 'Nhập số nhân',
              label: 'Số nhân',
            ),
            SizedBox(width: DialogFormAdd.width),
            TextFieldCustom(
              titleText: 'Số luồng',
              hintText: 'Nhập số luồng',
              label: 'Số luồng',
            ),
          ],
        ),
        const SizedBox(height: DialogFormAdd.height),
        PickImage(
          callBack: (data, name) {
            list = [...data!];
            imageName = name;
          },
        ),
        ButtonAdd(
          detail: detail,
          list: list,
          imageName: imageName,
          idProductType: 2,
          idTradeMark: idTrademark,
        ),
      ],
    );
  }
}

class FormHardDrive extends StatelessWidget {
  const FormHardDrive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: const [
            TextFieldCustom(),
            TextFieldCustom(),
          ],
        ),
        const SizedBox(height: DialogFormAdd.height),
        Row(
          children: const [
            TextFieldCustom(),
            TextFieldCustom(),
          ],
        ),
        const SizedBox(height: DialogFormAdd.height),
        Row(
          children: const [
            TextFieldCustom(),
            TextFieldCustom(),
          ],
        ),
      ],
    );
  }
}

class FormLaptop extends StatelessWidget {
  FormLaptop({super.key});

  ProductDetail detail = ProductDetail();
  Product product = Product();
  List<int> list = [];
  String imageName = '';
  int idTrademark = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GroupTextField(
          callBack: (name, stock, price) {
            detail.name = name;
            detail.stock = stock;
            detail.price = price;
          },
        ),
        const SizedBox(height: DialogFormAdd.height),
        Row(
          children: [
            Expanded(
              child: DropTrademark(
                callBack: (id) => idTrademark = id,
                items: const ['HP', 'Lenovo', 'Dell', 'MSI'],
              ),
            ),
            const SizedBox(width: DialogFormAdd.width),
            const TextFieldCustom(
              titleText: 'thông tin ram',
              hintText: 'Nhập thông tin ram',
              label: 'Ram',
            ),
          ],
        ),
        const SizedBox(height: DialogFormAdd.height),
        Row(
          children: const [
            TextFieldCustom(
              titleText: 'Card đồ họa',
              hintText: 'Nhập card đồ họa',
              label: 'Card đồ họa',
            ),
            SizedBox(width: DialogFormAdd.width),
            TextFieldCustom(
              titleText: 'Màn hình',
              hintText: 'Nhập thông tin màn hình',
              label: 'Màn hình',
            ),
          ],
        ),
        const SizedBox(height: DialogFormAdd.height),
        Row(
          children: [
            const TextFieldCustom(
              titleText: 'Ổ cứng',
              hintText: 'Nhập ổ cứng',
              label: 'Ổ cứng',
            ),
            const SizedBox(width: DialogFormAdd.width),
            Expanded(
              child: PickImage(
                callBack: (data, name) {
                  list = [...data!];
                  imageName = name;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: DialogFormAdd.height),
        ButtonAdd(
          detail: detail,
          list: list,
          imageName: imageName,
          idProductType: 6,
          idTradeMark: 1,
        ),
      ],
    );
  }
}

// String getIdTradeMark(String name){
//   switch (name) {
//     case 'value':

//       break;
//     default:
//   }
// }
class GroupTextField extends StatelessWidget {
  final void Function(String? name, String? stock, String? price) callBack;

  const GroupTextField({
    super.key,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const TextFieldCustom(
              titleText: 'id',
              text: 'id',
              isId: true,
            ),
            const SizedBox(width: DialogFormAdd.width),
            TextFieldCustom(
              titleText: 'Tên sản phẩm',
              hintText: 'Nhập tên sản phẩm',
              label: 'tên sản phẩm',
              callBack: (data) => callBack(data, '', ''),
            ),
          ],
        ),
        const SizedBox(height: DialogFormAdd.height),
        Row(
          children: [
            TextFieldCustom(
              titleText: 'Số lượng',
              hintText: 'Nhập số lượng',
              label: 'số lượng',
              callBack: (data) => callBack('', data, ''),
            ),
            const SizedBox(width: DialogFormAdd.width),
            TextFieldCustom(
              titleText: 'Giá',
              hintText: 'Nhập giá',
              label: 'giá',
              callBack: (data) => callBack('', '', data),
            ),
          ],
        ),
      ],
    );
  }
}

class ButtonAdd extends StatelessWidget {
  final ProductDetail detail;
  final List<int>? list;
  final String imageName;
  final int idTradeMark;
  final int idProductType;
  const ButtonAdd({
    super.key,
    required this.detail,
    required this.list,
    required this.imageName,
    required this.idProductType,
    required this.idTradeMark,
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
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              minimumSize: const Size(30, 50),
            ),
            onPressed: () async {
              Get.dialog(
                const Dialog(
                  backgroundColor: Colors.transparent,
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
              await productController.addProduct(
                detail: detail,
                idProductType: idProductType,
                idTradeMark: idTradeMark,
                image: list,
                imageName: imageName,
              );
              Loading.stopLoading();
            },
            child: const CustomText(text: 'Add'),
          ),
        ),
      ],
    );
  }
}
