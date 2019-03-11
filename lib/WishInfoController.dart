import 'package:aqueduct/aqueduct.dart';
import 'package:wish_server/model/Wish.dart';

class WishInfoController extends ResourceController {
  WishInfoController(this.context);

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


    final List<Wish> listWish = await Query<Wish>(context).fetch();

    var countAllProps =  listWish.map((wish)=>wish.countProps).reduce((a,b)=> a+b);
    var countAllCons =  listWish.map((wish)=>wish.countCons).reduce((a,b)=> a+b);






    return Response.ok({
      "countUserCons": wish.countCons,
      "countAllProps": countAllProps,
      "countUserProps": wish.countProps,
      "countAllCons": countAllCons,
    });
  }
}
