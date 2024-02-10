import 'package:altaher_jewellery/core/constants/constants.dart';
import 'package:altaher_jewellery/core/enums/enums.dart';
import 'package:altaher_jewellery/core/utils/extensions.dart';
import 'package:altaher_jewellery/home/domain/entities/home_entity.dart';
import 'package:altaher_jewellery/home/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums/filter_enum.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final TextEditingController searchController = TextEditingController();

  List<ProductEntity> _searchedProducts = [];

  List<ProductEntity> get searchedProducts => _searchedProducts;

  List<ProductEntity> _filteredProducts = [];

  List<ProductEntity> get filteredProducts => _filteredProducts;

  FilterEnum? _filter;

  FilterEnum? get filter => _filter;

  SearchCubit() : super(SearchInitial());

  search(HomeEntity homeEntity) {
    Categories targetedCategory = getTargetedCategory();
    getProductsByCategory(targetedCategory, homeEntity);
  }

  Categories getTargetedCategory() {
    return Categories.values.firstWhere(
      (category) => category.title.startsWith(
        searchController.text.length == 1
            ? searchController.text
            : searchController.text.substring(0, 2),
      ),
      orElse: () => Categories.notFound,
    );
  }

  getProductsByCategory(Categories category, HomeEntity homeEntity) {
    clearFilter();
    switch (category.getTitle()) {
      case AppConstants.bars:
        _searchedProducts = homeEntity.bars;
        _filteredProducts = homeEntity.bars;
        emit(
          SearchSuccessState(
            products: homeEntity.bars,
          ),
        );
        break;
      case AppConstants.necklaces:
        _searchedProducts = homeEntity.necklaces;
        _filteredProducts = homeEntity.necklaces;
        emit(
          SearchSuccessState(
            products: homeEntity.necklaces,
          ),
        );
        break;
      case AppConstants.earrings:
        _searchedProducts = homeEntity.earrings;
        _filteredProducts = homeEntity.earrings;
        emit(
          SearchSuccessState(
            products: homeEntity.earrings,
          ),
        );
        break;
      case AppConstants.bracelets:
        _searchedProducts = homeEntity.bracelets;
        _filteredProducts = homeEntity.bracelets;
        emit(
          SearchSuccessState(
            products: homeEntity.bracelets,
          ),
        );
        break;
      case AppConstants.rings:
        _searchedProducts = homeEntity.rings;
        _filteredProducts = homeEntity.rings;
        emit(
          SearchSuccessState(
            products: homeEntity.rings,
          ),
        );
      case AppConstants.twins:
      case AppConstants.debla:
        _searchedProducts = homeEntity.twins;
        _filteredProducts = homeEntity.twins;
        emit(
          SearchSuccessState(
            products: homeEntity.twins,
          ),
        );
      case AppConstants.group:
        _searchedProducts = homeEntity.group;
        _filteredProducts = homeEntity.group;
        emit(
          SearchSuccessState(
            products: homeEntity.group,
          ),
        );
        break;
      default:
        _searchedProducts = [];
        _filteredProducts = [];
        emit(
          const SearchEmptyState(
            message: 'عفوا هذا المنتج غير موجود.',
          ),
        );
    }
  }

  // filterAllProductsByWeight(
  //   HomeEntity homeEntity,
  //   String weight,
  // ) {
  //   List<ProductEntity> products = [];
  //   products.addAll(homeEntity.rings);
  //   products.addAll(homeEntity.bracelets);
  //   products.addAll(homeEntity.bars);
  //   products.addAll(homeEntity.necklaces);
  //   products.addAll(homeEntity.earrings);
  //   List<ProductEntity> filteredProducts = products.where((product) {
  //     return product.weight.contains(weight);
  //   }).toList();
  //   if (filteredProducts.isEmpty) {
  //     emit(
  //       const FilterEmptyState(
  //         message: 'عفوا هذا المنتج غير موجود.',
  //       ),
  //     );
  //   } else {
  //     emit(
  //       SearchedFilterApplied(
  //         products: filteredProducts,
  //       ),
  //     );
  //   }
  // }
  //
  // filterCategoryProductsByWeight(
  //   List<ProductEntity> products,
  //   String weight,
  // ) {
  //   List<ProductEntity> filteredProducts = [];
  //   filteredProducts = products.where((product) {
  //     return product.weight.contains(weight);
  //   }).toList();
  //   if (filteredProducts.isEmpty) {
  //     emit(
  //       const FilterEmptyState(
  //         message: 'عفوا هذا المنتج غير موجود.',
  //       ),
  //     );
  //   } else {
  //     emit(
  //       SearchedFilterApplied(
  //         products: filteredProducts,
  //       ),
  //     );
  //   }
  // }
  void initFilteredProducts(HomeEntity homeEntity) {
    List<ProductEntity> products = [];
    products.addAll(homeEntity.rings);
    products.addAll(homeEntity.twins);
    products.addAll(homeEntity.bracelets);
    products.addAll(homeEntity.necklaces);
    products.addAll(homeEntity.earrings);
    products.addAll(homeEntity.group);
    products.addAll(homeEntity.bars);
    _searchedProducts = products;
    _filteredProducts = products;
  }

  void applyFilter(FilterEnum filter) {
    List<ProductEntity> newProducts;

    switch (filter) {
      case FilterEnum.weightLowToHigh:
        newProducts = List<ProductEntity>.from(_filteredProducts);
        newProducts.sort(
          (a, b) {
            return a.weight.parseToInt().compareTo(b.weight.parseToInt());
          },
        );
        break;
      case FilterEnum.weightHighToLow:
        newProducts = List<ProductEntity>.from(_filteredProducts);
        newProducts.sort(
          (a, b) {
            return b.weight.parseToInt().compareTo(a.weight.parseToInt());
          },
        );
        break;
    }
    _filter = filter;
    _filteredProducts = newProducts;
    emit(
      SearchedFilterApplied(filter),
    );
  }

  void clearFilter() {
    _filter = null;
    _filteredProducts = _searchedProducts;
    emit(
      SearchedFilterCleared(),
    );
  }

  void clearSearch() {
    _filteredProducts = _searchedProducts;
    emit(FavoritesSearchCleared());
    if (_filter != null) {
      applyFilter(_filter!);
    }
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
