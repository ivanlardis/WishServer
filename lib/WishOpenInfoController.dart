import 'package:aqueduct/aqueduct.dart';
import 'package:wish_server/model/User.dart';
import 'package:wish_server/model/Wish.dart';
import 'package:wish_server/model/WishFull.dart';
import 'package:wish_server/model/WishInfo.dart';
import 'package:wish_server/model/WishOpenInfo.dart';

class WishOpenInfoController extends ResourceController {
  WishOpenInfoController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getWishInfo() async {
    final wishs = await Query<Wish>(context).fetch();

    final users = await Query<User>(context).fetch();
    var wishsFull = new List<WishFull>();
    for (var wishBuf in wishs) {
      for (var userBuf in users) {
        if (wishBuf.userId == userBuf.id) {
          wishsFull.add(WishFull(
              timeAfterLastPress: wishBuf.timeAfterLastPress,
              countCons: wishBuf.countCons,
              countProps: wishBuf.countProps,
              id: wishBuf.userId,
              userName: userBuf.username));
        }
      }
    }

    final List<Wish> listWish = await Query<Wish>(context).fetch();

    var countAllProps =
        listWish.map((wish) => wish.countProps).reduce((a, b) => a + b);
    var countAllCons =
        listWish.map((wish) => wish.countCons).reduce((a, b) => a + b);

    WishOpenInfo wishInfo = WishOpenInfo(
        countAllCons: countAllCons,
        wishsFull: wishsFull,
        countAllProps: countAllProps);

    return Response.ok(wishInfo.toJson());
  }
}
