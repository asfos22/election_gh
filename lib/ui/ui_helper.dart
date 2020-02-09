import 'package:flutter/material.dart';

class UIHelper {
  // STRING
  static final String appName = "Vote GH";
  static final String createAccount = "Create\nAccount";
  static final String welcomeBack = "Welcome\nBack";
  static final String name = "Name";
  static final String hello = "Hello";
  static final String email = "Email address";
  static final String username = "Username";
  static final String password = "Password";
  static final String psCode = "Polling Station Code";
  static final String voterID = "Voter ID";
  static final String age = "Age";
  static final String dob = "DOB";
  static final String login = "Login";
  static final String signIn = "Sign In";
  static final String signUp = "SIGN UP";
  static final String uploadVoterID = "Upload Voter ID";
  static final String signInLower = "Sign in";
  static final String signUpLower = "Sign up";
  static final String genderMale = "Male";
  static final String genderFemale = "Female";
  static final String selectGender = "Select gender";
  static final String selectVoterID = "Select Voter ID";
  static final String selectCandidate = "Candidate voting";
  static final String openCamera = "Open Camera";
  static final String selectGallery = "Open Gallery";
  static final String submit = "Submit";
  static final String verify = "Verify";

  //static final String chooseVoterID = "Choose Voter ID"
  static final String chooseVoterID = "Choose Voter ID photo";
  static final String noInternet = "No internet avaiable, try again";
  static final String notAvailable = "Not available";
  static final String chooseImage = "Please select photo of your voter id";

  //static final String  upload = "Submit";
  static final String stayLoggedIn = "Stay Logged In";
  static final String forgetPassword = "Forget PsCode?";
  static final String loginSpotify = "LOG IN WITH SPOTIFY ";
  static final String loginFacebook = "Login with Facebook";
  static final String emailRequired = "Email is required";
  static final String passwordRequired = "Password is required";
  static final String dontHaveAnAccount = "Don't have an account?";
  static final String verifyAccount = "Already register? Verify your Voter ID";
  static final String done = "Done";
  static final String next = "Next";
  static final String enterVoterID = "Enter voter ID";
  static final String enterPSCode = "Enter polling station code";

  static const String sliderHeaderOne = "Your vote, your power!";
  static const String sliderHeaderTwo = "Easy to express your self!";
  static const String sliderHeaderThree = "Connect with Others";
  static const String sliderDesc =
      "The official Ghana election  app for 2020 presidential app";
  static const String sliderDescSecondary =
      "One vote, one candidate, Vote. It’s what keeps our democracy.";
  static const String sliderDescAlt =
      "Vote as if your life and country cepends on it.";

  // -- click
  static final String upload = "upload";

  // IMAGES

  static final String sliderAssetOne = "assets/images/collabo.png";
  static final String sliderAssetTwo = "assets/images/slide_2.png";
  static final String sliderAssetThree = "assets/images/slide_3.png";

  // preference

  static const String isInstall = "is-install";
  static const String isRegistered = "voter-preference";

  static const Color THEME_PRIMARY = Color(0XFF575C79);
  static const Color THEME_LIGHT = Color(0XFF8489A8);
  static const Color THEME_DARK = Color(0XFF2D334D);

  static const Color colorGrey = Color(0xFF616161);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorBlue = Color(0xFF4D7DF9);
  static const Color colorLightGrey = Color(0xFFF1F0F2);
  static const Color colorRed = Color(0xFFFE0000);
  static const Color colorYellow = Color(0xFFFFFF00);
  static const Color colorGreen = Color(0xFF4CAF50);
  static const Color colorRedSecondary = Color(0xFFC40000);
  static const Color colorNavyBlue = Color(0xFF4D7DF9);
  static const Color colorBlueSecondary = Color(0xFF5A7BB5);
  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFFFFFF);
  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);

  // SPACE
  static dynamicHeight(double height) => 170;

  static dynamicWidth(double width) => 110;

  static dynamicSp(double fontsize) => 102;

  // CANDIDATE
  static const String nanaAkufoAddo = "Nana Akufo-Addo";
  static const String johnDramaniMahama = "John Dramani Mahama";
  static const String vote = "VOTE";

  //-- Validation

  // Input validation message
  static String invalidEmailAddressText = "Invalid email address";
  static String invalidPasswordText = "Invalid Password";
  static String invalidPSCodeText = "Invalid Polling Station Code";
  static String emptyPSCodeText = "Please enter Polling Station Code";
  static String emptyDOBText = "Please Select DOB";
  static String invalidVoterIDText = "Invalid Voter ID Number";
  static String emptyVoterNumberText = "Please enter Voter ID Number";
  static String emptyPasswordText = "Please insert the Password";
  static String emptyEmailText = "Please insert the Email";
  static String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static String invalidConfirmPasswordText = "Password not match";

  // --style
  static final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
  static final normalTextStyle = baseTextStyle.copyWith(
      color: UIHelper.colorGrey, fontSize: 16.0, fontWeight: FontWeight.w900);
}
