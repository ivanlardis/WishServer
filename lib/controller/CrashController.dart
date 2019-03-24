import 'package:aqueduct/aqueduct.dart';
import 'package:wish_server/model/PulseMetric.dart';
import 'package:wish_server/model/User.dart';
import 'package:wish_server/model/UserDevice.dart';
import 'package:wish_server/model/Wish.dart';
import 'package:wish_server/model/WishFull.dart';
import 'package:wish_server/model/WishInfo.dart';
import 'package:wish_server/model/WishOpenInfo.dart';

class CrashController extends ResourceController {

  CrashController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getWishInfo() async {


      var query = Query<Wish>(context)
        ..where((u) => u.userId).notEqualTo(-1);

      int wishDeleted = await query.delete();

      var query1 = Query<User>(context)
        ..where((u) => u.id).notEqualTo(-1);

      int usersDeleted = await query1.delete();


      var query2 = Query<UserDevice>(context)
        ..where((u) => u.id).notEqualTo(-1);

      var query3 = Query<PulseMetric>(context)
        ..where((u) => u.id).notEqualTo(-1);

      int usersDeleted32 = await query3.delete();
      int usersDeleted1 = await query2.delete();
      return Response.ok("OK");

  }
}
