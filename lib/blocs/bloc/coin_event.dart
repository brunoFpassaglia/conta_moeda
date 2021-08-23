part of 'coin_bloc.dart';

abstract class CoinEvent {}

class CoinFetched extends CoinEvent {
  final DateTime date;

  CoinFetched(this.date);
}
