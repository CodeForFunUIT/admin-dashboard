import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/style.dart';
import 'package:flutter_web_dashbard/models/productDetail.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';
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
  static const double width = 8;

  final int idProductType;
  final ProductDetail model;
  final int idTradeMark;

  const DialogForm({
    super.key,
    required this.model,
    required this.idProductType,
    required this.idTradeMark,
  });

  @override
  Widget build(BuildContext context) {
    switch (idProductType) {
      case 1:
        return FormCpu(detail: model);
      case 2:
        return FormRam(
          detail: model,
          idTradeMark: idTradeMark,
          idProductType: idProductType,
        );
      case 3:
        return FormOCung(detail: model);
      case 4:
        return FormLaptop(detail: model);
      default:
        return const Center(child: Text('error'));
    }
  }
}

class FormRam extends StatelessWidget {
  final ProductDetail detail;
  final int idProductType;
  final int idTradeMark;

  const FormRam({
    super.key,
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
                    text: detail.id,
                    isId: true,
                  ),
                ),
                const SizedBox(width: DialogForm.width),
                Expanded(child: TextFieldCustom(text: detail.ram)),
              ],
            ),
            const SizedBox(height: DialogForm.height),
            Row(
              children: [
                Expanded(child: TextFieldCustom(text: detail.chuanRam)),
                const SizedBox(width: DialogForm.width),
                Expanded(child: TextFieldCustom(text: detail.bus)),
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
                      // Loading.startLoading(context);
                      // await productController.updateProduct(
                      //   detail,
                      //   idProductType,
                      //   idTradeMark,
                      // );
                      // Loading.stopLoading();
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
  const FormCpu({
    super.key,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'CPU',
          color: blue,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              TextFieldCustom(
                text: detail.id,
                isId: true,
              ),
              TextFieldCustom(text: detail.soNhan),
            ],
          ),
          const SizedBox(height: DialogForm.height),
          Row(
            children: [
              TextFieldCustom(text: detail.soLuong),
              TextFieldCustom(text: detail.xungNhipCoBan),
            ],
          ),
          const SizedBox(height: DialogForm.height),
          Row(
            children: [
              TextFieldCustom(text: detail.xungNhipToiDa),
              TextFieldCustom(text: detail.theHe),
            ],
          ),
          const SizedBox(height: DialogForm.height),
          Row(
            children: [
              TextFieldCustom(text: detail.tienTrinh),
              TextFieldCustom(text: detail.doHoa),
            ],
          ),
        ],
      ),
    );
  }
}

class FormOCung extends StatelessWidget {
  final ProductDetail detail;

  const FormOCung({
    super.key,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: 'Laptop',
          color: blue,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFieldCustom(
                  text: detail.id,
                  isId: true,
                ),
              ),
              Expanded(child: TextFieldCustom(text: detail.ramDetail)),
            ],
          ),
          const SizedBox(height: DialogForm.height),
          Row(
            children: [
              TextFieldCustom(text: detail.xungNhipCoBan),
              TextFieldCustom(text: detail.oCung),
            ],
          ),
          const SizedBox(height: DialogForm.height),
          Row(
            children: [
              TextFieldCustom(text: detail.manHinh),
              TextFieldCustom(text: detail.trongLuong),
            ],
          ),
        ],
      ),
    );
  }
}

class FormLaptop extends StatelessWidget {
  final ProductDetail detail;

  const FormLaptop({
    super.key,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
