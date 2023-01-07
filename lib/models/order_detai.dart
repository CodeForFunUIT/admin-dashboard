class OrderDetail {
  OrderDetail({
    this.id,
    this.idOrder,
    this.idProduct,
    this.number,
    this.nameProduct,
    this.price,
  });

  String? id;
  String? idOrder;
  String? nameProduct;
  String? price;
  String? idProduct;
  String? number;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        idOrder: json["idOrder"],
        idProduct: json["idProduct"],
        number: json["number"],
        nameProduct: json["nameProduct"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idOrder": idOrder,
        "idProduct": idProduct,
        "number": number,
        "nameProduct": nameProduct,
        "price": price,
      };
  factory OrderDetail.copyWith(OrderDetail? orderDetail) => OrderDetail(
        id: orderDetail?.id,
        idOrder: orderDetail?.idOrder,
        idProduct: orderDetail?.idProduct,
        number: orderDetail?.number,
        nameProduct: orderDetail?.nameProduct,
        price: orderDetail?.price,
      );
}
