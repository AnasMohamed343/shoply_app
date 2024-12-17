class AddressModel {
  String? street1, street2, city, state, country;

  AddressModel(
      {this.street1, this.street2, this.city, this.state, this.country});

  AddressModel.fromJson(Map<String, dynamic> json) {
    street1 = json['street1'];
    street2 = json['street2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    return {
      'street1': street1,
      'street2': street2,
      'city': city,
      'state': state,
      'country': country,
    };
  }
}
