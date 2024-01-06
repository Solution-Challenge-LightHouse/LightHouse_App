// 1 - 수와연산
// 2 - 문자와식
// 3 - 함수
// 4 - 기하
// 5 - 확률과통계

import 'package:flutter/material.dart';
import 'package:flutterlogin/lighthouse/HomeScreen/appbar.dart';
import 'package:flutterlogin/lighthouse/HomeScreen/drawer.dart';

class Middle1_Main_Screen extends StatelessWidget {
  const Middle1_Main_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      drawer: const drawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 35),
            const Text(
              'Middle school grade 1',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 15),
            Container(
              height: 600,
              width: 600,
              decoration: BoxDecoration(
                  color: const Color(0xFFF5F3FF),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(320, 80)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const Middle1_Main_Screen()));
                      },
                      child: const Text(
                        'Numbers and operations',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(320, 80)),
                      onPressed: () {},
                      child: const Text('characters and expressions',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          minimumSize: const Size(320, 80)),
                      onPressed: () {},
                      child: const Text('function',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(
                            320,
                            80,
                          )),
                      onPressed: () {},
                      child: const Text('Geometry',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(
                            320,
                            80,
                          )),
                      onPressed: () {},
                      child: const Text('Probability and Statistics',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
