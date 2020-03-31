class StockProduct {
  String stockID;
  String name;
  String priceNAB;
  String unitTotalNAB;
  String availableTotalNAB;
  String logo;

  StockProduct({this.stockID, this.name, this.priceNAB, this.unitTotalNAB, this.availableTotalNAB, this.logo  });

  factory StockProduct.fromJson(Map<String, dynamic> json){
    return StockProduct(
      stockID: json['stockID'] as String,
      name: json['Name'] as String,
      priceNAB: json['priceNAB'] as String,
      unitTotalNAB: json['unitTotalNAB'] as String,
      availableTotalNAB: json['availableTotalNAB'] as String,
      logo: json['logo'] as String,
      );
  }
}