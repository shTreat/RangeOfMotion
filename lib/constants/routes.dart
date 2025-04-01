

import 'package:flutter/material.dart';
import 'package:range_of_motion/main.dart';

import '../rage_of_motion_options_screen.dart';

class Routes {
  //Account
  static const splash = 'splash';
  static const login = 'login';
  static const loginFieldWorker = 'loginfieldworker';
  static const loginOtp = 'loginotp';
  static const loginRole = 'loginRole';
  static const resetPassword = 'resetPassword';
  static const sendResetPasswordEmail = 'sendResetPasswordEmail';

  //FieldWorker routes
  static const fieldWorkerDestinations = 'fieldWorkerDestinations';

  static const educateTest = 'educateTest';
  static const educateTestResults = 'educateTestResults';
  static const healthCampAddVisitDiagnosis = 'healthCampAddVisitDiagnosis';
  static const healthCampAddVisitPerscription =
      'healthCampAddVisitPerscription';
  static const healthCampAddVisitCompletion = 'healthCampAddVisitCompletion';
  static const healthCampFindPatient = 'healthCampFindPatient';
  static const patientAcceptConsent = 'patientAcceptConsent';
  static const patientConsent = 'patientConsent';
  static const patients = 'patients';
  static const patientRegister = 'patientRegister';
  static const patientDynamic = 'patientDynamic';
  static const patientEdit = 'patientEdit';
  static const trainingTest = 'trainingTest';
  static const trainingTestResults = 'trainingTestResults';
  static const patientScreeningOverview = 'patientScreeningOverview';
  static const patientScreening = 'patientScreening';
  static const treatmentAdvice = 'treatmentAdvice';
  static const treatmentAdviceWhatIf = 'treatmentAdviceWhatIf';
  static const projectList = 'projectList';
  static const patientScreeningView = 'patientScreeningView';
  static const referral_card = 'referral_card';

  static const patientRulesetOutput = 'PatientRulesetOutput';
  static const doctorRulesetOutput = 'DoctorRulesetOutput';

  //Project Manager routes
  static const projectManagerDestinations = 'projectManagerDestinations';
  static const enrolUser = 'enrolUser';
  static const manageFieldWorkerDetails = 'manageFieldWorkerDetails';
  static const updateFieldWorkerProfile = 'updateFieldWorkerProfile';
  static const findUser = 'findUser';

  //Doctor routes
  static const doctorDestinations = 'doctorDestinations';

  //Common routes
  static const video = 'video';
  static const teachingModuleStart = 'teachingModuleStart';
  static const teachingModule = 'teachingModule';
  static const patientDetails = 'patientDetails';
  static const offlineSync = 'offlineSync';

  // TreatRoutes
  static const myDiary = 'myDiary';
  static const knowledge = 'knowledge';
  static const patientSpecificScreen = 'patientSpecificScreen';
  static const patientFieldWorkerMessageScreen =
      'patientFieldWorkerMessageScreen';
  static const patientAppointmentScreen = 'patientAppointmentScreen';
  static const therapyPlanScreen = 'therapyPlanScreen';
  static const progressScreen = 'progressScreen';
  static const informationScreen = 'informationScreen';
  static const videolist = 'videolist';
  static const therapyplanQuestion = 'therapyplanQuestion';
  static const resourceCategoryListScreen = 'resourceCategoryListScreen';
  static const scheduleScreen = 'scheduleScreen';

  static const knowledgeResourceScreen = 'knowledgeResourceScreen';
  static const appointmentNotificationScreen = 'appointmentNotificationScreen';
  static const appointmentNotification = 'appointmentNotification';
  static const exerciseVideo = 'exerciseVideo';
  static const staticfieldWorkerDestinations = 'staticfieldWorkerDestinations';
  static const mydiarychildren = 'mydiarychildren';
  static const mydiaryquestion = 'mydiaryquestion';
  static const pdfViewScreen = 'pdfViewerScreen';

  static const calenderScreen = 'calenderScreen';
  static const patientAppoinmentAddScreen = 'patientAppoinmentAddScreen';

  static const painGraphScreen = 'painGraphScreen';
  static const exerciseGraphScreen = 'exerciseGraphScreen';
  static const activityGraphScreen = 'activityGraphScreen';
  static const kneeFuncGraphScreen = 'kneeFuncGraphScreen';
  static const physioProgressScreen = 'physioProgressScreen';

  static const customAdvancePDFViewScreen = 'customAdvancedPdfViewerScreen';
  static const romResults = 'romResults';

  static const romGraphScreen = 'romGraphScreen';

  // ROM new flow
  static const rangeOfMotionSelectionScreen = 'rangeOfMotionSelection';
  static const romAngleCalculator = 'romAngleCalculator';
  static const pinSaverScreen = 'pinSaverScreen';
  static const generalNotificationScreen = 'generalNotificationScreen';
  // OTP reset flow
  static const otpResetScreen = 'otpResetScreen';
  static const loginPinResetScreen = 'loginPinResetScreen';

  static const videoInfo = 'VideoInfo';
  static const romPositionSelector = 'romPositionSelector';

// Custom route names for only firebase purpose start
  static const myDiaryPainScreen = 'My diary: Pain';
  static const myDiaryExerciseScreen = 'My diary: Exercise';
  static const myDiaryActivityScreen = 'My diary: Activity';
  static const myDiaryKneeFunctionScreen = 'My diary: Kneefunction';
  static const myDiaryPainRecords = 'My diary: Pain records';
  static const myDiaryExerciseRecords = 'My diary: Exercise records';
  static const myDiaryActivityRecords = 'My diary: Activity records';
  static const myDiaryKneeFunctionRecords = 'My diary: Kneefunction records';

  static const customExerciseVideo = 'Exercise video: ';
  static const customResource = 'Resource List: ';
  static const customResourcePDF = 'PDF: ';

  static const customPainProgress = 'Progress: Pain graph';
  static const customExerciseProgress = 'Progress: Exercise graph';
  static const customActivityProgress = 'Progress: Activity graph';
  static const customKneeFunctionProgress = 'Progress: Kneefunction graph';
  static const customROMProgress = 'Progress: ROM graph';

  static const customChatScreen = 'Message: Chat screen';

  static const selectRangeOfMotion = 'ROM: Range of motion(ROM) position';
  static const customRomResults = 'ROM: Results';
  static const customROMcalculator = 'ROM: Calculation';

  static const customNotificationAppointment = 'Notification: Appointment';
  static const customNotificationGeneral = 'Notification: General';

  static const customResetOTPScreen = 'Login: Reset OTP Screen';
  static const customLoginOTPScreen = 'Login: OTP screen';
  static const customLoginResetPin = 'Login: Reset Pin screen';

  static const customRegisterMember = 'Register: Patient';
  static const customPatientSpecificScreen = 'Patient specific: Information';

  static const customTherapyPlanOptions = 'Therapy plan: Selection';
  static const customTherapyPlanQuestionsOptions = 'Therapy plan: ';

  static const customPhyoPatientGraphs = 'Progress: Patient progress graphs';
  static const patientPhysioAppointmentList =
      'Appointment: Patient appointment list';
  static const physioPatientCreateAppointment =
      'Appointment: Create new appointment';

  static const treatHomeScreen = 'Homescreen: Treat';
  static const multiMorbidityHomeScreen = 'Homescreen: Multimoribidity';
  static const splashScreen = 'Splash screen';
  static const loginPatientFamily = 'Login: Patient / Family';
  static const loginHealthWorker = 'Login: Health care worker';
  static const loginPinSaverScreen = 'Login: PIN screen';
  static const customLoginresetPassword = 'Login: Reset password';
  static const loginRoleSelector = 'Login: Role selection';
  static const loginProjectList = 'Login: Project list selection';
  static const loginResetEmail = 'Login: Reset password on email';
  //mahi
  static const therapyplanlistscreen = 'therapyplanlistscreen';
  static const therapyplanQuestiondetails = 'therapyplanQuestionDetails';
  // Custom route names for only firebase purpose start end
  Future<MaterialPageRoute> getPageRoute(
      {required String routeName,
      Object? arguments,
       String? customRouteName}) async {
    var customRoute =
        customRouteName ?? (getDefaultRouteName(routeName) ?? routeName);

    // await FirebaseAnalytics.instance.setCurrentScreen(screenName: customRoute);
    return MaterialPageRoute(
      builder: (_) => getRouteView(routeName)!,
      settings: RouteSettings(name: routeName, arguments: arguments),
    );
  }

  String? getDefaultRouteName(String routeName) {
    switch (routeName) {
      case fieldWorkerDestinations:
        return treatHomeScreen;
      case staticfieldWorkerDestinations:
        return multiMorbidityHomeScreen;
      case splash:
        return splashScreen;
      case login:
        return loginPatientFamily;
      case loginFieldWorker:
        return loginHealthWorker;
      case pinSaverScreen:
        return loginPinSaverScreen;
      case resetPassword:
        return customLoginresetPassword;
      case loginRole:
        return loginRoleSelector;
      case projectList:
        return loginProjectList;
      case sendResetPasswordEmail:
        return loginResetEmail;
      case mydiaryquestion:
        return 'My diary: Questions';

      case knowledge:
        return 'Knowledge';
      case myDiary:
        return 'My diary';
      case loginOtp:
        return customLoginOTPScreen;
      case patientSpecificScreen:
        return customPatientSpecificScreen;
      case patientFieldWorkerMessageScreen:
        return customChatScreen;
      case patientAppointmentScreen:
        return 'Paitnet: Appointment screen';

      case therapyPlanScreen:
        return customTherapyPlanOptions;

      case educateTest:
        return educateTest;
      case educateTestResults:
        return educateTestResults;
      case healthCampAddVisitDiagnosis:
        return healthCampAddVisitDiagnosis;
      case healthCampAddVisitPerscription:
        return healthCampAddVisitPerscription;
      case healthCampAddVisitCompletion:
        return healthCampAddVisitCompletion;
      case healthCampFindPatient:
        return healthCampFindPatient;
      case patientDetails:
        return patientDetails;
      case patientAcceptConsent:
        return patientAcceptConsent;
      case patientConsent:
        return patientConsent;
      case patients:
        return patients;
      case patientRegister:
        return customRegisterMember;
      case patientDynamic:
        return 'Register member dynamic screen';
      case patientEdit:
        return patientEdit;
      case trainingTest:
        return trainingTest;
      case projectManagerDestinations:
        return 'Homescreen: Project manager';
      case enrolUser:
        return enrolUser;
      case manageFieldWorkerDetails:
        return manageFieldWorkerDetails;
      case updateFieldWorkerProfile:
        return updateFieldWorkerProfile;
      case findUser:
        return findUser;
      case teachingModuleStart:
        return teachingModuleStart;
      case teachingModule:
        return teachingModule;

      case video:
        return 'Video Player screen';
      case offlineSync:
        return offlineSync;
      case patientScreeningOverview:
        return patientScreeningOverview;
      case patientRulesetOutput:
        return patientRulesetOutput;
      case doctorRulesetOutput:
        return doctorRulesetOutput;
      case patientScreening:
        return patientScreening;
      case treatmentAdvice:
        return treatmentAdvice;
      case treatmentAdviceWhatIf:
        return treatmentAdviceWhatIf;
      case doctorDestinations:
        return doctorDestinations;
      case patientScreeningView:
        return patientScreeningView;
      case referral_card:
        return referral_card;
      case videolist:
        return 'Video player list screen';
      case therapyplanQuestion:
        return therapyplanQuestion;
      case progressScreen:
        return 'Progress screen: Patient graphs';
      case informationScreen:
        return 'Information screen';
      case scheduleScreen:
        return 'Schedule screen';
      case knowledgeResourceScreen:
        return 'Resource screen';
      case resourceCategoryListScreen:
        return 'Resource list screen';
      case appointmentNotificationScreen:
        return customNotificationAppointment;
      case appointmentNotification:
        return 'Appointment screen';
      case exerciseVideo:
        return 'Exercise video';
      case mydiarychildren:
        return 'My diary: Selection screen';

      case pdfViewScreen:
        return 'PDF screen';
      case calenderScreen:
        return patientPhysioAppointmentList;
      case patientAppoinmentAddScreen:
        return physioPatientCreateAppointment;
      case painGraphScreen:
        return customPainProgress;
      case exerciseGraphScreen:
        return customExerciseProgress;
      case activityGraphScreen:
        return customActivityProgress;
      case kneeFuncGraphScreen:
        return customKneeFunctionProgress;
      case physioProgressScreen:
        return customPhyoPatientGraphs;
      case customAdvancePDFViewScreen:
        return 'Pdf view screen';

      case romResults:
        return 'ROM result screen';

      case romGraphScreen:
        return customROMProgress;

      case rangeOfMotionSelectionScreen:
        return selectRangeOfMotion;

      case romAngleCalculator:
        return 'ROM: Calculator';

      case generalNotificationScreen:
        return customNotificationGeneral;

      case otpResetScreen:
        return customResetOTPScreen;

      case loginPinResetScreen:
        return customLoginResetPin;
      case romPositionSelector:
        return 'Rom selection screen';
      case therapyplanlistscreen:
        return therapyplanlistscreen;
      case therapyplanQuestiondetails:
        return therapyplanQuestiondetails;
      // default:
      //   return null;
    }
  }

  Widget? getRouteView(String routeName) {
    switch (routeName) {
      // case pinSaverScreen:
      //   return TreatPinSaver();
      // case knowledge:
      //   return KnowledgeScreen();
      // case myDiary:
      //   return MyDiaryScreen();
      // case loginOtp:
      //   return TreatOtpPage();
      // case patientSpecificScreen:
      //   return PatientSpecificScreen();
      // case patientFieldWorkerMessageScreen:
      //   return PatientFieldWorkerMessage();
      // case patientAppointmentScreen:
      //   return AppointmentScreen();

      // case therapyPlanScreen:
      //   return TherapyPlanScreen();
      // case splash:
      //   return SplashPage();
      // case login:
      //   return LoginMobileNumber();
      // case loginFieldWorker:
      //   return TreatLogin();
      // case loginRole:
      //   return LoginRole();
      // case resetPassword:
      //   return ResetPasswordPage();
      // case sendResetPasswordEmail:
      //   return SendResetPasswordEmailPage();
      case fieldWorkerDestinations:
        return MyHomePage(title: 'ROM Calculator');
      // case educateTest:
      //   return EducateTestPage();
      // case educateTestResults:
      //   return EducateTestResultsPage();
      // case healthCampAddVisitDiagnosis:
      //   return HealthCampAddVisitDiagnosisPage();
      // case healthCampAddVisitPerscription:
      //   return HealthCampAddVisitPerscriptionPage();
      // case healthCampAddVisitCompletion:
      //   return HealthCampAddVisitCompletionPage();
      // case healthCampFindPatient:
      //   return HealthCampFindPatientPage();
      // case patientDetails:
      //   return PatientDetailsPage();
      // case patientAcceptConsent:
      //   return PatientAcceptConsentPage();
      // case patientConsent:
      //   return PatientConsentPage();
      // case patients:
      //   return PatientsPage();
      // case patientRegister:
      //   return Registrationstatic();
      // case patientDynamic:
      //   return RegistrationDynamic();
      // case patientEdit:
      //   return PatientEditPage();
      // case trainingTest:
      //   return TrainingTestPage();
      // case projectManagerDestinations:
      //   return ProjectManagerDestinationsPage();
      // case enrolUser:
      //   return EnrolUserPage();
      // case manageFieldWorkerDetails:
      //   return ManageFieldWorkerDetails();
      // case updateFieldWorkerProfile:
      //   return UpdateFieldWorkerProfile();
      // case findUser:
      //   return FindUserPage();
      // case teachingModuleStart:
      //   return TeachingModuleStartPage();
      // case teachingModule:
      //   return TeachingModulePage();
      // case video:
      //   return VideoPage();
      // case offlineSync:
      //   return OfflineSync();
      // case patientScreeningOverview:
      //   return PatientOverView();
      // case patientRulesetOutput:
      //   return PatientRulesetOutput();
      // case doctorRulesetOutput:
      //   return DoctorRulesetOutput();
      // case patientScreening:
      //   return NewPatientScreening();
      // case treatmentAdvice:
      //   return TreatmentAdvicePage();
      // case treatmentAdviceWhatIf:
      //   return WhatIfView();
      // case doctorDestinations:
      //   return DestinationsPageDoctor();
      // case projectList:
      //   return ProjectList();
      // case patientScreeningView:
      //   return PatientScreeningView();
      // case referral_card:
      //   return RefralCard();
      // case videolist:
      //   return VideoItemList();
      // case therapyplanQuestion:
      //   return TherapyPlanScreenQuestion();
      // case progressScreen:
      //   return ProgressScreen();
      // case informationScreen:
      //   return InformationScreen();
      // case scheduleScreen:
      //   return ScheduleScreen();
      // case knowledgeResourceScreen:
      //   return KnowledgeResourceScreen();
      // case resourceCategoryListScreen:
      //   return ResourceCategoryListScreen();
      // case appointmentNotificationScreen:
      //   return AppointmentNotificationScreen();
      // case exerciseVideo:
      //   return ExerciseVideo();
      // case staticfieldWorkerDestinations:
      //   return StaticDestinationPageFieldWorker();
      // case mydiarychildren:
      //   return MyDiaryChildren();
      // case mydiaryquestion:
      //   return MyDiaryQuestions();
      // case pdfViewScreen:
      //   return PDFViewerPage();
      // case calenderScreen:
      //   return CustomCalenderScreen();
      // case patientAppoinmentAddScreen:
      //   return PatientAppoinmentScheduleScreen();
      // case painGraphScreen:
      //   return PainGraphScreen();
      // case exerciseGraphScreen:
      //   return ExerciseGraphScreen();
      // case activityGraphScreen:
      //   return ActivityGraphScreen();
      // case kneeFuncGraphScreen:
      //   return KneefuncGraphScreen();
      // case physioProgressScreen:
      //   return PhysioProgressScreen();
      // case customAdvancePDFViewScreen:
      //   return CustomAdvancedPdfViewer();

      // case romResults:
      //   return Results();

      // case romGraphScreen:
      //   return RomGraphScreen();

      case rangeOfMotionSelectionScreen:
        return RangeOfMotionSelectionScreen();

      // case romAngleCalculator:
      //   return RomAngleCalculator();

      // case generalNotificationScreen:
      //   return GeneralNotificationScreen();

      // case otpResetScreen:
      //   return OTPResetScreen();

      // case loginPinResetScreen:
      //   return LoginPinResetScreen();
      // case romPositionSelector:
      //   return RomPositionSelector();
      // case therapyplanlistscreen:
      //   return TherapyPlanListScreen();

      // case therapyplanQuestiondetails:
      //   return TherapyPlanScreenQuestionDetails();
      // default:
      //   return SplashPage();
    }
  }
}
