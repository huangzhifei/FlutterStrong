class ProductContentMainModel {
  late ProductContentMainItem? result;

  ProductContentMainModel(this.result);

  ProductContentMainModel.fromJson(Map<String, dynamic> json) {
    if (json["result"] != null) {
      result = ProductContentMainItem.fromJson(json["result"]);
    } else {
      result = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (result != null) {
      data["result"] = result!.toJson();
    }
    return data;
  }

}

class ProductContentMainItem {
  String? sId;
  String? title;
  String? cid;
  Object? price;
  String? oldPrice;
  Object? isBest;
  Object? isHot;
  Object? isNew;
  String? status;
  String? pic;
  String? content;
  String? cname;
  List<Attr>? attr;
  String? subTitle;
  Object? saleCount;

  // 新增
  int? count;
  String? selectedAttr;

  ProductContentMainItem({
    this.sId,
    this.title,
    this.cid,
    this.price,
    this.oldPrice,
    this.isBest,
    this.isHot,
    this.isNew,
    this.status,
    this.pic,
    this.content,
    this.cname,
    this.attr,
    this.subTitle,
    this.saleCount,
    this.count,
    this.selectedAttr,
  });

  ProductContentMainItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    oldPrice = json['old_price'];
    isBest = json['is_best'];
    isHot = json['is_hot'];
    isNew = json['is_new'];
    status = json['status'];
    pic = json['pic'];
    content = json['content'];
    cname = json['cname'];
    if (json['attr'] != null) {
      attr = <Attr>[];
      json['attr'].forEach((v) {
        attr!.add(Attr.fromJson(v));
      });
    }
    subTitle = json['sub_title'];
    saleCount = json['sale_count'];

    // 新增
    count = 1;
    selectedAttr = '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['title'] = title;
    data['cid'] = cid;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['is_best'] = isBest;
    data['is_hot'] = isHot;
    data['is_new'] = isNew;
    data['status'] = status;
    data['pic'] = pic;
    data['content'] = content;
    data['cname'] = cname;
    if (attr != null) {
      data['attr'] = attr!.map((v) => v.toJson()).toList();
    }
    data['sub_title'] = subTitle;
    data['sale_count'] = saleCount;
    return data;
  }
}

class Attr {
  String? cate;
  List<String>? list;

  // 新添加属性，用于添加 check
  late List<Map> attrList;
  Attr({this.cate, this.list});

  Attr.fromJson(Map<String, dynamic> json) {
    cate = json["cate"];
    list = json["list"].cast<String>();
    attrList = [];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["cate"] = cate;
    data["list"] = list;
    return data;
  }
}
