import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:conta_moeda/models/coin_model.dart';
import 'package:conta_moeda/repositories/coin_repo.dart';

part 'coin_event.dart';
part 'coin_state.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final CoinRepo _repo = CoinRepo();
  CoinBloc() : super(CoinInitial());

  @override
  Stream<CoinState> mapEventToState(
    CoinEvent event,
  ) async* {
    if (event is CoinFetched) {
      yield CoinFetchLoading();
      try {
        var coins = await _repo.getCoins(params: {
          "\$top": '14',
          r"$filter": "Data eq ${event.date.toString().substring(0, 10)}",
        });
        yield CoinFetchSuccess(coins: coins);
      } catch (e) {
        yield CoinFetchFailure();
      }
    }
  }
}
