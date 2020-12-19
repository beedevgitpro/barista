import 'package:flutter/cupertino.dart';
import 'package:woocommerce/models/product_category.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';

import '../constants.dart';

class ProductsProvider with ChangeNotifier {
  final WooCommerce woocommerce = WooCommerce(
      baseUrl: kBaseUrl,
      consumerKey: kConsumerKey,
      consumerSecret: kConsumerSecret,
      apiPath: '/wp-json/wc/v3/');
  List<WooProduct> _productList = [
    // ProductProvider(
    //   description:
    //       'Banana, fruit of the genus Musa, of the family Musaceae, one of the most important fruit crops of the world.',
    //   productId: '2',
    //   categoryId: '1',
    //   discount: '10',
    //   price: 25,
    //   ratingInText: '4.0',
    //   isFavourite: false,
    //   rating: 4.0,
    //   weight: 1,
    //   productTitle: 'Thailand Special Banana',
    //   imageUrl:
    //       'https://qph.fs.quoracdn.net/main-qimg-6cc33d0feb87dddbda7b5146f41f46d5',
    // ),
    // ProductProvider(
    //     productTitle: 'Pure Thai Fish',
    //     imageUrl:
    //     'https://cdn.pixabay.com/photo/2014/11/05/15/57/salmon-518032_960_720.jpg',
    //     description:
    //     'The main flavor in this well-known dish comes from the tamarind. Make sure you have the highest quality organic tamarind paste for the best flavor!',
    //     productId: '3',
    //     ratingInText: '4.0',
    //     price: 20,
    //     rating: 4,
    //     weight: 1.5,
    //     isFavourite: true,
    //     discount: '40'),
    // ProductProvider(
    //   productTitle: 'Bluefin tuna',
    //   imageUrl:
    //       'https://i.pinimg.com/originals/ec/ea/04/ecea0421a30bda7d39ed88ffc5529a26.jpg',
    //   price: 20,
    //   description:
    //       'Bluefin tuna are endangered. Although the population of wild Pacific bluefin tuna in the US is below target levels, US-caught tuna is considered sustainable because policies are already in place to prevent overfishing.',
    //   productId: '4',
    //   categoryId: '6',
    //   discount: '10',
    //   ratingInText: '4.0',
    //   rating: 4,
    //   weight: 1.5,
    //   isFavourite: true,
    // ),
    // ProductProvider(
    //   productTitle: 'Wild Atlantic salmon',
    //   imageUrl:
    //       'https://img1.mashed.com/img/gallery/the-truth-about-farmed-salmon-vs-wild-salmon/intro-1551285210.jpg',
    //   price: 20,
    //   description:
    //       'Wild Atlantic salmon from the Gulf of Maine is endangered and has protected status. Most US Atlantic salmon is farmed.',
    //   productId: '5',
    //   categoryId: '6',
    //   discount: '10',
    //   ratingInText: '4.0',
    //   rating: 4,
    //   weight: 1.5,
    //   isFavourite: true,
    // ),
    // ProductProvider(
    //   productTitle: 'Chinook salmon',
    //   imageUrl:
    //       'https://media.foodnetwork.ca/recipetracker/dmm/C/H/Chinook_Salmon_with_Smoked_Salmon_Leek_and_Potato_Chowder_001.jpg',
    //   price: 20,
    //   description:
    //       'Chinook salmon from the Sacramento River and Upper Columbia River are endangered, while several other varieties of Chinook salmon are threatened. Chinook salmon from Alaska is considered sustainable.',
    //   productId: '6',
    //   categoryId: '6',
    //   discount: '10',
    //   ratingInText: '4.0',
    //   rating: 4,
    //   weight: 1.5,
    //   isFavourite: true,
    // ),
    // ProductProvider(
    //   productTitle: 'Coho salmon',
    //   imageUrl:
    //       'https://mdyo8n9ckd3g81vs1qipy6bt-wpengine.netdna-ssl.com/wp-content/uploads/2019/01/Coho-Salmon-fillets.jpg',
    //   price: 20,
    //   description:
    //       'Coho salmon from the Central California coast are endangered, while Coho salmon from the lower Columbia River, Oregon coast, southern Oregon, and Northern California coasts are threatened.',
    //   productId: '7',
    //   categoryId: '6',
    //   discount: '10',
    //   ratingInText: '4.0',
    //   rating: 4,
    //   weight: 1.5,
    //   isFavourite: true,
    // ),
    // ProductProvider(
    //   productTitle: 'Sockeye salmon',
    //   imageUrl:
    //       'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2013/4/29/1/RX-ALASKASEAFOODGRILLINGRSI_Sockeye-Salmon-Herb-Garlic_s4x3.jpg.rend.hgtvcom.826.620.suffix/1371616640903.jpeg',
    //   price: 20,
    //   description: 'Sockeye salmon from the Snake River are endangered.',
    //   productId: '3',
    //   categoryId: '6',
    //   discount: '10',
    //   ratingInText: '4.0',
    //   rating: 4,
    //   weight: 1.5,
    //   isFavourite: true,
    // ),
    // ProductProvider(
    //   productTitle: 'Steelhead trout',
    //   imageUrl:
    //       'https://peopletravelfood.com/wp-content/uploads/2020/01/steelhead-trout-1170x846.jpg',
    //   price: 20,
    //   description:
    //       'Steelhead trout are endangered in Southern California and threatened in the California Central Valley, California coast, Columbia River, Puget Sound, Snake River Basin, and Upper Willamette River.',
    //   productId: '3',
    //   categoryId: '6',
    //   discount: '10',
    //   ratingInText: '4.0',
    //   rating: 4,
    //   weight: 1.5,
    //   isFavourite: true,
    // ),
    // ProductProvider(
    //     productId: '1',
    //     productTitle: 'Pure Thai Fish',
    //     description:
    //         'The main flavor in this well-known dish comes from the tamarind. Make sure you have the highest quality organic tamarind paste for the best flavor!',
    //     imageUrl:
    //         'https://cdn.pixabay.com/photo/2014/11/05/15/57/salmon-518032_960_720.jpg',
    //     ratingInText: '4.0',
    //     price: 20.0,
    //     rating: 4,
    //     weight: 1.5,
    //     isFavourite: true,
    //     discount: '40'),
  ];
  List<WooProductCategory> _category = [];

  List<WooProductCategory> get getCategoryList {
    return [..._category];
  }

  List<WooProduct> get getFavouritesList {
    return [..._productList];
  }

  List<WooProduct> get getProductsList {
    return [..._productList];
  }

  // void setProduct(List<WooProduct> value) {
  //   _productList = value;
  //   print('Product Provider' + _Category[0].name);
  //   notifyListeners();
  // }

  // void setCategory(List<WooProductCategory> value) {
  //   _Category = value;
  //   print('Provider' + _Category[0].name);
  //   notifyListeners();
  // }

  Future<List<WooProductCategory>> getParentCartegories() async {
    _category = await woocommerce.getProductCategories(parent: 0);
    notifyListeners();
    return _category;
  }

  List<WooProduct> _featuredProducts = [];

  Future<List<WooProduct>> getFeaturedProducts() async {
    _featuredProducts = await woocommerce.getProducts(
      page: 1,
      featured: true,
    );
    notifyListeners();
    return _featuredProducts;
  }

  List<WooProduct> _relatedProducts = [];

  Future<List<WooProduct>> fetchRelatedProducts(
      final List<int> relatedProductIdList) async {
    //(woocommerce.getProducts(page: 1, category: categoryId))

    _relatedProducts = await Future.wait<WooProduct>(relatedProductIdList
        .map((e) => woocommerce.getProductById(id: e))
        .toList());
    return _relatedProducts;
  }

  List<WooProduct> get getRelatedProducts {
    return _relatedProducts;
  }

  Future<WooProduct> getProductOnId(int id) async {
    WooProduct wooProduct = await woocommerce.getProductById(id: id);
    notifyListeners();
    return wooProduct;
  }
}
