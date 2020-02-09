import 'package:election_gh/ui/ui_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveVoterIDPreference(int accountID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(UIHelper.isRegistered, accountID);
}

//--

getVoterAccountIDPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getInt(UIHelper.isRegistered);
}
//--

saveInstalledPreference(int isInstall) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(UIHelper.isInstall, isInstall);
}

//--

getIsInstalledPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getInt(UIHelper.isInstall);
}
