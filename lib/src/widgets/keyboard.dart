import 'package:android_tv_login_screen/src/data/letters_uppercase.dart';
import 'package:android_tv_login_screen/src/data/symbols.dart';
import 'package:flutter/material.dart';
import 'package:android_tv_login_screen/src/data/numbers.dart';
import 'package:android_tv_login_screen/src/widgets/letter.dart';
import 'package:android_tv_login_screen/src/data/letters_lowercase.dart';

class ATVKeyboard extends StatefulWidget {
  final ValueChanged<Map<String, String>>? onChanged;
  final ValueChanged<bool>? onNext;
  final VoidCallback onLogin;
  final Color bgColor;
  final Color keyboardFocusColor;
  final Color keyboardBorderColor;
  final Color keyboardButtonColor;
  final Color keyboardKeyFontColor;
  final List<String>? customDomains;
  final List<String>? customExtensions;

  ATVKeyboard({
    required this.bgColor,
    required this.keyboardFocusColor,
    required this.keyboardBorderColor,
    required this.keyboardButtonColor,
    required this.keyboardKeyFontColor,
    required this.customDomains,
    required this.customExtensions,
    required this.onChanged,
    required this.onNext,
    required this.onLogin
  });

  @override
  _ATVKeyboardState createState() => _ATVKeyboardState();
}

class _ATVKeyboardState extends State<ATVKeyboard> {
  List<String> labels = [];
  List<String> domains = [];
  List<String> uppercaseSymbolsExtensions = [];
  bool isLowerCase = true;
  bool isSymbols = false;
  bool isEmail = true;
  String email = '';
  String password = '';
  late FocusNode _next;

  List<IconData> icons = [
    Icons.arrow_back,
    Icons.arrow_forward,
    Icons.backspace,
  ];
  

  @override
    void initState() {
      labels.addAll(lowerCase);
      if(widget.customDomains != null){
        domains = widget.customDomains!;
      }
      domains.addAll(['@gmail.com','@outlook.com','@yahoo.com',]);
      uppercaseSymbolsExtensions.addAll(['ABC', '#\$%']);
      if(widget.customExtensions != null){
        uppercaseSymbolsExtensions.addAll(widget.customExtensions!);
      }
      uppercaseSymbolsExtensions.addAll(['.com', '.net', '.org']);
      int uppercaselength = uppercaseSymbolsExtensions.length;
      if(uppercaselength > 5){
        uppercaseSymbolsExtensions.removeRange(5, uppercaselength);
      }
      uppercaseSymbolsExtensions.add('backspace');
      _next = FocusNode();
      super.initState();
    }

  _changeCase(){
    
    if(isLowerCase){
      if(labels[0] == '!'){
        labels.clear();
        setState(() {
        labels.addAll(upperCase);
        isLowerCase = false;
        uppercaseSymbolsExtensions[0] = 'abc';
      });
      } else {
        labels.clear();
        setState(() {
        labels.addAll(upperCase);
        isLowerCase = false;
        uppercaseSymbolsExtensions[0] = 'abc';
      });
      }
    } else {
      labels.clear();
      setState(() {
        uppercaseSymbolsExtensions[0] = 'ABC';
        labels.addAll(lowerCase);
        isLowerCase = true;
      });
    }
  }

  _changeSymbols(){
    if(isSymbols){
      if(labels[0] == 'a' || labels[0] == 'A'){
        labels.clear();
         setState(() {
          labels.addAll(symbols);
        });
      } else {
        labels.clear();
        setState(() {
        labels.addAll(lowerCase);
        isSymbols = false;
      });
      }
    } else {
      labels.clear();
      setState(() {
        labels.addAll(symbols);
        isSymbols = true;
      });
    }
  }

  // Widget _buildControls(IconData iconData, {required Function() onPressed}){
  //   return Container(
  //     height: 30,
  //     child: IconButton(
  //       icon: Icon(iconData, color: widget.keyboardKeyFontColor, size: 20), 
  //       padding: EdgeInsets.zero,
  //       splashRadius: 20,
  //       splashColor: widget.keyboardFocusColor,
  //       focusColor: widget.keyboardFocusColor,
  //       hoverColor: widget.keyboardFocusColor,
  //       color: widget.keyboardFocusColor,
  //       onPressed: onPressed
  //       ),
  //     );
  // }





  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        color: widget.bgColor,
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //numbers 
              GridView.builder(
                shrinkWrap: true,
                itemCount: numbers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10,
                ),
                itemBuilder: (context, index) {
                      return Button(
                        autofocus: index == 0 ? true : false,
                        focusColor: widget.keyboardFocusColor,
                        borderColor: widget.keyboardBorderColor,
                        buttonColor: widget.keyboardButtonColor,
                        label: Text(
                          numbers[index],
                          style: TextStyle(
                            fontSize: 20,
                            color: widget.keyboardKeyFontColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          if(isEmail){
                            email = email + numbers[index];
                            widget.onChanged!({'email': email});
                          } else {
                            password = password + numbers[index];
                            widget.onChanged!({'password': password});
                          }
                          
                        },
                      );
                }),
              //letters - uppercase or lowercase 
              GridView.builder(
                shrinkWrap: true,
                itemCount: labels.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10,
                ),
                itemBuilder: (context, index) {
                      return Button(
                        autofocus: false,
                        focusColor: widget.keyboardFocusColor,
                        borderColor: widget.keyboardBorderColor,
                        buttonColor: widget.keyboardButtonColor,
                        label: Text(
                          labels[index],
                          style: TextStyle(
                            fontSize: 20,
                            color: widget.keyboardKeyFontColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          if(isEmail){
                            email = email + labels[index];
                            widget.onChanged!({'email': email});
                          } else {
                            password = password + labels[index];
                            widget.onChanged!({'password': password});
                          }
                          
                        },
                      );
                }),
              //Buttons - Changecase - symbols - extensions
              GridView.builder(
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      childAspectRatio: 2
                ),
                itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(2),
                        child: RawMaterialButton(
                          // constraints: BoxConstraints(minWidth: 30, maxHeight: 10),
                          highlightElevation: 0,
                          focusElevation: 0,
                          hoverElevation: 0,
                          fillColor: widget.keyboardButtonColor,
                          elevation: 0,
                          focusColor: widget.keyboardFocusColor,
                          // focusNode: _node,
                          onPressed: () {
                            if(index == 0){ //change case
                              _changeCase();
                            } else if(index == 1) { //change to symbols
                              _changeSymbols();
                            } else if(uppercaseSymbolsExtensions[index] == 'backspace'){
                              if(isEmail){
                                email = email.substring(0, email.length - 1);
                                widget.onChanged!({'email': email});
                              } else {
                                password = password.substring(0, password.length -1);
                                widget.onChanged!({'password': password});
                              }
                            } else {
                              if(isEmail){
                                email = email + uppercaseSymbolsExtensions[index];
                                widget.onChanged!({'email': email});
                              } else {
                                password = password + uppercaseSymbolsExtensions[index];
                                widget.onChanged!({'password': password});
                              }
                              
                            }
                          },
                          child: uppercaseSymbolsExtensions[index] != 'backspace' ? Container(
                            height: 20,
                            alignment: Alignment.center,
                            child: Text(
                              uppercaseSymbolsExtensions[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: widget.keyboardKeyFontColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ) : Icon(
                              Icons.backspace,
                              color: widget.keyboardKeyFontColor, size: 20
                            ),
                        ),
                      );
                }),
              //Domains
              GridView.builder(
                shrinkWrap: true,
                itemCount: 3,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 4
                ),
                itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(2),
                        child: RawMaterialButton(
                          constraints: BoxConstraints(maxWidth: 30, maxHeight: 10),
                          highlightElevation: 0,
                          focusElevation: 0,
                          hoverElevation: 0,
                          fillColor: widget.keyboardButtonColor,
                          elevation: 0,
                          focusColor: widget.keyboardFocusColor,
                          // focusNode: _node,
                          onPressed: () {
                            if(isEmail){
                              email = email + domains[index];
                              widget.onChanged!({'email': email});
                            } else {
                              password = password + domains[index];
                              widget.onChanged!({'password': password});
                            }
                            
                          },
                          child: Container(
                            height: 20,
                            alignment: Alignment.center,
                            child: Text(
                              domains[index],
                              style: TextStyle(
                                fontSize: 14,
                                color: widget.keyboardKeyFontColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ),
                        ),
                      );
                }),
                //Domains
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                    // _buildControls(
                    //   Icons.arrow_back, 
                    //   onPressed: (){

                    //   }
                    // ),
                    // _buildControls(
                    //   Icons.arrow_forward, 
                    //   onPressed: (){

                    //   }
                    // ),
                    // _buildControls(
                    //   Icons.backspace, 
                    //   onPressed: (){
                    //     if(isEmail){
                    //       email = email.substring(0, email.length - 1);
                    //       widget.onChanged!({'email': email});
                    //     } else {
                    //       password = password.substring(0, password.length -1);
                    //       widget.onChanged!({'password': password});
                    //     }
                        
                    //   }
                    // ),
                //   ],
                // ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 30,
                      child: RawMaterialButton(
                          constraints: BoxConstraints(maxHeight: 10),
                          padding: EdgeInsets.only(left: 10, right: 10),
                          highlightElevation: 0,
                          focusElevation: 0,
                          hoverElevation: 0,
                          fillColor: widget.keyboardButtonColor,
                          elevation: 0,
                          focusColor: widget.keyboardFocusColor,
                          focusNode: _next,
                          onPressed: () {
                            isEmail ? widget.onNext!(true) : widget.onNext!(false);
                            _next.unfocus();
                            setState(() {
                              isEmail = !isEmail;                       
                            });
                            
                          },
                          child: Container(
                            height: 20,
                            alignment: Alignment.center,
                            child: Text(
                              isEmail ? 'NEXT' : 'BACK',
                              style: TextStyle(
                                fontSize: 14,
                                color: widget.keyboardKeyFontColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ),
                        ),
                      ),
                      isEmail ? Container() : Container(
                      height: 30,
                      child: RawMaterialButton(
                          constraints: BoxConstraints(maxHeight: 10),
                          padding: EdgeInsets.only(left: 10, right: 10),
                          highlightElevation: 0,
                          focusElevation: 0,
                          hoverElevation: 0,
                          fillColor: widget.keyboardButtonColor,
                          elevation: 0,
                          focusColor: widget.keyboardFocusColor,
                          // focusNode: _node,
                          onPressed: () {
                            widget.onLogin();
                          },
                          child: Container(
                            height: 20,
                            alignment: Alignment.center,
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                fontSize: 14,
                                color: widget.keyboardKeyFontColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

}