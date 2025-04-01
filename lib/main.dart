import 'package:flutter/material.dart';
import 'package:range_of_motion/rom_angle_calculator.dart';
import 'package:range_of_motion/widgets/button_single.dart';

import 'constants/routes.dart';
import 'rage_of_motion_options_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: createMaterialColor(Colors.purple.shade300)),
      home: const MyHomePage(title: 'ROM Calculator'),
      initialRoute: '/',
      routes: {
        // '/': (context) => MyHomePage(title: 'ROM Calculator'),
        // Routes.romPositionSelector: (context) => RomPositionSelector(),
        // Routes.pinSaverScreen: (context) => TreatPinSaver(),
        // Routes.knowledge: (context) => KnowledgeScreen(),
        // Routes.myDiary: (context) => MyDiaryScreen(),
        // Routes.loginOtp: (context) => TreatOtpPage(),
        // Routes.patientSpecificScreen: (context) => PatientSpecificScreen(),
        // Routes.patientFieldWorkerMessageScreen: (context) =>
        //     PatientFieldWorkerMessage(),
        // Routes.patientAppointmentScreen: (context) => AppointmentScreen(),
        // Routes.therapyPlanScreen: (context) => TherapyPlanScreen(),

        // Routes.splash: (context) => SplashPage(),
        // // Routes.login: (context) => Login(),
        // Routes.login: (context) => LoginMobileNumber(),
        // Routes.loginFieldWorker: (context) => TreatLogin(),
        // Routes.loginRole: (context) => LoginRole(),
        // Routes.resetPassword: (context) => ResetPasswordPage(),
        // Routes.sendResetPasswordEmail: (context) =>
        //     SendResetPasswordEmailPage(),
        // // Routes.fieldWorkerDestinations: (context) =>
        // //     DestinationPageFieldWorker(),
        Routes.fieldWorkerDestinations: (context) =>
            MyHomePage(title: 'ROM Calculator'),
        // Routes.educateTest: (context) => EducateTestPage(),
        // Routes.educateTestResults: (context) => EducateTestResultsPage(),
        // Routes.healthCampAddVisitDiagnosis: (context) =>
        //     HealthCampAddVisitDiagnosisPage(),
        // Routes.healthCampAddVisitPerscription: (context) =>
        //     HealthCampAddVisitPerscriptionPage(),
        // Routes.healthCampAddVisitCompletion: (context) =>
        //     HealthCampAddVisitCompletionPage(),
        // Routes.healthCampFindPatient: (context) => HealthCampFindPatientPage(),
        // Routes.patientDetails: (context) => PatientDetailsPage(),
        // Routes.patientAcceptConsent: (context) => PatientAcceptConsentPage(),
        // Routes.patientConsent: (context) => PatientConsentPage(),
        // Routes.patients: (context) => PatientsPage(),
        // Routes.patientRegister: (context) => Registrationstatic(),
        // Routes.patientDynamic: (context) => RegistrationDynamic(),
        // Routes.patientEdit: (context) => PatientEditPage(),
        // Routes.trainingTest: (context) => TrainingTestPage(),
        // Routes.trainingTestResults: (context) => TrainingTestResultsPage(),
        // Routes.projectManagerDestinations: (context) =>
        //     ProjectManagerDestinationsPage(),
        // Routes.enrolUser: (context) => EnrolUserPage(),
        // Routes.manageFieldWorkerDetails: (context) =>
        //     ManageFieldWorkerDetails(),
        // Routes.updateFieldWorkerProfile: (context) =>
        //     UpdateFieldWorkerProfile(),
        // Routes.findUser: (context) => FindUserPage(),
        // Routes.teachingModuleStart: (context) => TeachingModuleStartPage(),
        // Routes.teachingModule: (context) => TeachingModulePage(),
        // Routes.video: (context) =>
        //     VideoPage(videoPath: ModalRoute.of(context).settings.arguments),
        // Routes.offlineSync: (context) => OfflineSync(),
        // Routes.patientScreeningOverview: (context) => PatientOverView(),
        // Routes.patientRulesetOutput: (context) => PatientRulesetOutput(),
        // Routes.doctorRulesetOutput: (context) => DoctorRulesetOutput(),
        // Routes.patientScreening: (context) => NewPatientScreening(),
        // Routes.treatmentAdvice: (context) => TreatmentAdvicePage(),
        // Routes.treatmentAdviceWhatIf: (context) => WhatIfView(),
        // Routes.doctorDestinations: (context) => DestinationsPageDoctor(),
        // Routes.projectList: (context) => ProjectList(),
        // Routes.patientScreeningView: (context) => PatientScreeningView(),
        // Routes.referral_card: (context) => RefralCard(),
        // Routes.videolist: (context) => VideoItemList(),
        // Routes.therapyplanQuestion: (context) => TherapyPlanScreenQuestion(),
        // Routes.progressScreen: (context) => ProgressScreen(),
        // Routes.informationScreen: (context) => InformationScreen(),
        // Routes.scheduleScreen: (context) => ScheduleScreen(),
        // Routes.knowledgeResourceScreen: (context) => KnowledgeResourceScreen(),
        // Routes.resourceCategoryListScreen: (context) =>
        //     ResourceCategoryListScreen(),
        // Routes.appointmentNotificationScreen: (context) =>
        //     AppointmentNotificationScreen(),
        // Routes.exerciseVideo: (context) => ExerciseVideo(),
        // Routes.staticfieldWorkerDestinations: (context) =>
        //     StaticDestinationPageFieldWorker(),
        // Routes.mydiarychildren: (context) => MyDiaryChildren(),
        // Routes.mydiaryquestion: (context) => MyDiaryQuestions(),
        // Routes.pdfViewScreen: (context) => PDFViewerPage(),
        // Routes.calenderScreen: (context) => CustomCalenderScreen(),
        // Routes.patientAppoinmentAddScreen: (context) =>
        //     PatientAppoinmentScheduleScreen(),
        // Routes.painGraphScreen: (context) => PainGraphScreen(),
        // Routes.exerciseGraphScreen: (context) => ExerciseGraphScreen(),
        // Routes.activityGraphScreen: (context) => ActivityGraphScreen(),
        // Routes.kneeFuncGraphScreen: (context) => KneefuncGraphScreen(),
        // Routes.physioProgressScreen: (context) => PhysioProgressScreen(),
        // Routes.customAdvancePDFViewScreen: (context) =>
        //     CustomAdvancedPdfViewer(),

        // Routes.romResults: (context) => Results(),
        // Routes.romGraphScreen: (context) => RomGraphScreen(),
        // // Range of motion new flow
        Routes.rangeOfMotionSelectionScreen: (context) =>
            RangeOfMotionSelectionScreen(),
        // Routes.romAngleCalculator: (context) => RomAngleCalculator(),
        // Routes.generalNotificationScreen: (context) =>
        //     GeneralNotificationScreen(),
        // Routes.otpResetScreen: (context) => OTPResetScreen(),
        // Routes.loginPinResetScreen: (context) => LoginPinResetScreen(),
      },
    );
  }

  MaterialColor createMaterialColor(Color color) {
    Map<int, Color> swatch = {
      50: Color.alphaBlend(Colors.white.withOpacity(0.9), color),
      100: Color.alphaBlend(Colors.white.withOpacity(0.8), color),
      200: Color.alphaBlend(Colors.white.withOpacity(0.6), color),
      300: Color.alphaBlend(Colors.white.withOpacity(0.4), color),
      400: Color.alphaBlend(Colors.white.withOpacity(0.2), color),
      500: color, // Default shade
      600: Color.alphaBlend(Colors.black.withOpacity(0.1), color),
      700: Color.alphaBlend(Colors.black.withOpacity(0.2), color),
      800: Color.alphaBlend(Colors.black.withOpacity(0.3), color),
      900: Color.alphaBlend(Colors.black.withOpacity(0.4), color),
    };

    return MaterialColor(color.value, swatch);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('ROM Calculator'),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RangeOfMotionSelectionScreen()), // NewScreen is the widget for the new screen
                );
              },
              child: Text('Start'))),
    );
  }
}
