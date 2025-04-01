import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:range_of_motion/utils/label_text.dart';
import 'package:vibration/vibration.dart';

import 'constants/constants.dart';
import 'constants/routes.dart';
import 'gyro_results.dart';
import 'widgets/blinking_widget.dart';
import 'widgets/custom_dialog.dart';
import 'widgets/custom_screen_size.dart';

typedef IntCallback = void Function(int val);

class AngleCalculatorWidget extends StatefulWidget {
  const AngleCalculatorWidget({
    Key? key,
    this.xValue,
    this.yValue,
    required this.callback,
  }) : super(key: key);

  final double? xValue;
  final IntCallback callback;
  final double? yValue;
  @override
  State<AngleCalculatorWidget> createState() => _AngleCalculatorWidgetState();
}

class _AngleCalculatorWidgetState extends State<AngleCalculatorWidget> {
  int? angle;
  @override
  Widget build(BuildContext context) {
    setState(() {
      angle =
          ((atan2((widget.xValue!), (widget.yValue!)) * (180 / pi))).round();
      widget.callback(-angle!);
    });
    return SizedBox.shrink();
  }
}

int angleCalculator({double? firstPoint, double? secondPoint}) {
  var angle = ((atan2((firstPoint!), (secondPoint!)) * (180 / pi))).round();

  return -angle;
}

enum PageNum {
  first,
  second,
  third,
}

enum CustomTexts {
  title,
  body,
  imagePath,
  blinkingText,
  position,
  angleType,
  positionText,
}

class RomAngleCalculator extends StatefulWidget {
  final PageNum? page;
  final int? initalKnee;
  final bool? isOneKneeMeasured;
  RomAngleCalculator(
      {Key? key, this.page, this.initalKnee, this.isOneKneeMeasured = false})
      : super(key: key);

  @override
  State<RomAngleCalculator> createState() => _RomAngleCalculatorState();
}

class _RomAngleCalculatorState extends State<RomAngleCalculator> {
  bool isAngleRecorded = false;
  bool isFlexionAngleRecorded = false;
  bool isExtensionAngleRecorded = false;
  bool _accelAvailable = false;
  PageNum? pageNum;
  bool left = true;
  bool right = false;
  bool firstPos = true;
  bool secondPos = false;

  bool firstPage = true;
  bool secondPage = false;
  bool upside = false;
  bool onePage = true;
  bool visibility = true;
  List<double> _accelData = List.filled(3, 0.0);
  List<double> angles = [];
  StreamSubscription? _accelSubscription;
  StreamSubscription? _accelSubscriptionOffset;
  double? x;
  double? y;
  double? z;
  double firstx = 0.0;
  double firsty = 0.0;
  double firstz = 0.0;
  List firstxPoints = [];
  List firstyPoints = [];
  List firstzPoints = [];
  int firstAngle = 0;
  // int secondAngle = 0;
  int currentAngle = 0;
  int offsetAngle = 0;

  // int extentLeft = 0;
  // int extentRight = 0;
  // int flexionLeft = 0;
  // int flexionRight = 0;
  dynamic allLabel;

  int? flexionAngle;
  int? extensionAngle;
  bool isFlexion = true;
  int? flexion1, flexion2, extension1, extension2;
  List<List> measuredAngled = [[]];
  // final ActivityLogs _activityLogs = ActivityLogs();
  // var logger = Logger();
  var screentittle;

  // void insertLogData(ActivityLogs activityLogs) {
  //   _activityLogs.screen_end = DateTime.now().toString();

  //   logger.log(_activityLogs, context);
  // }

  @override
  void initState() {
    pageNum = widget.page;
    _checkAccelerometerStatus();
    if (widget.initalKnee == 1) {
      right = true;
      left = false;
    } else {
      left = true;
      right = false;
    }
    if (widget.page == PageNum.first) {
      firstPos = true;
    } else if (widget.page == PageNum.third) {
      firstPos = false;
    } else {
      firstPos = false;
    }
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ]);
      await customDialogBox();
    });

    // _activityLogs.screen_start = DateTime.now().toString();
  }

  var allLoad = false;
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!allLoad) {
      try {
        // allLabel = await DataProvider().updateLabel();
        // await FirebaseAnalytics.instance
        //     .setCurrentScreen(screenName: '${Routes.customROMcalculator}');
      } catch (e) {
      } finally {
        allLoad = true;
      }
    }
  }

  @override
  void dispose() async {
    super.dispose();
    try {
      await _stopAccelerometer();
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ]);
      await _accelSubscriptionOffset?.cancel();
      await _accelSubscription?.cancel();
      // _activityLogs.screen_name = screentittle.toString();
      // insertLogData(_activityLogs);
    } catch (e) {}

    // super.dispose();
  }

  String generateCustomText({
    CustomTexts title = CustomTexts.title,
  }) {
    var kneeposition = widget.initalKnee;
    var isPosition1 = widget.page == PageNum.first;
    var isRight = kneeposition == 1 ? true : false;
    var bodyText = '';
    if (title == CustomTexts.title) {
      if (isPosition1) {
        if (isRight) {
          bodyText = '${LabelText.romPosition1}: ${LabelText.rightLeg}';
        } else {
          bodyText = '${LabelText.romPosition1}: ${LabelText.leftLeg}';
        }
      } else {
        if (isRight) {
          bodyText = '${LabelText.romPosition3}: ${LabelText.rightLeg}';
        } else {
          bodyText = '${LabelText.romPosition3}: ${LabelText.leftLeg}';
        }
      }
    } else if (title == CustomTexts.body) {
      if (isPosition1 && isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.romChairFlexision1Text;
          } else {
            bodyText = LabelText.romChairFlexision2Text;
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.romChairExtension1Text;
          } else {
            bodyText = LabelText.romChairExtension2Text;
          }
        }
      } else if (isPosition1 && !isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.romChairFlexision1Text;
          } else {
            bodyText = LabelText.romChairFlexision2Text;
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.romChairExtension1Text;
          } else {
            bodyText = LabelText.romChairExtension2Text;
          }
        }
      } else if (!isPosition1 && isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.romLayingOnBackFlexion1Text;
          } else {
            bodyText = LabelText.romLayingOnBackFlexion2Text;
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.romLayingOnBackExtension1Text;
          } else {
            bodyText = LabelText.romLayingOnBackExtension2Text;
          }
        }
      } else if (!isPosition1 && !isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.romLayingOnBackFlexion1Text;
          } else {
            bodyText = LabelText.romLayingOnBackFlexion2Text;
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.romLayingOnBackExtension1Text;
          } else {
            bodyText = LabelText.romLayingOnBackExtension2Text;
          }
        }
      }
    } else if (title == CustomTexts.imagePath) {
      if (isPosition1 && isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = 'assets/position1 first.png';
          } else {
            bodyText = 'assets/position1 second.png';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = 'assets/position1 third.png';
          } else {
            bodyText = 'assets/position1 fourth.png';
          }
        }
      } else if (isPosition1 && !isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = 'assets/position1 first.png';
          } else {
            bodyText = 'assets/position1 second.png';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = 'assets/position1 third.png';
          } else {
            bodyText = 'assets/position1 fourth.png';
          }
        }
      } else if (!isPosition1 && isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = 'assets/position2 first.png';
          } else {
            bodyText = 'assets/position2 second.png';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = 'assets/position2 third.png';
          } else {
            bodyText = 'assets/position2 fourth.png';
          }
        }
      } else if (!isPosition1 && !isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = 'assets/position2 first.png';
          } else {
            bodyText = 'assets/position2 second.png';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = 'assets/position2 third.png';
          } else {
            bodyText = 'assets/position2 fourth.png';
          }
        }
      }
    } else if (title == CustomTexts.blinkingText) {
      if (isPosition1 && isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.romPositionPosition1first;
          } else {
            bodyText = LabelText.romPositionPosition1second;
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.romPositionPosition1third;
          } else {
            bodyText = LabelText.romPositionPosition1fourth;
          }
        }
      } else if (isPosition1 && !isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.romPositionPosition1first;
          } else {
            bodyText = LabelText.romPositionPosition1second;
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.romPositionPosition1third;
          } else {
            bodyText = LabelText.romPositionPosition1fourth;
          }
        }
      } else if (!isPosition1 && isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.romPositionPosition2first;
          } else {
            bodyText = LabelText.romPositionPosition2second;
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.romPositionPosition2third;
          } else {
            bodyText = LabelText.romPositionPosition2fourth;
          }
        }
      } else if (!isPosition1 && !isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.romPositionPosition2first;
          } else {
            bodyText = LabelText.romPositionPosition2second;
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.romPositionPosition2third;
          } else {
            bodyText = LabelText.romPositionPosition2fourth;
          }
        }
      }
    } else if (title == CustomTexts.position) {
      if (isPosition1 && isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = '1';
          } else {
            bodyText = '0';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = '1';
          } else {
            bodyText = '0';
          }
        }
      } else if (isPosition1 && !isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = '1';
          } else {
            bodyText = '0';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = '1';
          } else {
            bodyText = '0';
          }
        }
      } else if (!isPosition1 && isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = '1';
          } else {
            bodyText = '0';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = '1';
          } else {
            bodyText = '0';
          }
        }
      } else if (!isPosition1 && !isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = '1';
          } else {
            bodyText = '0';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = '1';
          } else {
            bodyText = '0';
          }
        }
      }
    } else if (title == CustomTexts.angleType) {
      if (isPosition1 && isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.flexionAngle +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.flexionAngle +
                // ' 2'
                '';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.extensionAngle +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.extensionAngle +
                // ' 2'
                '';
          }
        }
      } else if (isPosition1 && !isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.flexionAngle +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.flexionAngle +
                // ' 2'
                '';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.extensionAngle +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.extensionAngle +
                // ' 2'
                '';
          }
        }
      } else if (!isPosition1 && isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.flexionAngle +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.flexionAngle +
                // ' 2'
                '';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.extensionAngle +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.extensionAngle +
                // ' 2'
                '';
          }
        }
      } else if (!isPosition1 && !isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.flexionAngle +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.flexionAngle +
                // ' 2'
                '';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.extensionAngle +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.extensionAngle +
                // ' 2'
                '';
          }
        }
      }
    } else if (title == CustomTexts.positionText) {
      if (isPosition1 && isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.positionText1 +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.positionText2 +
                // ' 2'
                '';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.positionText1 +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.positionText2 +
                // ' 2'
                '';
          }
        }
      } else if (isPosition1 && !isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.positionText1 +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.positionText2 +
                // ' 2'
                '';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.positionText1 +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.positionText2 +
                // ' 2'
                '';
          }
        }
      } else if (!isPosition1 && isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.positionText1 +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.positionText2 +
                // ' 2'
                '';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.positionText1 +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.positionText2 +
                // ' 2'
                '';
          }
        }
      } else if (!isPosition1 && !isRight) {
        if (!isFlexionAngleRecorded) {
          if (!isAngleRecorded) {
            bodyText = LabelText.positionText1 +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.positionText2 +
                // ' 2'
                '';
          }
        } else {
          if (!isAngleRecorded) {
            bodyText = LabelText.positionText1 +
                // ' 1'
                '';
          } else {
            bodyText = LabelText.positionText2 +
                // ' 2'
                '';
          }
        }
      }
    }
    screentittle = bodyText;
    return bodyText;
  }

  Future customDialogBox() async {
    visibility = false;
    setState(() {});
    // return await showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return WillPopScope(
    //         onWillPop: () async => false,
    //         child: AlertDialog(
    //           contentPadding: EdgeInsets.symmetric(horizontal: 10),
    //           title: Container(
    //               padding: EdgeInsets.all(8),
    //               decoration: BoxDecoration(
    //                   color: Theme.of(context).colorScheme.tertiary,
    //                   borderRadius: BorderRadius.circular(6.73)),
    //               child: Text(
    //                 generateCustomText(),
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.w500,
    //                     fontSize: 22,
    //                     color: Colors.white),
    //               )),
    //           content: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               SizedBox(
    //                 height: 200,
    //                 width: 250,
    //                 child: Image.asset(
    //                     generateCustomText(title: CustomTexts.imagePath)),
    //               ),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               Text(
    //                 generateCustomText(
    //                   title: CustomTexts.body,
    //                 ),
    //                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               // Text(
    //               //   LabelText.getLabel(
    //               //       'popHint3', LabelText.popHint3, allLabel),
    //               //   style: TextStyle(
    //               //     fontSize: 25,
    //               //     fontWeight: FontWeight.bold,
    //               //     color: Colors.red,
    //               //   ),
    //               // ),
    //               // SizedBox(
    //               //   height: 10,
    //               // ),
    //               SizedBox(
    //                 width: double.infinity,
    //                 child: ElevatedButton(
    //                   // width: MediaQuery.of(context).size.width * .30,
    //                   // backgroundColor: Theme.of(context).primaryColorDark,
    //                   child: Text(
    //                     LabelText.getLabel(
    //                         'snapGyro', LabelText.snapGyro, allLabel),
    //                     style: TextStyle(color: Colors.white),
    //                   ),
    //                   onPressed: () => Navigator.pop(context),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 10,
    //               )
    //             ],
    //           ),
    //         ),
    //       );
    //     });
  }

  Future<void> _checkAccelerometerStatus() async {
    await SensorManager()
        .isSensorAvailable(Sensors.ACCELEROMETER)
        .then((result) {
      setState(() {
        _accelAvailable = result;
      });
      startAccelo();
    });
  }

  Future<void> startAccelo() async {
    await _startAccelerometerOffset();
  }

  Future<void> _startAccelerometerOffset() async {
    if (_accelSubscription != null) return;
    if (_accelAvailable) {
      final stream = await SensorManager().sensorUpdates(
        sensorId: Sensors.ACCELEROMETER,
        interval: Sensors.SENSOR_DELAY_NORMAL,
      );
      _accelSubscriptionOffset = stream.listen((sensorEvent) async {
        x = double.parse(sensorEvent.data[0].toStringAsFixed(2));
        y = double.parse(sensorEvent.data[1].toStringAsFixed(2));
        z = double.parse(sensorEvent.data[2].toStringAsFixed(2));

        // if (onePage) {
        //   if (z > 4 || z < -4) {
        //     // TODO: Disable offset by making visibility manual.
        //     // firstPage = true;
        //     // visibility = false;

        //     // secondPage = false;
        //   } else {
        //     firstPage = false;
        //     visibility = true;
        //     secondPage = true;
        //   }
        // }

        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  Future<void> _startAccelerometerCurrent() async {
    if (_accelSubscription == null) return;
    if (_accelAvailable) {
      final stream = await SensorManager().sensorUpdates(
        sensorId: Sensors.ACCELEROMETER,
        interval: Sensors.SENSOR_DELAY_NORMAL,
      );
      _accelSubscription = stream.listen((sensorEvent) {
        z = double.parse(sensorEvent.data[2].toStringAsFixed(2));
        // if (z > 4 || z < -4) {
        //   upside = false;
        //   // TODO: Disable offset by making visibility manual.
        //   // visibility = false;
        // } else {
        //   upside = true;
        //   visibility = true;
        // }
        setState(() {
          _accelData = sensorEvent.data;
        });
      });
    }
  }

  Future<List<double>> _startAccelerometerInitialAngle() async {
    if (_accelSubscription != null) return [];
    if (_accelAvailable) {
      final stream = await SensorManager().sensorUpdates(
        sensorId: Sensors.ACCELEROMETER,
        interval: Sensors.SENSOR_DELAY_NORMAL,
      );

      _accelSubscription = stream.listen((sensorEvent) async {
        var tempfirstx = sensorEvent.data[0];
        firstxPoints.add(tempfirstx);
        var tempfirsty = sensorEvent.data[1];
        firstyPoints.add(tempfirsty);
        var tempfirstz = sensorEvent.data[2];
        firstzPoints.add(tempfirstz);
        setState(() {});
        dev.log(sensorEvent.data[0].toString(), name: "first angle");
        dev.log(sensorEvent.data[1].toString(), name: "second angle");
        dev.log(sensorEvent.data[2].toString(), name: "third angle");
      });
      await Future.delayed(Duration(milliseconds: 700), (() async {
        await Vibration.vibrate();
        // await Vibrate.vibrateWithPauses([Duration(milliseconds: 300)])
        //     .whenComplete(() async {
        await _accelSubscription?.cancel();
        firstx = (firstxPoints.reduce((value, element) => value + element) /
            firstxPoints.length);
        firsty = (firstyPoints.reduce((value, element) => value + element) /
            firstyPoints.length);
        firstz = (firstzPoints.reduce((value, element) => value + element) /
            firstzPoints.length);
        // });
      }));

      await _resetAccelerometer();
      await _startAccelerometerCurrent();
    }
    return [firstx, firsty, firstz];
  }

  Future<void> _resetAccelerometer() async {
    _accelData = List.filled(3, 0.0);

    firstxPoints = [];
    firstyPoints = [];
    firstzPoints = [];
    if (_accelSubscription == null) {
      setState(() {
        firstAngle = 0;
        currentAngle = 0;
      });
    } else {
      await _accelSubscription?.cancel();
      setState(() {
        firstAngle = 0;
        currentAngle = 0;
      });
    }
  }

  Future<void> _stopAccelerometer({bool disableOffset = true}) async {
    if (_accelSubscription == null) return;
    await _accelSubscription?.cancel();
    if (disableOffset) {
      await _accelSubscriptionOffset?.cancel();
    }
    _accelSubscription = null;
  }

  int getCorrectedValue(int value1, int value2) {
    var correctedValue = value1 - value2;
    correctedValue = (correctedValue + 180) % 360 - 180;
    // if (correctedValue < 0) {
    //   correctedValue = 360 - correctedValue.abs();
    // }

    // if (correctedValue > 200) {
    //   correctedValue = correctedValue - 360;
    // }
    // if (correctedValue < 0) {
    //   correctedValue = correctedValue * -1;
    // }

    return correctedValue.abs();
  }

// niru
  int getCorrectedEXtAngleValue(int value1, int value2) {
    var correctedValue = value1 - value2;
    correctedValue = (correctedValue + 180) % 360 - 180;
    return correctedValue;
  }

  int getCorrectedExtensionValue(int value1, int value2) {
    var correctedValue = value2 - value1;
    correctedValue = (correctedValue + 180) % 360 - 180;

    return correctedValue;
  }

  //
  Future<bool> _onWillPop() async {
    return (await customDialog(
          context,
          title: LabelText.are_you_sure,
          content: LabelText.leave_page,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                LabelText.dialogNo,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await Navigator.pushReplacement(
                    context,
                    await Routes().getPageRoute(
                      routeName: Routes.rangeOfMotionSelectionScreen,
                    ));
              },
              child: Text(
                LabelText.dialogYes,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () async {
                    // await Navigator.pushNamedAndRemoveUntil(context,
                    //     Routes.fieldWorkerDestinations, (route) => false);
                    await Navigator.pushReplacement(
                        context,
                        await Routes().getPageRoute(
                          routeName: Routes.rangeOfMotionSelectionScreen,
                        ));
                  }),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                LabelText.rangeOfMotion,
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: CustomScreenSize(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width)
                          .getDynamicScreenPaddingWidth() +
                      5),
              alignment: AlignmentDirectional.topStart,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    !visibility &&
                            generateCustomText(
                                  title: CustomTexts.position,
                                ) ==
                                '1'
                        ? BlinkingWidget(
                            child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_upward_rounded,
                                size: 45,
                                color: Theme.of(context).primaryColor,
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.73),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryVariant),
                                child: Text(
                                  generateCustomText(
                                    title: CustomTexts.blinkingText,
                                  ),
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Constants.mediumSpacer,
                            ],
                          ))
                        : SizedBox.shrink(),
                    !visibility &&
                            generateCustomText(title: CustomTexts.position) ==
                                '0'
                        ? Constants.largeSpacer
                        : SizedBox.shrink(),
                    !visibility
                        ? Card(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(generateCustomText(),
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                                Constants.smallSpacer,
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6.67),
                                  child: Image.asset(
                                    generateCustomText(
                                      title: CustomTexts.imagePath,
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    // fit: BoxFit.fill,
                                  ),
                                ),
                                Constants.smallSpacer,
                                Text(
                                  generateCustomText(title: CustomTexts.body),
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),

                    !visibility &&
                            generateCustomText(
                                  title: CustomTexts.position,
                                ) ==
                                '0'
                        ? BlinkingWidget(
                            child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Constants.mediumSpacer,
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.73),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryVariant),
                                child: Text(
                                  generateCustomText(
                                    title: CustomTexts.blinkingText,
                                  ),
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_downward_rounded,
                                size: 45,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ))
                        : SizedBox.shrink(),

                    !visibility
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        visibility = true;
                                      });
                                    },
                                    child: Text(
                                      LabelText.next,
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    // !visibility ? Spacer() : SizedBox.shrink(),
                    AngleCalculatorWidget(
                      xValue: _accelData[0],
                      yValue: _accelData[1],
                      callback: (val) {
                        currentAngle = val;
                        dev.log(currentAngle.toString(), name: "current angle");
                      },
                    ),
                    // !visibility
                    //     ? Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //         children: [
                    //           Icon(
                    //             Icons.arrow_back,
                    //             size: 30,
                    //           ),
                    //           Expanded(
                    //             child: Text(
                    //                 LabelText.getLabel(
                    //                     'romHint2', LabelText.romHint2, allLabel),
                    //                 textAlign: TextAlign.center,
                    //                 softWrap: true,
                    //                 style: TextStyle(fontSize: 20)),
                    //           ),
                    //           Icon(
                    //             Icons.arrow_forward,
                    //             size: 30,
                    //           )
                    //         ],
                    //       )
                    //     : SizedBox.shrink(),
                    if (flexionAngle != null && extensionAngle != null) ...[
                      // Text("hey"),
                      // Text("FlexionAngle : ${flexionAngle}"),
                      // Text("ExtensionAngle : ${extensionAngle}"),
                      // Text(
                      //     "${LabelText.getLabel('angle', LabelText.angle, allLabel)}: ${getCorrectedValue(flexionAngle, extensionAngle)}"),
                      // MaterialButton(
                      //     child: Text("Save"),
                      //     color: isAngleRecorded
                      //         ? Theme.of(context).primaryColor
                      //         : Theme.of(context).colorScheme.tertiary,
                      //     onPressed: () async {}),
                      // MaterialButton(
                      //     child: Text("recalculate"),
                      //     color: isAngleRecorded
                      //         ? Theme.of(context).primaryColor
                      //         : Theme.of(context).colorScheme.tertiary,
                      //     onPressed: () async {}),
                    ] else ...[
                      // visibility ? Spacer() : SizedBox.shrink(),
                      // visibility
                      //     ? Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      // flexion1 != null
                      //     ? Text(LabelText.getLabel('flexionAngle',
                      //             LabelText.flexionAngle, allLabel) +
                      //         '1: $flexion1°')
                      //     : SizedBox.shrink(),
                      // flexion2 != null
                      //     ? Text(LabelText.getLabel('flexionAngle',
                      //             LabelText.flexionAngle, allLabel) +
                      //         '2: $flexion2°')
                      //     : SizedBox.shrink(),
                      // extension1 != null
                      //     ? Text(LabelText.getLabel('extensionAngle',
                      //             LabelText.extensionAngle, allLabel) +
                      //         '1: $extension1°')
                      //     : SizedBox.shrink(),
                      // extension2 != null
                      //     ? Text(LabelText.getLabel('extensionAngle',
                      //             LabelText.extensionAngle, allLabel) +
                      //         '2: $extension2°')
                      //     : SizedBox.shrink(),
                      //     ],
                      //   )
                      // : SizedBox.shrink(),
                      visibility ? Constants.mediumSpacer : SizedBox.shrink(),
                      Container(
                        // padding:
                        //     EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.73),
                          // color: Theme.of(context).colorScheme.primaryVariant,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            visibility
                                ? Text(
                                    generateCustomText(
                                      title: CustomTexts.title,
                                    ),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 24),
                                  )
                                : SizedBox.shrink(),
                            visibility ? Divider() : SizedBox.shrink(),
                            visibility
                                ? Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6.67),
                                      child: Image.asset(
                                        generateCustomText(
                                          title: CustomTexts.imagePath,
                                        ),
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        // fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                            visibility
                                ? Text(
                                    '${generateCustomText(title: CustomTexts.angleType)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22))
                                : SizedBox(),
                            visibility
                                ? Text(
                                    '${generateCustomText(title: CustomTexts.positionText)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22))
                                : SizedBox(),
                            visibility
                                ? Text(
                                    '${flexion2 != null ? 0 : getCorrectedValue(firstAngle, currentAngle)}°',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 35))
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),

                      // Text("FlexionAngle : ${flexionAngle}"),
                      // Text("ExtensionAngle : ${extensionAngle}"),
                      if (visibility) ...[
                        !isFlexionAngleRecorded
                            ? MaterialButton(
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.4,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                color: isAngleRecorded
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).colorScheme.tertiary,
                                onPressed: () async {
                                  if (!isFlexionAngleRecorded) {
                                    if (!isAngleRecorded) {
                                      angles =
                                          (await _startAccelerometerInitialAngle());
                                      if (angles.isNotEmpty) {
                                        firstAngle = (angleCalculator(
                                            firstPoint: angles[0],
                                            secondPoint: angles[1]));
                                      }
                                      flexion1 = 0;
                                      isAngleRecorded = true;
                                      await customDialogBox();
                                      setState(() {});
                                    } else {
                                      angles =
                                          (await _startAccelerometerInitialAngle());

                                      if (angles.isNotEmpty) {
                                        firstAngle = (angleCalculator(
                                            firstPoint: angles[0],
                                            secondPoint: angles[1]));
                                      } else {
                                        await Future.delayed(
                                            Duration(milliseconds: 700),
                                            (() async {
                                          await Vibration.vibrate();
                                          // await Vibrate.vibrateWithPauses(
                                          //         [Duration(milliseconds: 300)])
                                          //     .whenComplete(() async {});
                                        }));
                                      }
                                      var secondFlexionAngle =
                                          getCorrectedValue(
                                              firstAngle, currentAngle);
                                      flexionAngle = getCorrectedValue(
                                          flexionAngle ?? 0,
                                          secondFlexionAngle);
                                      isAngleRecorded = false;
                                      isFlexionAngleRecorded = true;
                                      currentAngle = 0;
                                      firstAngle = 0;
                                      flexion2 = flexionAngle;
                                      setState(() {});
                                      await _stopAccelerometer(
                                          disableOffset: false);
                                      await customDialogBox();
                                    }
                                  }
                                },
                                child: Text(isAngleRecorded
                                    ? LabelText.snapGyro
                                    : LabelText.snapGyro),
                              )
                            : MaterialButton(
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.4,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                color: isAngleRecorded
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).colorScheme.tertiary,
                                onPressed: () async {
                                  if (!isExtensionAngleRecorded) {
                                    if (!isAngleRecorded) {
                                      angles =
                                          (await _startAccelerometerInitialAngle());
                                      if (angles.isNotEmpty) {
                                        firstAngle = (angleCalculator(
                                            firstPoint: angles[0],
                                            secondPoint: angles[1]));
                                      }
                                      flexion1 = null;
                                      flexion2 = null;
                                      extension1 = 0;
                                      // extensionAngle = 0;
                                      isAngleRecorded = true;
                                      setState(() {});
                                      await customDialogBox();
                                    } else {
                                      angles =
                                          (await _startAccelerometerInitialAngle());
                                      if (angles.isNotEmpty) {
                                        firstAngle = (angleCalculator(
                                            firstPoint: angles[0],
                                            secondPoint: angles[1]));
                                      } else {
                                        await Future.delayed(
                                            Duration(milliseconds: 700),
                                            (() async {
                                          await Vibration.vibrate();
                                          // await Vibrate.vibrateWithPauses(
                                          //         [Duration(milliseconds: 300)])
                                          //     .whenComplete(() async {});
                                        }));
                                      }
                                      // var secondExtensionAngle =
                                      //     getCorrectedValue(
                                      //         firstAngle, currentAngle);
                                      var secondExtensionAngle =
                                          getCorrectedEXtAngleValue(
                                              firstAngle, currentAngle);

                                      // extensionAngle = getCorrectedValue(
                                      //     extensionAngle ?? 0,
                                      //     secondExtensionAngle);

                                      // niru
                                      extensionAngle =
                                          getCorrectedExtensionValue(
                                              extensionAngle ?? 0,
                                              secondExtensionAngle);
                                      isAngleRecorded = false;
                                      isExtensionAngleRecorded = true;
                                      extension2 = extensionAngle;
                                      await _stopAccelerometer();
                                      setState(() {});
                                      var page = 1;
                                      if (pageNum == PageNum.first) {
                                        page = 1;
                                      } else if (pageNum == PageNum.second) {
                                        page = 2;
                                      } else {
                                        page = 3;
                                      }

                                      await Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (_) => GyroResult(
                                                    isOneKneeMeasured: widget
                                                            .isOneKneeMeasured ??
                                                        false,
                                                    pageNum: widget.page,
                                                    initialKnee:
                                                        widget.initalKnee,
                                                    extLeft: left && !right
                                                        ? extensionAngle
                                                        : null,
                                                    extRight: right && !left
                                                        ? extensionAngle
                                                        : null,
                                                    flexLeft: left && !right
                                                        ? flexionAngle
                                                        : null,
                                                    flexRight: right && !left
                                                        ? flexionAngle
                                                        : null,
                                                    page: page,
                                                  ),
                                              settings: RouteSettings(
                                                  name: Routes
                                                      .customRomResults)));
                                    }
                                  }
                                },
                                child: Text(isAngleRecorded
                                    ? LabelText.snapGyro
                                    : LabelText.snapGyro)),
                        // Spacer()
                      ] else ...[
                        SizedBox.shrink()
                      ],
                      visibility ? SizedBox(height: 50) : SizedBox.shrink(),
                    ],
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
