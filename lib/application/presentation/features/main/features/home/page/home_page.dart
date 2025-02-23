import 'package:crypto_data/application/domain/entities/cryptocurrency_entity.dart';
import 'package:crypto_data/application/domain/entities/price_chart_entity.dart';
import 'package:crypto_data/application/presentation/features/main/features/home/cubit/home_cubit.dart';
import 'package:crypto_data/application/presentation/widgets/crypto_chart_widget.dart';
import 'package:crypto_data/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getPagginatedCryptocurrencyList(1, 3, 'usd');
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (final context, final state) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: state.cryptocurrencyList == null ||
                          state.cryptocurrencyList!.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: state.cryptocurrencyList!.length,
                          itemBuilder: (final context, final index) {
                            final CryptocurrencyEntity crypto =
                                state.cryptocurrencyList![index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: ListTile(
                                leading: Image.network(
                                  crypto.image,
                                  width: 40,
                                  height: 40,
                                  errorBuilder: (final context, final error,
                                          final stackTrace) =>
                                      const Icon(Icons.image_not_supported),
                                ),
                                title: Text(crypto.name),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Price: ${crypto.currentPrice} USD'),
                                    const SizedBox(height: 10),
                                    FutureBuilder<PriceChartEntity>(
                                      future: context
                                          .read<HomeCubit>()
                                          .getPriceChart(crypto.id, 7),
                                      builder: (final context, final snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else if (snapshot.hasData) {
                                          return cryptoChartWidget(
                                              snapshot.data!.priceChart);
                                        } else {
                                          return const Text(
                                              'No data available');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                ),
              ],
            ),
          ),
        ),
      );
}
