// 1 - 수와연산
// 2 - 문자와식
// 3 - 함수
// 4 - 기하
// 5 - 확률과통계

import 'package:flutter/material.dart';
import 'package:lighthouse/lighthouse/HomeScreen/appbar.dart';
import 'package:lighthouse/lighthouse/HomeScreen/drawer.dart';
import 'package:lighthouse/lighthouse/math_problem/middle1/middle1_1.dart';
import 'package:lighthouse/lighthouse/math_problem/middle1/middle1_all.dart';
import 'package:lighthouse/lighthouse/math_problem/middle3/middle3_1.dart';
import 'package:lighthouse/lighthouse/math_problem/middle3/middle3_2.dart';
import 'package:lighthouse/lighthouse/math_problem/middle3/middle3_3.dart';
import 'package:lighthouse/lighthouse/math_problem/middle3/middle3_4.dart';
import 'package:lighthouse/lighthouse/math_problem/middle3/middle3_5.dart';

class Middle3_Main_Screen extends StatelessWidget {
  const Middle3_Main_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar('Math Problem'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 35),
              const Text(
                'Middle school grade 3',
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
                              builder: (_) => const Middle3_1()));
                        },
                        child: const Text(
                          '제곱근과 실수',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            minimumSize: const Size(320, 80)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const Middle3_2()));
                        },
                        child: const Text('다항식의 곱셈과 인수분해',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            minimumSize: const Size(320, 80)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const Middle3_3()));
                        },
                        child: const Text('이차방정식',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            minimumSize: const Size(
                              320,
                              80,
                            )),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const Middle3_4()));
                        },
                        child: const Text('삼각비',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: const Size(
                              320,
                              80,
                            )),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const Middle3_5()));
                        },
                        child: const Text('원의 성질',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
