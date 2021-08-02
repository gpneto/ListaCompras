import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:ui' as ui;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lista_compras/actions/user_info_operate.dart';
import 'package:lista_compras/routes/routes.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'action.dart';
import 'state.dart';
import 'package:toast/toast.dart';

Effect<LoginPageState> buildEffect() {
  return combineEffects(<Object, Effect<LoginPageState>>{
    LoginPageAction.action: _onAction,
    LoginPageAction.loginclicked: _onLoginClicked,
    LoginPageAction.signUp: _onSignUp,
    LoginPageAction.googleSignIn: _onGoogleSignIn,
    LoginPageAction.appleSignIn: _onAppleSignIn,

    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose
  });
}

final FirebaseAuth _auth = FirebaseAuth.instance;
void _onInit(Action action, Context<LoginPageState> ctx) async {
  ctx.state..emailLogin = true;
  ctx.state.accountFocusNode = FocusNode();
  ctx.state.pwdFocusNode = FocusNode();
  final Object ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 2000));
  ctx.state.submitAnimationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 1000));
  ctx.state.accountTextController = TextEditingController();
  ctx.state.passWordTextController = TextEditingController();
  ctx.state.phoneTextController = TextEditingController();
  ctx.state.codeTextContraller = TextEditingController();
  ctx.state.countryCode = '+1';


}

void _onBuild(Action action, Context<LoginPageState> ctx) {
  Future.delayed(Duration(milliseconds: 150),
      () => ctx.state.animationController.forward());
}

void _onDispose(Action action, Context<LoginPageState> ctx) {
  ctx.state.animationController.dispose();
  ctx.state.accountFocusNode.dispose();
  ctx.state.pwdFocusNode.dispose();
  ctx.state.submitAnimationController.dispose();
  ctx.state.accountTextController.dispose();
  ctx.state.passWordTextController.dispose();
  ctx.state.phoneTextController.dispose();
  ctx.state.codeTextContraller.dispose();
}

void _onAction(Action action, Context<LoginPageState> ctx) {}

Future _onLoginClicked(Action action, Context<LoginPageState> ctx) async {
  // UserCredential _result;
  // ctx.state.submitAnimationController.forward();
  // if (ctx.state.emailLogin)
  //   _result = await _emailSignIn(action, ctx);
  //
  // if (_result?.user == null) {
  //   Toast.show("Account verification required", ctx.context,
  //       duration: 3, gravity: Toast.BOTTOM);
  //   ctx.state.submitAnimationController.reverse();
  // } else {
  //   var user = _result?.user;
  //   var _nickName = user.displayName ??
  //       user.phoneNumber.substring(user.phoneNumber.length - 4);
  //
  //   if (user.displayName == null)
  //     user
  //         .updateProfile(UserUpdateInfo()..displayName = _nickName)
  //         .then((v) => UserInfoOperate.whenLogin(user, _nickName));
  //   UserInfoOperate.whenLogin(user, _nickName);
  //   Navigator.of(ctx.context).pop({'s': true, 'name': _nickName});
  // }
}

Future<UserCredential> _emailSignIn(
    Action action, Context<LoginPageState> ctx) async {
  if (ctx.state.accountTextController.text != '' &&
      ctx.state.passWordTextController.text != '') {
    try {
      final _email = ctx.state.accountTextController.text.trim();
      return await _auth.signInWithEmailAndPassword(
          email: _email, password: ctx.state.passWordTextController.text);
    } on Exception catch (e) {
      Toast.show(e.toString(), ctx.context, duration: 3, gravity: Toast.BOTTOM);
      ctx.state.submitAnimationController.reverse();
    }
  }
  return null;
}



Future _onSignUp(Action action, Context<LoginPageState> ctx) async {
  // Navigator.of(ctx.context)
  //     .push(PageRouteBuilder(pageBuilder: (context, an, _) {
  //   return FadeTransition(
  //     opacity: an,
  //     child: RegisterPage().buildPage(null),
  //   );
  // })).then((results) {
  //   // if (results is PopWithResults) {
  //   //   PopWithResults popResult = results;
  //   //   if (popResult.toPage == 'mainpage')
  //   //     Navigator.of(ctx.context).pop(results.results);
  //   // }
  // });
}


/// Generates a cryptographically secure random nonce, to be included in a
/// credential request.
String generateNonce([int length = 32]) {
  final charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}


void _onGoogleSignIn(Action action, Context<LoginPageState> ctx) async {
  ctx.state.submitAnimationController.forward();


  try {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (googleUser == null)
      return ctx.state.submitAnimationController.reverse();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final User user =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);



    if(googleUser.displayName != null && _auth.currentUser.displayName != googleUser.displayName){
      await _auth.currentUser.updateDisplayName(googleUser.displayName);
    }


    if(googleUser.email != null && _auth.currentUser.email != googleUser.email ){
      await _auth.currentUser.updateEmail(googleUser.email);
    }

    if(googleUser.photoUrl != null && _auth.currentUser.photoURL != googleUser.photoUrl ){
      await _auth.currentUser.updatePhotoURL(googleUser.photoUrl);
    }

    assert(user.uid == _auth.currentUser.uid);
    await user.reload();
    if (user != null) {
      UserInfoOperate.whenLogin(_auth.currentUser, _auth.currentUser.displayName);

      await Navigator.of(ctx.context).pushReplacement(PageRouteBuilder(
          pageBuilder: (_, __, ___) {
            return Routes.routes.buildPage('mainpage', {
              'pages': List<Widget>.unmodifiable([
                Routes.routes.buildPage('homePage', null),
                Routes.routes.buildPage('discoverPage', null),
                Routes.routes.buildPage('configPage', null)
              ])
            });
          },
          settings: RouteSettings(name: 'mainpage')));



    } else {
      ctx.state.submitAnimationController.reverse();
      Toast.show("Google signIn fail", ctx.context,
          duration: 3, gravity: Toast.BOTTOM);
    }
  } on Exception catch (e) {
    ctx.state.submitAnimationController.reverse();
    Toast.show(e.toString(), ctx.context, duration: 5, gravity: Toast.BOTTOM);
  }
}

Future<User> signInWithApple() async {
  // To prevent replay attacks with the credential returned from Apple, we
  // include a nonce in the credential request. When signing in in with
  // Firebase, the nonce in the id token returned by Apple, is expected to
  // match the sha256 hash of `rawNonce`.
  final rawNonce = generateNonce();
  final nonce = sha256ofString(rawNonce);

  try {
    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    print(appleCredential.authorizationCode);

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    final authResult =
    await _auth.signInWithCredential(oauthCredential);

    final displayName =
        '${appleCredential.givenName} ${appleCredential.familyName}';
    final userEmail = '${appleCredential.email}';

    final firebaseUser = authResult.user;
    print(displayName);
    if(appleCredential.givenName != null ){
      await firebaseUser.updateDisplayName(displayName);
    }


    if(appleCredential.email != null ){
      await firebaseUser.updateEmail(userEmail);
    }
    await authResult.user.reload();

    return _auth.currentUser;
  } catch (exception) {
    print(exception);
  }
}



void _onAppleSignIn(Action action, Context<LoginPageState> ctx) async {
  ctx.state.submitAnimationController.forward();

  User user = await signInWithApple();
  if (user != null) {
    UserInfoOperate.whenLogin(user, user.displayName);

    await Navigator.of(ctx.context).pushReplacement(PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return Routes.routes.buildPage('mainpage', {
            'pages': List<Widget>.unmodifiable([
              Routes.routes.buildPage('homePage', null),
              Routes.routes.buildPage('discoverPage', null),
              Routes.routes.buildPage('configPage', null)
            ])
          });
        },
        settings: RouteSettings(name: 'mainpage')));



  } else {
    ctx.state.submitAnimationController.reverse();
    Toast.show("Google signIn fail", ctx.context,
        duration: 3, gravity: Toast.BOTTOM);
  }
}

