class OverView {
  OverView(
      {this.start,
        this.curent,
        this.min,
        this.max,
        this.userName});

  factory OverView.fromJson(Map<String, dynamic> json) {
    return OverView(
        start: json['start'] as int,
        curent: json['curent']as int,
        max: json['max']as int,
        min: json['min']as int,
        userName: json['userName'] as String);
  }



  Map<String, dynamic> toJson() => {
    'start': start,
    'curent': curent,
    'max': max,
    'userName': userName,
    'min': min
  };
  int start = 0;
  int curent = 0;
  int max = 0;
  int min = 0;
  String userName;
}