import 'package:aqueduct/aqueduct.dart';
import 'package:wish_server/persistence/DBModels.dart';


class WishController extends ResourceController {

  WishController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllHeroes() async {

    print("get my");
    final wishQuery = Query<Wish>(context);
    final wishes = await wishQuery.fetch();
    return Response.ok(wishes);
  }

  @Operation.post()
  Future<Response> createHero() async {
    print("post my");
    final Map<String, dynamic> body = await request.body.decode();
    print("post my1");
    print(body);
    final query = Query<Wish>(context)
      ..values.value = body['value'] as int
      ..values.time = body['time'] as int
      ..values.timeAfterLastPress = body['timeAfterLastPress'] as int;

    final insertedHero = await query.insert();

    return Response.ok(insertedHero);
  }


}