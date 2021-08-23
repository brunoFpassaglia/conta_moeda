import 'package:conta_moeda/blocs/bloc/coin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? _date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moedas Brasileiras'),
        backgroundColor: Colors.green,
      ),
      // backgroundColor: Colors.yellowAccent,
      body: Column(
        children: [
          Text(_date?.toString() ?? 'Escolha uma data'),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
            onPressed: () async {
              var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.utc(1994, 07, 01),
                  lastDate: DateTime.now());
              setState(() {
                _date = date;
              });
            },
            child: Text('Data'),
          ),
          SingleChildScrollView(
            child: BlocProvider(
              create: (_) => CoinBloc(),
              child: BlocBuilder<CoinBloc, CoinState>(
                builder: (context, state) {
                  if (state is CoinFetchSuccess) {
                    return Column(
                      children: state.coins.map((e) => Text(e.name)).toList(),
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
          ),
        ],
      ),
    );
  }
}
