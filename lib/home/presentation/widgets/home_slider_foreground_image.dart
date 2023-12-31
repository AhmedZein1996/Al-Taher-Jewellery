import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/shared/widgets/cached_network_image.dart';

class HomeSliderForegroundImage extends StatelessWidget {
  final String imgUrl;

  const HomeSliderForegroundImage({
    super.key,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          20.0,
        ),
      ),
      child: CachedNetworkImageWidget(
        imgUrl: imgUrl,
        onErrorWidget: kNetworkImageOnErrorWidget,
      ),
    );
  }
}
