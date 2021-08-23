import 'package:conta_moeda/models/coin_model.dart';
import 'package:dio/dio.dart';

class CoinRepo {
  Dio _dio = Dio();
  String endpoint =
      r'https://olinda.bcb.gov.br/olinda/servico/mecir_dinheiro_em_circulacao/versao/v1/odata/informacoes_diarias?$format=json';

  static final CoinRepo _singleton = CoinRepo._();
  CoinRepo._();

  factory CoinRepo() {
    return _singleton;
  }

  Future<List<CoinModel>> getCoins({
    required Map<String, String> params,
  }) async {
    try {
      Response response = await _dio
          .get(endpoint, queryParameters: {'format': 'json', ...params});

      final coins = response.data['value']
          .map<CoinModel>((coin) => CoinModel.fromJson(coin))
          .toList();
      return coins;
    } on Exception {
      rethrow;
    }
  }
}
