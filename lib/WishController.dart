import 'package:aqueduct/aqueduct.dart';
import 'package:wish_server/persistence/DBModels.dart';


class WishController extends ResourceController {

  WishController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllHeroes() async {
    final wishQuery = Query<Wish>(context);
    final wishes = await wishQuery.fetch();
    return Response.ok(wishes);
  }
  @Operation.post()
  Future<Response> createHero() async {
    final Map<String, dynamic> body = await request.body.decode();
    final query = Query<Wish>(context)
      ..values.value = body['value'] as int
      ..values.time = body['time'] as int;

    final insertedHero = await query.insert();

    return Response.ok(insertedHero);
  }
//  @Operation.get('id')
//  Future<Response> getHeroByID(@Bind.path('id') int id) async {
//    final hero = _heroes.firstWhere((hero) => hero['id'] == id, orElse: () => null);
//
//    if (hero == null) {
//      return Response.notFound();
//    }
//
//    return Response.ok(hero);
//  }

}