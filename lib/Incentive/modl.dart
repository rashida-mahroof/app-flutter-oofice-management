// To parse this JSON data, do
//
//     final incentives = incentivesFromJson(jsonString);

import 'dart:convert';

List<Incentives> incentivesFromJson(String str) => List<Incentives>.from(json.decode(str).map((x) => Incentives.fromJson(x)));

String incentivesToJson(List<Incentives> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Incentives {
    Incentives({
        this.userId,
        this.fromDate,
        this.toDate,
        this.empCode,
        this.empName,
        this.totalSales,
        this.salesReturn,
        this.discount,
        this.commision,
        this.productCode,
        this.voucherNo,
        this.amount,
        this.date,
        this.partyName,
        this.invoiceAmnt,
        this.incentive,
        this.billAmount,
        this.mrp,
        this.incenPerc,
    });

    int? userId;
    dynamic fromDate;
    dynamic toDate;
    dynamic empCode;
    dynamic empName;
    dynamic totalSales;
    dynamic salesReturn;
    dynamic discount;
    dynamic commision;
    dynamic productCode;
    String? voucherNo;
    dynamic amount;
    String? date;
    String? partyName;
    String? invoiceAmnt;
    String? incentive;
    double? billAmount;
    double? mrp;
    double? incenPerc;

    factory Incentives.fromJson(Map<String, dynamic> json) => Incentives(
        userId: json["UserId"],
        fromDate: json["FromDate"],
        toDate: json["ToDate"],
        empCode: json["EmpCode"],
        empName: json["EmpName"],
        totalSales: json["TotalSales"],
        salesReturn: json["SalesReturn"],
        discount: json["Discount"],
        commision: json["Commision"],
        productCode: json["ProductCode"],
        voucherNo: json["VoucherNo"],
        amount: json["Amount"],
        date: json["Date"],
        partyName: json["PartyName"],
        invoiceAmnt: json["InvoiceAmnt"],
        incentive: json["Incentive"],
        billAmount: json["BillAmount"],
        mrp: json["MRP"],
        incenPerc: json["IncenPerc"],
    );

    Map<String, dynamic> toJson() => {
        "UserId": userId,
        "FromDate": fromDate,
        "ToDate": toDate,
        "EmpCode": empCode,
        "EmpName": empName,
        "TotalSales": totalSales,
        "SalesReturn": salesReturn,
        "Discount": discount,
        "Commision": commision,
        "ProductCode": productCode,
        "VoucherNo": voucherNo,
        "Amount": amount,
        "Date": date,
        "PartyName": partyName,
        "InvoiceAmnt": invoiceAmnt,
        "Incentive": incentive,
        "BillAmount": billAmount,
        "MRP": mrp,
        "IncenPerc": incenPerc,
    };
}
