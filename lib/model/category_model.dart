import 'package:flutter_svg/flutter_svg.dart';

class CategoryModel {
  String? name, image, categoryId;
  //String? image;
  CategoryModel({this.name, this.image, this.categoryId});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'image': image, 'categoryId': categoryId};
  }
}
