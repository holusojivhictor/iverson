import 'package:iverson/domain/assets.dart';
import 'package:iverson/domain/enums/enums.dart';

import 'models/language_model.dart';
import 'models/splash/splash_data.dart';

const kPadding = 10.0;
const kAnimationDuration = Duration(milliseconds: 200);

class Data {
  static List<SplashData> splashData = [
    SplashData(
      image: Assets.getSvgPath("web_shopping.svg"),
      title: "Welcome!",
      text: "Welcome to Iverson, let's shop!",
    ),
    SplashData(
      image: Assets.getSvgPath("online_groceries.svg"),
      title: "Take control of your shopping life",
      text: "We help people connect with stores \naround Nigeria",
    ),
    SplashData(
      image: Assets.getSvgPath("shopping.svg"),
      title: "Best shopping experience",
      text: "We show the easy way to shop. \nJust stay at home with us",
    ),
  ];
}

/// Languages map
const languagesMap = {
  AppLanguageType.english: LanguageModel('en', 'US'),
};

/// Validator strings
final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp phoneNumberValidatorRegExp = RegExp(r"^[0-9]");
const String kEmailNullError = "Please enter your email.";
const String kFirstNameNullError = "Please enter your first name.";
const String kAddressNullError = "Please enter your address.";
const String kLastNameNullError = "Please enter your last name.";
const String kPhoneNumberNullError = "Please enter your phone number.";
const String kInvalidPhoneNumberError = "Please enter a valid phone number. Signs not necessary.";
const String kInvalidEmailError = "Please enter a valid email.";
const String kPassNullError = "Please enter your password.";
const String kPassMatchNullError = "Password does not match.";
const String kShortPassError = "Password should be longer than 8 characters.";
const String kConfirmPassNullError = "Please confirm your password.";