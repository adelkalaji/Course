import 'package:flutter_application_3/controller/course.dart';
import 'package:flutter_application_3/models/course.dart';
import 'package:flutter_application_3/provider/favorite_provider.dart';
import 'package:flutter_application_3/Utiles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/Detail/detail_screen.dart';

class FavoriteProduct extends StatefulWidget {
  final Course product;
  final int index;
  const FavoriteProduct(
      {super.key, required this.product, required this.index});

  @override
  State<FavoriteProduct> createState() => _FavoriteProductState();
}

@override
void initState() {}

class _FavoriteProductState extends State<FavoriteProduct> {
  @override
  Widget build(BuildContext context) {
    try {
      final provider = FavoriteProvider.of(context);
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(product: widget.product),
            ),
          );
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kcontentColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Center(
                    child: Hero(
                      tag: widget.product,
                      child: Image.network(
                        CourseApiController.FavoriteCourses.elementAt(
                                widget.index)
                            .courseImage!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "${CourseApiController.FavoriteCourses.elementAt(widget.index).courseName}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${CourseApiController.FavoriteCourses.elementAt(widget.index).teacherName}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
                child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: kprimaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    provider.toggleFavorite(widget.product);
                  },
                  child: Icon(
                    provider.isExist(widget.product)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ))
          ],
        ),
      );
    } catch (e) {
      return const Text("refre");
    }
  }
}
