import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:range_of_motion/widgets/custom_screen_size.dart';

import '../../constants/constants.dart';
import 'linear_gradient_icon.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key,
      this.title,
      this.trailingText = '',
      this.leadingIcon = '',
      this.isSelected = false,
      this.isNetworkImage = false,
      this.hasTrailIcon = true,
      this.trailIcon = '',
      this.trailWidget,
      @required this.onPress,
      this.linearGradientIconColor = const [
        Color(0xFFAD74FF),
        Color(0xFF791BFF),
      ]})
      : super(key: key);

  final List<Color> linearGradientIconColor;
  final String? title;
  final String trailingText;
  final String leadingIcon;
  final bool isSelected;
  final VoidCallback? onPress;
  final bool isNetworkImage;
  final bool hasTrailIcon;
  final String trailIcon;
  final Widget? trailWidget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: CustomScreenSize(width: MediaQuery.of(context).size.width)
                  .getDynamicScreenPaddingWidth() +
              5),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.032),
                    offset: Offset(5, 3),
                    spreadRadius: 3,
                    blurRadius: 10.0)
              ],
              borderRadius: BorderRadius.circular(7.63),
              color: Colors.white,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(7.63),
              color: Colors.white,
              child: InkWell(
                borderRadius: BorderRadius.circular(7.63),
                onTap: onPress,
                splashFactory: InkSplash.splashFactory,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: isSelected
                                  ? Color(0xFFBFBFBF)
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(7.63),
                        ),
                        tileColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: hasTrailIcon ? 10 : 0, horizontal: 20),
                        minLeadingWidth: hasTrailIcon ? 45 : 0,
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (hasTrailIcon)
                              Flexible(
                                child: LinearGradientIcon(
                                  size: 43,
                                  isNetworkImage: isNetworkImage,
                                  icon: leadingIcon,
                                  linearGradientColor:
                                      linearGradientIconColor.isEmpty
                                          ? const [
                                              Color(0xFFAD74FF),
                                              Color(0xFF791BFF),
                                            ]
                                          : linearGradientIconColor,
                                ),
                              ),
                          ],
                        ),
                        title: Text(
                          title ?? '',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              wordSpacing: 4,
                              // letterSpacing: 0.288,
                              color:Color(0xFF333333)),
                              // color: HexColor('#333333')),
                        ),
                        // ignore: prefer_if_null_operators
                        trailing: trailWidget != null
                            ? trailWidget
                            : trailIcon.isNotEmpty
                                ? Image.asset(
                                    trailIcon,
                                    scale: 3,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : Text(
                                    trailingText,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: linearGradientIconColor.isEmpty
                                            ? const [
                                                Color(0xFFAD74FF),
                                                Color(0xFF791BFF),
                                              ].last
                                            : linearGradientIconColor.last),
                                  ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Center(
          child: InkWell(
            borderRadius: BorderRadius.circular(7.63),
            onTap: onPress,
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: isSelected ? Color(0xFFBFBFBF) : Colors.transparent),
                borderRadius: BorderRadius.circular(7.63),
              ),
              tileColor: Colors.white,
              contentPadding: EdgeInsets.all(10),
              leading: LinearGradientIcon(
                size: 60,
                isNetworkImage: isNetworkImage,
                icon: leadingIcon,
                linearGradientColor: linearGradientIconColor.isEmpty
                    ? const [
                        Color(0xFFAD74FF),
                        Color(0xFF791BFF),
                      ]
                    : linearGradientIconColor,
              ),
              title: Text(
                title ?? '',
              ),
              trailing: Text(
                trailingText,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: linearGradientIconColor.isEmpty
                        ? const [
                            Color(0xFFAD74FF),
                            Color(0xFF791BFF),
                          ].last
                        : linearGradientIconColor.last),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
