import 'package:flutter/material.dart';

class FoodModel{
  FoodModel({this.foodTitle,this.foodImage,this.foodPrice,this.foodCal});
  String foodImage;
  String foodTitle;
  String foodPrice;
  String foodCal;
}
class CartFoodModel{
  CartFoodModel({this.foodTitle,this.foodImage,this.foodPrice,this.quantity});
  String foodImage;
  String foodTitle;
  String foodPrice;
  int quantity;
}