import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  final messageList = [
    {
      "message": "Hola, ¿Cuánto tiempo tomará entregar mis medicinas?",
      "time": "10:04 pm",
      "isMe": true
    },
    {
      "message": "Hola, señora, llegaré en 10 minutos a su ubicación.",
      "time": "10:05 pm",
      "isMe": false
    },
    {"message": "Está bien", "time": "10:05 pm", "isMe": true}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: false,
        toolbarHeight: 65.0,
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.west,
            color: blackColor,
          ),
        ),
        title: Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/chat/delivery-boy-image.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            widthSpace,
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "George Anderson",
                    style: bold18Black,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Socio de entrega",
                    style: medium14Grey,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: blackColor,
            ),
          )
        ],
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
            top: fixPadding,
            left: fixPadding * 2.0,
            right: fixPadding * 2.0,
            bottom: fixPadding * 4.0),
        reverse: true,
        itemCount: messageList.length,
        itemBuilder: (context, index) {
          int reverseIndex = messageList.length - index - 1;
          return messageList[reverseIndex]['isMe'] == true
              ? sendMessages(reverseIndex)
              : receiveMessages(reverseIndex);
        },
      ),
      bottomNavigationBar: textFieldAndSendButton(),
    );
  }

  Widget receiveMessages(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: fixPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 35,
            width: 35,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/chat/delivery-boy-image.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          width5Space,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(fixPadding),
                  margin: const EdgeInsets.only(right: fixPadding * 8.0),
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    messageList[index]['message'].toString(),
                    style: medium14White,
                  ),
                ),
                heightBox(3.0),
                Text(
                  messageList[index]['time'].toString(),
                  style: medium12Grey,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sendMessages(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: fixPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(fixPadding),
            margin: const EdgeInsets.only(left: fixPadding * 8.0),
            decoration: const BoxDecoration(
              color: recColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
            child: Text(
              messageList[index]['message'].toString(),
              style: medium14Black,
            ),
          ),
          heightBox(3.0),
          Text(
            messageList[index]['time'].toString(),
            style: medium12Grey,
          ),
        ],
      ),
    );
  }

  Widget textFieldAndSendButton() {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 1.5),
      width: double.maxFinite,
      color: primaryColor,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              style: semibold14White,
              cursorColor: whiteColor,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Escribe un mensaje...",
                hintStyle: semibold14White,
                contentPadding:
                    EdgeInsets.symmetric(vertical: fixPadding * 1.5),
              ),
            ),
          ),
          widthSpace,
          GestureDetector(
            onTap: () {
              if (messageController.text.isNotEmpty) {
                setState(() {
                  messageList.add({
                    "message": messageController.text,
                    "time": DateFormat.jm().format(DateTime.now()),
                    "isMe": true
                  });
                  messageController.clear();
                  messageList;
                });
              }
            },
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: whiteColor,
              ),
              child: const Icon(
                Icons.send,
                color: primaryColor,
                size: 20.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
