// To parse this JSON data, do
//
//     final productDetail = productDetailFromJson(jsonString);

import 'dart:convert';

ProductDetail productDetailFromJson(String str) =>
    ProductDetail.fromJson(json.decode(str));

String productDetailToJson(ProductDetail data) => json.encode(data.toJson());

class ProductDetail {
  ProductDetail({
    this.id,
    this.image,
    this.name,
    this.price,
    this.trademark,
    this.idTradeMark,
    this.stock,
    this.soNhan,
    this.soLuong,
    this.xungNhipCoBan,
    this.xungNhipToiDa,
    this.theHe,
    this.doHoa,
    this.tienTrinh,
    this.ram,
    this.chuanRam,
    this.bus,
    this.ramDetail,
    this.oCung,
    this.manHinh,
    this.trongLuong,
    this.cpu,
    this.imageName,
  });

  String? id;
  String? image;
  String? name;
  String? price;
  String? trademark;
  String? idTradeMark;
  String? stock;
  dynamic soNhan;
  dynamic soLuong;
  dynamic xungNhipCoBan;
  dynamic xungNhipToiDa;
  dynamic theHe;
  dynamic doHoa;
  dynamic tienTrinh;
  String? ram;
  String? chuanRam;
  String? bus;
  dynamic ramDetail;
  dynamic oCung;
  dynamic manHinh;
  dynamic trongLuong;
  String? cpu;
  String? imageName;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        price: json["price"],
        trademark: json["trademark"],
        stock: json["stock"],
        soNhan: json["soNhan"],
        soLuong: json["soLuong"],
        xungNhipCoBan: json["xungNhipCoBan"],
        xungNhipToiDa: json["xungNhipToiDa"],
        theHe: json["theHe"],
        doHoa: json["doHoa"],
        tienTrinh: json["tienTrinh"],
        ram: json["ram"],
        chuanRam: json["chuanRam"],
        bus: json["bus"],
        ramDetail: json["ramDetail"],
        oCung: json["oCung"],
        manHinh: json["manHinh"],
        trongLuong: json["trongLuong"],
        cpu: json["cpu"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "trademark": trademark,
        "stock": stock,
        "soNhan": soNhan,
        "soLuong": soLuong,
        "xungNhipCoBan": xungNhipCoBan,
        "xungNhipToiDa": xungNhipToiDa,
        "theHe": theHe,
        "doHoa": doHoa,
        "tienTrinh": tienTrinh,
        "ram": ram,
        "chuanRam": chuanRam,
        "bus": bus,
        "ramDetail": ramDetail,
        "oCung": oCung,
        "manHinh": manHinh,
        "trongLuong": trongLuong,
        "cpu": cpu,
      };

  ProductDetail copyWith(ProductDetail detail) => ProductDetail(
        id: detail.id ?? id,
        image: detail.image ?? image,
        name: detail.name ?? name,
        price: detail.price ?? price,
        trademark: detail.trademark ?? trademark,
        stock: detail.stock ?? stock,
        soNhan: detail.soNhan ?? soNhan,
        soLuong: detail.soLuong ?? soLuong,
        xungNhipCoBan: detail.xungNhipCoBan ?? xungNhipCoBan,
        xungNhipToiDa: detail.xungNhipToiDa ?? xungNhipToiDa,
        theHe: detail.theHe ?? theHe,
        doHoa: detail.doHoa ?? doHoa,
        tienTrinh: detail.tienTrinh ?? tienTrinh,
        ram: detail.ram ?? ram,
        chuanRam: detail.chuanRam ?? chuanRam,
        bus: detail.bus ?? bus,
        ramDetail: detail.ramDetail ?? ramDetail,
        oCung: detail.oCung ?? oCung,
        manHinh: detail.manHinh ?? manHinh,
        trongLuong: detail.trongLuong ?? trongLuong,
      );

  @override
  String toString() {
    return "id: $id image: $image name: $name price: $price trademark: $trademark,idTradeMark: $idTradeMark,stock: $stock,soNhan: $soNhan,soLuong: $soLuong,xungNhipCoBan: $xungNhipCoBan,xungNhipToiDa: $xungNhipToiDa,theHe: $theHe,doHoa: $doHoa,tienTrinh: $tienTrinh,ram: $ram,chuanRam: $chuanRam,bus: $bus,ramDetail: $ramDetail,oCung: $oCung,manHinh: $manHinh,trongLuong: $trongLuong,cpu: $cpu,imageName: $imageName";
  }
}
