import 'dart:convert';

import 'package:flutter_web_dashbard/constants/link.dart';
import 'package:flutter_web_dashbard/models/order.dart';
import 'package:flutter_web_dashbard/models/product.dart';
import 'package:flutter_web_dashbard/models/productDetail.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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

  List<Order> _orders = [];
  List<Order> get orders => _orders;
  set orders(List<Order> data) {
    _orders = [...data];
    update();
  }

  int get lengthOrderProgress =>
      _orders.where((e) => e.status == 'pending').length;
  int get lengthOrderApprove =>
      _orders.where((e) => e.status == 'approve').length;
  int get lengthOrderDecline =>
      _orders.where((e) => e.status == 'decline').length;
  int get lengthOrderOutDate =>
      _orders.where((e) => e.status == 'outDate').length;

  DateTime date(Order order) {
    String day = order.date!.split('/').first;
    String month = order.date!.split('/')[1];
    String year = order.date!.split('/')[2];
    return DateTime(int.parse(year), int.parse(month), int.parse(day));
  }

  int get salaryToday => _orders
      .where(
        (e) =>
            int.parse(e.date!.split('/').first) == DateTime.now().day &&
            e.status == "approve",
      )
      .fold(0, (pre, e) => pre + int.parse(e.price!));
  int get salaryLast7Day => _orders
      .where(
        (e) =>
            date(e).compareTo(
                  DateTime.now().subtract(
                    const Duration(days: 7),
                  ),
                ) >
                0 &&
            e.status == "approve",
      )
      .fold(0, (pre, e) => pre + int.parse(e.price!));

  int get salaryThisMonth => _orders
      .where(
        (e) =>
            date(e).compareTo(
                  DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    1,
                  ),
                ) >=
                0 &&
            date(e).compareTo(
                  DateTime(
                    DateTime.now().year,
                    DateTime.now().month + 1,
                    1,
                  ),
                ) <
                0 &&
            e.status == "approve",
      )
      .fold(0, (pre, e) => pre + int.parse(e.price!));

  int get salaryLastMonth => _orders
      .where(
        (e) =>
            date(e).compareTo(
                  DateTime(
                    DateTime.now().year,
                    DateTime.now().month - 1,
                    1,
                  ),
                ) >=
                0 &&
            date(e).compareTo(
                  DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    1,
                  ),
                ) <
                0 &&
            e.status == "approve",
      )
      .fold(0, (pre, e) => pre + int.parse(e.price!));
  int get salaryLast2Month => _orders
      .where(
        (e) =>
            date(e).compareTo(
                  DateTime(
                    DateTime.now().year,
                    DateTime.now().month - 2,
                    1,
                  ),
                ) >=
                0 &&
            date(e).compareTo(
                  DateTime(
                    DateTime.now().year,
                    DateTime.now().month - 1,
                    1,
                  ),
                ) <
                0 &&
            e.status == "approve",
      )
      .fold(0, (pre, e) => pre + int.parse(e.price!));
  int get salaryLast3Month => _orders
      .where(
        (e) =>
            date(e).compareTo(
                  DateTime(
                    DateTime.now().year,
                    DateTime.now().month - 3,
                    1,
                  ),
                ) >=
                0 &&
            date(e).compareTo(
                  DateTime(
                    DateTime.now().year,
                    DateTime.now().month - 2,
                    1,
                  ),
                ) <
                0 &&
            e.status == "approve",
      )
      .fold(0, (pre, e) => pre + int.parse(e.price!));

  int get salaryLastYear => _orders
      .where(
        (e) =>
            date(e).compareTo(
                  DateTime(
                    DateTime.now().year - 1,
                    DateTime.now().month,
                    1,
                  ),
                ) >=
                0 &&
            date(e).compareTo(
                  DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    1,
                  ),
                ) <
                0 &&
            e.status == "approve",
      )
      .fold(0, (pre, e) => pre + int.parse(e.price!));

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

  Future<void> getOrder() async {
    final http.Response response = await http.post(Uri.parse(Link.getOrder));

    if (response.statusCode == 200) {
      orders = (jsonDecode(response.body) as List)
          .map((e) => Order.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load Product');
    }
  }

  Future<void> updateOrder({
    required Order order,
    required String status,
    // approve
    // decline
    //outDate
  }) async {
    final body = {
      "id": int.parse(order.id!),
      "idUser": int.parse(order.idUser!),
      "price": order.price,
      "status": status,
      "date": order.date,
    };
    final http.Response response = await http.post(
      Uri.parse(Link.updateOrder),
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      orders = (jsonDecode(response.body) as List)
          .map((e) => Order.fromJson(e))
          .toList();
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
    request.fields['price'] = detail.price!;
    request.fields['name'] = detail.name!;
    request.fields['idTradeMark'] = idTradeMark.toString();
    request.fields['trademark'] = detail.trademark!;

    if (idProductType == 2) {
      request.fields['ram'] = detail.ram!;
      request.fields['bus'] = detail.bus!;
      request.fields['chuanRam'] = detail.chuanRam!;
    } else if (idProductType == 1) {
      request.fields['doHoa'] = detail.doHoa!;
      request.fields['xungNhipCoBan'] = detail.xungNhipCoBan!;
      request.fields['xungNhipToiDa'] = detail.xungNhipToiDa!;
      request.fields['theHe'] = detail.theHe!;
      request.fields['tienTrinh'] = detail.tienTrinh!;
      request.fields['soNhan'] = detail.soNhan!;
      request.fields['soLuong'] = detail.soLuong!;
    } else if (idProductType == 6) {
      request.fields['ramDetail'] = detail.ramDetail!;
      request.fields['cpu'] = detail.cpu!;
      request.fields['manHinh'] = detail.manHinh!;
      request.fields['oCung'] = detail.oCung!;
    }

    // request.files.add(
    //   http.MultipartFile.fromBytes(
    //     'image',
    //     image!,
    //     contentType: MediaType('application', 'json'),
    //     filename: imageName,
    //   ),
    // );

    print(request);

    // request.send().then((res) {
    //   if (res.statusCode == 200) {
    //     print("file upload success");
    //   } else {
    //     print('error');
    //   }
    // });
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
