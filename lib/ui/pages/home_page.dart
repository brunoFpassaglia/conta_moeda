import 'package:conta_moeda/blocs/bloc/coin_bloc.dart';
import 'package:conta_moeda/ui/components/coin_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CoinBloc _coinBloc = CoinBloc();
  DateTime? _date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Moedas Brasileiras'),
          backgroundColor: Colors.green,
        ),
        // backgroundColor: Colors.yellowAccent,
        body: BlocProvider.value(
            value: _coinBloc,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                  onTap: () async {
                    var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.utc(1994, 07, 01),
                        lastDate: DateTime.now());
                    setState(() {
                      _date = date;
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 0.3)),
                      child: Text(
                        _date?.toString() ?? 'Escolha uma data',
                        style: TextStyle(fontSize: 32),
                      ))),
              ElevatedButton(
                onPressed: _date == null
                    ? null
                    : () async {
                        _coinBloc.add(CoinFetched(_date!));
                      },
                child: Text('Buscar'),
              ),
              SingleChildScrollView(
                child: BlocBuilder<CoinBloc, CoinState>(
                  builder: (context, state) {
                    if (state is CoinFetchSuccess) {
                      return Container(
                        height: 300,
                        child: CoinBarChart(series: state.coins),
                      );
                    }
                    if (state is CoinFetchFailure) {
                      return Text('Nao foi possivel buscar as moedas');
                    }
                    if (state is CoinFetchLoading) {
                      return CircularProgressIndicator(
                          backgroundColor: Colors.white38);
                    }
                    return Container();
                  },
                ),
              ),
            ])));
  }
}
