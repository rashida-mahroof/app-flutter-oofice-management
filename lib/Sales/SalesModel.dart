// To parse this JSON data, do
//
//     final sales = salesFromJson(jsonString);

import 'dart:convert';

List<Sales> salesFromJson(String str) => List<Sales>.from(json.decode(str).map((x) => Sales.fromJson(x)));

String salesToJson(List<Sales> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sales {
    Sales({
        this.fromDate,
        this.toDate,
        this.date,
        this.particulars,
        this.userId,
        this.voucherId,
        this.voucherNo,
        this.netAmount,
        this.remarks,
        this.deliveryDate,
        this.isDelivered,
        this.paidAmount,
        this.balanceAmount,
        this.deliveryAddress,
        this.orderdate,
        this.deliverytime,
        this.transmasterid,
    });

    DateTime? fromDate;
    DateTime? toDate;
    String ?date;
    String ?particulars;
    int? userId;
    int? voucherId;
    String? voucherNo;
    dynamic netAmount;
    String? remarks;
    String? deliveryDate;
    int? isDelivered;
    dynamic paidAmount;
    dynamic balanceAmount;
    String? deliveryAddress;
    dynamic orderdate;
    dynamic deliverytime;
    dynamic transmasterid;

    factory Sales.fromJson(Map<String, dynamic> json) => Sales(
        fromDate: DateTime.parse(json["FromDate"]),
        toDate: DateTime.parse(json["ToDate"]),
        date: json["Date"],
        particulars: json["Particulars"],
        userId: json["UserID"],
        voucherId: json["VoucherID"],
        voucherNo: json["VoucherNo"],
        netAmount: json["NetAmount"],
        remarks: json["Remarks"],
        deliveryDate: json["DeliveryDate"],
        isDelivered: json["IsDelivered"],
        paidAmount: json["PaidAmount"],
        balanceAmount: json["BalanceAmount"],
        deliveryAddress: json["DeliveryAddress"],
        orderdate:json["OrderDate"],
        deliverytime:json["DeliveryTime"],
        transmasterid:json["TransMasterID"],
    );

    Map<String, dynamic> toJson() => {
        "FromDate": fromDate!.toIso8601String(),
        "ToDate": toDate!.toIso8601String(),
        "Date": date,
        "Particulars": particulars,
        "UserID": userId,
        "VoucherID": voucherId,
        "VoucherNo": voucherNo,
        "NetAmount": netAmount,
        "Remarks": remarks,
        "DeliveryDate": deliveryDate,
        "IsDelivered": isDelivered,
        "PaidAmount": paidAmount,
        "BalanceAmount": balanceAmount,
        "DeliveryAddress": deliveryAddress,
        "OrderDate":orderdate,
        "DeliveryTime":deliverytime,
        "TransMasterID":transmasterid,
    };
}
