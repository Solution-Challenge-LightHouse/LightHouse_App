import 'package:flutter/material.dart';
import 'package:flutterlogin/lighthouse/math_problem/middle1/middle1_main.dart';

class HomeScreenTop extends StatelessWidget {
  const HomeScreenTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Math problem',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 350,
            width: 600,
            decoration: BoxDecoration(
                color: const Color(0xFFF5F3FF),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFFAC9AF9),
                        minimumSize: const Size(320, 80)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const Middle1_Main_Screen()));
                    },
                    child: const Text(
                      'Middle school grade 1',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 172, 154, 249),
                        minimumSize: const Size(320, 80)),
                    onPressed: () {},
                    child: const Text('Middle school grade 1',
                        style: TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 172, 154, 249),
                        minimumSize: const Size(320, 80)),
                    onPressed: () {},
                    child: const Text('Middle school grade 1',
                        style: TextStyle(fontSize: 20)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
