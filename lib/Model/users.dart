// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.userId,
        this.userName,
        this.password,
        this.erPpwd,
        this.name,
        this.role,
        this.partyId,
        this.roleId,
        this.email,
        this.mobile,
        this.loginSuccess,
        this.modifiedDate,
        this.isActive,
        this.Right,
        this.branchId,

    });

    int ?userId;
    String? userName;
    String? password;
    dynamic? erPpwd;
    String ?name;
    String ?role;
    int ?partyId;
    int ?roleId;
    String? email;
    String? mobile;
    bool ?loginSuccess;
    String? modifiedDate;
    int ?isActive;
    Iterable<dynamic>? Right;
    int ?branchId;

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["UserID"],
        userName: json["UserName"],
        password: json["Password"],
        erPpwd: json["ERPpwd"],
        name: json["Name"],
        role: json["Role"],
        partyId: json["PartyID"],
        roleId: json["RoleID"],
        email: json["Email"],
        mobile: json["Mobile"],
        loginSuccess: json["LoginSuccess"],
        modifiedDate: json["ModifiedDate"],
        isActive: json["IsActive"],
        Right:json["Right"],
        branchId:json["BranchId"]
    );

    Map<String, dynamic> toJson() => {
        "UserID": userId,
        "UserName": userName,
        "Password": password,
        "ERPpwd": erPpwd,
        "Name": name,
        "Role": role,
        "PartyID": partyId,
        "RoleID": roleId,
        "Email": email,
        "Mobile": mobile,
        "LoginSuccess": loginSuccess,
        "ModifiedDate": modifiedDate,
        "IsActive": isActive,
        "Right":Right,
        "BranchId":branchId
    };
}
