import 'package:aqueduct/aqueduct.dart';
import 'package:wish_server/model/PulseMetric.dart';
import 'package:wish_server/model/OverView.dart';
import 'package:wish_server/model/UserDevice.dart';
import 'package:wish_server/model/Wish.dart';

class OtBoxOverView extends ResourceController {
  OtBoxOverView(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllHeroes() async {
    final userDeviceQuery = Query<UserDevice>(context)
      ..where((h) => h.active).equalTo(true);

    var userDevice = await userDeviceQuery.fetch();

    final pulseMetricQuery = Query<PulseMetric>(context);
    var pulseMetric = await pulseMetricQuery.fetch();
    var list = new List<OverView>();
    for (int i = 0; i < userDevice.length; i++) {
      var device = userDevice[i];
      var overview = OverView(
          start: device.changed.millisecondsSinceEpoch,
          userName: device.name,
          min: 0,
          max: 0,
          curent: 0);

      for (int i1 = 0; i1 < pulseMetric.length; i1++) {
        var mertic = pulseMetric[i1];
        if (mertic.mac == device.mac) {
          overview.min = mertic.min;
          overview.max = mertic.max;
          overview.curent = mertic.pulse;
        }
      }

      list.add(overview);
    }

    return Response.ok(list);
  }
}
