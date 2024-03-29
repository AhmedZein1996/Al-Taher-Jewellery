import 'package:altaher_jewellery/core/enums/enums.dart';
import 'package:altaher_jewellery/core/shared/widgets/failure_widget.dart';
import 'package:altaher_jewellery/home/presentation/blocs/products/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../categories/presentation/widgets/category_list_items.dart';
import '../../../core/managers/asset_manager.dart';
import '../../../currency/presentation/blocs/get_gold_price/currency_cubit.dart';
import '../widgets/home_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProductsCubit>().getProducts();
        context.read<CurrencyCubit>().getGoldPrice();
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: SvgPicture.asset(
                ImageManager.categoriesBackgroundLines,
                fit: BoxFit.fill,
              ),
            ),
          ),
          BlocBuilder<ProductsCubit, ProductsState>(
            buildWhen: (previous, current) {
              return previous.getProductsState != current.getProductsState;
            },
            builder: (context, state) {
              if (state.getProductsState == RequestState.error) {
                return FailureWidget(
                  message: state.getProductsError ?? 'حدث خطأ ما',
                  onRetry: () {
                    context.read<ProductsCubit>().getProducts();
                  },
                );
              }
              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 90.h),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    HomeSlider(
                      isLoading: state.getProductsState == RequestState.loading,
                      slideImages: state.homeEntity.slider,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    CategoryListItems(
                      title: 'خواتم',
                      products: state.homeEntity.rings,
                      isLoading: state.getProductsState == RequestState.loading,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CategoryListItems(
                      title: 'دبل وتوينزات',
                      products: state.homeEntity.twins,
                      isLoading: state.getProductsState == RequestState.loading,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CategoryListItems(
                      title: 'حلقان',
                      products: state.homeEntity.earrings,
                      isLoading: state.getProductsState == RequestState.loading,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CategoryListItems(
                      title: 'غوايش',
                      products: state.homeEntity.bracelets,
                      isLoading: state.getProductsState == RequestState.loading,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CategoryListItems(
                      title: 'سلاسل',
                      products: state.homeEntity.necklaces,
                      isLoading: state.getProductsState == RequestState.loading,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CategoryListItems(
                      title: 'أطقم',
                      products: state.homeEntity.group,
                      isLoading: state.getProductsState == RequestState.loading,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CategoryListItems(
                      title: 'سبايك',
                      products: state.homeEntity.bars,
                      isLoading: state.getProductsState == RequestState.loading,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
