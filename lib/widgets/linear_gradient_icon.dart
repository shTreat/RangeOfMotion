import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LinearGradientIcon extends StatelessWidget {
  const LinearGradientIcon({
    Key? key,
    this.linearGradientColor,
    this.size = 46,
    this.icon = 'assets/message.png',
    this.isNetworkImage = false,
  }) : super(key: key);
  final List<Color>? linearGradientColor;
  final double size;
  final String icon;
  final bool isNetworkImage;
  bool validateURL(String value) {
    final uri = Uri.tryParse(value.toString());
    if (!uri!.hasAbsolutePath) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: size,
              child: isNetworkImage
                  ? validateURL(icon)
                      ? CachedNetworkImage(
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                            child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                    value: progress.progress,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiary)),
                          ),
                          imageUrl: icon.toString().replaceAll(r'\', r'/'),
                          errorWidget: (context, error, stackTrace) =>
                              Image.asset(
                            'assets/exercise.png',
                          ),
                        )
                      : Image.asset(
                          'assets/exercise.png',
                          fit: BoxFit.fill,
                        )
                  // Image.network(
                  //     icon.toString().replaceAll(r'\', r'/'),
                  //     loadingBuilder: (context, child, loadingProgress) {
                  //       if (loadingProgress == null) {
                  //         return child;
                  //       }
                  //       return Center(
                  //         child: CircularProgressIndicator(
                  //           value: loadingProgress.expectedTotalBytes != null
                  //               ? loadingProgress.cumulativeBytesLoaded /
                  //                   loadingProgress.expectedTotalBytes
                  //               : null,
                  //         ),
                  //       );
                  //     },
                  //     errorBuilder: (context, error, stackTrace) => Image.asset(
                  //       'assets/exercise.png',
                  //     ),
                  //   )
                  : Image.asset(
                      icon.isEmpty ? 'assets/message_icon.png' : icon,
                      fit: BoxFit.fill,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
