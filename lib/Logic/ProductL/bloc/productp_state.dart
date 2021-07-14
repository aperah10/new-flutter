part of 'productp_bloc.dart';

abstract class ProductpState extends Equatable {
  const ProductpState();

  @override
  List<Object> get props => [];
}

class ProductpInitialState extends ProductpState {
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends ProductpState {
  @override
  List<Object> get props => [];
}

class ProductLoadedState extends ProductpState {
  List<ProductM> productData;
  ProductLoadedState({required this.productData});

  @override
  List<Object> get props => [];
}

class ProductErrorState extends ProductpState {
  String message;
  ProductErrorState({required this.message});
  @override
  List<Object> get props => [];
}
