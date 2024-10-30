class Cale {
  late final String product_name;
  late final String cas;
  late final String client_name;
  final DateTime creationDate;
  int quantity;
  double price;
  double unityprice;
  double reductionAmount;
  Cale({
    required this.product_name,
    required this.cas,
    required this.client_name,
    required this.creationDate,
    this.quantity = 0,
    this.price = 0,
    this.unityprice = 0,
    this.reductionAmount = 0.0,
  });
}
