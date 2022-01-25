import 'package:flutter/material.dart';

class EmptyListContent extends StatelessWidget {
  const EmptyListContent({
    Key? key,
    this.message = "Add tasks to get started",
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "images/empty-box.jpg",
            width: 300,
            height: 200,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
