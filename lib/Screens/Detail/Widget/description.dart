import 'package:flutter/material.dart';
import 'package:flutter_application_3/Screens/video/video_screen.dart';
import 'package:flutter_application_3/Utiles/colors.dart';

class Description extends StatelessWidget {
  final String description;
  const Description({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xffff660e),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => _navigateToVideoPage(context),
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: kprimaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "فيديو",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            const Text(
              "شرح الكورس",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  void _navigateToVideoPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => VideoListScreen(),
      ),
    );
  }
}
