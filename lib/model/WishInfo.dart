import 'package:wish_server/model/WishFull.dart';

class WishsInfo {
  WishsInfo(
      {this.countUserCons,
        this.countAllProps,
        this.countUserProps,
        this.wishsFull,
        this.ownerId,
        this.countAllCons});

  factory WishsInfo.fromJson(Map<String, dynamic> json) {
    return WishsInfo(
      countUserCons: json['countUserCons'] as int,
      countAllProps: json['countAllProps'] as int,
      countUserProps: json['countUserProps'] as int,
      ownerId: json['ownerId'] as int,
      wishsFull: json['wishsFull'] as List<WishFull>,
      countAllCons: json['countAllCons'] as int,);
  }

  Map<String, dynamic> toJson() => {
    'countUserCons': countUserCons,
    'countAllProps': countAllProps,
    'countUserProps': countUserProps,
    'countAllCons': countAllCons,
    'wishsFull': wishsFull,
    'ownerId': ownerId,
  };
  var wishsFull = new List<WishFull>();
  int countUserCons = 0;
  int countAllProps = 0;
  int countUserProps = 0;
  int countAllCons = 0;
  int ownerId = 0;
}