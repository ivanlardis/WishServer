import 'package:aqueduct/aqueduct.dart';

class PulseMetric extends ManagedObject<_PulseMetric> implements _PulseMetric {



  Map<String, dynamic> toJson() => {
    'mac': mac,
    'time': time,
    'pulse': pulse,
    'min': min,
    'max': max,

  };
}

class _PulseMetric{



  @primaryKey
  @Column(unique: true)
  int id;


  String mac;

  DateTime time;

  int pulse;

  int min;

  int max;

}


