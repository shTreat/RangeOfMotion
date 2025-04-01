import 'dart:convert';
import 'package:flutter/material.dart';

class Constants {
  static const defaultLocale = 'en';
  static Map<String, String> supportedLanguages = {'English': 'en'};

  static const theme = MaterialColor(
    0xFF6E2E7F,
    {
      50: Color(0xFFF0E5F1),
      100: Color(0xFFDBBEDC),
      200: Color(0xFFC495C6),
      300: Color(0xFFAC6DAF),
      400: Color(0xFF9B519E),
      500: Color(0xFF8A398E),
      600: Color(0xFF7E3488),
      700: Color(0xFF6E2E7F),
      800: Color(0xFF5F2975),
      900: Color(0xFF452162),
    },
  );

  //DateTime constants
  static int initialDateTimeYear = 1970;
  static DateTime minimumDate = DateTime.fromMillisecondsSinceEpoch(0);

  //Colour constants
  static Color testColorPassed = Colors.green[700]!;
  static Color testColorFailed = Colors.red[700]!;
  static Color testColorActive = Colors.blue[700]!;
  static Color testColorFailedRetriesLeft = Colors.deepOrange[700]!;

  static Color uploadImageBorderColor = Colors.grey[400]!;

  static Color trafficLightGreen = Colors.green;
  static Color trafficLightOrange = Colors.orange;
  static Color trafficLightYellow = Colors.yellow;
  static Color trafficLightRed = Colors.red;
  static Color trafficLightGrey = Colors.grey;
  static Color trafficLightBlack = Colors.black;
  static Color trafficLightNone = Colors.transparent;

  static Color followUpIsDiabetic = Colors.cyan[200]!;

  //Sqlflite
  static String sqfliteDb = 'health_worker.db';
  static String sqfliteAdressAreasDb = 'addressareas.db';

  //Hive box indices
  static const hiveFollowUpIndex = 0;
  static const hiveHealthCampEventIndex = 1;
  static const hiveHealthCampLocationIndex = 2;
  static const hiveMemberIndex = 3;
  static const hiveOfflineIndex = 4;
  static const hiveModuleStatusIndex = 5;
  static const hivePersonSessionIndex = 6;
  static const hiveModulesIndex = 7;
  static const hiveModuleIndex = 8;
  static const hiveModuleCardIndex = 9;
  static const hiveConsultationIndex = 10;
  static const hivePatientScreeningIndex = 11;
  static const hiveHtOutputVariablesIndex = 12;
  static const hiveAttributeIndex = 13;
  static const hiveModuleStatusQuestionIndex = 14;
  static const hiveModuleStatusChoiceIndex = 15;
  static const hiveModuleTestIndex = 16;
  static const hiveQuestionIndex = 17;
  static const hiveChoiceIndex = 18;
  static const hiveModuleSessionIndex = 19;
  static const hiveModuleSessionTrainingIndex = 20;
  static const hiveModuleSessionTestIndex = 21;
  static const hiveModuleSessionAnswerIndex = 22;
  static const hiveEducationModuleIndex = 23;
  static const hiveHealthCampVisitIndex = 24;
  static const hiveYearRangeIndex = 25;
  static const hiveSmokeHistoryIndex = 26;
  static const hiveHealthCareServiceIndex = 27;
  static const hiveReasonsNotSeeingDoctorAfterReferralIndex = 28;
  static const hiveFastingPeriodIndex = 29;
  static const hiveTreatmentAnswerIndex = 30;
  static const hiveBloodPressureIndex = 31;
  static const hiveGenderIndex = 32;
  static const hiveHtInputVariablesIndex = 33;
  static const hiveDoctorVisitIndex = 34;
  static const hivePatientEnrollmentIndex = 35;
  static const hivePersonAttributeIndex = 36;

  //Hive box keys
  static String hiveBoxDefaultKey = 'key';

  static String hivePersonSession = 'personSessionHive';
  static String hiveFollowUp = 'followUpHive';
  static String hiveModuleStatus = 'moduleStatusHive';
  static String hiveModules = 'modulesHive';
  static String hiveHealthCampDiagnosis = 'healthCampDiagnosisHive';
  static String hiveHealthCampPerscription = 'healthCampPerscriptionHive';
  static String hiveHealthCamps = 'healthCampsHive';
  static String hiveMembers = 'membersHive';
  static String hiveEducationMembers = 'educationMembersHive';
  static String hiveOffline = 'offlineHive';
  static String hivePatientEnrollment = 'patientEnrollmentHive';
  static String hivePersonAttribute = 'personAttributeHive';

  //file name constants
  static String signatureFile(String uuid) => 'signature_$uuid.png';
  static const String profilePictureFile = 'profile_picture.png';

  static const String personSessionFile = 'person_session.json';
  static const String modulesFile = 'modules.json';
  static const String moduleStatusFile = 'moduleStatus.json';
  static const String healthCampsFile = 'health_camps.json';
  static const String healthCampDiagnosisFile = 'health_camp_diagnosis.json';
  static const String healthCampPerscriptionFile =
      'health_camp_perscription.json';
  static const String followUpsFile = 'follow_ups.json';
  static const String membersFile = 'members.json';
  static const String educationMembersFile = 'education_members.json';
  static const String offlineFile = 'offline.json';

  // HealthTracker constants
  static const String trafficLightGreenString = 'Green';
  static const String trafficLightOrangeString = 'Orange';
  static const String trafficLightYellowString = 'Yellow';
  static const String trafficLightRedString = 'Red';

  // String constants
  static const String maleChar = 'M';
  static const String femaleChar = 'F';
  static const String nullString = 'null';
  static const String undefinedString = 'undefined';
  static const String trueString = 'true';
  static const String falseString = 'false';
    static const String ap_count = 'apppointmentCount';
      static const String ex_count = 'excerciseCount';
            static const String notify_count = 'notify_count';



  //int constants
  static int numberOfAttempts = 3;
  static int numberOfDaysFollowUp = 7;
  static int patientSyncThreshold = 10;

  static int pageAnimateDuration = 400;
  static int patientFetchMaxRecords = 10;

  //double constants
  static double tinyPadding = 4;
  static double smallPadding = 8;
  static double mediumPadding = 16;
  static double largePadding = 40;
  static double extraLargePadding = 56;

  static SizedBox get tinySpacer => SizedBox(height: Constants.tinyPadding);
  static SizedBox get smallSpacer => SizedBox(height: Constants.smallPadding);
  static SizedBox get mediumSpacer => SizedBox(height: Constants.mediumPadding);
  static SizedBox get largeSpacer => SizedBox(height: Constants.largePadding);
  static SizedBox get extraLargeSpacer =>
      SizedBox(height: Constants.extraLargePadding);

  // static List<Widget> keyValueRow(String key, String value,
  //         {bool space = true}) =>
  //     [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         mainAxisSize: MainAxisSize.max,
  //         children: [
  //           Text('${key.toString().capitalize()}:'),
  //           Text('${value.toString().capitalize()}'),
  //         ],
  //       ),
  //       if (space) Constants.tinySpacer,
  //     ];

  static List<Widget> branding({bool firstLogo = true}) => [
        //WebsafeSvg.asset(Constants.logoFilePath),
        if (firstLogo)
          Image.asset('assets/logo2.png')
        else
          Image.asset('assets/logo1.png'),

        SizedBox(width: 15),
      ];

  static double infoDialogMargin = 30;
  static double dateTimeInputWidth = 70;
  static double numericInputWidth = 50;
  static double numericInputHeight = 50;
  static double extraPadding = 25;

  static double profilePadding = 30;
  static double screeningCardPadding = 60;
  static double screeningWidgetHeight = 100;
  static double screeningWidgetPadding = 130;

  static double daysInAYear = 365.25;
  static double sbpTarget = 140;

  static int maxAgeForPatients = 100;

  //Mime types
  static const applicationJSON = 'application/json';

  static const String logoFilePath = 'assets/logo.svg';

  //Regex
  //Minimum eight characters, at least one uppercase letter, one lowercase letter and one number with optional special characters
  static const passwordRegex = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^ ]{8,}$';
  static const phoneNumberRegex = r'[0-9 \-\+]+';

  //OpenMRS
  static const openMrsRoleNameProjectManager = 'Project Manager';
  static const openMrsRoleNameFieldWorker = 'ASHA';
  static const openMrsRoleNameDoctor = 'Doctor';
  static const openMrsRoleUuidFieldWorker =
      'a9e81592-fbdd-411f-ab95-b943e9ab3fcc';
  static const openMrsAttributePhoneNumber = 'phonenumber';
  static const openMrsAttributeConsent = 'consent';
  static const openMrsAttributeDateRegistered = 'dateRegistered';
  static const openMrsAttributeAddress = 'location';
  static const openMrsAttributeNationalId = 'nationalid';
  static const openMrsAttributeCertificate = 'certificate';
  static const openMrsAttributeProfilePicture = 'profilePicture';
  static const openMrsAttributePasswordReset = 'Requires password reset';
  static const openMrsEncounterTypePreTest = 'preTest';
  static const openMrsEncounterTypePostTest = 'postTest';
  static const openMrsEncounterTypeTeaching = 'teaching';
  static const openMrsEncounterTypeHealthCamp = 'HealthCamp';
  static const openMrsEncounterTypeHealthCampFollowUp = 'HealthCampFollowUp';
  static const openMrsVisitTypeHealthCampFollowUp = 'HEALTHCAMPFOLLOWUP';
  static const openMrsConceptClassModuleTotal = 'ModuleTotal';
  static const openMrsConceptClassModuleCompleted = 'ModuleCompleted';
  static const openMrsConceptClassQuizQuestion = 'QuizQuestion';
  static const openMrsConceptClassCorrectChoice = 'CorrectChoice';
  static const openMrsGetCustomForm =
      'custom:(uuid,name,formFields:(uuid,sortWeight,field:(uuid,concept:(uuid,answers:(uuid,descriptions:(uuid,description,locale),conceptClass:(name)),descriptions:(description,locale),conceptClass:(display)),selectMultiple)))';
  static const openMrsGetCustomAllPersons =
      'custom:(uuid,display,givenName,familyName,birthdate,attributes:(attributeType:(display),value,uuid))';
  static const openMrsGetCustomAllUsers =
      'custom:(uuid,username,roles:(display,uuid),person:(uuid,display,givenName,familyName,attributes:(attributeType:(display),value,uuid)),retired)';
  static const openMrsGetCustomConcept =
      'custom:(setMembers:(uuid,name:(name),descriptions:(description,locale),datatype:(name)))';
  static const openMrsGetCustomVisit =
      'custom:(uuid,patient:(uuid,person:(uuid,display,givenName,familyName,attributes:(attributeType:(display),value,uuid))),visitType:(display),startDatetime,stopDatetime,encounters:(uuid,location),auditInfo)';
  static const openMrsGetCustomObs =
      'custom:(concept:(uuid,conceptClass:(display)),value:(name:(display)))';
  static const openMrsAttributeUuidPersonEmail =
      '7ea809ec-f9b7-4ea8-84e0-5e790029e3ed';
  static const openMrsAttributeUuidPersonPhone =
      '6e72198f-53bd-487e-bbfe-def79785420f';
  static const openMrsAttributeUuidConsent =
      '2a8c5410-42a4-4377-b462-90dce3c49d27';
  static const openMrsAttributeUuidNationalId =
      'a79af99a-1a22-4697-9cba-e842d3c67cef';
  static const openMrsAttributeUuidGovernmentRegistrationNumber =
      'a69a2de3-e9fc-458d-8648-e2ab0523b770';
  static const openMrsAttributeUuidSignature =
      '5b1b3d50-30c4-440c-ac79-2fbcc95da446';
  static const openMrsAttributeUuidProfilePicture =
      'bbf44887-04e6-48ad-ac3d-0a784c9283c1';
  static const openMrsAttributeUuidCertificate =
      '41d5bec3-41ba-497d-a367-18980cb9472d';
  static const openMrsAttributeUuidPersonDateRegistered =
      '869d70cf-ed25-4f86-aea3-007fb037de7c';
  static const openMrsAttributeUuidPersonLocation =
      'fb08a17d-f2e1-4fd8-a961-404e0392e736';
  static const openMrsAttributeUuidVisitTypeCommunityEducation =
      '11465907-c8e7-4f1c-add6-0ff390cc1c81';
  static const openMrsAttributeUuidVisitTypeFieldWorkerTraining =
      '5ed326eb-eb3c-4b65-8e80-2fcef266c18f';
  static const openMrsAttributeUuidVisitTypeHealthCamp =
      'a635c917-bb9e-4599-9510-9035d52e2cb9';
  static const openMrsAttributeUuidVisitTypeHealthCampFollowUp =
      'd2173fd9-36a2-45bb-ae04-c9fc815421d9';
  static const openMrsConceptUuidHealthCampDiagnosis =
      '3c946211-9b1f-49c8-8dd5-5968c32b585d';
  static const openMrsConceptUuidHealthCampPerscription =
      '7a77e289-2189-4a21-b366-c1a922b28b1a';
  static const openMrsConceptUuidFollowUpCompleted =
      'c90efe34-47c9-4806-a623-7fa7131a0e46';
  static const openMrsConceptUuidFollowUpCompletedReason =
      'aebdb784-472a-4953-be95-5265b0d0b06f';

  static const openMrsConceptUuidVisitTypeScreeningFollowup =
      '3f58b08f-b2e3-4ed0-9900-3090c3b57d74';
  static const openMrsConceptUuidVisitTypeReferralFollowup =
      '1feaaef6-30fb-4b57-896f-f9ac42b80367';

  static const openMrsConceptUuidDoctorOutcomeNoMedicationRecommended =
      'ee6ea800-edd0-4983-97f7-e76cd7163557';
  static const openMrsConceptUuidDoctorOutcomeRecommendedMedicationPrescribed =
      '42bcae51-f8b8-4e0f-8fa4-b2269b7d8a53';
  static const openMrsConceptUuidDoctorOutcomeRecommendedMedicationNotPrescribed =
      '68109c25-068e-439e-8b53-f9329575c9e3';

  static const String StatusRetired = 'Retired';
  static const String StatusSuspended = 'Suspended';
  static const String StatusActive = 'Active';

  static const String ChangeStatusActivate = 'activate';
  static const String ChangeStatusSuspend = 'suspend';

  static const int ScreenEncounterTypes_PatientScreening = 0;
  static const int ScreenEncounterTypes_FullReview = 1;
  static const int ScreenEncounterTypes_QuickReview = 2;
  static const int ScreenEncounterTypes_DoctorReview = 3;

  static const int NationalIdLength = 16;

  static const String HighRiskLevel = 'high';
  static const String countryCode = '+91';
  // static const resources = [
  //   ResourceItem(
  //       title: 'Kader Resources',
  //       title_id: 'Materi Promkes',
  //       type: ResourceType.Heading),
  //   ResourceItem(
  //       title: 'Heart Attack',
  //       title_id: 'Serangan Jantung',
  //       type: ResourceType.Video,
  //       assetPath: 'assets/resources/heartattack.3gp'),
  //   ResourceItem(
  //       title: 'Nutrition',
  //       title_id: 'Nutrisi',
  //       type: ResourceType.Video,
  //       assetPath: 'assets/resources/nutrition.3gp'),
  //   ResourceItem(
  //       title: 'Phyiscal Activity',
  //       title_id: 'Aktivitas Fisik',
  //       type: ResourceType.Video,
  //       assetPath: 'assets/resources/physicalactivity.3gp'),
  //   ResourceItem(
  //       title: 'Smoking',
  //       title_id: 'Bahaya Merokok',
  //       type: ResourceType.Video,
  //       assetPath: 'assets/resources/smoking.3gp'),
  //   ResourceItem(
  //       title: 'Patient Resources',
  //       title_id: 'Edukasi Pasien',
  //       type: ResourceType.Heading),
  //   ResourceItem(
  //       title: 'Stroke',
  //       type: ResourceType.Video,
  //       assetPath: 'assets/resources/stroke.3gp'),
  //   ResourceItem(
  //       title: 'Manual 1',
  //       type: ResourceType.Pdf,
  //       assetPath: 'assets/resources/manual_1.pdf'),
  //   ResourceItem(
  //       title: 'Manual 2',
  //       type: ResourceType.Pdf,
  //       assetPath: 'assets/resources/manual_2.pdf'),
  //   ResourceItem(
  //       title: 'Manual 3',
  //       type: ResourceType.Pdf,
  //       assetPath: 'assets/resources/manual_3.pdf'),
  //   ResourceItem(
  //       title: 'Manual 4',
  //       type: ResourceType.Pdf,
  //       assetPath: 'assets/resources/manual_4.pdf'),
  //   ResourceItem(
  //       title: 'Manual 5',
  //       type: ResourceType.Pdf,
  //       assetPath: 'assets/resources/manual_5.pdf'),
  //   ResourceItem(
  //       title: 'Manual 6',
  //       type: ResourceType.Pdf,
  //       assetPath: 'assets/resources/manual_6.pdf'),
  //   ResourceItem(
  //       title: 'Manual 7',
  //       type: ResourceType.Pdf,
  //       assetPath: 'assets/resources/manual_7.pdf'),
  //   ResourceItem(
  //       title: 'Manual 8',
  //       type: ResourceType.Pdf,
  //       assetPath: 'assets/resources/manual_8.pdf'),
  //   ResourceItem(
  //       title: 'Manual 9',
  //       type: ResourceType.Pdf,
  //       assetPath: 'assets/resources/manual_9.pdf'),
  //   ResourceItem(
  //       title: 'Manual 10',
  //       type: ResourceType.Pdf,
  //       assetPath: 'assets/resources/manual_10.pdf'),
  //   ResourceItem(
  //       title: 'Text Document',
  //       type: ResourceType.Text,
  //       assetPath: 'assets/resources/sampletext.txt'),
  //   ResourceItem(
  //       title: 'Alarm audio',
  //       type: ResourceType.Audio,
  //       assetPath: 'assets/resources/alarm.mp3'),
  // ];
}

// extension RoleHelpers on HealthWorkerAPIModelsUser {
//   bool isFieldWorker() {
//     return _hasRole(this, Constants.openMrsRoleNameFieldWorker);
//   }

//   bool isProjectManager() {
//     return _hasRole(this, Constants.openMrsRoleNameProjectManager);
//   }

//   bool isDoctor() {
//     return _hasRole(this, Constants.openMrsRoleNameDoctor);
//   }

//   bool _hasRole(HealthWorkerAPIModelsUser user, String role) =>
//       user?.roles?.any((userRole) => userRole?.isRole(role)) ?? false;
// }

extension DateTimeHelpers on DateTime {
  String differenceInYears() {
    return (DateTime.now()
                .difference(
                  this,
                )
                .inDays /
            Constants.daysInAYear)
        .toStringAsFixed(0);
  }
}

extension StringHelpers on String {
  // String toLocale(Localisations localizations) {
  //   if (trim().startsWith('{')) {
  //     try {
  //       final json = jsonDecode(this);
  //       final localString = json[localizations.localeName];
  //       final localMap = (json as Map<String, Object>)?.values;
  //       return localString ??
  //           json[Constants.defaultLocale] ??
  //           localMap?.first ??
  //           this;
  //       // ignore: empty_catches
  //     } catch (error) {}
  //   }
  //   return this;
  // }

  bool isFieldWorker() {
    return isRole(Constants.openMrsRoleNameFieldWorker);
  }

  bool isProjectManager() {
    return isRole(Constants.openMrsRoleNameProjectManager);
  }

  bool isDoctor() {
    return isRole(Constants.openMrsRoleNameDoctor);
  }

  bool isRole(String roleToCheck) =>
      roleToCheck != null ? compareTo(roleToCheck) == 0 : false;

  bool canEditPatientDetails() {
    return isFieldWorker();
  }

  bool canCreatePatient() {
    return isFieldWorker();
  }

  bool canCreateKaderOrDoctor() {
    return isProjectManager();
  }
}
