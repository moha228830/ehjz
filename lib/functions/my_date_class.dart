class My_date_class {
  int id;
  String date;
  String day;
  String dayEn;
  int onlyDay;
  int onlyMonth;
  int onlyYear;

  My_date_class(
      {this.id,
        this.date,
        this.day,
        this.dayEn,
        this.onlyDay,
        this.onlyMonth,
        this.onlyYear});

  My_date_class.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    day = json['day'];
    dayEn = json['day_en'];
    onlyDay = json['only_day'];
    onlyMonth = json['only_month'];
    onlyYear = json['only_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['day'] = this.day;
    data['day_en'] = this.dayEn;
    data['only_day'] = this.onlyDay;
    data['only_month'] = this.onlyMonth;
    data['only_year'] = this.onlyYear;
    return data;
  }
}