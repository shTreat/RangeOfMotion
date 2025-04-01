import 'package:flutter/material.dart';
import 'package:range_of_motion/rom_angle_calculator.dart';
import 'package:range_of_motion/utils/label_text.dart';
import 'package:range_of_motion/widgets/button_single.dart';
import 'package:range_of_motion/widgets/custom_screen_size.dart';

import 'constants/constants.dart';
import 'constants/routes.dart';
import 'widgets/custom_list_tile.dart';

class RangeOfMotionSelectionScreen extends StatefulWidget {
  RangeOfMotionSelectionScreen({Key? key}) : super(key: key);

  @override
  State<RangeOfMotionSelectionScreen> createState() =>
      _RangeOfMotionSelectionScreenState();
}

class _RangeOfMotionSelectionScreenState
    extends State<RangeOfMotionSelectionScreen> {
  var allLabel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          await Navigator.pushReplacement(
              context,
              await Routes().getPageRoute(
                routeName: Routes.fieldWorkerDestinations,
              ));
 
          return false;
        },
              child: Scaffold(
          body: Column(
            children: [
              Constants.mediumSpacer,
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        // visualDensity: VisualDensity.minimumDensity,
                        padding: EdgeInsets.only(left: 10, right: 20),
                        constraints: BoxConstraints(),

                        onPressed: () async {
                          // await Navigator.pushNamedAndRemoveUntil(context,
                          //     Routes.fieldWorkerDestinations, (route) => false);

                          await Navigator.pushAndRemoveUntil(
                              context,
                              await Routes().getPageRoute(
                                routeName: Routes.fieldWorkerDestinations,
                              ),
                              (route) => false);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          // size: 25,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        LabelText.selectRangeOfMotion,
                        style:
                            TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      CustomScreenSize(width: MediaQuery.of(context).size.width)
                              .getDynamicScreenPaddingWidth() +
                          5,
                ),
                child: Column(
                  children: [
                    Constants.mediumSpacer,
                    CustomListTile(
                        title: LabelText.romPosition3,
                        leadingIcon: 'assets/rom_on_chair.png',
                        onPress: () async {
                          var kneeSelectorId = (await kneeSelector(context));
                          switch (kneeSelectorId) {
                            case 1:
                              print('Right knee selected');
                              await Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => RomAngleCalculator(
                                        page: PageNum.third,
                                        initalKnee: kneeSelectorId!,
                                      ),
                                  settings: RouteSettings(
                                      name: 'ROM: ' +
                                          LabelText.romPosition3 +
                                          ' ' +
                                          LabelText.rightLeg)));
                              break;
                            case 2:
                              print('Right knee selected');
                              await Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => RomAngleCalculator(
                                        page: PageNum.third,
                                        initalKnee: kneeSelectorId!,
                                      ),
                                  settings: RouteSettings(
                                      name: 'ROM: ' +
                                          LabelText.romPosition3 +
                                          ' ' +
                                          LabelText.leftLeg)));
                              break;
                            default:
                              print('Nothing is selected');
                              break;
                          }
                        }),
                    CustomListTile(
                      title: LabelText.romPosition1,
                      leadingIcon: 'assets/rom_on_back.png',
                      onPress: () async {
                        var kneeSelectorId = (await kneeSelector(context));
                        switch (kneeSelectorId) {
                          case 1:
                            print('Right knee selected');
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => RomAngleCalculator(
                                      page: PageNum.first,
                                      initalKnee: kneeSelectorId!,
                                    ),
                                settings: RouteSettings(
                                    name: 'ROM: ' +
                                        LabelText.romPosition1 +
                                        ' ' +
                                        LabelText.rightLeg)));
                            break;
                          case 2:
                            print('Right knee selected');
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => RomAngleCalculator(
                                      page: PageNum.first,
                                      initalKnee: kneeSelectorId!,
                                    ),
                                settings: RouteSettings(
                                    name: 'ROM: ' +
                                        LabelText.romPosition1 +
                                        ' ' +
                                        LabelText.leftLeg)));
                            break;
                          default:
                            print('Nothing is selected');
                            break;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int?> kneeSelector(BuildContext context) async {
    return (await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(actions: [
        ElevatedButton(
          //backgroundColor:ProjectThemeValue.getTheme('Themebutton_color', ProjectThemeValue.Themebutton_color, allTheme),
          child: Text(LabelText.rightLeg),
          onPressed: () {
            return Navigator.pop(context, 1);
          },
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        ElevatedButton(
          //backgroundColor:ProjectThemeValue.getTheme('Themebutton_color', ProjectThemeValue.Themebutton_color, allTheme),
          child: Text(LabelText.leftLeg),
          onPressed: () {
            return Navigator.pop(context, 2);
          },
        ),
      ]),
    ).then((source) async {
      if (source != null) {
        return source;
      }
      return null;
    }));
  }
}
