class PaymentMethodModel {
  String? name;
  String? image;
  PaymentMethodModel({this.name, this.image});

  static PaymentMethodModel empty() => PaymentMethodModel(name: '', image: '');
}
