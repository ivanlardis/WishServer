import 'package:aqueduct/aqueduct.dart';
import 'package:wish_server/persistence/DBModels.dart';

class WishInfoController extends ResourceController {
  WishInfoController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllHeroes() async {
    final wishQuery = Query<Wish>(context);
    final List<Wish> wishes = await wishQuery.fetch();


    return Response.ok({
      "wishCountUserCons":    wishes.length,
      "wishCountAllProps":   wishes.length,
      "wishCountUserProps":   wishes.length,
      "wishCountAllCons":   wishes.length,



    });
  }



}


