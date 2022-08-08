
class ProductListModel {
  late List<ProductListItemModel> result;

  ProductListModel({required this.result});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    List responseResult = json["result"];
    result = <ProductListItemModel>[];
    if (responseResult != null && responseResult.isNotEmpty) {
      // result = <ProductListItemModel>[];
      for (var e in responseResult) {
        result.add(ProductListItemModel.fromJson(e));
      }
    } else {
      // 说明数据为空，人为造点数据
      result = generateDemoData();
    }
  }

  List<ProductListItemModel> generateDemoData() {
    List<ProductListItemModel> data = [];
    {
      ProductListItemModel item1 = ProductListItemModel();
      item1.sId = "001";
      item1.title = "测试数据1，笔记本电脑大促销！";
      item1.cid = "xx_001";
      item1.price = "100";
      item1.oldPrice = "88";
      item1.pic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item1.sPic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      data.add(item1);
    }

    {
      ProductListItemModel item2 = ProductListItemModel();
      item2.sId = "002";
      item2.title = "测试数据2，笔记本电脑大促销！";
      item2.cid = "xx_002";
      item2.price = "134";
      item2.oldPrice = "100";
      item2.pic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item2.sPic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      data.add(item2);
    }

    {
      ProductListItemModel item3 = ProductListItemModel();
      item3.sId = "003";
      item3.title = "测试数据3，笔记本电脑大促销！";
      item3.cid = "xx_003";
      item3.price = "198";
      item3.oldPrice = "188";
      item3.pic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item3.sPic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      data.add(item3);
    }

    {
      ProductListItemModel item4 = ProductListItemModel();
      item4.sId = "004";
      item4.title = "测试数据4，笔记本电脑大促销！";
      item4.cid = "xx_004";
      item4.price = "127";
      item4.oldPrice = "98";
      item4.pic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item4.sPic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      data.add(item4);
    }

    {
      ProductListItemModel item5 = ProductListItemModel();
      item5.sId = "005";
      item5.title = "测试数据5，笔记本电脑大促销！";
      item5.cid = "xx_005";
      item5.price = "87";
      item5.oldPrice = "56";
      item5.pic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item5.sPic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      data.add(item5);
    }

    {
      ProductListItemModel item6 = ProductListItemModel();
      item6.sId = "006";
      item6.title = "测试数据6，笔记本电脑大促销！";
      item6.cid = "xx_006";
      item6.price = "128";
      item6.oldPrice = "78";
      item6.pic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item6.sPic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      data.add(item6);
    }

    {
      ProductListItemModel item7 = ProductListItemModel();
      item7.sId = "007";
      item7.title = "测试数据7，笔记本电脑大促销！";
      item7.cid = "xx_007";
      item7.price = "130";
      item7.oldPrice = "90";
      item7.pic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item7.sPic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      data.add(item7);
    }

    {
      ProductListItemModel item8 = ProductListItemModel();
      item8.sId = "008";
      item8.title = "测试数据8，笔记本电脑大促销！";
      item8.cid = "xx_008";
      item8.price = "1320";
      item8.oldPrice = "1188";
      item8.pic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item8.sPic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      data.add(item8);
    }

    {
      ProductListItemModel item9 = ProductListItemModel();
      item9.sId = "009";
      item9.title = "测试数据9，笔记本电脑大促销！";
      item9.cid = "xx_009";
      item9.price = "1500";
      item9.oldPrice = "1388";
      item9.pic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item9.sPic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      data.add(item9);
    }

    {
      ProductListItemModel item10 = ProductListItemModel();
      item10.sId = "010";
      item10.title = "测试数据10，笔记本电脑大促销！";
      item10.cid = "xx_010";
      item10.price = "1200";
      item10.oldPrice = "188";
      item10.pic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item10.sPic =
      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      data.add(item10);
    }

    return data;
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data["result"] = result.map((e) => e.toJson()).toList();
    return data;
  }

}

class ProductListItemModel {
  late String sId;
  late String title;
  late String cid;
  late String price;
  late String oldPrice;
  late String pic;
  late String sPic;

  ProductListItemModel({
    String? sId,
    String? title,
    String? cid,
    Object? price,
    String? oldPrice,
    String? pic,
    String? sPic
  });

  ProductListItemModel.fromJson(json) {
    sId = json["_id"];
    title = json["title"];
    cid = json["cid"];
    price = json["price"];
    oldPrice = json["old_price"];
    pic = json["pic"];
    sPic = json["s_pic"];
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data["_id"] = sId;
    data["title"] = title;
    data["cid"] = cid;
    data["price"] = price;
    data["old_price"] = oldPrice;
    data["pic"] = pic;
    data["s_pic"] = sPic;
    return data;
  }

}