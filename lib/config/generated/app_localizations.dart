import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id')
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'College Scheduler'**
  String get title;

  /// No description provided for @deleteConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation Deletion!'**
  String get deleteConfirmationTitle;

  /// No description provided for @deleteDescription.
  ///
  /// In en, this message translates to:
  /// **'The deleted data cannot be restored, Are you sure you want to delete it?'**
  String get deleteDescription;

  /// No description provided for @deleteCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get deleteCancelButton;

  /// No description provided for @deleteProceedButton.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete it'**
  String get deleteProceedButton;

  /// No description provided for @quoteAfterLogin.
  ///
  /// In en, this message translates to:
  /// **'\"THE BEST TIME TO GROW A TREE IS 20 YEARS AGO, THE SECOND BEST TIME IS NOW\"'**
  String get quoteAfterLogin;

  /// No description provided for @quoteAfterLoginMark.
  ///
  /// In en, this message translates to:
  /// **'~ Chinese Proverb'**
  String get quoteAfterLoginMark;

  /// Generic description for getting data success
  ///
  /// In en, this message translates to:
  /// **'Successfully getting data {feature}'**
  String gettingDataSuccess(Object feature);

  /// Generic description for creating data success
  ///
  /// In en, this message translates to:
  /// **'Successfully creating data {feature}'**
  String creatingDataSuccess(Object feature);

  /// Generic description for updating data success
  ///
  /// In en, this message translates to:
  /// **'Successfully updating data {feature}'**
  String updatingDataSuccess(Object feature);

  /// Generic description for deleting data success
  ///
  /// In en, this message translates to:
  /// **'Successfully deleting data {feature}'**
  String deletingDataSuccess(Object feature);

  /// Generic description for empty getting data
  ///
  /// In en, this message translates to:
  /// **'You don\'t have data on {feature}'**
  String gettingDataEmpty(Object feature);

  /// Generic description for problem getting data
  ///
  /// In en, this message translates to:
  /// **'There\'s a problem when getting {feature} data'**
  String gettingDataProblem(Object feature);

  /// Generic description for problem creating data
  ///
  /// In en, this message translates to:
  /// **'There\'s a problem when creating {feature} data'**
  String creatingDataProblem(Object feature);

  /// Generic description for problem updating data
  ///
  /// In en, this message translates to:
  /// **'There\'s a problem when updating {feature} data'**
  String updatingDataProblem(Object feature);

  /// Generic description for problem deleting data
  ///
  /// In en, this message translates to:
  /// **'There\'s a problem when deleting {feature} data'**
  String deletingDataProblem(Object feature);

  /// No description provided for @homeMenuButton.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeMenuButton;

  /// No description provided for @eventsMenuButton.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get eventsMenuButton;

  /// No description provided for @settingsMenuButton.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsMenuButton;

  /// No description provided for @dataSettingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get dataSettingsLabel;

  /// No description provided for @notificationSettingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notificationSettingsLabel;

  /// No description provided for @accountSettingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountSettingsLabel;

  /// No description provided for @incoming.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get incoming;

  /// No description provided for @changeFullnameOrUsernameTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Fullname Or Username'**
  String get changeFullnameOrUsernameTitle;

  /// No description provided for @fullnameLabel.
  ///
  /// In en, this message translates to:
  /// **'Fullname'**
  String get fullnameLabel;

  /// No description provided for @fullnameHint.
  ///
  /// In en, this message translates to:
  /// **'Input your Fullname'**
  String get fullnameHint;

  /// No description provided for @fullnameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please input your Fullname'**
  String get fullnameEmpty;

  /// No description provided for @fullnameNewhint.
  ///
  /// In en, this message translates to:
  /// **'Input your new Fullname'**
  String get fullnameNewhint;

  /// No description provided for @fullnameNewEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Please input your new Fullname'**
  String get fullnameNewEmptyError;

  /// No description provided for @usernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameLabel;

  /// No description provided for @usernameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please input your account username'**
  String get usernameEmpty;

  /// No description provided for @usernameHint.
  ///
  /// In en, this message translates to:
  /// **'Input your Username'**
  String get usernameHint;

  /// No description provided for @usernameNewHint.
  ///
  /// In en, this message translates to:
  /// **'Input your new Username'**
  String get usernameNewHint;

  /// No description provided for @usernameNewEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Please input your new Username'**
  String get usernameNewEmptyError;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Input your password'**
  String get passwordHint;

  /// No description provided for @passwordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please input your account password'**
  String get passwordEmpty;

  /// No description provided for @passwordUpTo8.
  ///
  /// In en, this message translates to:
  /// **'Password Must Up To 8 Characters'**
  String get passwordUpTo8;

  /// No description provided for @passwordContainNumber.
  ///
  /// In en, this message translates to:
  /// **'Password Must Contain At least One Number'**
  String get passwordContainNumber;

  /// No description provided for @passwordContainerSymbol.
  ///
  /// In en, this message translates to:
  /// **'Password Must Contain Symbol'**
  String get passwordContainerSymbol;

  /// No description provided for @confirmationPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation Password'**
  String get confirmationPasswordTitle;

  /// No description provided for @confirmationPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Input Your Confirmation Password'**
  String get confirmationPasswordHint;

  /// No description provided for @confirmationPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please input your confirmation password'**
  String get confirmationPasswordEmpty;

  /// No description provided for @passwordAndConfirmationDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Your password and confirmation password doesn\'t match'**
  String get passwordAndConfirmationDontMatch;

  /// No description provided for @registerFailed.
  ///
  /// In en, this message translates to:
  /// **'Register Failed'**
  String get registerFailed;

  /// No description provided for @registerAccount.
  ///
  /// In en, this message translates to:
  /// **'Register Account'**
  String get registerAccount;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Register Success'**
  String get registerSuccess;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already Have Account? '**
  String get alreadyHaveAccount;

  /// No description provided for @loginHere.
  ///
  /// In en, this message translates to:
  /// **'Login Here'**
  String get loginHere;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get loginFailed;

  /// No description provided for @loginEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please input your credentials'**
  String get loginEmpty;

  /// No description provided for @loginLabel.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginLabel;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login Success'**
  String get loginSuccess;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Have Account? '**
  String get noAccount;

  /// No description provided for @registerHere.
  ///
  /// In en, this message translates to:
  /// **'Register Here'**
  String get registerHere;

  /// No description provided for @passwordChangeFullnameUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Input your password for validation account'**
  String get passwordChangeFullnameUsernameHint;

  /// No description provided for @passwordEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Please input your password for security purpose'**
  String get passwordEmptyError;

  /// No description provided for @changingFullnameUsernamePasswordDisclamer.
  ///
  /// In en, this message translates to:
  /// **'For security purpose, please insert your account password, so that we can know this is you who trying to change the username'**
  String get changingFullnameUsernamePasswordDisclamer;

  /// No description provided for @changeFullnameUsernameFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Fullname or Username failed'**
  String get changeFullnameUsernameFailedTitle;

  /// No description provided for @emptyFieldError.
  ///
  /// In en, this message translates to:
  /// **'Please fill the required data'**
  String get emptyFieldError;

  /// No description provided for @submitChange.
  ///
  /// In en, this message translates to:
  /// **'Submit Changes'**
  String get submitChange;

  /// greeting user
  ///
  /// In en, this message translates to:
  /// **'Welcome Back! \n{user}'**
  String greetingFriend(Object user);

  /// No description provided for @dataStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Status'**
  String get dataStatusTitle;

  /// No description provided for @idleStatus.
  ///
  /// In en, this message translates to:
  /// **'NOT STARTED'**
  String get idleStatus;

  /// No description provided for @progressStatus.
  ///
  /// In en, this message translates to:
  /// **'PROGESS'**
  String get progressStatus;

  /// No description provided for @doneStatus.
  ///
  /// In en, this message translates to:
  /// **'DONE'**
  String get doneStatus;

  /// No description provided for @dataPriorityTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Priority'**
  String get dataPriorityTitle;

  /// No description provided for @lowPriority.
  ///
  /// In en, this message translates to:
  /// **'LOW'**
  String get lowPriority;

  /// No description provided for @mediumPriority.
  ///
  /// In en, this message translates to:
  /// **'MEDIUM'**
  String get mediumPriority;

  /// No description provided for @highPriority.
  ///
  /// In en, this message translates to:
  /// **'HIGH'**
  String get highPriority;

  /// No description provided for @coreMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Core Menu'**
  String get coreMenuTitle;

  /// No description provided for @dataClassTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Class'**
  String get dataClassTitle;

  /// No description provided for @dataEventsTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Events'**
  String get dataEventsTitle;

  /// No description provided for @dataLecturerTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Lecturer'**
  String get dataLecturerTitle;

  /// No description provided for @recentDataEvents.
  ///
  /// In en, this message translates to:
  /// **'Recent Data Events'**
  String get recentDataEvents;

  /// No description provided for @createDataClass.
  ///
  /// In en, this message translates to:
  /// **'Create Data Class'**
  String get createDataClass;

  /// No description provided for @editButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editButton;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @searchItemByTitle.
  ///
  /// In en, this message translates to:
  /// **'Search Item By Title'**
  String get searchItemByTitle;

  /// No description provided for @filterEvents.
  ///
  /// In en, this message translates to:
  /// **'Filter Events'**
  String get filterEvents;

  /// No description provided for @dateOfEventsLabel.
  ///
  /// In en, this message translates to:
  /// **'Date Of Event'**
  String get dateOfEventsLabel;

  /// No description provided for @dateOfEventsHint.
  ///
  /// In en, this message translates to:
  /// **'Please input Date Of Event'**
  String get dateOfEventsHint;

  /// No description provided for @priorityLabel.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priorityLabel;

  /// No description provided for @prioritySelect.
  ///
  /// In en, this message translates to:
  /// **'Select Priority'**
  String get prioritySelect;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusLabel;

  /// No description provided for @statusSelect.
  ///
  /// In en, this message translates to:
  /// **'Select Status'**
  String get statusSelect;

  /// No description provided for @clearButton.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearButton;

  /// No description provided for @submitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButton;

  /// No description provided for @deadlineLabel.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadlineLabel;

  /// No description provided for @selectClassLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Class'**
  String get selectClassLabel;

  /// No description provided for @createDataLecturer.
  ///
  /// In en, this message translates to:
  /// **'Create Data Lecturer'**
  String get createDataLecturer;

  /// No description provided for @detailEventTitle.
  ///
  /// In en, this message translates to:
  /// **'Detail Event'**
  String get detailEventTitle;

  /// No description provided for @startHourLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Hour'**
  String get startHourLabel;

  /// No description provided for @endHourLabel.
  ///
  /// In en, this message translates to:
  /// **'End Hour'**
  String get endHourLabel;

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationLabel;

  /// No description provided for @classNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Class Name'**
  String get classNameLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @eventHistory.
  ///
  /// In en, this message translates to:
  /// **'Event History'**
  String get eventHistory;

  /// No description provided for @inputDataClassTitle.
  ///
  /// In en, this message translates to:
  /// **'Input Data Class'**
  String get inputDataClassTitle;

  /// No description provided for @classNameHint.
  ///
  /// In en, this message translates to:
  /// **'Input Class Name'**
  String get classNameHint;

  /// No description provided for @classNameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please input the name of the class'**
  String get classNameEmpty;

  /// No description provided for @lecturerLabel.
  ///
  /// In en, this message translates to:
  /// **'Lecturer'**
  String get lecturerLabel;

  /// No description provided for @lecturerSelect.
  ///
  /// In en, this message translates to:
  /// **'Select Lecturer'**
  String get lecturerSelect;

  /// No description provided for @dayLabel.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get dayLabel;

  /// No description provided for @daySelect.
  ///
  /// In en, this message translates to:
  /// **'Select Day'**
  String get daySelect;

  /// No description provided for @dayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get dayMonday;

  /// No description provided for @dayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get dayTuesday;

  /// No description provided for @dayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get dayWednesday;

  /// No description provided for @dayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get dayThursday;

  /// No description provided for @dayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get dayFriday;

  /// No description provided for @daySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get daySaturday;

  /// No description provided for @daySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get daySunday;

  /// No description provided for @startHourEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please input starting time of the class'**
  String get startHourEmpty;

  /// No description provided for @endHourEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please input ending time of the class'**
  String get endHourEmpty;

  /// No description provided for @createDataClassFailed.
  ///
  /// In en, this message translates to:
  /// **'Create Data Class Failed'**
  String get createDataClassFailed;

  /// No description provided for @createDataClassSuccess.
  ///
  /// In en, this message translates to:
  /// **'Create Data Class Success'**
  String get createDataClassSuccess;

  /// No description provided for @inputDataLecturerTitle.
  ///
  /// In en, this message translates to:
  /// **'Input Data Lecturer'**
  String get inputDataLecturerTitle;

  /// No description provided for @lecturerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Lecturer Name'**
  String get lecturerNameLabel;

  /// No description provided for @lecturerNameHint.
  ///
  /// In en, this message translates to:
  /// **'Input Lecturer Name'**
  String get lecturerNameHint;

  /// No description provided for @lecturerNameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please input the name of lecturer'**
  String get lecturerNameEmpty;

  /// No description provided for @lecturerInputFailed.
  ///
  /// In en, this message translates to:
  /// **'Create Data Lecturer Failed'**
  String get lecturerInputFailed;

  /// No description provided for @loginHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Login History'**
  String get loginHistoryTitle;

  /// No description provided for @createEventSchedule.
  ///
  /// In en, this message translates to:
  /// **'Create Event Schedule'**
  String get createEventSchedule;

  /// No description provided for @titleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title Event'**
  String get titleLabel;

  /// No description provided for @titleHint.
  ///
  /// In en, this message translates to:
  /// **'Input Title Event'**
  String get titleHint;

  /// No description provided for @titleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please input the title event'**
  String get titleEmpty;

  /// No description provided for @createEventSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully Create Event Schedule'**
  String get createEventSuccess;

  /// No description provided for @createEventFailed.
  ///
  /// In en, this message translates to:
  /// **'Create Event Failed'**
  String get createEventFailed;

  /// Action Success Title
  ///
  /// In en, this message translates to:
  /// **'{action} Success'**
  String actionFeatureSuccess(Object action);

  /// Action Failed Title
  ///
  /// In en, this message translates to:
  /// **'{action} Failed'**
  String actionFeatureFailed(Object action);

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// Translate Menu Settings
  ///
  /// In en, this message translates to:
  /// **'{menu, select, menuDataClass{Data Class} menuDataLecturer{Data Lecturer} menuEventHistory{Event History} menuReminderEvent{Reminder Event} menuReminderInput{Reminder Input} menuChangePassword{Change Password} menuChangeFullnameOrUsername{Change Fullname Or Username} menuLoginHistory{Login History} menuExportDatabase{Export Database} menuImportDatabase{Import Database} menuLogout{Logout} other{}}'**
  String menuSettingsLabel(String menu);

  /// No description provided for @quoteDante.
  ///
  /// In en, this message translates to:
  /// **'THE PATH TO PARADISE BEGINS IN HELL'**
  String get quoteDante;

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordTitle;

  /// No description provided for @oldPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPasswordLabel;

  /// No description provided for @newPaswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPaswordLabel;

  /// No description provided for @confirmNewPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPasswordLabel;

  /// No description provided for @oldPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Input your old password'**
  String get oldPasswordHint;

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Input your new password'**
  String get newPasswordHint;

  /// No description provided for @confirmNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Input confirmation of new password'**
  String get confirmNewPasswordHint;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'id': return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
