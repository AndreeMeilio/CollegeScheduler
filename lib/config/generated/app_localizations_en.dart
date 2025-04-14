// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'College Scheduler';

  @override
  String get deleteConfirmationTitle => 'Confirmation Deletion!';

  @override
  String get deleteDescription => 'The deleted data cannot be restored, Are you sure you want to delete it?';

  @override
  String get deleteCancelButton => 'Cancel';

  @override
  String get deleteProceedButton => 'Yes, Delete it';

  @override
  String get quoteAfterLogin => '\"THE BEST TIME TO GROW A TREE IS 20 YEARS AGO, THE SECOND BEST TIME IS NOW\"';

  @override
  String get quoteAfterLoginMark => '~ Chinese Proverb';

  @override
  String gettingDataSuccess(Object feature) {
    return 'Successfully getting data $feature';
  }

  @override
  String creatingDataSuccess(Object feature) {
    return 'Successfully creating data $feature';
  }

  @override
  String updatingDataSuccess(Object feature) {
    return 'Successfully updating data $feature';
  }

  @override
  String deletingDataSuccess(Object feature) {
    return 'Successfully deleting data $feature';
  }

  @override
  String gettingDataEmpty(Object feature) {
    return 'You don\'t have data on $feature';
  }

  @override
  String gettingDataProblem(Object feature) {
    return 'There\'s a problem when getting $feature data';
  }

  @override
  String creatingDataProblem(Object feature) {
    return 'There\'s a problem when creating $feature data';
  }

  @override
  String updatingDataProblem(Object feature) {
    return 'There\'s a problem when updating $feature data';
  }

  @override
  String deletingDataProblem(Object feature) {
    return 'There\'s a problem when deleting $feature data';
  }

  @override
  String get homeMenuButton => 'Home';

  @override
  String get eventsMenuButton => 'Events';

  @override
  String get settingsMenuButton => 'Settings';

  @override
  String get dataSettingsLabel => 'Data';

  @override
  String get notificationSettingsLabel => 'Notification';

  @override
  String get accountSettingsLabel => 'Account';

  @override
  String get incoming => 'Coming Soon';

  @override
  String get changeFullnameOrUsernameTitle => 'Change Fullname Or Username';

  @override
  String get fullnameLabel => 'Fullname';

  @override
  String get fullnameHint => 'Input your Fullname';

  @override
  String get fullnameEmpty => 'Please input your Fullname';

  @override
  String get fullnameNewhint => 'Input your new Fullname';

  @override
  String get fullnameNewEmptyError => 'Please input your new Fullname';

  @override
  String get usernameLabel => 'Username';

  @override
  String get usernameEmpty => 'Please input your account username';

  @override
  String get usernameHint => 'Input your Username';

  @override
  String get usernameNewHint => 'Input your new Username';

  @override
  String get usernameNewEmptyError => 'Please input your new Username';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Input your password';

  @override
  String get passwordEmpty => 'Please input your account password';

  @override
  String get passwordUpTo8 => 'Password Must Up To 8 Characters';

  @override
  String get passwordContainNumber => 'Password Must Contain At least One Number';

  @override
  String get passwordContainerSymbol => 'Password Must Contain Symbol';

  @override
  String get confirmationPasswordTitle => 'Confirmation Password';

  @override
  String get confirmationPasswordHint => 'Input Your Confirmation Password';

  @override
  String get confirmationPasswordEmpty => 'Please input your confirmation password';

  @override
  String get passwordAndConfirmationDontMatch => 'Your password and confirmation password doesn\'t match';

  @override
  String get registerFailed => 'Register Failed';

  @override
  String get registerAccount => 'Register Account';

  @override
  String get registerSuccess => 'Register Success';

  @override
  String get alreadyHaveAccount => 'Already Have Account? ';

  @override
  String get loginHere => 'Login Here';

  @override
  String get loginFailed => 'Login Failed';

  @override
  String get loginEmpty => 'Please input your credentials';

  @override
  String get loginLabel => 'Login';

  @override
  String get loginSuccess => 'Login Success';

  @override
  String get noAccount => 'Don\'t Have Account? ';

  @override
  String get registerHere => 'Register Here';

  @override
  String get passwordChangeFullnameUsernameHint => 'Input your password for validation account';

  @override
  String get passwordEmptyError => 'Please input your password for security purpose';

  @override
  String get changingFullnameUsernamePasswordDisclamer => 'For security purpose, please insert your account password, so that we can know this is you who trying to change the username';

  @override
  String get changeFullnameUsernameFailedTitle => 'Change Fullname or Username failed';

  @override
  String get emptyFieldError => 'Please fill the required data';

  @override
  String get submitChange => 'Submit Changes';

  @override
  String greetingFriend(Object user) {
    return 'Welcome Back! \n$user';
  }

  @override
  String get dataStatusTitle => 'Data Status';

  @override
  String get idleStatus => 'NOT STARTED';

  @override
  String get progressStatus => 'PROGESS';

  @override
  String get doneStatus => 'DONE';

  @override
  String get dataPriorityTitle => 'Data Priority';

  @override
  String get lowPriority => 'LOW';

  @override
  String get mediumPriority => 'MEDIUM';

  @override
  String get highPriority => 'HIGH';

  @override
  String get coreMenuTitle => 'Core Menu';

  @override
  String get dataClassTitle => 'Data Class';

  @override
  String get dataEventsTitle => 'Data Events';

  @override
  String get dataLecturerTitle => 'Data Lecturer';

  @override
  String get recentDataEvents => 'Recent Data Events';

  @override
  String get createDataClass => 'Create Data Class';

  @override
  String get editButton => 'Edit';

  @override
  String get deleteButton => 'Delete';

  @override
  String get searchItemByTitle => 'Search Item By Title';

  @override
  String get filterEvents => 'Filter Events';

  @override
  String get dateOfEventsLabel => 'Date Of Event';

  @override
  String get dateOfEventsHint => 'Please input Date Of Event';

  @override
  String get priorityLabel => 'Priority';

  @override
  String get prioritySelect => 'Select Priority';

  @override
  String get statusLabel => 'Status';

  @override
  String get statusSelect => 'Select Status';

  @override
  String get clearButton => 'Clear';

  @override
  String get submitButton => 'Submit';

  @override
  String get deadlineLabel => 'Deadline';

  @override
  String get selectClassLabel => 'Select Class';

  @override
  String get createDataLecturer => 'Create Data Lecturer';

  @override
  String get detailEventTitle => 'Detail Event';

  @override
  String get startHourLabel => 'Start Hour';

  @override
  String get endHourLabel => 'End Hour';

  @override
  String get locationLabel => 'Location';

  @override
  String get classNameLabel => 'Class Name';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get eventHistory => 'Event History';

  @override
  String get inputDataClassTitle => 'Input Data Class';

  @override
  String get classNameHint => 'Input Class Name';

  @override
  String get classNameEmpty => 'Please input the name of the class';

  @override
  String get lecturerLabel => 'Lecturer';

  @override
  String get lecturerSelect => 'Select Lecturer';

  @override
  String get dayLabel => 'Day';

  @override
  String get daySelect => 'Select Day';

  @override
  String get dayMonday => 'Monday';

  @override
  String get dayTuesday => 'Tuesday';

  @override
  String get dayWednesday => 'Wednesday';

  @override
  String get dayThursday => 'Thursday';

  @override
  String get dayFriday => 'Friday';

  @override
  String get daySaturday => 'Saturday';

  @override
  String get daySunday => 'Sunday';

  @override
  String get startHourEmpty => 'Please input starting time of the class';

  @override
  String get endHourEmpty => 'Please input ending time of the class';

  @override
  String get createDataClassFailed => 'Create Data Class Failed';

  @override
  String get createDataClassSuccess => 'Create Data Class Success';

  @override
  String get inputDataLecturerTitle => 'Input Data Lecturer';

  @override
  String get lecturerNameLabel => 'Lecturer Name';

  @override
  String get lecturerNameHint => 'Input Lecturer Name';

  @override
  String get lecturerNameEmpty => 'Please input the name of lecturer';

  @override
  String get lecturerInputFailed => 'Create Data Lecturer Failed';

  @override
  String get loginHistoryTitle => 'Login History';

  @override
  String get createEventSchedule => 'Create Event Schedule';

  @override
  String get titleLabel => 'Title Event';

  @override
  String get titleHint => 'Input Title Event';

  @override
  String get titleEmpty => 'Please input the title event';

  @override
  String get createEventSuccess => 'Successfully Create Event Schedule';

  @override
  String get createEventFailed => 'Create Event Failed';

  @override
  String actionFeatureSuccess(Object action) {
    return '$action Success';
  }

  @override
  String actionFeatureFailed(Object action) {
    return '$action Failed';
  }

  @override
  String get to => 'To';

  @override
  String menuSettingsLabel(String menu) {
    String _temp0 = intl.Intl.selectLogic(
      menu,
      {
        'menuDataClass': 'Data Class',
        'menuDataLecturer': 'Data Lecturer',
        'menuEventHistory': 'Event History',
        'menuReminderEvent': 'Reminder Event',
        'menuReminderInput': 'Reminder Input',
        'menuChangePassword': 'Change Password',
        'menuChangeFullnameOrUsername': 'Change Fullname Or Username',
        'menuLoginHistory': 'Login History',
        'menuExportDatabase': 'Export Database',
        'menuImportDatabase': 'Import Database',
        'menuLogout': 'Logout',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get quoteDante => 'THE PATH TO PARADISE BEGINS IN HELL';

  @override
  String get changePasswordTitle => 'Change Password';

  @override
  String get oldPasswordLabel => 'Old Password';

  @override
  String get newPaswordLabel => 'New Password';

  @override
  String get confirmNewPasswordLabel => 'Confirm New Password';

  @override
  String get oldPasswordHint => 'Input your old password';

  @override
  String get newPasswordHint => 'Input your new password';

  @override
  String get confirmNewPasswordHint => 'Input confirmation of new password';
}
