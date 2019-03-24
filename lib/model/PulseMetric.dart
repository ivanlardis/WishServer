import 'package:aqueduct/aqueduct.dart';

class PulseMetric extends ManagedObject<_PulseMetric> implements _PulseMetric {



  Map<String, dynamic> toJson() => {
    'mac': mac,
    'time': time,
    'pulse': pulse,

  };
}

class _PulseMetric{



  @primaryKey
  @Column(unique: true)
  int id;


  String mac;

  int time;

  int pulse;

}


