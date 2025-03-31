import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final reviewList = [
    {
      "image": "assets/review/review-1.png",
      "title": "Peter Willims",
      "date": "2 ene 2022",
      "rate": 5.0,
      "review":
          "Lorem ipsum dolor sit amet consectetur. Vel volutpat turpis a senectus aliquet vghiverra. Libero neque maecenas erat aliquet "
    },
    {
      "image": "assets/review/review-2.png",
      "title": "Courtney Henry",
      "date": "11 ene 2022",
      "rate": 4.5,
      "review":
          "Lorem ipsum dolor sit amet consectetur. Vel volutpat turpis a senectus aliquet vghiverra. Libero neque maecenas erat aliquet "
    },
    {
      "image": "assets/review/review-3.png",
      "title": "Guy Hawkins",
      "date": "12 ene 2022",
      "rate": 4.0,
      "review":
          "Lorem ipsum dolor sit amet consectetur. Vel volutpat turpis a senectus aliquet vghiverra. Libero neque maecenas erat aliquet "
    },
    {
      "image": "assets/review/review-4.png",
      "title": "Brooklyn Simmons",
      "date": "15 ene 2022",
      "rate": 4.5,
      "review":
          "Lorem ipsum dolor sit amet consectetur. Vel volutpat turpis a senectus aliquet vghiverra. Libero neque maecenas erat aliquet "
    },
    {
      "image": "assets/review/review-5.png",
      "title": "Jenny Wilson",
      "date": "15 ene 2022",
      "rate": 3.5,
      "review":
          "Lorem ipsum dolor sit amet consectetur. Vel volutpat turpis a senectus aliquet vghiverra. Libero neque maecenas erat aliquet "
    },
    {
      "image": "assets/review/review-6.png",
      "title": "Bessie Copper",
      "date": "16 ene 2022",
      "rate": 3.0,
      "review":
          "Lorem ipsum dolor sit amet consectetur. Vel volutpat turpis a senectus aliquet vghiverra. Libero neque maecenas erat aliquet "
    },
    {
      "image": "assets/review/review-7.png",
      "title": "Jacob Jones",
      "date": "16 ene 2022",
      "rate": 4.0,
      "review":
          "Lorem ipsum dolor sit amet consectetur. Vel volutpat turpis a senectus aliquet vghiverra. Libero neque maecenas erat aliquet "
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: false,
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
        title: const Text(
          "Reseñas",
          style: bold18Black,
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding / 2.0,
            fixPadding * 2.0, fixPadding / 2),
        itemCount: reviewList.length,
        itemBuilder: (context, index) {
          final reviewData = reviewList[index];
          return Container(
            padding: const EdgeInsets.all(fixPadding),
            margin: const EdgeInsets.only(bottom: fixPadding * 1.5),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: boxShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            reviewData['image'].toString(),
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
                            reviewData['title'].toString(),
                            style: semibold15Black,
                            overflow: TextOverflow.ellipsis,
                          ),
                          heightBox(fixPadding * 0.2),
                          Text(
                            reviewData['date'].toString(),
                            style: semibold14Grey,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    widthSpace,
                    const Icon(
                      Icons.grade_rounded,
                      color: yellowColor,
                      size: 17.0,
                    ),
                    width5Space,
                    Text(
                      reviewData['rate'].toString(),
                      style: medium14Black,
                    )
                  ],
                ),
                heightSpace,
                Text(
                  reviewData['review'].toString(),
                  style: medium14Grey,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
