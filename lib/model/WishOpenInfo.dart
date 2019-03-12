import 'package:wish_server/model/WishFull.dart';

class WishOpenInfo {
  WishOpenInfo({this.countAllProps, this.wishsFull, this.countAllCons});

  Map<String, dynamic> toJson() => {
        'countAllProps': countAllProps,
        'countAllCons': countAllCons,
        'wishsFull': wishsFull,
      };
  var wishsFull = new List<WishFull>();
  int countAllProps = 0;
  int countAllCons = 0;
}
