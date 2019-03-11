import 'package:aqueduct/aqueduct.dart';
import 'package:wish_server/model/User.dart';
import 'package:wish_server/model/Wish.dart';
import 'package:wish_server/model/WishFull.dart';
import 'package:wish_server/model/WishInfo.dart';

class WishInfoController extends ResourceController {
  WishInfoController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getWishInfo() async {
    final userId = request.authorization.ownerID;

    final wishQuery = Query<Wish>(context)
      ..where((h) => h.userId).equalTo(userId);

    var wish = await wishQuery.fetchOne();

    if (wish == null) {
      final query = Query<Wish>(context)
        ..values.countCons = 0
        ..values.countProps = 0
        ..values.userId = userId
        ..values.timeAfterLastPress = 0
        ..canModifyAllInstances = true;
      wish = await query.insert();
    }

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

    WishsInfo wishInfo = WishsInfo(
        countAllCons: countAllCons,
        wishsFull: wishsFull,
        ownerId: userId,
        countAllProps: countAllProps,
        countUserCons: wish.countCons,
        countUserProps: wish.countProps);

    return Response.ok(wishInfo.toJson());
  }
}
