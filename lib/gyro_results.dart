import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../../widgets/button_single.dart';
import 'constants/constants.dart';
import 'constants/routes.dart';
import 'rom_angle_calculator.dart';
import 'utils/label_text.dart';
import 'widgets/custom_dialog.dart';
import 'widgets/loading_overlay.dart';

class GyroResult extends StatefulWidget {
  final int? extLeft;
  final int? extRight;
  final int? flexLeft;
  final int? flexRight;
  final int? page;
  final PageNum? pageNum;
  final int? initialKnee;
  final bool isOneKneeMeasured;
  GyroResult(
      {Key? key,
      this.pageNum,
      this.isOneKneeMeasured = false,
      this.initialKnee,
      this.extLeft,
      this.extRight,
      this.flexLeft,
      this.flexRight,
      this.page})
      : super(key: key);

  @override
  State<GyroResult> createState() => _GyroResultState();
}

class _GyroResultState extends State<GyroResult> {
  // MwProjectMorbidityEvaluation patientvist_list;
  // MwProjectMorbidityEvaluation _projectMorbidityEvaluation =
  //     MwProjectMorbidityEvaluation();
  // List<MwProjectMorbidityEvaluationDetail> _projectMorbidityEvaluationDetail =
  //     <MwProjectMorbidityEvaluationDetail>[];
  // int projectmorbidityid;
  // int dbUserId, dbPersonId, projectId, health_facility_id = 0;
  // Map<String, Object> ruleset = {};
  var project_morbidity_output_id;
  // DataProvider _dataProvider;
  // List<ProjectMorbidityOutputQuestionApiModel>
  //     _projectMorbidityOutputQuestionApiModel =
  //     <ProjectMorbidityOutputQuestionApiModel>[];
  // List<RulesetVariable> ruleset_Variable;
  Map<int, String> rulesetVartl_all = {};
  Map<String, Object> rulesetVar = {};
  Map<int, String> rulesetVartl = {};
  // int flexion, flexion1, flexion2 = 0;
  int romL = 0, romR = 0;
  var allLabel;
  bool _isLoading = false;
  int? page;
  // Config _config;
  String role = '';

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    setState(() {});
    // await FirebaseAnalytics.instance.setCurrentScreen(
    //   screenName: '${Routes.customRomResults}',
    // );
    // _config = await fetchConfig();
    Object? data = ModalRoute.of(context)?.settings.arguments;

    if (data != null) {
      // patientvist_list = data[0];
      // _projectMorbidityEvaluation = await _dataProvider
      //     .getMwProjectMorbidityEvaluation(dbPersonId, patientvist_list);
      // if (_projectMorbidityEvaluation != null &&
      //     _projectMorbidityEvaluation.project_morbidity_evaluation_guid !=
      //         null) {
      //   _projectMorbidityEvaluationDetail =
      //       await _dataProvider.getMwProjectMorbidityEvaluationDetailList(
      //           _projectMorbidityEvaluation.project_morbidity_evaluation_guid);

      //   if (_projectMorbidityEvaluationDetail.isNotEmpty) {
      //     _projectMorbidityEvaluationDetail.forEach((element) {
      //       _formData[element.project_morbidity_queston_id.toString()] =
      //           element.project_morbidity_queston_value;
      //     });
      //   }
      // }
    } else {
      page = widget.page!;
      romL = getCorrectedValue(widget.flexLeft ?? 0, widget.extLeft ?? 0);
      romR = getCorrectedValue(widget.flexRight ?? 0, widget.extRight ?? 0);
    }

    // final prefs = await SharedPreferences.getInstance();
    // allLabel = await DataProvider().updateLabel();
    // role = prefs.getString(SecureStorageKeys.role);
    // setState(() {});
    // projectmorbidityid = _config.data.morbidity_rom_id;
    // dbUserId = prefs.getInt(SecureStorageKeys.dbUserId);
    // dbPersonId = prefs.getInt(SecureStorageKeys.dbPersonId);
    // projectId = prefs.getInt(SecureStorageKeys.projectId);
    // health_facility_id = prefs.getInt(SecureStorageKeys.health_facility_id);
    // ruleset['Today'] = DateTime.now().toString();
    // _projectMorbidityOutputQuestionApiModel =
    //     await _dataProvider.getprojectMorbidityOutputQuestionApiModel();

    // ruleset_Variable = await _dataProvider.getRulesetVariable();
    // ruleset_Variable.forEach((element) {
    //   rulesetVartl_all[element.ruleset_variable_id] =
    //       element.ruleset_variable_name.toLowerCase();
    // });

    // if (_projectMorbidityOutputQuestionApiModel.isNotEmpty) {
    //   project_morbidity_output_id = _projectMorbidityOutputQuestionApiModel[0]
    //       .project_morbidity_output_id;

    //   for (var i = 0; i < _projectMorbidityOutputQuestionApiModel.length; i++) {
    //     if (_projectMorbidityOutputQuestionApiModel[i]
    //         .ruleset_variable_name
    //         .isNotEmpty) {
    //       rulesetVar[_projectMorbidityOutputQuestionApiModel[i]
    //               .ruleset_variable_name
    //               .toLowerCase()] =
    //           _projectMorbidityOutputQuestionApiModel[i]
    //               .project_morbidity_output_question_id;
    //     }

    //     if (_projectMorbidityOutputQuestionApiModel[i].tl_ruleset_variable_id >
    //             0 &&
    //         rulesetVartl_all.containsKey(
    //             _projectMorbidityOutputQuestionApiModel[i]
    //                 .tl_ruleset_variable_id)) {
    //       rulesetVartl[_projectMorbidityOutputQuestionApiModel[i]
    //               .project_morbidity_output_question_id] =
    //           rulesetVartl_all[_projectMorbidityOutputQuestionApiModel[i]
    //               .tl_ruleset_variable_id];
    //     }
    //   }
    // }
    setState(() {});
  }

  Map<String, Object> _formData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _dataProvider = DataProvider();
  }

  Future<bool> _onWillPop() async {
    return (await customDialog(
          context,
          title: LabelText.are_you_sure,
          content: LabelText.leave_page,
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                // Navigator.pushReplacementNamed(
                //   context,
                //   Routes.fieldWorkerDestinations,
                // );
                await Navigator.pushReplacement(
                  context,
                  await Routes().getPageRoute(
                    routeName: Routes.fieldWorkerDestinations,
                  ),
                );
              },
              child: Text(
                LabelText.dialogYes,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                LabelText.dialogNo,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )) ??
        false;
  }

  String getPositionName(int position) {
    if (position == 0) {
      return "";
    } else if (position == 1) {
      return LabelText.romPosition1;
    } else if (position == 2) {
      return LabelText.romPosition2;
    } else if (position == 3) {
      return LabelText.romPosition3;
    } else {
      return '';
    }
  }

  String getImagePosition(int position) {
    if (position == 0) {
      return 'assets/position1 first.png';
    } else if (position == 1) {
      return 'assets/position1 first.png';
    } else if (position == 2) {
      return 'assets/position1 first.png';
    } else if (position == 3) {
      return 'assets/position2 first.png';
    } else {
      return 'assets/position2 first.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: 20,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              // LabelText.getLabel(
              //     'rangeOfMotion', LabelText.rangeOfMotion, allLabel)
              "${LabelText.position}: ${getPositionName(page!)}",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: kIsWeb
                  ? EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width *
                          (kIsWeb ? .285 : .1),
                    )
                  : EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width *
                          (kIsWeb ? .285 : .045)),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Constants.extraLargeSpacer,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.73),
                        child: AspectRatio(
                          aspectRatio: 1 / 0.6,
                          child: Image.asset(
                            getImagePosition(
                              page!,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Constants.smallSpacer,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (widget.extLeft != null && widget.flexLeft != null)
                            Expanded(
                              child: Card(
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${LabelText.leftLeg}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                      Divider(),
                                      Row(
                                        children: [
                                          Text('${LabelText.flexionAngle} ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400)),
                                          Image.asset(
                                            'assets/flexion_icon.png',
                                            width: 70,
                                          ),
                                          Text(': ${widget.flexLeft ?? 0}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Text('${LabelText.extensionAngle}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400)),
                                          Image.asset(
                                            'assets/extension_icon.png',
                                            width: 90,
                                          ),
                                          Text(
                                              ' : ${getExtensionValue(widget.extLeft ?? 0)}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      Divider(),
                                      Text(
                                          '${LabelText.rangeOfMotion} : ${getCorrectedValue(widget.flexLeft ?? 0, widget.extLeft ?? 0)}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          else
                            SizedBox.shrink(),
                          if (widget.extRight != null &&
                              widget.flexRight != null)
                            Expanded(
                              child: Card(
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${LabelText.rightLeg}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                      Divider(),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                                '${LabelText.flexionAngle} ',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Image.asset(
                                              'assets/flexion_icon.png',
                                              width: 70,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                                ': ${widget.flexRight ?? 0}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                                '${LabelText.extensionAngle}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Image.asset(
                                              'assets/extension_icon.png',
                                              width: 90,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                                ' : ${getExtensionValue(widget.extRight ?? 0)}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Constants.smallSpacer,
                                      Text(
                                          '${LabelText.rangeOfMotion} : ${getCorrectedValue(widget.flexRight ?? 0, widget.extRight ?? 0)}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          else
                            SizedBox.shrink(),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Builder(
                              builder: (context) => ElevatedButton(
                                // width: MediaQuery.of(context).size.width * .40,
                                // backgroundColor:
                                //     Theme.of(context).primaryColorDark,
                                child: Text(LabelText.recalculate),
                                onPressed: () async {
                                  await customDialog(
                                    context,
                                    title: LabelText.are_you_sure,
                                    content: LabelText.recaluculateMessage,
                                    actions: <Widget>[
                                      Row(
                                        children: [
                                          Spacer(),
                                          ElevatedButton(
                                            onPressed: () async {
                                              await Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              RomAngleCalculator(
                                                                page: widget
                                                                    .pageNum,
                                                                initalKnee: widget
                                                                    .initialKnee,
                                                                isOneKneeMeasured:
                                                                    false,
                                                              ),
                                                          settings: RouteSettings(
                                                              name: Routes
                                                                  .customROMcalculator)));
                                            },
                                            child: Center(
                                              child: Text(
                                                LabelText.dialogYes,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Center(
                                              child: Text(
                                                LabelText.dialogNo,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          Center(
                            child: Builder(
                              builder: (context) => ElevatedButton(
                                // width: MediaQuery.of(context).size.width * .40,
                                // backgroundColor:
                                //     Theme.of(context).primaryColorDark,
                                child: Text('Home'),
                                // (role.toLowerCase() != 'physiotherapist' &&
                                //         role.toLowerCase() != 'surgeon')
                                //     ? LabelText.getLabel(
                                //         'accept_consent_save',
                                //         LabelText.accept_consent_save,
                                //         allLabel)
                                //     : LabelText.getLabel(
                                //         'next', LabelText.next, allLabel),
                                onPressed: () async {
                                  await Navigator.pushReplacement(
                                      context,
                                      await Routes().getPageRoute(
                                        routeName:
                                            Routes.fieldWorkerDestinations,
                                      ));
                                  // setState(() {
                                  //   _isLoading = true;
                                  // });
                                  // _formData.clear();
                                  // _formData = {
                                  //   '1725': widget.extLeft ??
                                  //       0.toString(), //left extension
                                  //   '1726': widget.flexLeft ??
                                  //       0.toString(), //left flexion
                                  //   '1727': widget.extRight ??
                                  //       0.toString(), //right extension
                                  //   '1728': widget.flexRight ??
                                  //       0.toString(), //right flexion
                                  //   // '1729': '0',
                                  //   // '1730': flexion2.toString(),
                                  // };
                                  // await saveRomData(_formData, romL.toDouble(),
                                  //     romR.toDouble(), page);

                                  // setState(() {
                                  //   _isLoading = false;
                                  // });
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  if (_isLoading)
                    Positioned.fill(child: Center(child: LoadingOverlay())),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  int getCorrectedValue(int value1, int value2) {
    if (value1 >= value2) {
      return value1 - value2;
    } else if (value2 >= value1) {
      return value2 - value1;
    } else {
      return 0;
    }
    // var correctedValue = value1 - value2;
    // correctedValue = (correctedValue + 180) % 360 - 180;
    // return correctedValue.abs();
  }

  int getExtensionValue(int value) {
    var correctedValue = value;
    if (value > 0) {
      correctedValue = correctedValue * -1;
    }
    return correctedValue;
  }

//   Future<void> saveRomData(Map<String, Object> _formData, double romScore,
//       double romScoreR, int page) async {
//     var project_visit_role_idVal = 0;

//     _projectMorbidityEvaluation = MwProjectMorbidityEvaluation();
//     _projectMorbidityEvaluation.project_morbidity_evaluation_guid = Uuid().v1();
//     _projectMorbidityEvaluation.project_morbidity_evaluation_date =
//         DateTime.now().toString();
//     _projectMorbidityEvaluation.project_morbidity_evaluation_start_date =
//         DateTime.now().toString();
//     _projectMorbidityEvaluation.project_morbidity_evaluation_end_date =
//         DateTime.now().toString();
//     _projectMorbidityEvaluation.project_morbidity_evaluation_is_deleted =
//         'false';
//     // _projectMorbidityEvaluation.project_morbidity_evaluation_id;
//     _projectMorbidityEvaluation.project_id = projectId;
//     _projectMorbidityEvaluation.project_visit_role_id =
//         project_visit_role_idVal;
//     _projectMorbidityEvaluation.project_morbidity_id = projectmorbidityid;
//     _projectMorbidityEvaluation.project_morbidity_evaluation_user_id = dbUserId;
//     // _projectMorbidityEvaluation.project_morbidity_evaluation_location1_id;
//     // _projectMorbidityEvaluation.project_morbidity_evaluation_location2_id;
//     // _projectMorbidityEvaluation.project_morbidity_evaluation_location3_id;
//     _projectMorbidityEvaluation.project_morbidity_evaluation_created_by =
//         dbUserId;
//     _projectMorbidityEvaluation.project_morbidity_evaluation_created_on =
//         DateTime.now().toString();
//     _projectMorbidityEvaluation.patient_id = dbPersonId;
//     _projectMorbidityEvaluation.health_facility_id = health_facility_id;

//     _projectMorbidityEvaluation.score = romScore;
//     _projectMorbidityEvaluation.score2 = romScoreR;
//     _projectMorbidityEvaluation.position = page;
//     _projectMorbidityEvaluation.isEdited = 1;
//     _projectMorbidityEvaluationDetail.clear();

//     _formData.forEach((key, value) {
//       var projectMorbidityEvaluationDetail =
//           MwProjectMorbidityEvaluationDetail();
//       projectMorbidityEvaluationDetail.project_morbidity_evaluation_guid =
//           _projectMorbidityEvaluation.project_morbidity_evaluation_guid;
//       projectMorbidityEvaluationDetail
//           .project_morbidity_evaluation_detail_guid = Uuid().v1();
//       projectMorbidityEvaluationDetail.project_morbidity_queston_id =
//           int.tryParse(key);

//       var negativevalue;
//       if (key.contains('1725')) {
//         if (int.parse(value.toString()) > 0) {
//           var val = int.parse(value.toString()) * -1;
//           negativevalue = val.toString();
//         } else {
//           negativevalue = value.toString();
//         }

//         projectMorbidityEvaluationDetail.project_morbidity_queston_value =
//             negativevalue;
//       } else if (key.contains('1727')) {
//         if (int.parse(value.toString()) > 0) {
//           var val = int.parse(value.toString()) * -1;
//           negativevalue = val.toString();
//         } else {
//           negativevalue = value.toString();
//         }

//         projectMorbidityEvaluationDetail.project_morbidity_queston_value =
//             negativevalue;
//       } else {
//         projectMorbidityEvaluationDetail.project_morbidity_queston_value =
//             value.toString();
//       }

//       projectMorbidityEvaluationDetail.project_morbidity_id =
//           projectmorbidityid;
//       projectMorbidityEvaluationDetail
//           .project_morbidity_evaluation_detail_is_deleted = 'false';
//       projectMorbidityEvaluationDetail
//           .project_morbidity_evaluation_detail_created_by = dbUserId;
//       projectMorbidityEvaluationDetail
//               .project_morbidity_evaluation_detail_created_on =
//           DateTime.now().toString();

//       _projectMorbidityEvaluationDetail.add(projectMorbidityEvaluationDetail);
//     });
//     var _projectMorbidityOutputEvaluationDetailList =
//         List<ProjectMorbidityOutputEvaluationDetail>();
//     var projectMorbidityOutputEvaluation = ProjectMorbidityOutputEvaluation();
//     var outputRuleset = {};
// //var outputRulesetweb;
//     var rule = <String, dynamic>{};
//     rule['inputVariables'] = ruleset;

//     /* try {
//       if (!kIsWeb) {
//         var outputRuleset1 = await HealthTracker.results(rule);

//         outputRuleset1.forEach((key, value) {
//           outputRuleset.putIfAbsent(key.toLowerCase(), () => value);
//         });
//       } else {
//         // setState(() {
//         //   isEnable = false;
//         //   _inProgress = true;
//         // });
//         var jsonData = json.encode(ruleset);
//         var jsonVal = await callApi(
//             context, () => DoctorRulesetApi().apiDoctorRuleset(jsonData));

//         var output =
//             RulesetOutputModel.listFromJson(json.decode(jsonVal)).toList();

//         await output.forEach((element) {
//           if (element != null &&
//               element.value != null &&
//               element.value != 'null') {
//             outputRuleset.putIfAbsent(
//                 element.name.toLowerCase(), () => element.value);
//           }
//         });
//       }
//     } catch (e) {
//       print('ruleset...........' + e.toString());
//     }
// */
//     if (outputRuleset != null) {
//       projectMorbidityOutputEvaluation.project_morbidity_evaluation_guid =
//           _projectMorbidityEvaluation.project_morbidity_evaluation_guid;
//       projectMorbidityOutputEvaluation.start_date =
//           _projectMorbidityEvaluation.project_morbidity_evaluation_start_date;
//       projectMorbidityOutputEvaluation.end_date =
//           _projectMorbidityEvaluation.project_morbidity_evaluation_end_date;
//       projectMorbidityOutputEvaluation.user_id =
//           _projectMorbidityEvaluation.project_morbidity_evaluation_user_id;
//       projectMorbidityOutputEvaluation.project_id =
//           _projectMorbidityEvaluation.project_id;
//       projectMorbidityOutputEvaluation.created_by =
//           _projectMorbidityEvaluation.project_morbidity_evaluation_created_by;
//       projectMorbidityOutputEvaluation.created_on =
//           _projectMorbidityEvaluation.project_morbidity_evaluation_created_on;
//       projectMorbidityOutputEvaluation.patient_id =
//           _projectMorbidityEvaluation.patient_id;
//       projectMorbidityOutputEvaluation
//               .project_morbidity_output_evaluation_date =
//           _projectMorbidityEvaluation.project_morbidity_evaluation_date;
//       projectMorbidityOutputEvaluation
//           .project_morbidity_output_evaluation_guid = Uuid().v1();
//       projectMorbidityOutputEvaluation.project_morbidity_output_id =
//           project_morbidity_output_id;
//       projectMorbidityOutputEvaluation.project_morbidity_output_evaluation_id =
//           0;
//       projectMorbidityOutputEvaluation.project_visit_role_id =
//           project_visit_role_idVal;

//       rulesetVar.forEach((key, value) {
//         var aa = rulesetVar[key.toLowerCase()];
//         var aa1 = outputRuleset[key.toLowerCase()];
//         var _projectMorbidityOutputEvaluationDetail =
//             ProjectMorbidityOutputEvaluationDetail();
//         _projectMorbidityOutputEvaluationDetail
//                 .project_morbidity_output_question_id =
//             rulesetVar[key.toLowerCase()];
//         _projectMorbidityOutputEvaluationDetail
//             .project_morbidity_output_evaluation_detail_guid = Uuid().v1();
//         _projectMorbidityOutputEvaluationDetail
//                 .project_morbidity_output_evaluation_guid =
//             projectMorbidityOutputEvaluation
//                 .project_morbidity_output_evaluation_guid;
//         _projectMorbidityOutputEvaluationDetail.created_by =
//             _projectMorbidityEvaluation.project_morbidity_evaluation_created_by;
//         _projectMorbidityOutputEvaluationDetail.created_on =
//             _projectMorbidityEvaluation.project_morbidity_evaluation_created_on;
//         if (outputRuleset.containsKey(key.toLowerCase())) {
//           _projectMorbidityOutputEvaluationDetail
//                   .project_morbidity_output_queston_value =
//               outputRuleset[key.toLowerCase()].toString();
//         }

//         if (rulesetVartl.containsKey(_projectMorbidityOutputEvaluationDetail
//             .project_morbidity_output_question_id)) {
//           _projectMorbidityOutputEvaluationDetail
//                   .project_morbidity_output_queston_value_tl =
//               outputRuleset[rulesetVartl[_projectMorbidityOutputEvaluationDetail
//                       .project_morbidity_output_question_id]
//                   .toLowerCase()];
//         }
//         //_projectMorbidityOutputEvaluationDetail.project_morbidity_output_queston_value=outputRuleset[key].toString();
//         _projectMorbidityOutputEvaluationDetail.project_morbidity_output_id =
//             project_morbidity_output_id;

//         _projectMorbidityOutputEvaluationDetailList
//             .add(_projectMorbidityOutputEvaluationDetail);
//       });
//     }

//     if (!kIsWeb &&
//         (role.toLowerCase() != 'physiotherapist' &&
//             role.toLowerCase() != 'surgeon')) {
//       // setState(() {
//       //   _inProgress = true;
//       // });

//       await _dataProvider
//           .insertMwProjectMorbidityEvaluation(_projectMorbidityEvaluation);
//       await _dataProvider.insertMwProjectMorbidityEvaluationDetail(
//           _projectMorbidityEvaluationDetail);
//       if (!await Validate.internet()) {
//         await DataProvider()
//             .updatePatientEnrollmentRom(_projectMorbidityEvaluation.patient_id);
//       }

//       /*  if (projectMorbidityOutputEvaluation.project_morbidity_evaluation_guid !=
//               null &&
//           projectMorbidityOutputEvaluation
//               .project_morbidity_evaluation_guid.isNotEmpty) {
//         await _dataProvider.insertprojectMorbidityOutputEvaluation(
//             projectMorbidityOutputEvaluation);
//         await _dataProvider.insertMwProjectMorbidityOutputEvaluationDetail(
//             _projectMorbidityOutputEvaluationDetailList,
//             projectMorbidityOutputEvaluation.project_morbidity_evaluation_guid);
//       }
//       */
//     }

//     if (kIsWeb ||
//         await Validate.internet() &&
//             (role.toLowerCase() != 'physiotherapist' &&
//                 role.toLowerCase() != 'surgeon')) {
//       try {
//         await DataUpload.screeningUpload(context, _projectMorbidityEvaluation,
//             _projectMorbidityEvaluationDetail, null, null);

//         if (kIsWeb) {}
//       } catch (e) {
//         print(e);
//       }
//     }

//     await _navigate(allLabel);

//     print(_projectMorbidityEvaluationDetail);
//   }

  // bool getRulesetData() {
  //   ruleset = ruleset..removeWhere((key, value) => isNotNull(value) == false);

  //   print(ruleset);
  //   var jsonData = json.encode(ruleset);
  //   return true;
  // }

  Future<void> _navigate(allLabel) async {
    setState(() {
      _isLoading = false;
    });
    if (widget.isOneKneeMeasured) {
      await romAnotherPositionDialog();
    } else {
      await anotherKneeDialog();
    }
  }

  Future<void> anotherKneeDialog() async {
    await customDialog(
      context,
      title: LabelText.saveSuccessfully,
      content: LabelText.romAnotherKneeQuestion,
      actions: <Widget>[
        Row(
          children: [
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                // Navigator.pop(context, ModalRoute.withName(Routes.patientScreeningOverview));
                var nextKnee = 1;
                if (widget.initialKnee == 1) {
                  nextKnee = 2;
                } else if (widget.initialKnee == 2) {
                  nextKnee = 1;
                }
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => RomAngleCalculator(
                          page: widget.pageNum,
                          initalKnee: nextKnee,
                          isOneKneeMeasured: true,
                        ),
                    settings: RouteSettings(name: Routes.customROMcalculator)));
              },
              child: Center(
                child: Text(
                  LabelText.dialogYes,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await romAnotherPositionDialog();
              },
              child: Center(
                child: Text(
                  LabelText.dialogNo,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> romAnotherPositionDialog() async {
    await customDialog(context,
        isbarrierDismissible: false,
        title: LabelText.rangeOfMotion,
        content: LabelText.romAnotherPosition,
        actions: [
          ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                Navigator.pop(context);
                // await Navigator.pushReplacementNamed(
                //   context,
                //   Routes.rangeOfMotionSelectionScreen,
                // );

                await Navigator.pushReplacement(
                  context,
                  await Routes().getPageRoute(
                    routeName: Routes.rangeOfMotionSelectionScreen,
                  ),
                );
              },
              child: Text(
                LabelText.dialogYes,
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
          ElevatedButton(
              onPressed: () async {
                // await Navigator.pushNamedAndRemoveUntil(
                //     context, Routes.fieldWorkerDestinations, (route) => false);
                await Navigator.pushAndRemoveUntil(
                    context,
                    await Routes().getPageRoute(
                      routeName: Routes.fieldWorkerDestinations,
                    ),
                    (route) => false);
              },
              child: Text(
                LabelText.dialogNo,
                style: TextStyle(
                  color: Colors.white,
                ),
              ))
        ]);
  }
}
