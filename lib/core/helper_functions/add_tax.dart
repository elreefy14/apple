addTax({required double price}) {
  double tax = price * 0.15;
  return tax + price;
}
