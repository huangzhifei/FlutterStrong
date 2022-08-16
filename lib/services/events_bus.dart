import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

// 购物车广播
class ProductContentEvent {
  String content;
  ProductContentEvent(this.content);
}

// 用户中心广播
class UserEvent {
  String content;
  UserEvent(this.content);
}

// 增加地址广播
class AddressEvent {
  String content;
  AddressEvent(this.content);
}

// 默认地址广播
class DefaultAddressEvent {
  String content;
  DefaultAddressEvent(this.content);
}

// 我的订单列表广播
class OrderListEvent {
  String content;
  OrderListEvent(this.content);
}