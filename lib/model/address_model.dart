import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  String? phoneNumber, street, city, state, country, name;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel(
      {required this.id,
      this.phoneNumber,
      this.street,
      this.city,
      this.state,
      this.country,
      this.name,
      this.dateTime,
      this.selectedAddress = true});

  //String get formattedPhoneNumber =>

  static AddressModel empty() => AddressModel(
      id: '',
      name: '',
      phoneNumber: '',
      street: '',
      city: '',
      state: '',
      country: '');

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
        name: json['name'] as String,
        id: json['id'] as String,
        phoneNumber: json['phoneNumber'] as String,
        street: json['street'] as String,
        city: json['city'] as String,
        state: json['state'] as String,
        country: json['country'] as String,
        dateTime: (json['dateTime'] as Timestamp).toDate(),
        selectedAddress: json['selectedAddress'] as bool);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'dateTime': DateTime.now(),
      'selectedAddress': selectedAddress
    };
  }

  // factory constructor to create AddressModel from a DocumentSnapshot
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      name: data['name'] ?? '',
      id: snapshot.id,
      phoneNumber: data['phoneNumber'] ?? '',
      street: data['street'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      country: data['country'] ?? '',
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      selectedAddress: data['selectedAddress'] as bool,
    );
  }

  @override
  String toString() {
    return '$street, $city, $state, $country';
  }
}
