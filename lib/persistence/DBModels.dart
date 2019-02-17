import 'package:aqueduct/aqueduct.dart';


class Wish extends ManagedObject<_Wish> implements _Wish {}

class _Wish {
  @primaryKey
  int id;

  int value;

  int time;
}