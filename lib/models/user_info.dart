/// name : ""
/// phone : ""

class UserInfo {
  late String name;
  late String phone;

  static UserInfo? fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) return null;
    UserInfo userInfoBean = UserInfo();
    userInfoBean.name = map['name'];
    userInfoBean.phone = map['phone'];
    return userInfoBean;
  }

  Map toJson() => {
    "name": name,
    "phone": phone,
  };
}

