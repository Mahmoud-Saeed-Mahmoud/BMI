import 'dart:math';

import 'package:bmi/result.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMale = true;
  double heightVal = 170;
  int wieght = 55;
  int age = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Body Mass Index'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  buildExpanded1(context, 'Male'),
                  const SizedBox(
                    width: 15,
                  ),
                  buildExpanded1(context, 'Female'),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Height',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          heightVal.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'CM',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    Slider(
                      min: 90,
                      max: 300,
                      value: heightVal,
                      onChanged: (newVal) => setState(() => heightVal = newVal),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  buildExpanded2(context, 'Weight'),
                  const SizedBox(
                    width: 15,
                  ),
                  buildExpanded2(context, 'Age'),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.teal,
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .05,
            child: TextButton(
              onPressed: () {
                var result = wieght / pow((heightVal / 100), 2);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Result(result: result, isMale: isMale, age: age),
                  ),
                );
              },
              child: const Text(
                'Calculate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Expanded buildExpanded1(BuildContext context, String gender) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isMale = gender == 'Male' ? true : false),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:
                (isMale && gender == 'Male') || (!isMale && gender == 'Female')
                    ? Colors.teal
                    : Colors.blueGrey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                gender == 'Male' ? Icons.male : Icons.female,
                size: 90,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                gender == 'Male' ? 'Male' : 'Female',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildExpanded2(BuildContext context, String text) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.blueGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text == 'Age' ? 'Age' : 'Weight',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              text == 'Age' ? '$age' : '$wieght',
              style: Theme.of(context).textTheme.headline1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: text == 'Age' ? 'age--' : 'weight--',
                  onPressed: () =>
                      setState(() => text == 'Age' ? age -= 1 : wieght -= 1),
                  child: const Icon(
                    Icons.remove,
                  ),
                  mini: true,
                ),
                const SizedBox(
                  width: 15,
                ),
                FloatingActionButton(
                  heroTag: text == 'Age' ? 'age++' : 'weight++',
                  onPressed: () =>
                      setState(() => text == 'Age' ? age += 1 : wieght += 1),
                  child: const Icon(
                    Icons.add,
                  ),
                  mini: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
