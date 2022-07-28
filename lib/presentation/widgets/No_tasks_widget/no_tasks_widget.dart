import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoTasksElement extends StatelessWidget {
  const NoTasksElement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'You don\'t have any Tasks Yet ..!',
            style: TextStyle(
                color: Color(0xff0097A7),
                fontSize: 20,
            fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Spin(duration: const Duration(seconds: 4), child: const Fan()),
              Spin(duration: const Duration(seconds: 4), child: const Fan()),
              Spin(duration: const Duration(seconds: 4), child: const Fan()),
            ],
          ),
        ]),
      ),
    );
  }
}

class Fan extends StatelessWidget {
  const Fan({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const IconButton(
        onPressed: null,
        icon: Icon(
          FontAwesomeIcons.clipboardList,
          color: Colors.blueAccent,
          size: 50,
        ));
  }
}
