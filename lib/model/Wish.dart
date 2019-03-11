import 'package:aqueduct/aqueduct.dart';

class Wish extends ManagedObject<_Wish> implements _Wish {}

class _Wish {




  @primaryKey
  @Column(unique: true)
  int userId;

  int countCons;

  int countProps;

  int timeAfterLastPress;
}


