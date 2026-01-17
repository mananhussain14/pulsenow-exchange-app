import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/market_data_provider.dart';

class MarketDataScreen extends StatefulWidget {
  const MarketDataScreen({super.key});

  @override
  State<MarketDataScreen> createState() => _MarketDataScreenState();
}

class _MarketDataScreenState extends State<MarketDataScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MarketDataProvider>(context, listen: false).loadMarketData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketDataProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.error!,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: provider.loadMarketData,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: provider.loadMarketData,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: provider.marketData.length,
            itemBuilder: (context, index) {
              final item = provider.marketData[index];
              final isPositive = item.change24h >= 0;
              final changeColor = isPositive ? Colors.green : Colors.red;

              return ListTile(
                title: Text(
                  item.symbol,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isPositive ? '+' : ''}${item.change24h.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: changeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${isPositive ? '+' : ''}${item.changePercent24h.toStringAsFixed(2)}%',
                      style: TextStyle(color: changeColor),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
