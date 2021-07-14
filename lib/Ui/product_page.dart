import 'package:aper/Logic/ProductL/bloc/productp_bloc.dart';
import 'package:aper/Model/Product/productm.dart';
import 'package:aper/Respo/product/ProdRespo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDataShow extends StatefulWidget {
  ProductDataShow({Key? key}) : super(key: key);

  @override
  _ProductDataShowState createState() => _ProductDataShowState();
}

class _ProductDataShowState extends State<ProductDataShow> {
  ProductpBloc prodBloc = ProductpBloc(prodRespo: ProductDataRespo());

  @override
  void initState() {
    prodBloc = BlocProvider.of<ProductpBloc>(context);
    prodBloc.add(FetchProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: BlocConsumer<ProductpBloc, ProductpState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ProductErrorState) {
          return Center(child: Text(' this is eror ${state.message}'));
        }
        if (state is ProductLoadedState) {
          return buildHintsList(state.productData);
        }
        return Container();
      },
    )));
  }

  Widget buildHintsList(List<ProductM> productData) {
    return Container(
      child: new ListView.builder(
          itemCount: productData.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 90,
                        width: 100,
                       child: Image(
                       image: NetworkImage(
                               productData[index].pic ?? '', ))),
                       
                        // child: Image.network(productData[index].pic ?? '')),
                    // SizedBox(height: 30),
                    Text(productData[index].title ?? 'No data '), 
                     
                  ],
                ),
              ),
            );
          }),
    );
  }
}
