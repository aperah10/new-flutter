import 'package:aper/Logic/ProductL/bloc/productp_bloc.dart';

import 'package:aper/Respo/product/ProdRespo.dart';
import 'package:aper/Ui/newproduct_page.dart';
import 'package:aper/Ui/product_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc {
  static List<BlocProvider> allBlocs() {
    return [
       BlocProvider(create: (context)=> ProductpBloc(prodRespo: ProductDataRespo()),
      child: ProductDataShow(),),
       BlocProvider(create: (context)=> ProductpBloc(prodRespo: ProductDataRespo()),
      child: ProductDataList(),),

     
    ];
  }
}
