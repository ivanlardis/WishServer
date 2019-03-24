import 'package:aqueduct/aqueduct.dart';

class UserDevice extends ManagedObject<_UserDevice> implements _UserDevice {



  Map<String, dynamic> toJson() => {
    'mac': mac,
    'active': active,
    'name': name,
    'changed': changed,
  };
}

class _UserDevice {



  @primaryKey
  @Column(unique: true)
  int id;


  String mac;

  bool active;

  String name;

  int changed;

}


