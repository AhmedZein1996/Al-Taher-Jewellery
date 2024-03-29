import 'dart:developer';

import 'package:altaher_jewellery/core/managers/size_manager.dart';
import 'package:altaher_jewellery/home/presentation/widgets/home_slider_gold_price_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_slider_background.dart';
import 'home_slider_foreground_image.dart';
import 'home_slider_indicator.dart';

class HomeSlider extends StatefulWidget {
  final List<String> slideImages;
  final bool isLoading;

  const HomeSlider({
    super.key,
    required this.slideImages,
    required this.isLoading,
  });

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    log('is loading : ${widget.isLoading}');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.screenBodyPadding,
          ),
          child: CarouselSlider.builder(
            itemCount: widget.isLoading ? 3 : widget.slideImages.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return SizedBox(
                height: 202.h,
                width: .9.sw,
                child: Stack(
                  children: [
                    const HomeSliderBackground(),
                    HomeSliderForegroundImage(
                      isLoading: widget.isLoading,
                      imgUrl:
                          widget.isLoading ? '' : widget.slideImages[itemIndex],
                    ),
                    if (!widget.isLoading) const HomeSliderGoldPriceWidget()
                  ],
                ),
              );
            },
            options: CarouselOptions(
              height: 215.h,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(
                  () {
                    currentIndex = index;
                  },
                );
                // context.read<HomeCubit>().changeBanner(index);
              },
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        HomeSliderIndicator(
          currentIndex: currentIndex,
        ),
      ],
    );
  }
}
