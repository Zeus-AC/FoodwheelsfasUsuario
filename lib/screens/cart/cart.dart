import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';
import 'package:pn_fl_foody_user/widget/column_builder.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartList = [
    {
      "image": "assets/foodDetail/food-image.png",
      "name": "Pizza Margarita",
      "restaurant": "Food Hunger",
      "rate": 4.0,
      "price": 12.00,
      "quantity": 1
    },
    {
      "image": "assets/food/food19.png",
      "name": "Hamburguesa de queso clásico",
      "restaurant": "Bar61 Restaurant",
      "rate": 5.0,
      "price": 10.00,
      "quantity": 2
    },
    {
      "image": "assets/food/food20.png",
      "name": "Sándwich de chutney",
      "restaurant": "Marine Rise Restaurant",
      "rate": 4.5,
      "price": 8.00,
      "quantity": 5
    },
  ];

  double serviceText = 2.50;
  double deliveryCharge = 1.50;

  @override
  Widget build(BuildContext context) {
    final subTotal = cartList.fold(
      0.0,
      (previousValue, element) =>
          previousValue +
          ((element['quantity'] as int) * (element['price'] as double)),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: false,
        titleSpacing: 20.0,
        title: const Text(
          "Carrito",
          style: bold18Black,
        ),
      ),
      body: cartList.isEmpty
          ? emptyListContent()
          : ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(fixPadding * 2.0,
                  fixPadding / 2, fixPadding * 2.0, fixPadding * 4.0),
              children: [
                cartItemListContent(),
                totalPriceInfo(subTotal),
                heightSpace,
                heightSpace,
                proceedToCheckout()
              ],
            ),
    );
  }

  Widget emptyListContent() {
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding / 2,
            fixPadding * 2.0, fixPadding * 4.0),
        children: [
          Center(
            child: Image.asset(
              "assets/icons/empty-cart.png",
              height: 70.0,
              fit: BoxFit.cover,
            ),
          ),
          heightSpace,
          height5Space,
          const Text(
            "Tu carrito está vacío",
            style: bold18Grey,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget proceedToCheckout() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/selectDeliveryAddress');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding * 1.1),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Text(
          "Proceder al pago",
          style: bold20White,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget totalPriceInfo(double subTotal) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(fixPadding),
            width: double.maxFinite,
            color: recColor,
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "Subtotal",
                    style: semibold16Black,
                  ),
                ),
                widthSpace,
                Text(
                  "\$${subTotal.toStringAsFixed(2)}",
                  style: semibold16Black,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(fixPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Impuesto de servicio",
                        style: medium16Black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    widthSpace,
                    Text(
                      "\$${serviceText.toStringAsFixed(2)}",
                      style: medium16Black,
                    )
                  ],
                ),
                heightSpace,
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Cargo por entrega",
                        style: medium16Black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    widthSpace,
                    Text(
                      "\$${deliveryCharge.toStringAsFixed(2)}",
                      style: medium16Black,
                    )
                  ],
                ),
                heightSpace,
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Monto a pagar",
                        style: bold16Primary,
                      ),
                    ),
                    widthSpace,
                    Text(
                      "\$${(subTotal + serviceText + deliveryCharge).toStringAsFixed(2)}",
                      style: bold16Primary,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cartItemListContent() {
    return ColumnBuilder(
      itemBuilder: (context, index) {
        final itemData = cartList[index];
        return Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(bottom: fixPadding * 2.0),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: boxShadow,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(fixPadding),
                      child: Row(
                        children: [
                          Container(
                            height: 65.0,
                            width: 65.0,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage(
                                  itemData['image'].toString(),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          widthSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  itemData['name'].toString(),
                                  style: medium16Black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                height5Space,
                                Text(
                                  itemData['restaurant'].toString(),
                                  style: medium14Grey,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                height5Space,
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: yellowColor,
                                      size: 17.0,
                                    ),
                                    width5Space,
                                    Expanded(
                                      child: Text(
                                        itemData['rate'].toString(),
                                        style: medium14Black,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  removeIconButton(index),
                ],
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(fixPadding),
                color: recColor,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "\$${(cartList[index]['price'] as double).toStringAsFixed(2)}",
                        style: semibold16Black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    widthSpace,
                    addRemoveButton(Icons.remove, () {
                      if ((itemData['quantity'] as int) > 1) {
                        setState(() {
                          itemData['quantity'] =
                              (itemData['quantity'] as int) - 1;
                        });
                      }
                    }),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: fixPadding),
                      child: Text(
                        itemData['quantity'].toString(),
                        style: semibold16Black,
                      ),
                    ),
                    addRemoveButton(Icons.add, () {
                      setState(() {
                        itemData['quantity'] =
                            (itemData['quantity'] as int) + 1;
                      });
                    }),
                  ],
                ),
              )
            ],
          ),
        );
      },
      itemCount: cartList.length,
    );
  }

  Widget addRemoveButton(IconData icon, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 20.0,
        width: 20.0,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: whiteColor,
          size: 18.0,
        ),
      ),
    );
  }

  Widget removeIconButton(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          cartList.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: blackColor,
            behavior: SnackBarBehavior.floating,
            duration: Duration(milliseconds: 1500),
            content: Text(
              "Eliminado del carrito",
              style: semibold16White,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(fixPadding * 0.7),
        decoration: BoxDecoration(
          color: const Color(0xFFF7240D).withOpacity(0.2),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
          ),
        ),
        alignment: Alignment.center,
        child: Image.asset(
          "assets/icons/delete-icon.png",
          color: lightRedColor,
          height: 20.0,
          width: 20.0,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
