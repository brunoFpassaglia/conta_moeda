part of 'coin_bloc.dart';

abstract class CoinState {}

class CoinInitial extends CoinState {}

class CoinFetchLoading extends CoinState {}

class CoinFetchSuccess extends CoinState {
  final List<CoinModel> coins;

  CoinFetchSuccess({required this.coins});
}

class CoinFetchFailure extends CoinState {}
