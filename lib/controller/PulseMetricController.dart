import 'package:aqueduct/aqueduct.dart';
import 'package:wish_server/model/PulseMetric.dart';
import 'package:wish_server/model/UserDevice.dart';
import 'package:wish_server/model/Wish.dart';

class PulseMetricController extends ResourceController {
  PulseMetricController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllHeroes() async {


    final wishQuery = Query<PulseMetric>(context);

    var wish = await wishQuery.fetch();


    return Response.ok(wish);
  }



  @Operation.post()
  Future<Response> createHero() async {

    final Map<String, dynamic> body = await request.body.decode();

    print(body);


    final wishQuery = Query<PulseMetric>(context)
      ..where((h) => h.mac).equalTo( body['mac'] as String);

    final wish = await wishQuery.fetchOne();

    if (wish == null) {
      print("wish == null");
      final query = Query<PulseMetric>(context)
        ..values.mac = body['mac'] as String
        ..values.min =body['pulse'] as int
        ..values.max = body['pulse'] as int
        ..values.pulse = body['pulse'] as int
        ..values.time = DateTime.now()
        ..canModifyAllInstances = true;
      final insertedHero = await query.insert();
      return Response.ok(insertedHero);
    } else {

//
//

    var pulse =body['pulse'] as int;
    var max =wish.max;

    if(pulse > max){
      max = pulse;
    }
    var min =wish.min;

    if(pulse < min){
      min = pulse;
    }
      final query = Query<PulseMetric>(context)
        ..where((h) => h.id).equalTo(wish.id)
        ..values.id = wish.id
        ..values.min = min
        ..values.max = max
        ..values.mac = body['mac'] as String
        ..values.pulse = body['pulse'] as int
        ..values.time = DateTime.now()
        ..canModifyAllInstances = true;


      final insertedHero = await query.update();
      return Response.ok(insertedHero);
    }
  }
}
