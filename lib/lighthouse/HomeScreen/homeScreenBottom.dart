import 'package:flutter/material.dart';

class HomeScreenBottom extends StatelessWidget {
  const HomeScreenBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Community',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
              height: 300,
              width: 600,
              decoration: BoxDecoration(
                  color: const Color(0xFFF5F3FF),
                  borderRadius: BorderRadius.circular(10)))
        ],
      ),
    );
  }
}
