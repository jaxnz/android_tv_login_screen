import 'package:android_tv_login_screen/src/models/login_result.dart';
import 'package:android_tv_login_screen/src/widgets/keyboard.dart';
import 'package:android_tv_login_screen/src/widgets/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidTVLoginScreen extends StatefulWidget {
  final ValueChanged<ATVLoginResult>? onLogin;
  final bool error;
  final String errorMessage;
  final Color keyboardBackground;
  final Color keyboardKeyFocusColor;
  final Color keyboardKeyBorderColor;
  final Color keyboardButtonColor;
  final Color keyboardKeyFontColor;
  final List<String>? customDomains;
  final List<String>? customExtensions;
  final Color loginScreenBackgroundColor;
  final Widget loginScreenTopWidget;
  final Widget loginScreenBottomWidget;

  const AndroidTVLoginScreen({
     this.onLogin,
     this.error = false,
     this.errorMessage = 'Error logging in',
     this.keyboardBackground = Colors.black87,
     this.keyboardKeyFocusColor = Colors.blue,
     this.keyboardKeyBorderColor = Colors.blue,
     this.keyboardButtonColor = Colors.transparent,
     this.keyboardKeyFontColor = Colors.white70,
     this.customDomains,
     this.customExtensions,
     this.loginScreenBackgroundColor = Colors.blue,
     this.loginScreenTopWidget = const Text('Welcome to Sky Blue', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
     this.loginScreenBottomWidget = const Text('LOGO', style: TextStyle(fontSize: 60, color: Colors.white, fontWeight: FontWeight.bold)),
     });

  @override
  _AndroidTVLoginScreenState createState() => _AndroidTVLoginScreenState();
}

class _AndroidTVLoginScreenState extends State<AndroidTVLoginScreen> {
  late ValueNotifier<String> email = ValueNotifier<String>('');
  late ValueNotifier<String> password = ValueNotifier<String>('');
  late ValueNotifier<bool> isEmail = ValueNotifier<bool>(true);
  late ValueNotifier<int> emailSelectionOffset = ValueNotifier<int>(0);


  @override
    void dispose() {
      email.dispose();
      password.dispose();
      isEmail.dispose();
      emailSelectionOffset.dispose();
      super.dispose();
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
        },
        child: Row(
          children: [
            ATVKeyboard(
              bgColor: widget.keyboardBackground,
              keyboardFocusColor: widget.keyboardKeyFocusColor,
              keyboardBorderColor: widget.keyboardKeyBorderColor,
              keyboardButtonColor: widget.keyboardButtonColor,
              keyboardKeyFontColor: widget.keyboardKeyFontColor,
              customDomains: widget.customDomains,
              customExtensions: widget.customExtensions,
              onChanged: (value){
                if(isEmail.value == true ){
                  String newEmailValue = value['email']!;
                  // email.value.length < newEmailValue.length ? emailSelectionOffset.value++ : emailSelectionOffset.value--;
                  email.value = newEmailValue;
                } else {
                  String newPasswordValue = value['password']!;
                  password.value = newPasswordValue;
                }
              },
              onNext: (value){
                isEmail.value = !value;
              },
              onLogin: (){
                widget.onLogin!(ATVLoginResult(email: email.value, password: password.value));
              },
            ),
            AnimatedBuilder(
              animation: Listenable.merge([email, password, isEmail, emailSelectionOffset]),
              builder: (BuildContext context, _){
              return ATVLoginScreen(
                  email: email.value,
                  password: password.value,
                  isEmail: isEmail.value,
                  backgroundColor: widget.loginScreenBackgroundColor,
                  loginScreenTopWidget: widget.loginScreenTopWidget,
                  loginScreenBottomWidget: widget.loginScreenBottomWidget,
                  error: widget.error,
                  errorMessage: widget.errorMessage,
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}