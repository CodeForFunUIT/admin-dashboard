import 'dart:convert';

import 'package:flutter_web_dashbard/constants/link.dart';
import 'package:flutter_web_dashbard/models/order.dart';
import 'package:flutter_web_dashbard/models/order_detai.dart';
import 'package:flutter_web_dashbard/models/product.dart';
import 'package:flutter_web_dashbard/models/productDetail.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();

  final List<Product> _products = [];
  List<Product> get products => _products;
  set products(List<Product> data) {
    products.clear();
    for (var e in data) {
      products.add(e);
    }
    update();
  }

  List<Order> _orders = [];
  List<Order> get orders => _orders;
  set orders(List<Order> data) {
    _orders = [...data];
    update();
  }

  List<OrderDetail> _orderDetail = [];
  List<OrderDetail> get orderDetail => _orderDetail;
  set orderDetail(List<OrderDetail> data) {
    _orderDetail = [...data];
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

  bool _statusAddProduct = false;
  bool get statusAddProduct => _statusAddProduct;
  set statusAddProduct(bool data) {
    _statusAddProduct = data;
    update();
  }

  bool isFirst = true;

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
  int get salaryLast30Days => _orders
      .where(
        (e) =>
            date(e).compareTo(
                  DateTime(
                    DateTime.now().year,
                    DateTime.now().month - 1,
                    DateTime.now().day,
                  ),
                ) >=
                0 &&
            date(e).compareTo(
                  DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day + 1,
                  ),
                ) <
                0 &&
            e.status == "approve",
      )
      .fold(0, (pre, e) => pre + int.parse(e.price!));
  int get salaryLast12Months => _orders
      .where(
        (e) =>
            date(e).compareTo(
                  DateTime(
                    DateTime.now().year - 1,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
                ) >=
                0 &&
            date(e).compareTo(
                  DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day + 1,
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
    bool isAdd = true,
  }) {
    switch (idProductType) {
      case 1:
        return isAdd ? Link.addCpu : Link.updateCpu;
      case 2:
        return isAdd ? Link.addRam : Link.updateRam;
      case 6:
        return isAdd ? Link.addLaptop : Link.updateLaptop;

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
      products = (jsonDecode(response.body) as List)
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

  Future<void> getOrderDetail({required int orderId}) async {
    final body = jsonEncode({"idOrder": orderId});
    final http.Response response = await http.post(
      Uri.parse(Link.getOrderDetail),
      body: body,
    );

    if (response.statusCode == 200) {
      orderDetail = (jsonDecode(response.body) as List)
          .map((e) => OrderDetail.fromJson(e))
          .toList();
      print(orderDetail[0].idOrder);
    } else {
      throw Exception('Failed to load order Detail');
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
      products = (jsonDecode(response.body) as List)
          .map((e) => Product.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load Product');
    }
  }

  String initIdTradeMark({required int idProductType}) {
    switch (idProductType) {
      case 1:
        return '8';
      case 2:
        return '1';
      case 6:
        return '4';
      default:
        return '';
    }
  }

  String initNameTradeMark({required int idProductType}) {
    switch (idProductType) {
      case 1:
        return 'Intel';
      case 2:
        return 'KingSton';
      case 6:
        return 'HP';
      default:
        return '';
    }
  }

  Future<void> addProduct({
    required ProductDetail detail,
    required int idProductType,
    required List<int>? image,
  }) async {
    // print(image);
    http.MultipartRequest request = http.MultipartRequest(
      "POST",
      Uri.parse(getLink(idProductType: idProductType)),
    );

    request.fields['idProductType'] = idProductType.toString();
    request.fields['stock'] = detail.stock!;
    request.fields['filename'] = getFileName(idProductType: idProductType);
    request.fields['price'] = detail.price!;
    request.fields['name'] = detail.name!;
    if (detail.idTradeMark == null) {
      request.fields['idTradeMark'] =
          initIdTradeMark(idProductType: idProductType);
    } else {
      request.fields['idTradeMark'] = detail.idTradeMark!;
    }
    if (detail.trademark == null) {
      request.fields['trademark'] =
          initNameTradeMark(idProductType: idProductType);
    } else {
      request.fields['trademark'] = detail.trademark!;
    }

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
      request.fields['trongLuong'] = detail.trongLuong!;
    }

    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        image!,
        contentType: MediaType('application', 'json'),
        filename: detail.imageName,
        // check lai image name
      ),
    );

    request.send().then((res) {
      print(res.reasonPhrase);
      if (res.statusCode == 200) {
        statusAddProduct = true;
      } else {
        statusAddProduct = false;
      }
    }).onError((error, stackTrace) async {
      print(error.toString());
    });
  }

  Future<void> updateProduct(
    ProductDetail detail,
    int idProductType,
    int idTradeMark,
  ) async {
    late String body;

    switch (idProductType) {
      //cpu
      case 1:
        body = jsonEncode({
          "id": detail.id,
          "idProductType": idProductType.toString(),
          "idTradeMark": idTradeMark.toString(),
          "name": detail.name,
          "price": int.parse(detail.price!),
          "trademark": detail.trademark,
          "stock": detail.stock,
          "soNhan": detail.soNhan,
          "soLuong": detail.soLuong,
          "xungNhipCoBan": detail.xungNhipCoBan,
          "xungNhipToiDa": detail.xungNhipToiDa,
          "theHe": detail.theHe,
          "doHoa": detail.doHoa,
          "tienTrinh": detail.tienTrinh,
        });
        break;
      //ram
      case 2:
        body = jsonEncode({
          "id": detail.id,
          "idProductType": idProductType.toString(),
          "idTradeMark": idTradeMark.toString(),
          "name": detail.name,
          "price": int.parse(detail.price!),
          "trademark": detail.trademark,
          "stock": detail.stock,
          "ram": detail.ram,
          "chuanRam": detail.chuanRam,
          "bus": detail.bus,
        });
        break;
      case 6:
        body = jsonEncode({
          "id": detail.id,
          "idProductType": idProductType.toString(),
          "idTradeMark": idTradeMark.toString(),
          "name": detail.name,
          "price": int.parse(detail.price!),
          "trademark": detail.trademark,
          "stock": detail.stock,
          "ramDetail": detail.ramDetail,
          "oCung": detail.oCung,
          "manHinh": detail.manHinh,
          "trongLuong": detail.trongLuong,
          "cpu": detail.cpu,
        });
        break;
      default:
    }

    // print('id ${detail.id}');
    // print('idProductType ${idProductType.toString()}');
    // print('idTradeMark ${idTradeMark.toString}');
    // print('name ${detail.name}');
    // print('price ${int.parse(detail.price!)}');
    // print('trademark ${detail.trademark}');
    // print('stock ${detail.stock}');
    // print('ramDetail ${detail.ramDetail}');
    // print(';oCung ${detail.oCung}');
    // print('manHinh ${detail.manHinh}');
    // print('trongLuong ${detail.trongLuong}');
    // print('cpu ${detail.cpu}');
    print(getLink(idProductType: idProductType, isAdd: false));
    print(idProductType);
    print(idTradeMark);
    print(detail.toString());
    final http.Response response = await http.post(
      Uri.parse(getLink(idProductType: idProductType, isAdd: false)),
      body: body,
    );

    if (response.statusCode == 200) {
      products = (jsonDecode(response.body) as List)
          .map((e) => Product.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load Product');
    }
  }
}
