import 'package:flutter/material.dart';
import 'package:lighthouse/lighthouse/HomeScreen/appbar.dart';
import 'package:lighthouse/lighthouse/math_problem/middle1/middle1_1.dart';
import 'package:lighthouse/lighthouse/math_problem/middle1/middle1_main.dart';
import 'package:lighthouse/lighthouse/math_problem/middle2/middle2_main.dart';
import 'package:lighthouse/lighthouse/math_problem/middle3/middle3_main.dart';

class mathproblemmain extends StatelessWidget {
  const mathproblemmain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar('Math Problem'),
      // drawer: drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Math problem',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
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
                            backgroundColor:
                                const Color.fromARGB(255, 172, 154, 249),
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
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const Middle2_Main_Screen()));
                        },
                        child: const Text('Middle school grade 2',
                            style: TextStyle(fontSize: 20)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 172, 154, 249),
                            minimumSize: const Size(320, 80)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const Middle3_Main_Screen()));
                        },
                        child: const Text('Middle school grade 3',
                            style: TextStyle(fontSize: 20)),
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
