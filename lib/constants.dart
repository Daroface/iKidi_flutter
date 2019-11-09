import 'package:flutter/cupertino.dart';

class Constants {
  static const String LOGIN_BUTTON_TEXT = "Zaloguj";
  static const String LOGIN_FIELD_HINT = "E-mail";
  static const String LOGIN_ERROR_STATEMENT = "Wprowadź e-mail";
  static const String PASSWORD_FIELD_HINT = "Hasło";
  static const String PASSWORD_ERROR_STATEMENT = "Wprowadź hasło";
  static const String LOGGING_STATEMENT = "Logowanie...";

  static const double TOP_PADDING = 80.0;
  static const double SIDE_PADDING = 24.0;
  static const double BOTTOM_PADDING = 24.0;
  static const double SPACE_UNDER_LOGO_PADDING = 70.0;
  static const double SPACE_UNDER_WALL_ITEM_PADDING = 40.0;
  static const double SPACE_PADDING = 15.0;

  //hostname
  static const String HOST_URL = "http://10.0.2.2:2464/";

  //endpoints
  static const String LOGIN_URL = "Api/Login";
  static const String LOGOUT_URL = "Api/Logout";
  static const String HOME_URL = "Api/Home";
  static const String CLUB_URL = "Api/Club/";

  static const String LOGIN_PARAMETER = "Email";
  static const String PASSWORD_PARAMETER = "Password";

  //messages
  static const String ERROR_SIGNIN_MESSAGE =
      "Błąd!\nNieprawidłowy e-mail lub hasło!";

  static final Padding spaceUnderLogo = new Padding(
      padding: const EdgeInsets.only(top: SPACE_UNDER_LOGO_PADDING));

  static final Padding spaceUnderElement = new Padding(
      padding: const EdgeInsets.only(top: SPACE_UNDER_WALL_ITEM_PADDING));

  static final Padding spaceUnderSubelement =
      new Padding(padding: const EdgeInsets.only(top: SPACE_PADDING));
}
