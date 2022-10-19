import 'dart:convert';

List<ToyotaModelClass> toyotaModelClassFromJson(String str) => List<ToyotaModelClass>.from(json.decode(str).map((x) => ToyotaModelClass.fromJson(x)));

String toyotaModelClassToJson(List<ToyotaModelClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ToyotaModelClass {
  ToyotaModelClass({
    required this.jobcId,
    required this.sa,
    required this.frameNo,
    required this.vehRegNo,
    required this.customerName,
    required this.openDateTime,
  });

  String jobcId;
  String sa;
  String frameNo;
  String vehRegNo;
  String customerName;
  DateTime openDateTime;

  factory ToyotaModelClass.fromJson(Map<String, dynamic> json) => ToyotaModelClass(
    jobcId: json["Jobc_id"],
    sa: json["SA"],
    frameNo: json["Frame_no"],
    vehRegNo: json["Veh_reg_no"],
    customerName: json["Customer_name"],
    openDateTime: DateTime.parse(json["Open_date_time"]),
  );

  Map<String, dynamic> toJson() => {
    "Jobc_id": jobcId,
    "SA": sa,
    "Frame_no": frameNo,
    "Veh_reg_no": vehRegNo,
    "Customer_name": customerName,
    "Open_date_time": openDateTime.toIso8601String(),
  };
}