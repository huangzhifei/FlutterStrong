class ProductContentMainModel {
  late ProductContentMainItem? result;

  ProductContentMainModel(this.result);

  // tyep: 1 为手动测试数据
  ProductContentMainModel.fromJson(Map<String, dynamic> json, int type) {
    if (type == 1) {
      // 构造测试数据
      result = _generateDemoData(json["id"]);
    } else {
      if (json["result"] != null) {
        result = ProductContentMainItem.fromJson(json["result"]);
      } else {
        result = null;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["result"] = result!.toJson();
    return data;
  }

  ProductContentMainItem? _generateDemoData(valueId) {
    ProductContentMainItem temp = ProductContentMainItem();
    temp.sId = valueId;
    temp.title = "电脑";
    temp.cid = valueId;
    temp.price = 88;
    temp.oldPrice = 68;
    temp.isBest = true;
    temp.isHot = true;
    temp.pic = "https://img1.360buyimg.com/pop/jfs/t1/86679/17/30090/41666/629f250aEa6126d60/98e52dfec720adee.jpg";
    temp.content = "本商品质保周期为1年质保，在此时间范围内可提交维修申请，具体请以厂家服务为准。 本产品提供上门安装调试、提供上门检测"
        "和维修等售后服务，自收到商品之日起，如您所购买家电商品出现质量问题，请先联系厂家进行检测，凭厂商提供的故障检测证明"
        "您可以查询本品牌在各地售后服务中心的联系方式";
    temp.cname = "家用电器";
    temp.subTitle = "本商品质保周期为1年质保，在此时间范围内可提交维修申请，具体请以厂家服务为准。";
    temp.saleCount = 0.7;
    temp.count = 3;
    temp.selectedAttr = "自收到商品之日起，如您所购买家电商品出现质量问题，请先联系厂家进行检测，凭厂商提供的故障检测证明";

    {
      temp.attr = <Attr>[];
      {
        Attr attr = Attr();
        attr.cate = "尺寸";
        attr.list = ["电脑", "手机"];
        attr.attrList = [{"checked": false}, {"title": "xl"}];
        temp.attr!.add(attr);
      }
      {
        Attr attr = Attr();
        attr.cate = "颜色";
        attr.list = ["红色", "黑色"];
        attr.attrList = [{"checked": true}, {"title": "xxl"}];
        temp.attr!.add(attr);
      }
    }

    return temp;
  }

}

class ProductContentMainItem {
  String? sId;
  String title = "";
  String? cid;
  double price = 0;
  double oldPrice = 0;
  Object? isBest;
  Object? isHot;
  Object? isNew;
  String? status;
  String pic = "";
  String? content;
  String? cname;
  List<Attr>? attr;
  String? subTitle;
  Object? saleCount;
  bool checked = false;
  // 新增
  int count = 0;
  String selectedAttr = "";

  ProductContentMainItem({
    this.sId,
    this.title = "",
    this.cid,
    this.price = 0,
    this.oldPrice = 0,
    this.isBest,
    this.isHot,
    this.isNew,
    this.status,
    this.pic = "",
    this.content,
    this.cname,
    this.attr,
    this.subTitle,
    this.saleCount,
    this.count = 0,
    this.checked = false,
    this.selectedAttr = "",
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
  List<Map>? attrList;
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
