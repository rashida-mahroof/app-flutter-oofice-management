import 'dart:convert';
class TaskClass {

  TaskClass({
    this.Subject,
    this.Message,
    this.TaskId,
    this.Status,
    this.Name,
    this.Role,
    this.CreatedDate,
    this.RecievedDate,
  });

  String? Subject;
  String? Message;
  int? TaskId;
  String?Status;
  String?Name;
  String?Role;
  String?CreatedDate;
  String?RecievedDate;

  factory TaskClass.fromJson(Map<String, dynamic> map){
    return TaskClass(
      Subject: map["Subject"],
      Message: map["Message"],
      TaskId: map["TaskId"],
      Status: map["Status"],
      Name: map["Name"],
      Role: map["Role"],
      CreatedDate: map["CreatedDate"],
      RecievedDate: map["RecievedDate"],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Subject'] = this.Subject;
    data['Message'] = this.Message;
    data['TaskId'] = this.TaskId;
    data['Status'] = this.Status;
    data['Name'] = this.Name;
    data['Role'] = this.Role;
    data['CreatedDate'] = this.CreatedDate;
    data['RecievedDate'] = this.RecievedDate;
    return data;
  }

}

// To parse this JSON data, do
//
//     final tasktrans = tasktransFromJson(jsonString);



List<Tasktrans> tasktransFromJson(String str) => List<Tasktrans>.from(json.decode(str).map((x) => Tasktrans.fromJson(x)));

String tasktransToJson(List<Tasktrans> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tasktrans {
    Tasktrans({
        this.senderId,
        this.recieverId,
        this.status,
        this.date,
        this.taskId,
        this.updatedDate,
        this.updatedTime,
        this.comment,
    });

    int? senderId;
    int? recieverId;
    String? status;
    String? date;
    int? taskId;
    String? updatedDate;
    String? updatedTime;
    String? comment;

    factory Tasktrans.fromJson(Map<String, dynamic> json) => Tasktrans(
        senderId: json["SenderID"],
        recieverId: json["RecieverId"],
        status: json["Status"],
        date: json["Date"],
        taskId: json["TaskID"],
        updatedDate: json["UpdatedDate"],
        updatedTime: json["UpdatedTime"],
        comment: json["Comment"],
    );

    Map<String, dynamic> toJson() => {
        "SenderID": senderId,
        "RecieverId": recieverId,
        "Status": status,
        "Date": date,
        "TaskID": taskId,
        "UpdatedDate": updatedDate,
        "UpdatedTime": updatedTime,
        "Comment": comment,
    };
}
