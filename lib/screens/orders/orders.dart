import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final tabBarList = ["En Curso", "Historial"];

  int selectedTabBar = 0;

  PageController pageController = PageController();

  final ongoingOrderList = [
    {
      "image": "assets/home/restaurant-6.png",
      "name": "Marine Rise Restaurant",
      "items": 3,
      "orderId": "CCA123456854",
      "totalAmount": 32.00,
      "status": "Preparando",
    },
    {
      "image": "assets/home/restaurant-8.png",
      "name": "Bar 61 Restaurant",
      "items": 2,
      "orderId": "ABA123456854",
      "totalAmount": 30.00,
      "status": "Preparando",
    },
    {
      "image": "assets/home/restaurant-7.png",
      "name": "Hunger Spot",
      "items": 1,
      "orderId": "FFA123456854",
      "totalAmount": 20.00,
      "status": "Envío",
    },
  ];

  final historyOrderList = [
    {
      "image": "assets/home/restaurant-6.png",
      "name": "Marine Rise Restaurant",
      "items": 3,
      "orderId": "CCA123456854",
      "totalAmount": 32.00,
      "status": "Pedido",
    },
    {
      "image": "assets/home/restaurant-8.png",
      "name": "Bar 61 Restaurant",
      "items": 2,
      "orderId": "ABA123456854",
      "totalAmount": 30.00,
      "status": "Pedido",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: false,
        titleSpacing: 20.0,
        title: const Text(
          "Pedidos",
          style: bold18Black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tabBar(),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedTabBar = index;
                });
              },
              children: [
                ongoingOrderListContent(size),
                historyListContent(size)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget historyListContent(Size size) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0, vertical: fixPadding),
      itemCount: historyOrderList.length,
      itemBuilder: (context, index) {
        final historyOrderData = historyOrderList[index];
        return listContent(context, size, historyOrderData);
      },
    );
  }

  Widget ongoingOrderListContent(Size size) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0, vertical: fixPadding),
      itemCount: ongoingOrderList.length,
      itemBuilder: (context, index) {
        final ongoingOrderData = ongoingOrderList[index];
        return listContent(context, size, ongoingOrderData);
      },
    );
  }

  listContent(BuildContext context, Size size, Map itemData) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/orderDetail', arguments: itemData);
      },
      child: Container(
        height: 90.0,
        margin: const EdgeInsets.symmetric(vertical: fixPadding),
        clipBehavior: Clip.hardEdge,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: boxShadow,
        ),
        child: Row(
          children: [
            imageBox(itemData['image'].toString()),
            Expanded(
              child: Stack(
                children: [
                  orderContent(size, itemData),
                  if (itemData['status'] == "Preparando")
                    statusBox("Preparando", orangeColor),
                  if (itemData['status'] == "Envío")
                    statusBox("Enviado", primaryColor),
                  if (itemData['status'] == "Pedido")
                    statusBox("Pedido", greyColor)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  statusBox(String text, Color color) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 1.5, vertical: fixPadding / 2),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
          ),
        ),
        child: Text(
          text,
          style: bold14Grey.copyWith(color: color),
        ),
      ),
    );
  }

  imageBox(String image) {
    return Container(
      width: 65.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            image,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget orderContent(Size size, Map itemData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  itemData['name'].toString(),
                  style: medium16Black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              widthSpace,
              Text(
                "${itemData['items']} Artículos",
                style: semibold14Grey,
              )
            ],
          ),
          heightBox(3.0),
          Row(
            children: [
              Container(
                height: 12.0,
                width: 12.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryColor, width: 2.0),
                ),
              ),
              width5Space,
              Expanded(
                child: Text(
                  itemData['orderId'].toString(),
                  style: semibold14Grey,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          heightBox(3.0),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 240),
            child: Text(
              "\$${(itemData['totalAmount'] as double).toStringAsFixed(2)}",
              style: bold16Black,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget tabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding, vertical: fixPadding * 1.5),
      width: double.maxFinite,
      color: recColor,
      child: Row(
        children: List.generate(
          tabBarList.length,
          (index) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTabBar = index;
                    pageController.jumpToPage(selectedTabBar);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: fixPadding),
                  padding: const EdgeInsets.all(fixPadding * 0.8),
                  decoration: BoxDecoration(
                    color: selectedTabBar == index ? primaryColor : whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    tabBarList[index].toString(),
                    style: selectedTabBar == index
                        ? semibold16White
                        : semibold16Black,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
