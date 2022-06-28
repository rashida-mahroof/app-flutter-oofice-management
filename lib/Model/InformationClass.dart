// To parse this JSON data, do
//
//     final informationClass = informationClassFromJson(jsonString);

import 'dart:convert';

InformationClass informationClassFromJson(String str) => InformationClass.fromJson(json.decode(str));

String informationClassToJson(InformationClass data) => json.encode(data.toJson());

class InformationClass {
    InformationClass({
        this.data,
    });

    List<Datum>?data;

    factory InformationClass.fromJson(Map<String, dynamic> json) => InformationClass(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.senderName,
        this.subject,
        this.message,
        this.recievedAt,
    });

    String? senderName;
    String? subject;
    String? message;
    DateTime? recievedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        senderName: json["SenderName"],
        subject: json["Subject"],
        message: json["Message"],
        recievedAt: DateTime.parse(json["RecievedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "SenderName": senderName,
        "Subject": subject,
        "Message": message,
        "RecievedAt": recievedAt!.toIso8601String(),
    };
}



// To parse this JSON data, do
//
//     final roles = rolesFromJson(jsonString);



Roles rolesFromJson(String str) => Roles.fromJson(json.decode(str));

String rolesToJson(Roles data) => json.encode(data.toJson());

class Roles {
    Roles({
        this.data,
    });

    List<Datum> ?data;

    factory Roles.fromJson(Map<String, dynamic> json) => Roles(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DatumS {
    DatumS({
        this.rolename,
        this.roleId,
    });

    String? rolename;
    int? roleId;

    factory DatumS.fromJson(Map<String, dynamic> json) => DatumS(
        rolename: json["Rolename"],
        roleId: json["RoleID"],
    );

    Map<String, dynamic> toJson() => {
        "Rolename": rolename,
        "RoleID": roleId,
    };
}


// To parse this JSON data, do
//
//     final roles = rolesFromJson(jsonString);



// To parse this JSON data, do
//
//     final userslist = userslistFromJson(jsonString);



List<Userslist> userslistFromJson(String str) => List<Userslist>.from(json.decode(str).map((x) => Userslist.fromJson(x)));

String userslistToJson(List<Userslist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Userslist {
    Userslist({
        this.usersNamesForList,
    });

    String? usersNamesForList;

    factory Userslist.fromJson(Map<String, dynamic> json) => Userslist(
        usersNamesForList: json["UsersNamesForList"],
    );

    Map<String, dynamic> toJson() => {
        "UsersNamesForList": usersNamesForList,
    };
}


// To parse this JSON data, do
//
//     final infoById = infoByIdFromJson(jsonString);


// To parse this JSON data, do
//
//     final infoById = infoByIdFromJson(jsonString);



List<InfoById> infoByIdFromJson(String str) => List<InfoById>.from(json.decode(str).map((x) => InfoById.fromJson(x)));

String infoByIdToJson(List<InfoById> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoById {
    InfoById({
        this.infoId,
        this.subject,
        this.content,
        this.image,
        this.name,
        this.createdDate,
    });

    int? infoId;
    String? subject;
    String? content;
    String? image;
    String? name;
    DateTime? createdDate;

    factory InfoById.fromJson(Map<String, dynamic> json) => InfoById(
        infoId: json["InfoId"],
        subject: json["Subject"],
        content: json["Content"],
        image: json["Image"],
        name: json["Name"],
        createdDate: DateTime.parse(json["CreatedDate"]),
    );

    Map<String, dynamic> toJson() => {
        "InfoId": infoId,
        "Subject": subject,
        "Content": content,
        "Image": image,
        "Name": name,
        "CreatedDate": createdDate!.toIso8601String(),
    };
}
