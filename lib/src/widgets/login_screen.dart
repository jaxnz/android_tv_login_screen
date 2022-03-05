import 'package:flutter/material.dart';


class ATVLoginScreen extends StatefulWidget {
  final String email;
  final String password;
  final bool isEmail;
  final Color backgroundColor;
  final Widget loginScreenTopWidget;
  final Widget loginScreenBottomWidget;
  final bool error;
  final String errorMessage;
  const ATVLoginScreen({
    required this.isEmail,
    required this.email,
    required this.password,
    required this.backgroundColor,
    required this.loginScreenTopWidget,
    required this.loginScreenBottomWidget,
    required this.error,
    required this.errorMessage,
   });

  @override
  _ATVLoginScreenState createState() => _ATVLoginScreenState();
}

class _ATVLoginScreenState extends State<ATVLoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  FocusNode _nodeEmail = FocusNode();
  FocusNode _nodePassword = FocusNode();


  
  @override
  Widget build(BuildContext context) {
     _email.value = _email.value.copyWith(
        text: widget.email,
        // selection: TextSelection.collapsed(offset: widget.emailSelectionOffset),
      );
    _password.value = _password.value.copyWith(
        text: widget.password,
        // selection: TextSelection.collapsed(offset: widget.emailSelectionOffset),
      );
    return Expanded(
      flex: 7,
      child: Container(
        color: widget.backgroundColor,
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(50),
                child: widget.loginScreenTopWidget,
              ),
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                height: 30,
                decoration: BoxDecoration(
                  border: widget.isEmail ? Border(bottom: BorderSide(color: Colors.white, width: 2.0)) : Border(bottom: BorderSide(color: Colors.white, width: 1.0)),
                ),
                child: TextFormField(
                  controller: _email,
                  autofocus: false,
                  focusNode: _nodeEmail,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'Email Address', 
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  readOnly: true,
                  showCursor: true,
                  
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  border: widget.isEmail ? Border(bottom: BorderSide(color: Colors.white, width: 1.0)) : Border(bottom: BorderSide(color: Colors.white, width: 2.0)),
                ),
                child: TextFormField(
                  controller: _password,
                  obscureText: true,
                  autofocus: false,
                  focusNode: _nodePassword,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Password', 
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.white),
                  readOnly: true,
                  showCursor: true,
                  enabled: false,
                ),
              ),
              widget.error ? Container(
                padding: EdgeInsets.all(10),
                child: Text(widget.errorMessage, style: TextStyle(color: Colors.red),),
              ) : Container(),
              Container(
                padding: EdgeInsets.only(top: 50),
                child: widget.loginScreenBottomWidget,
              ),
            ],
          ),
        ),
      ),
    );
  }
}