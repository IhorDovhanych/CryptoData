import 'package:crypto_data/application/di/injections.dart';
import 'package:crypto_data/application/domain/entities/cryptocurrency_entity.dart';
import 'package:crypto_data/application/presentation/features/main/features/detail/cubit/detail_cubit.dart';
import 'package:crypto_data/application/presentation/widgets/big_crypto_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.cryptocurrency});

  final CryptocurrencyEntity cryptocurrency;
  @override
  Widget build(final BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<DetailCubit>(
            create: (final _) => getIt<DetailCubit>(),
          ),
        ],
        child: _DetailPageContent(cryptocurrency: cryptocurrency),
      );
}

class _DetailPageContent extends StatefulWidget {
  const _DetailPageContent({required this.cryptocurrency});

  final CryptocurrencyEntity cryptocurrency;

  @override
  ___DetailPageContentState createState() => ___DetailPageContentState();
}

class ___DetailPageContentState extends State<_DetailPageContent> {

  @override
  void initState() {
    super.initState();
    context.read<DetailCubit>().getPriceChart(widget.cryptocurrency.id, 7);
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(widget.cryptocurrency.name),
      ),
      body: BlocBuilder<DetailCubit, DetailState>(
        builder: (final context, final state) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Image.network(
                    widget.cryptocurrency.image,
                    width: 100,
                    height: 100,
                    errorBuilder: (final context, final error, final stackTrace) =>
                        const Icon(Icons.error, size: 100),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.cryptocurrency.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.cryptocurrency.symbol.toUpperCase(),
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Text(
                  '\$${widget.cryptocurrency.currentPrice}',
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                if (state.priceChart != null)
                  bigCryptoChartWidget(state.priceChart!.priceChart, state.days!),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<DetailCubit>().getPriceChart(widget.cryptocurrency.id, 1);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: state.days == 1 ? Colors.white : Colors.black,
                        backgroundColor: state.days == 1 ? Colors.blue : Colors.grey,
                      ),
                      child: const Text('24 H'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<DetailCubit>().getPriceChart(widget.cryptocurrency.id, 7);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: state.days == 7 ? Colors.white : Colors.black,
                        backgroundColor: state.days == 7 ? Colors.blue : Colors.grey,
                      ),
                      child: const Text('7 Days'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<DetailCubit>().getPriceChart(widget.cryptocurrency.id, 30);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: state.days == 30 ? Colors.white : Colors.black,
                        backgroundColor: state.days == 30 ? Colors.blue : Colors.grey,
                      ),
                      child: const Text('30 Days'),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }

