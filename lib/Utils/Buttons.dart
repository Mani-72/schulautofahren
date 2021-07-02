import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final BuildContext context;
  CreateButton(this.onPressed, this.text, this.context);
  @override
  Widget build(BuildContext context) {
    return CreateButtonStateFul(onPressed, text, context);
  }
}

class CreateButtonStateFul extends StatefulWidget {
  final Function onPressed;
  final String text;
  final BuildContext context;
  CreateButtonStateFul(this.onPressed, this.text, this.context);

  @override
  State<StatefulWidget> createState() =>
      _CreateButton(onPressed, text, context);
}

class _CreateButton extends State<CreateButtonStateFul>
    with TickerProviderStateMixin {
  final Function onPressed;
  final String text;
  final BuildContext context;
  _CreateButton(this.onPressed, this.text, this.context);
  double _scale;
  AnimationController _controller;
  BuildContext cont;
  @override
  void initState() {
    print(text);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 50),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    cont = context;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            // onLongPressEnd: _onLongPressEnd,
            onHorizontalDragEnd: _onDragDown,
            child: Material(
              borderRadius: BorderRadius.circular(100.0),
              elevation: 0,
              child: Transform.scale(
                scale: _scale,
                child: _animatedButtonUI(context),
              ),
              // ElevatedButton(
              //   style: ButtonStyle(
              //     elevation: MaterialStateProperty.all(0),
              //     backgroundColor: MaterialStateProperty.resolveWith<Color>(
              //       (Set<MaterialState> states) {
              //         if (states.contains(MaterialState.pressed))
              //           return Theme.of(context)
              //               .colorScheme
              //               .primary
              //               .withOpacity(0.5);

              //         return null; // Use the component's default.
              //       },
              //     ),
              //   ),
              //   child: Text(text),
              // onPressed: () => onPressed(context),
              // ),
            ),
          ),
        ),
      ],
    );
  }

  List<Color> gradientColors = [
    Color(0xFF0000FF),
    Color(0xFFFF3400),
  ];

  Widget _animatedButtonUI(BuildContext cont) => Container(
        height: 50.0,
        // width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x80000000),
              offset: Offset(0, 5),
              blurRadius: 30,
            ),
          ],
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    print("Tap Down");
    _controller.forward();
    gradientColors = [
      Color(0xFFFF3400),
      Color(0xFF0000FF),
    ];
  }

  void _onDragDown(DragEndDetails details) {
    print("Drag Down");
    _controller.reverse();
    gradientColors = [
      Color(0xFF0000FF),
      Color(0xFFFF3400),
    ];
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    print("Long Press End");

    _controller.reverse();
    gradientColors = [
      Color(0xFF0000FF),
      Color(0xFFFF3400),
    ];
    onPressed(cont);
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();

    gradientColors = [
      Color(0xFF0000FF),
      Color(0xFFFF3400),
    ];
    print(onPressed);
    onPressed(cont);
    print("Tap UP");
  }
}
