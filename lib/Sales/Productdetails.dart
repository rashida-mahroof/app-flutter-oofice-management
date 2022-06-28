// To parse this JSON data, do
//
//     final productdetails = productdetailsFromJson(jsonString);

import 'dart:convert';


List<Productdetails> productdetailsFromJson(String str) => List<Productdetails>.from(json.decode(str).map((x) => Productdetails.fromJson(x)));

String productdetailsToJson(List<Productdetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Productdetails {
    Productdetails({
        this.voucherNumber,
        this.productCode,
        this.qty,
        this.rate,
        this.branchCode,
        this.mrp,
        this.discRate,
        this.discPerc,
        this.clothNumber,
    });

    dynamic voucherNumber;
    String ?productCode;
    dynamic ? qty;
    dynamic? rate;
    String? branchCode;
    dynamic? mrp;
    dynamic? discRate;
    dynamic? discPerc;
    String? clothNumber;

    factory Productdetails.fromJson(Map<String, dynamic> json) => Productdetails(
        voucherNumber: json["VoucherNumber"],
        productCode: json["ProductCode"],
        qty: json["Qty"],
        rate: json["Rate"].toDouble(),
        branchCode: json["BranchCode"],
        mrp: json["MRP"].toDouble(),
        discRate: json["DiscRate"],
        discPerc: json["DiscPerc"].toDouble(),
        clothNumber: json["ClothNumber"],
    );

    Map<String, dynamic> toJson() => {
        "VoucherNumber": voucherNumber,
        "ProductCode": productCode,
        "Qty": qty,
        "Rate": rate,
        "BranchCode": branchCode,
        "MRP": mrp,
        "DiscRate": discRate,
        "DiscPerc": discPerc,
        "ClothNumber": clothNumber,
    };
}
