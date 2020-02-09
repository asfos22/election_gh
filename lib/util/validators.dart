
import 'package:election_gh/ui/ui_helper.dart';

class InputValidators {
  // Function to validate the email input
  static String validateEmail(String value) {
    Pattern emailPattern = UIHelper.emailPattern;
    RegExp emailRegex = new RegExp(emailPattern);
    if (!emailRegex.hasMatch(value)) {
      return UIHelper.invalidEmailAddressText;
    }
    return null;
  }

  // Function to validate the voter id input
  static String validateVoterID(String value) {
    if (value.length >= 11) {
      return UIHelper.invalidVoterIDText;
    } else if (value.length < 10) {
      return UIHelper.emptyVoterNumberText;
    }
    return null;
  }

  // Function to validate PS Code

  static String validatePassCode(String value) {
    if (value.length >= 9) {
      return UIHelper.invalidPSCodeText;
    } else if (value.length < 8) {
      return UIHelper.emptyPSCodeText;
    }
    return null;
  }

  static String validateDOB(String value) {
    if (value.length < 1) {
      return UIHelper.emptyDOBText;
    }
    return null;
  }

  // Function to validate the voter id input
  static String validatePassword(String value) {
    if (value.length >= 15) {
      return UIHelper.invalidPasswordText;
    } else if (value.length < 6) {
      return UIHelper.emptyPasswordText;
    }
    return null;
  }

}