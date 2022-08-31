
import 'package:flutter_strong/models/address_model.dart';

extension AddressModelEnName on AddressModel {
  String getEnName () {
    return name + area;
  }
}