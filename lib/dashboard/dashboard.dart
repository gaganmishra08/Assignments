import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food/Model/food.dart';
import 'package:food/Utility/appImages.dart';
import 'package:food/dashboard/dashboardController.dart';
import 'package:get/get.dart';

import '../main.dart';

class DashboardView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  double height;
  double width;
  final controller = Get.put(DashboardController());

  SlidingUpPanelController panelController = SlidingUpPanelController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        title: SizedBox(
          width: width * 0.56,
          height: 45,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColor.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black))),
            ),
            child: Text(
              "100a Ealing Rd . 24 mins",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
        ),
        leading: Padding(
            padding: EdgeInsets.only(left: 20),
            child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {})),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {}))
        ],
        backgroundColor: AppColor.background,
        elevation: 0,
        centerTitle: true,
        titleSpacing: 0,
      ),
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hits of the week",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: height * 0.045),
                    _imageSwiper(context),
                    SizedBox(height: height * 0.02),
                    Container(
                      width: width,
                      height: 5,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, position) {
                            return Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        controller.index.value == position
                                            ? Colors.black
                                            : Colors.grey),
                                  ),
                                  onPressed: () {}),

                            );
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                padding: EdgeInsets.only(left: 30),
                height: 40,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.grey[300]),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: Colors.grey))),
                        ),
                        child: Icon(
                          Icons.close_fullscreen,
                          color: Colors.black,
                          size: 24,
                        )),
                    _filter(),
                  ],
                ),
              ),
              SizedBox(height: height * 0.045),
              _foodSelection(context)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: MyFloatingActionButton(),
    );
  }

  Widget _imageSwiper(BuildContext context) {
    return Container(
      width: width,
      height: 250,
      child: Swiper(
        itemBuilder: (context, int index) {
          controller.index.value = index;
          return new Image.asset(
            AppImage.slider,
            fit: BoxFit.fill,
          );
        },
        itemCount: 4,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }

  Widget _filter() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: controller.filter.length,
          itemBuilder: (context, position) {
            return Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Container(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.grey[300]),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Colors.grey))),
                  ),
                  child: Text(
                    controller.filter[position].title,
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {},
                ),
              ),
            );
          }),
    );
  }

  Widget _foodSelection(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: controller.food.length,
          itemBuilder: (context, position) {
            return Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: InkWell(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            controller.food[position].foodImage,
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.food[position].foodTitle,
                              textAlign: TextAlign.start,
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          Colors.grey[300]),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                          )),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                        controller.food[position].foodPrice,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                        controller.food[position].foodCal,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[400])))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    //Cart View Start here
                    if (controller.isCart.value == true) {

                      controller.isCart.value = true;
                      controller.isSliding.value = false;
                   controller.getUpdate();
                    }
                    else {
                      print( controller.isCart.value);
                      Scaffold.of(context)
                          .showBottomSheet<void>((BuildContext context) {
                        controller.isSliding.value = true;
                        return Obx(
                              () =>
                              Visibility(
                                visible: controller.isSliding.value,
                                child: SingleChildScrollView(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),

                                        borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  ),),
                                    height: height * 0.8,
                                    padding: EdgeInsets.only(
                                        top: 0,
                                        left: 20,
                                        right: 20,
                                        bottom: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Center(
                                            child: Image.asset(
                                              controller.food[position]
                                                  .foodImage,
                                              width: 200,
                                              height: 200,
                                            )),
                                        SizedBox(
                                          height: height * 0.015,
                                        ),
                                        Text(
                                          controller.food[position].foodTitle,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: height * 0.015,
                                        ),
                                        Text(
                                          "Famous Hawaiian dish.Rice pillow with tender chicken breast, mushrooms, cherry tomatoes, seaweed amd corn, with unagi sauce",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: height * 0.015,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border:
                                            Border.all(color: Colors.grey[300]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    10.0) //                 <--- border radius here
                                            ),
                                          ),
                                          padding: EdgeInsets.all(16),
                                          height: 85,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    '325',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Kcal',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors
                                                            .grey[300]),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    '325',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Kcal',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors
                                                            .grey[300]),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    '325',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Kcal',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors
                                                            .grey[300]),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    '325',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Kcal',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors
                                                            .grey[300]),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    '325',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Kcal',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors
                                                            .grey[300]),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Add in poke"),
                                            IconButton(
                                                icon: Icon(
                                                  FontAwesomeIcons.greaterThan,
                                                  size: 12,
                                                ),
                                                onPressed: () {}),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        10.0) //                 <--- border radius here
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    IconButton(
                                                        icon: Icon(
                                                            Icons.remove),
                                                        color: Colors.grey
                                                            .shade700,
                                                        onPressed: () {
                                                          if (controller
                                                              .count.value ==
                                                              0) {
                                                            controller.isSliding
                                                                .value = false;
                                                            controller.count
                                                                .value =
                                                            1;
                                                          } else {
                                                            controller.count
                                                                .value ==
                                                                1
                                                                ? controller
                                                                .isSliding
                                                                .value = false
                                                                : controller
                                                                .getCount(
                                                                false);
                                                          }
                                                        }),
                                                    Container(
                                                      color: Colors.grey[300],
                                                      padding: const EdgeInsets
                                                          .only(
                                                          bottom: 8,
                                                          right: 12,
                                                          left: 12),
                                                      child: Text(
                                                        controller.count.value
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons.add),
                                                      color: Colors.grey
                                                          .shade700,
                                                      onPressed: () {
                                                        controller.getCount(
                                                            true);
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.4,
                                              height: 45,
                                              child: Obx(() =>
                                                  TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStateProperty.all(
                                                          AppColor.black),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                          RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  30.0),
                                                              side: BorderSide(
                                                                  color:
                                                                  Colors
                                                                      .black))),
                                                    ),
                                                    child: Text(
                                                      "Add to cart  \$${double
                                                          .parse(controller
                                                          .food[position]
                                                          .foodPrice.replaceAll(
                                                          "\$", "")) *
                                                          controller.count
                                                              .value}",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () {
                                                      controller.isCart.value =
                                                      true;

                                                      controller.isSliding
                                                          .value =
                                                      false;
                                                      if (controller.cart
                                                          .isEmpty) {
                                                        controller.cart.insert(
                                                            0,
                                                            CartFoodModel(
                                                                foodTitle: controller
                                                                    .food[position]
                                                                    .foodTitle,
                                                                foodPrice: controller
                                                                    .food[position]
                                                                    .foodPrice,
                                                                foodImage: controller
                                                                    .food[position]
                                                                    .foodImage,
                                                                quantity: controller
                                                                    .count
                                                                    .value));
                                                      } else {
                                                        Get.snackbar("Alert",
                                                            "Only one item at a time");
                                                      }
                                                      controller.cartCount
                                                          .value =
                                                          controller.count
                                                              .value;
                                                      controller.count.value =
                                                      1;
                                                    },
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        );
                      });
                    }
                  },
                ));
          }),
    );
  }
}

class MyFloatingActionButton extends StatelessWidget {
  double height;
  double width;
  final controller = Get.put(DashboardController());

  int quantityCount;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;
    return Obx(() =>
        Visibility(
          visible: controller.isCart.value,
          child: Container(
            width: 300,
            height: 60,
            child: FloatingActionButton(
              backgroundColor: AppColor.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              onPressed: () {
                controller.isCart.value = false;
                controller.isPayment.value = true;
                showBottomSheet(
                  context: context,
                  builder: (context) =>
                      Visibility(
                        visible: controller.isPayment.value,
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                            ),),
                          height: height * 0.9,
                          padding: EdgeInsets.only(
                              top: 0, left: 20, right: 20, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "We will deliver in 24 minutes to the address",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "100a Ealing Rd",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Change address",
                                        style: TextStyle(color: Colors.grey),
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                width: width,
                                height: height * 0.3,
                                child: Obx(() =>
                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: controller.cart.length,
                                        itemBuilder: (context, position) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      controller
                                                          .cart[position]
                                                          .foodImage,
                                                      width: 80,
                                                      height: 80,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(children: [
                                                      Container(
                                                        width: width * 0.35,
                                                        child: Text(
                                                          controller
                                                              .cart[position]
                                                              .foodTitle,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Obx(() =>
                                                          Text(
                                                              ((controller
                                                                  .cartCount
                                                                  .value) *
                                                                  double.parse(
                                                                      controller
                                                                          .cart[
                                                                      position]
                                                                          .foodPrice
                                                                          .replaceAll(
                                                                          "\$",
                                                                          "")))
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold)))
                                                    ]),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                            EdgeInsets.all(8.0),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey[300],
                                                                borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                                    Radius
                                                                        .circular(
                                                                        10.0) //                 <--- border radius here
                                                                ),
                                                              ),
                                                              height: 35,
                                                              child: IconButton(
                                                                  icon: Icon(
                                                                      Icons
                                                                          .remove),
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700,
                                                                  onPressed: () {
                                                                    controller
                                                                        .gerCartCount(
                                                                        false,
                                                                        position);
                                                                  }),
                                                            )),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .only(
                                                              bottom: 5.0),
                                                          child: Obx(() =>
                                                              Text(
                                                                controller
                                                                    .cartCount
                                                                    .value
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .all(8.0),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors
                                                                  .grey[300],
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                      10.0) //                 <--- border radius here
                                                              ),
                                                            ),
                                                            height: 35,
                                                            child: IconButton(
                                                              icon: Icon(
                                                                  Icons.add),
                                                              color:
                                                              Colors.grey
                                                                  .shade700,
                                                              onPressed: () {
                                                                controller
                                                                    .gerCartCount(
                                                                    true,
                                                                    position);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        })),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Divider(),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Delivery",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Text(
                                        "\$0.0",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Free delivery from \$30",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: width,
                                    height: 50,
                                    child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColor.black),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(15.0),
                                                  side: BorderSide(
                                                      color: Colors.black))),
                                        ),
                                        onPressed: () {
                                          controller.isSliding.value = false;
                                        Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Pay",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                );
              },
              child: Text(
                "Add to cart",
                style: TextStyle(fontSize: 14, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              elevation: 1.0,
            ),
          ),
        ));
  }
}
