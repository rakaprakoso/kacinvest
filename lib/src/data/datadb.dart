class StockProduct {
  String stockID;
  String name;
  int priceNAB;
  int unitTotalNAB;
  int availableTotalNAB;

  StockProduct({this.stockID, this.name, this.priceNAB, this.unitTotalNAB, this.availableTotalNAB  });

  factory StockProduct.fromJson(Map<String, dynamic> json){
    return StockProduct(
      stockID: json['stockID'] as String,
      name: json['Name'] as String,
      priceNAB: json['priceNAB'] as int,
      unitTotalNAB: json['unitTotalNAB'] as int,
      availableTotalNAB: json['availableTotalNAB'] as int,
      );
  }
}