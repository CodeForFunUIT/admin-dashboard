import 'dart:convert';

import 'package:flutter_web_dashbard/constants/link.dart';
import 'package:flutter_web_dashbard/models/product.dart';
import 'package:flutter_web_dashbard/models/productDetail.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();

  final List<Product> _list = [];
  List<Product> get list => _list;
  set list(List<Product> data) {
    list.clear();
    for (var e in data) {
      list.add(e);
    }
    update();
  }

  late ProductDetail _detail;
  ProductDetail get detail => _detail;
  set detail(ProductDetail data) {
    _detail = data;
    update();
  }

  String getLink({
    required int idProductType,
  }) {
    switch (idProductType) {
      case 1:
        return Link.addCpu;
      case 2:
        return Link.addRam;
      case 6:
        return Link.addLaptop;

      default:
        return '';
    }
  }

  String getFileName({required int idProductType}) {
    switch (idProductType) {
      case 1:
        return 'cpu';
      case 2:
        return 'ram';
      case 6:
        return 'laptop';
      default:
        return '';
    }
  }

  Future<void> getProduct() async {
    final http.Response response = await http.post(Uri.parse(Link.getProduct));

    if (response.statusCode == 200) {
      list = (jsonDecode(response.body) as List)
          .map((e) => Product.fromJson(e))
          .toList();
      // this.list = [...list];
    } else {
      throw Exception('Failed to load Product');
    }
  }

  Future<void> getProductDetail(String id) async {
    final body = jsonEncode({
      "idProduct": id,
    });
    final http.Response response = await http.post(
      Uri.parse(Link.getProductDetail),
      body: body,
    );

    if (response.statusCode == 200) {
      detail = ProductDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Product');
    }
  }

  Future<void> deleteProduct(String id) async {
    final body = jsonEncode({
      "id": id,
    });

    final http.Response response = await http.post(
      Uri.parse(Link.deleteProduct),
      body: body,
    );

    if (response.statusCode == 200) {
      list = (jsonDecode(response.body) as List)
          .map((e) => Product.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load Product');
    }
  }

  Future<void> addProduct({
    required ProductDetail detail,
    required int idProductType,
    required int idTradeMark,
    required List<int>? image,
    required String imageName,
  }) async {
    http.MultipartRequest request = http.MultipartRequest(
      "POST",
      Uri.parse(getLink(idProductType: idProductType)),
    );
    request.fields['idProductType'] = idProductType.toString();
    request.fields['stock'] = detail.stock!;
    request.fields['filename'] = getFileName(idProductType: idProductType);
    request.fields['idTradeMark'] = idTradeMark.toString();
    request.fields['price'] = detail.price!;
    request.fields['name'] = detail.name!;
    request.fields['trademark'] = detail.trademark!;
    request.fields['ram'] = detail.ram!;
    request.fields['bus'] = detail.bus!;
    request.fields['chuanRam'] = detail.chuanRam!;

    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        image!,
        contentType: MediaType('application', 'json'),
        filename: imageName,
      ),
    );
    request.send().then((res) {
      if (res.statusCode == 200) {
        print("file upload success");
      } else {
        print('error');
      }
    });
  }

  Future<void> updateProduct(
    ProductDetail detail,
    int idProductType,
    int idTradeMark,
  ) async {
    late String body;

    switch (idProductType) {
      case 1:
        // body = jsonEncode({
        //   "":
        // });
        break;
      case 2:
        body = jsonEncode({
          "id": detail.id,
          "idProductType": idProductType.toString(),
          "idTradeMark": idTradeMark.toString(),
          "name": detail.name,
          "price": detail.price,
          "trademark": detail.trademark,
          "stock": detail.stock,
        });
        break;
      default:
    }

    final http.Response response = await http.post(
      Uri.parse(Link.deleteProduct),
      body: body,
    );

    if (response.statusCode == 200) {
      list = (jsonDecode(response.body) as List)
          .map((e) => Product.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load Product');
    }
  }
}
