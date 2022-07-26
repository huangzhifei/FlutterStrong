class OrderModel {
  bool success = true;
  String message = "";
  List<Result> result = [];

  OrderModel({required this.success, required this.message, required this.result});

  OrderModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    message = json["message"];
    if (json["result"] != null) {
      result = <Result>[];
      for (var item in json["result"]) {
        result.add(item);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["success"] = success;
    data["message"] = message;
    if (result.isNotEmpty) {
      data["result"] = result.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Result {
  late String sId;
  late String uid;
  late String name;
  late String phone;
  late String address;
  late String allPrice;
  late int payStatus;
  late int orderStatus;
  late List<OrderItem> orderItem;

  Result(
      {required this.sId,
      required this.uid,
      required this.name,
      required this.phone,
      required this.address,
      required this.allPrice,
      required this.payStatus,
      required this.orderStatus,
      required this.orderItem});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uid = json['uid'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    allPrice = json['all_price'];
    payStatus = json['pay_status'];
    orderStatus = json['order_status'];
    if (json['order_item'] != null) {
      orderItem = <OrderItem>[];
      json['order_item'].forEach((v) {
        orderItem.add(OrderItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['uid'] = uid;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['all_price'] = allPrice;
    data['pay_status'] = payStatus;
    data['order_status'] = orderStatus;
    data['order_item'] = orderItem.map((v) => v.toJson()).toList();
    return data;
  }
}

class OrderItem {
  late String sId;
  late String orderId;
  late String productTitle;
  late String productId;
  late int productPrice;
  late String productImg;
  late int productCount;
  late String selectedAttr;
  late int addTime;

  OrderItem(
      {required this.sId,
      required this.orderId,
      required this.productTitle,
      required this.productId,
      required this.productPrice,
      required this.productImg,
      required this.productCount,
      required this.selectedAttr,
      required this.addTime});

  OrderItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderId = json['order_id'];
    productTitle = json['product_title'];
    productId = json['product_id'];
    productPrice = json['product_price'];
    productImg = json['product_img'];
    productCount = json['product_count'];
    selectedAttr = json['selected_attr'];
    addTime = json['add_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['order_id'] = orderId;
    data['product_title'] = productTitle;
    data['product_id'] = productId;
    data['product_price'] = productPrice;
    data['product_img'] = productImg;
    data['product_count'] = productCount;
    data['selected_attr'] = selectedAttr;
    data['add_time'] = addTime;
    return data;
  }
}
