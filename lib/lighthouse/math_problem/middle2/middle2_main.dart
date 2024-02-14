import 'package:flutter/material.dart';
import 'package:lighthouse/lighthouse/HomeScreen/appbar.dart';
import 'package:lighthouse/lighthouse/math_problem/middle1/middle1_1.dart';
import 'package:lighthouse/lighthouse/math_problem/middle1/middle1_all.dart';
import 'package:lighthouse/lighthouse/math_problem/middle2/middle2_1.dart';
import 'package:lighthouse/lighthouse/math_problem/middle2/middle2_2.dart';
import 'package:lighthouse/lighthouse/math_problem/middle2/middle2_3.dart';
import 'package:lighthouse/lighthouse/math_problem/middle2/middle2_4.dart';

class Middle2_Main_Screen extends StatelessWidget {
  const Middle2_Main_Screen({super.key});

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
                'Middle school grade 2',
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
                              builder: (_) => const Middle2_1()));
                        },
                        child: const Text(
                          '유한소수,무한소수,순환소수',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            minimumSize: const Size(320, 80)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const Middle2_2()));
                        },
                        child: const Text('다항식과 다항식',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            minimumSize: const Size(320, 80)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const Middle2_3()));
                        },
                        child: const Text('삼각형과 사각형, 피타고라스 정리',
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
                              builder: (_) => const Middle2_4()));
                        },
                        child: const Text('확률',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
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
