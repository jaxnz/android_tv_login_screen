import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Function? onPressed;
  final Widget label;
  final Color? borderColor;
  final Color buttonColor;
  final Color? focusColor;
  final bool autofocus;
  Button({
    required this.label,
    this.onPressed,
    required this.autofocus,
    this.borderColor,
    this.focusColor,
    required this.buttonColor,
  });

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  FocusNode? _node;

  @override
  void initState() {
    _node = new FocusNode();
    super.initState();
  }

  @override
    void dispose() {
      _node!.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      child: RawMaterialButton(
        constraints: BoxConstraints(minWidth: 30, minHeight: 30),
        highlightElevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        autofocus: widget.autofocus,
        fillColor: widget.buttonColor,
        elevation: 0,
        focusColor: widget.focusColor ?? widget.focusColor,
        focusNode: _node,
        onPressed: () {
          widget.onPressed!();
        },
        child: Container(
        alignment: Alignment.center,
        child: widget.label,
      ),
      ),
    );
  }
}