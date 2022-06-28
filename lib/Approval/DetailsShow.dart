
class SamplePostClass {

  SamplePostClass({
    this.Subject,
    this.Message,
    this.ApprovalId,
    this.Status,
    this.Name,
    this.Role,
    this.CreatedDate,
    this.RecievedDate,
  });

  String? Subject;
  String? Message;
  int? ApprovalId;
  String?Status;
  String?Name;
  String?Role;
  String?CreatedDate;
  String?RecievedDate;

  factory SamplePostClass.fromJson(Map<String, dynamic> map){
    return SamplePostClass(
      Subject: map["Subject"],
      Message: map["Message"],
      ApprovalId: map["ApprovalId"],
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
    data['ApprovalId'] = this.ApprovalId;
    data['Status'] = this.Status;
    data['Name'] = this.Name;
    data['Role'] = this.Role;
    data['CreatedDate'] = this.CreatedDate;
    data['RecievedDate'] = this.RecievedDate;
    return data;
  }

}