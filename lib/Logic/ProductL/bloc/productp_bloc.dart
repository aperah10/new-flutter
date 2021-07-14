import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aper/Model/Product/productm.dart';
import 'package:aper/Respo/product/ProdRespo.dart';

part 'productp_event.dart';
part 'productp_state.dart';



class ProductpBloc extends Bloc<ProductpEvent, ProductpState> {
  ProductRespo prodRespo;

  ProductpBloc({required this.prodRespo}) : super(ProductpInitialState());
  
  // @override
  ProductpState get initialState => ProductpInitialState();

  @override
  Stream<ProductpState> mapEventToState(
    ProductpEvent event,
  ) async* {
    if (event is FetchProductEvent) {
      yield ProductLoadingState();

      try {
        List<ProductM> productData =await  prodRespo.getProduct();
        yield ProductLoadedState(productData: productData) ;
      }
      catch (e){
          yield ProductErrorState(message: e.toString());
      }
    }
  }
}
