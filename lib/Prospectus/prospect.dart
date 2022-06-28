
class Prospect {

  Prospect({
    this.Source,
    this.SubSource,
    this.CustomerName,
    this.Mobile,
    this.District,
    this.City,
    this.Address,
    this.ProspectType,
    this.SucessProducts,
    this.SucessNote,
    this.SucessComments,
    this.ReasonType,
    this.ReasonNote,
    this.Possibility,
    this.FinancialStatus,
    this.NextFollowUpdate,
    this.NextStep,
    this.SucessType,
    this.OrderDeliveryDate,

    // this.RecievedDate,
  });

  String? Source;
  String? SubSource;
  String? CustomerName;
  String?Mobile;
  String?District;
  String?City;
  String?Address;
  String?ProspectType;
  String?SucessProducts;
  String?SucessNote;
  String?SucessComments;
  String?ReasonType;
  String?ReasonNote;
  String?Possibility;
  String?FinancialStatus;
  DateTime?NextFollowUpdate;
  String?NextStep;
  String?SucessType;
  DateTime?OrderDeliveryDate;

  factory Prospect.fromJson(Map<String, dynamic> map){
    return Prospect(
      Source: map["Source"],
      SubSource: map["SubSource"],
      CustomerName: map["CustomerName"],
      Mobile: map["Mobile"],
      District: map["District"],
      City: map["City"],
      Address: map["Address"],
      ProspectType: map["ProspectType"],
      SucessProducts: map["SucessProducts"],
      SucessNote: map["SucessNote"],
      SucessComments: map["SucessComments"],
      ReasonType: map["ReasonType"],
      ReasonNote: map["ReasonNote"],
      Possibility: map["Possibility"],
      FinancialStatus: map["FinancialStatus"],
      NextFollowUpdate: map["NextFollowUpdate"],
      NextStep: map["NextStep"],
      SucessType: map["SucessType"],
      OrderDeliveryDate: map["OrderDeliveryDate"],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Source'] = this.Source;
    data['SubSource'] = this.SubSource;
    data['CustomerName'] = this.CustomerName;
    data['Mobile'] = this.Mobile;
    data['District'] = this.District;
    data['City'] = this.City;
    data['Address'] = this.Address;
    data['ProspectType'] = this.ProspectType;
    data['SucessProducts'] = this.SucessProducts;
    data['SucessNote'] = this.SucessNote;
    data['SucessComments'] = this.SucessComments;
    data['ReasonType'] = this.ReasonType;
    data['ReasonNote'] = this.ReasonNote;
    data['Possibility'] = this.Possibility;
    data['FinancialStatus'] = this.FinancialStatus;
    data['NextFollowUpdate'] = this.NextFollowUpdate;
    data['NextStep'] = this.NextStep;
    data['SucessType'] = this.SucessType;
    data['OrderDeliveryDate'] = this.OrderDeliveryDate;
    return data;
  }

}


class ProspectProduct {

  ProspectProduct({
    this.Product,
    this.Price,
    this.Material,
    this.Size,
    

    // this.RecievedDate,
  });

  String? Product;
  String? Price;
  String? Material;
  String?Size;

  factory ProspectProduct.fromJson(Map<String, dynamic> map){
    return ProspectProduct(
      Product: map["Product"],
      Price: map["Price"],
      Material: map["Material"],
      Size: map["Size"],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Product'] = this.Product;
    data['Price'] = this.Price;
    data['Material'] = this.Material;
    data['Size'] = this.Size;
    return data;
  }

}