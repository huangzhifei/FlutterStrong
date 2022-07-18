
class CateModel {
  List<CateItemModel> result = [];
  CateModel({required this.result});

  CateModel.fromJson(Map<String, dynamic> json, int type) {
    List temp = json["result"];
    result = <CateItemModel>[];
    if (temp.isNotEmpty) {
      for (var element in temp) {
        result.add(CateItemModel.fromJson(element));
      }
    } else {
      // 说明数据为空，人为造点数据
      if (type == 1) {
        // 左侧数据
        result = generateLeftDemoData();
      } else {
        result = generateRightDemoData();
      }
    }
  }

  List<CateItemModel> generateLeftDemoData() {
    List<CateItemModel> data = [];
    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a431";
      item.title = "电脑办公";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "A";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a432";
      item.title = "女装内衣";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "B";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a433";
      item.title = "手机数码";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "C";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a434";
      item.title = "化妆品";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "D";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a45";
      item.title = "箱包";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "E";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a46";
      item.title = "女鞋";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "F";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a47";
      item.title = "汽车用品";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "G";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a48";
      item.title = "酒水饮料";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "H";
      data.add(item);
    }

    return data;
  }

  List<CateItemModel> generateRightDemoData() {
    List<CateItemModel> data = [];
    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a431";
      item.title = "笔记本电脑A";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "A";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a432";
      item.title = "笔记本电脑B";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "B";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a433";
      item.title = "笔记本电脑C";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "C";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a434";
      item.title = "笔记本电脑D";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "D";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a45";
      item.title = "笔记本电脑E";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "E";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a463";
      item.title = "一体机";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "F";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a462";
      item.title = "显示器";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "G";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb07a462";
      item.title = "散热器";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "H";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef44ce1fb0fb07a462";
      item.title = "主板";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "I";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef44cee1fb0fb07a462";
      item.title = "CPU";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "J";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a431";
      item.title = "笔记本电脑A";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "A";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a432";
      item.title = "笔记本电脑B";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "B";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a433";
      item.title = "笔记本电脑C";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "C";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a434";
      item.title = "笔记本电脑D";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "D";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a45";
      item.title = "笔记本电脑E";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "E";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a463";
      item.title = "一体机";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "F";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a462";
      item.title = "显示器";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "G";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb07a462";
      item.title = "散热器";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "H";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef44ce1fb0fb07a462";
      item.title = "主板";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "I";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef44cee1fb0fb07a462";
      item.title = "CPU";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.pid = "12";
      item.sort = "J";
      data.add(item);
    }

    return data;
  }
}

class CateItemModel {
  late String sId;
  late String title;
  late Object status;
  late String pic;
  late String pid;
  late String sort;

  CateItemModel({
    String? sId,
    String? title,
    Object? status,
    String? pic,
    String? pid,
    String? sort
  });

  CateItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    pid = json['pid'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['title'] = title;
    data['status'] = status;
    data['pic'] = pic;
    data['pid'] = pid;
    data['sort'] = sort;
    return data;
  }

}