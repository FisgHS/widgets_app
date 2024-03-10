import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {

  static const name = 'animated_screen';

  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Indicators'),
      ),
      body: const _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox( height: 30,),
          Text('Circular progress indicator'),
          SizedBox(height: 15,),
          CircularProgressIndicator(strokeWidth: 2, backgroundColor: Colors.black12,),

          SizedBox(height: 30,),
          Text('Circular y linear indicator controlado'),
          SizedBox(height: 15,),
          _ControllerProgresIndicator(),

        ],
      ),
    );
  }
}


class _ControllerProgresIndicator extends StatelessWidget {
  const _ControllerProgresIndicator();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic( const Duration(milliseconds: 300) , (value) {
        return (value * 2) / 100 ;
      }).takeWhile((value) => value < 100),
      builder: (context, snapshot) {

        final progressValue = snapshot.data ?? 0;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(value: progressValue ,strokeWidth: 2, backgroundColor: Colors.black12,),
              const SizedBox(width: 20,),
              Expanded(
                child: LinearProgressIndicator(value: progressValue,)
              )
            ],
          ),
        );

      },
    );
  }
}