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
  
  var project_morbidity_output_id;
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
    
    Object? data = ModalRoute.of(context)?.settings.arguments;

    if (data != null) {
      
    } else {
      page = widget.page!;
      romL = getCorrectedValue(widget.flexLeft ?? 0, widget.extLeft ?? 0);
      romR = getCorrectedValue(widget.flexRight ?? 0, widget.extRight ?? 0);
    }
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
                                onPressed: () async {
                                  await Navigator.pushReplacement(
                                      context,
                                      await Routes().getPageRoute(
                                        routeName:
                                            Routes.fieldWorkerDestinations,
                                      ));
                                  
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
