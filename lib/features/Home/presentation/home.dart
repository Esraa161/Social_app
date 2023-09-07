import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
           alignment: Alignment.bottomCenter,
            children: [
              Card(
                shadowColor: Colors.grey,
                child: Lottie.asset('assets/images/animation_lm7sa99z.json',
                    height: MediaQuery.of(context).size.height/3,
                width: double.infinity),

                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Communicate with friendes",
                style: TextStyle(color:  Color.fromARGB(202, 36, 30, 98),),),
              )
            ],
          ),
        )
      ],
    );
  }
}
