import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, {String? pageName}) {
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
              Text(pageName ?? "String Tools"),
            ],
          ),
        ),
        CustomizedAppBarLinks(
          context,
          {'/split-to-lines': 'Split to lines', '/collate': 'Collate Text', '/': 'Home', '/list-tools': 'List Tools'},
        ),
      ],
    ),
  );
}

class CustomizedAppBarLinks extends StatefulWidget {
  final BuildContext context;
  final Map<String, String> buttons;

  const CustomizedAppBarLinks(this.context, this.buttons);

  @override
  _CustomizedAppBarLinksState createState() => _CustomizedAppBarLinksState();
}

class _CustomizedAppBarLinksState extends State<CustomizedAppBarLinks> {
  GlobalKey key = LabeledGlobalKey("button_icon");
  late OverlayEntry overlayEntry;
  Size? buttonSize;
  Offset? buttonPosition;
  bool isMenuOpen = false;

  findButton() {
    RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    buttonSize = renderBox?.size;
    buttonPosition = renderBox?.localToGlobal(Offset.zero);
  }

  getList() {
    print(widget.buttons);
    return Container(
        height: widget.buttons.length * buttonSize!.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: ListView(
          children: [for (var row in widget.buttons.entries) Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: TextButton(onPressed: () {
              closeMenu();
              Navigator.pushNamed(context, row.key);
            }, child: Text(row.value)),
          )],
          shrinkWrap: true,
        ));
  }

  overlayEntryBuilder() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        top: buttonPosition!.dy + buttonSize!.height,
        right: MediaQuery.of(context).size.width - buttonPosition!.dx - buttonSize!.width,
        width: 100.0,
        child: Material(
          color: Colors.transparent,
          child: getList(),
        ),
      );
    });
  }

  void openMenu() {
    findButton();
    overlayEntry = overlayEntryBuilder();
    Overlay.of(context)!.insert(overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  void closeMenu() {
    overlayEntry.remove();
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (height > width) {
      return Container(
        key: key,
        decoration: BoxDecoration(
          color: Color(0xFFF5C6373),
          borderRadius: BorderRadius.circular(4),
        ),
        child: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {
            if (isMenuOpen) {
              closeMenu();
            } else {
              openMenu();
            }
          },
        ),
      );
    } else {
      return Row(
        children: [for (var row in widget.buttons.entries) NavButton(context, row.key, row.value)],
      );
    }
  }
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
