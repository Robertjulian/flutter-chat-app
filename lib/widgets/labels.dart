import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String subtitle;
  final String title;

  const Labels(
      {Key? key,
      required this.route,
      required this.subtitle,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.blue.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, route);
            },
          ),
        ],
      ),
    );
  }
}
