import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

extension OptionalInFixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow == null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Imma-Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
    );
  }
}

class Counter extends StateNotifier<int?> {
  Counter() : super(null);
  void increament() => state = (state == null) ? 0 : (state + 1);
}

final counterProvider =
    StateNotifierProvider<Counter, int?>((ref) => Counter());

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(builder: (context, ref, child) {
          final count = ref.watch(counterProvider);
          final text = count == null ? "Press The Button" : count.toString();
          return Text(text);
        }),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              ref.read(counterProvider.notifier).increament();
            },
            child: Text(
              "Increament Count",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
