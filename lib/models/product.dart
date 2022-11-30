class Product {
  String? id;
  String? idProductType;
  String? idTradeMark;
  String? name;
  String? price;
  String? tradeMark;
  String? image;

  Product({
    this.id,
    this.idProductType,
    this.idTradeMark,
    this.name,
    this.price,
    this.tradeMark,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        idProductType: json['idProductType'],
        idTradeMark: json['idTradeMark'],
        tradeMark: json['tradeMark'],
        image: json["image"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "idProductType": idProductType,
        "tradeMark": tradeMark,
        "idTradeMark": idTradeMark,
      };
}
