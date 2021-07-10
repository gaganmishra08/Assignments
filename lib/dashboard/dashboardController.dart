import 'package:food/Model/filter.dart';
import 'package:food/Model/food.dart';
import 'package:food/Utility/appImages.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxInt count = 1.obs;
  RxBool isCart = false.obs;
  RxBool isSliding = false.obs;
  RxBool isPayment = false.obs;
  RxInt index = 0.obs;
  RxInt cartCount = 1.obs;
  var cart = List<CartFoodModel>().obs;
getUpdate(){
  update();
}
  getCount(bool val) {
    val == true ? count.value += 1 : count.value -= 1;
    update();
  }

  gerCartCount(bool val, int position) {
    if(cartCount.value>0){
      val == true ? cart[position].quantity += 1 : cart[position].quantity -= 1;
      cartCount.value = cart[position].quantity;


      if(cartCount.value==0){
        cart.removeAt(position);

      }
      update();


    }

  }

  List<FilterModel> filter = [
    FilterModel(title: "Salads"),
    FilterModel(title: "Pizza"),
    FilterModel(title: "Beverages"),
    FilterModel(title: "Snacks"),
  ];
  List<FoodModel> food = [
    FoodModel(
        foodTitle: "Poke with chicken",
        foodCal: "345 kcal",
        foodImage: AppImage.dessert,
        foodPrice: "\$3.24"),
    FoodModel(
        foodTitle: "Salad with radishes and Mushrooms",
        foodCal: "375 kcal",
        foodImage: AppImage.salad,
        foodPrice: "\$3.40"),
    FoodModel(
        foodTitle: "Two slices of pizza with extra sauce",
        foodCal: "400 kcal",
        foodImage: AppImage.pizza,
        foodPrice: "\$4.35"),
  ];
}
