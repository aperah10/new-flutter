import 'package:aper/Logic/ProductL/bloc/productp_bloc.dart';
import 'package:aper/Respo/product/ProdRespo.dart';
import 'package:aper/Widget/GridViewList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDataList extends StatefulWidget {
  ProductDataList({
    Key? key,
  }) : super(key: key);

  @override
  _ProductDataListState createState() => _ProductDataListState();
}

class _ProductDataListState extends State<ProductDataList> {
  ProductpBloc prodBloc = ProductpBloc(prodRespo: ProductDataRespo());

  @override
  void initState() {
    prodBloc = BlocProvider.of<ProductpBloc>(context);
    prodBloc.add(FetchProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductpBloc, ProductpState>(
        listener: (context, state) {},
        builder: (context, state) {
          print("produc page state: $state");
          if (state is ProductLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProductErrorState) {
            return Center(child: Text(' this is eror ${state.message}'));
          }
          if (state is ProductLoadedState) {
            return Scaffold(body: GridViewListShow(productstate: state.productData,)); }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
