import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {

  static const name = 'snackbars_screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar( BuildContext context ) {

    ScaffoldMessenger.of(context).clearSnackBars();

    final snackbar = SnackBar(
      content: const Text('Hola Mundo'),
      action: SnackBarAction(label: 'Ok!', onPressed: () {} ),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);

  }


  void openDialog( BuildContext context) {

    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('¿Estas seguro?'),
        content: const Text('Aliquip incididunt non aliqua commodo. Voluptate enim tempor est adipisicing eu. Non eiusmod anim ullamco voluptate cupidatat enim aute officia ipsum deserunt labore duis elit dolor. Quis deserunt id irure tempor cupidatat ut amet elit sunt consectetur. Cupidatat duis quis dolor velit officia consectetur nostrud culpa sint. Consequat excepteur cupidatat cupidatat nisi ex officia do cupidatat. Est exercitation eu eiusmod eiusmod est id culpa anim incididunt.'),
        actions: [
          TextButton(onPressed: ()=> context.pop() , child: const Text('Cancelar')),
          FilledButton(onPressed: ()=> context.pop() , child: const Text('Aceptar'))
        ],
      ),
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars y Dialogos'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: (){
                showAboutDialog(
                  context: context,
                  children: [
                    const Text('Aliqua magna dolor duis ut dolor sit ut eiusmod velit reprehenderit labore. Excepteur cillum tempor est in dolor quis consectetur ullamco laborum eu. Mollit dolor veniam qui fugiat sint ad velit fugiat eiusmod laboris. Irure eu excepteur esse aute pariatur amet. Anim aliqua laboris excepteur veniam mollit sit non ipsum. Cupidatat aliquip cillum consequat occaecat culpa excepteur culpa deserunt qui pariatur laboris.')
                  ]
                );
              }, 
              child: const Text('Licencias usadas')
            ),
            FilledButton.tonal(
              onPressed: () => openDialog(context), 
              child: const Text('Mostrar dialogo')
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrar Snackbar'),
        icon: const Icon( Icons.remove_red_eye_outlined ),
        onPressed: () => showCustomSnackbar(context), 
      ),

    );
  }
}