import 'package:auto_route/auto_route.dart';
import 'package:crypto_data/application/domain/entities/cryptocurrency_entity.dart';
import 'package:crypto_data/application/domain/entities/price_chart_entity.dart';
import 'package:crypto_data/application/presentation/features/main/features/home/cubit/home_cubit.dart';
import 'package:crypto_data/application/presentation/router/router.gr.dart';
import 'package:crypto_data/application/presentation/widgets/crypto_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  bool _isAnimationEnabled = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    context.read<HomeCubit>().getPagginatedCryptocurrencyList(1, 1, 'usd');
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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

                            return AnimatedBuilder(
                              animation: _animationController,
                              builder: (final context, final child) {
                                if (index == 0 && _isAnimationEnabled) {
                                  _animationController.forward();
                                  _isAnimationEnabled = true;
                                }

                                return Transform(
                                  transform: Matrix4.translationValues(
                                      0, 50 * (1 - _animationController.value), 0),
                                  child: Opacity(
                                    opacity: _opacityAnimation.value,
                                    child: Card(
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
                                        onTap: () async {
                                          await AutoRouter.of(context)
                                              .push(DetailRoute(cryptocurrency: CryptocurrencyEntity(id: crypto.id, symbol: crypto.symbol, name: crypto.name, image: crypto.image, currentPrice: crypto.currentPrice)));
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                ),
              ],
            ),
          ),
        ),
      );
}
