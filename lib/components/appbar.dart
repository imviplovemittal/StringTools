import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Image.asset(
                'assets/images/icon.png',
                height: 50,
              ),
              SizedBox(
                width: 10,
              ),
              Text("String Tools"),
            ],
          ),
        ),
        Row(
          children: [
            NavButton(context, '/split-to-lines', 'Split to lines'),
            NavButton(context, '/collate', 'Collate Text'),
            NavButton(context, '/', 'Home'),
          ],
        )
      ],
    ),
  );
}

class NavButton extends StatelessWidget {
  final BuildContext context;
  final String route;
  final String buttonText;

  const NavButton(this.context, this.route, this.buttonText);

  @override
  Widget build(BuildContext context) {
    var currentRoute = ModalRoute.of(context)!.settings.name;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            decoration: (currentRoute == route) ? TextDecoration.underline : TextDecoration.none,
            fontWeight: (currentRoute == route) ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
