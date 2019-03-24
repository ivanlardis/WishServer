import 'package:aqueduct/aqueduct.dart';
import 'package:wish_server/model/PulseMetric.dart';
import 'package:wish_server/model/UserDevice.dart';
import 'package:wish_server/model/Wish.dart';

class UserDeviceController extends ResourceController {
  UserDeviceController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllHeroes() async {


    final wishQuery = Query<UserDevice>(context);

    var wish = await wishQuery.fetch();


    return Response.ok(wish);
  }

  @Operation.post()
  Future<Response> createHero() async {

    final Map<String, dynamic> body = await request.body.decode();

    print(body);


    final wishQuery = Query<UserDevice>(context)
      ..where((h) => h.mac).equalTo( body['mac'] as String);

    final wish = await wishQuery.fetchOne();

    if (wish == null) {
      print("wish == null");
      final query = Query<UserDevice>(context)
        ..values.mac = body['mac'] as String
        ..values.name = body['name'] as String
        ..values.changed = DateTime.now()
        ..values.active = body['active'] as bool
        ..canModifyAllInstances = true;
      final insertedHero = await query.insert();


      var query3 = Query<PulseMetric>(context)
        ..where((u) => u.mac).equalTo( body['mac'] as String);

      int usersDeleted32 = await query3.delete();


      return Response.ok(insertedHero);
    } else {

//
    print(DateTime.now().millisecondsSinceEpoch);
//
      final query = Query<UserDevice>(context)
        ..where((h) => h.id).equalTo(wish.id)
        ..values.id = wish.id
        ..values.mac = body['mac'] as String
        ..values.name = body['name'] as String
        ..values.changed =  DateTime.now()
        ..values.active =body['active'] as bool;


      final insertedHero = await query.update();



      var query3 = Query<PulseMetric>(context)
        ..where((u) => u.mac).equalTo( body['mac'] as String);

      int usersDeleted32 = await query3.delete();

      return Response.ok(insertedHero);
    }
  }
}
