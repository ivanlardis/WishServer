import 'package:aqueduct/aqueduct.dart';
import 'package:wish_server/model/Wish.dart';

class WishController extends ResourceController {
  WishController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllHeroes() async {


    var userId = 11;
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

    return Response.ok(wish);
  }

  @Operation.post()
  Future<Response> createHero() async {

    final Map<String, dynamic> body = await request.body.decode();

    print(body);

    var userId = 11;

    final wishQuery = Query<Wish>(context)
      ..where((h) => h.userId).equalTo(userId);

    final wish = await wishQuery.fetchOne();

    if (wish == null) {
      print("wish == null");
      final query = Query<Wish>(context)
        ..values.countCons = body['countCons'] as int
        ..values.countProps = body['countProps'] as int
        ..values.userId = userId
        ..values.timeAfterLastPress = body['timeAfterLastPress'] as int
        ..canModifyAllInstances = true;
      final insertedHero = await query.insert();
      return Response.ok(insertedHero);
    } else {

      print("wish != null");
      final query = Query<Wish>(context)
        ..where((h) => h.userId).equalTo(userId)
        ..values.countCons = body['countCons'] as int
        ..values.countProps = body['countProps'] as int
        ..values.userId = userId
        ..values.timeAfterLastPress = body['timeAfterLastPress'] as int
        ..canModifyAllInstances = true;
      final insertedHero = await query.update();
      return Response.ok(insertedHero);
    }
  }
}
