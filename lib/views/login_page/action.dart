import 'package:fish_redux/fish_redux.dart';

enum LoginPageAction {
  action,
  loginclicked,
  signUp,
  googleSignIn,
  switchLoginMode,
  facebookSignIn,
  appleSignIn,
  sendVerificationCode,
  countryCodeChange,
}

class LoginPageActionCreator {
  static Action onAction() {
    return const Action(LoginPageAction.action);
  }

  static Action onLoginClicked() {
    return const Action(LoginPageAction.loginclicked);
  }

  static Action onSignUp() {
    return const Action(LoginPageAction.signUp);
  }

  static Action onGoogleSignIn() {
    return const Action(LoginPageAction.googleSignIn);
  }

  static Action onAppleSignIn() {
    return const Action(LoginPageAction.appleSignIn);
  }

  static Action switchLoginMode() {
    return const Action(LoginPageAction.switchLoginMode);
  }

  static Action sendVerificationCode() {
    return const Action(LoginPageAction.sendVerificationCode);
  }

  static Action countryCodeChange(String code) {
    return Action(LoginPageAction.countryCodeChange, payload: code);
  }
}
