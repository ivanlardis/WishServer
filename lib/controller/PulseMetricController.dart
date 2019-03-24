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



      final query = Query<PulseMetric>(context)
        ..values.mac = body['mac'] as String
        ..values.pulse = body['pulse'] as int
        ..values.time = DateTime.now().millisecondsSinceEpoch
        ..canModifyAllInstances = true;
      final insertedHero = await query.insert();
      return Response.ok(insertedHero);

  }
}
