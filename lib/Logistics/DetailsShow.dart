
class SamplePostClass {

  SamplePostClass({
    this.VehicleNum,
    this.DriverNum,
    this.TripId,
    this.Up_RouteNam,
    this.Down_RouteNo,
    this.UpKm,
    this.DownKm,
    this.Up_dates,
    this.Down_dates,
    this.Up_time,
    this.Down_time,
    this.Up_Space,
    this.Down_Space,
  });

  String? VehicleNum;
  String? DriverNum;
  int? TripId;
  String?Up_RouteNam;
  String?Down_RouteNo;
  int?UpKm;
  int?DownKm;
  String?Up_dates;
  String?Down_dates;
  String?Up_time;
  String?Down_time;
  String?Up_Space;
  String?Down_Space;

  factory SamplePostClass.fromJson(Map<String, dynamic> map){
    return SamplePostClass(
      VehicleNum: map["VehicleNum"],
      DriverNum: map["DriverNum"],
      TripId: map["TripId"],
      Up_RouteNam: map["Up_RouteNam"],
      Down_RouteNo: map["Down_RouteNo"],
      UpKm: map["UpKm"],
      DownKm: map["DownKm"],
      Up_dates: map["Up_dates"],
      Down_dates:map["Down_dates"],
        Up_time:map["Up_time"],
        Down_time:map["Down_time"],
        Up_Space:map["Up_Space"],
        Down_Space:map["Down_Space"],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VehicleNum'] = this.VehicleNum;
    data['DriverNum'] = this.DriverNum;
    data['TripId'] = this.TripId;
    data['Up_RouteNam'] = this.Up_RouteNam;
    data['Down_RouteNo'] = this.Down_RouteNo;
    data['UpKm'] = this.UpKm;
    data['DownKm'] = this.DownKm;
    data['Up_dates'] = this.Up_dates;
    data['Down_dates']=this.Down_dates;
    data['Up_time']=this.Up_time;
    data['Down_time']=this.Down_time;
    data['Up_Space']=this.Up_Space;
    data['Down_Space']=this.Down_Space;
    return data;
  }

}