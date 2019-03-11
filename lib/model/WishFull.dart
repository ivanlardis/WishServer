class WishFull {
  WishFull(
      {this.timeAfterLastPress,
        this.countCons,
        this.countProps,
        this.id,
        this.userName});

  factory WishFull.fromJson(Map<String, dynamic> json) {
    return WishFull(
        timeAfterLastPress: json['timeAfterLastPress'] as int,
        countCons: json['countCons']as int,
        countProps: json['countProps']as int,
        id: json['id']as int,
        userName: json['userName'] as String);
  }

  Map<String, dynamic> toJson() => {
    'timeAfterLastPress': timeAfterLastPress,
    'countCons': countCons,
    'countProps': countProps,
    'id': id,
    'userName': userName
  };
  int timeAfterLastPress = 0;
  int countCons = 0;
  int countProps = 0;
  int id = 0;
  String userName;
}