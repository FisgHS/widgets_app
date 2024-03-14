import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScroll extends StatefulWidget {

  static const name = 'infinite_scroll_screen';

  const InfiniteScroll({super.key});

  @override
  State<InfiniteScroll> createState() => _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScroll> {

  List<int> imagesIds = [1,2,3,4,5];
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  bool isMounted = true;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      
      if ((scrollController.position.pixels + 500) >= scrollController.position.maxScrollExtent){
        // Load next page
        loadNextPage();
      }

    });

  }

  @override
  void dispose() {
    scrollController.dispose();
    isMounted = false;
    super.dispose();
  }

  Future loadNextPage() async {

    // Si el isLoading es true solo dar return
    if ( isLoading ) return;
    // Se define el isLoading en true
    isLoading = true;
    // Se pintan
    setState(() {});

    // Se define una espera
    await Future.delayed(const Duration(seconds: 2));

    // Se agregan las img
    addFiveImages();
    // Se define el isloading en false
    isLoading = false;

    if ( !isMounted ) return;
    setState(() {});

    moveScrollToBottom();

  }

  Future<void> onRefresh() async {

    isLoading = true;
    setState(() {});

    await Future.delayed(const Duration(seconds: 3));
    if ( !isMounted ) return;

    isLoading = false;
    final lastId = imagesIds.last;
    imagesIds.clear();
    imagesIds.add(lastId + 1);
    addFiveImages();

    setState(() {});

  }

  void moveScrollToBottom() {

    if ( scrollController.position.pixels + 150 <= scrollController.position.maxScrollExtent ) return;

    scrollController.animateTo(
      scrollController.position.pixels + 120, // Si se coloca 0 se dirige al top
      duration: const Duration(milliseconds: 300), 
      curve: Curves.fastOutSlowIn
    );

  }

  void addFiveImages() {
    final lastId = imagesIds.last;
    imagesIds.addAll(
      [1,2,3,4,5].map((e) => lastId + e)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          edgeOffset: 10,
          strokeWidth: 2,
          child: ListView.builder(
            controller: scrollController,
            itemCount: imagesIds.length,
            itemBuilder: (context, index) {
              return FadeInImage(
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
                placeholder: const AssetImage('assets/images/jar-loading.gif'), 
                image: NetworkImage('https://picsum.photos/id/${ imagesIds[index] }/500/300')
              );
            },
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        // Si el isLoading = true, el boton solo se podra presionar y no tendra ninguna funcion
        // Si isLoading = false, al presionar el boton volvera al menu
        onPressed: isLoading?
                    (){}
                    : () => context.pop(),
        child:
          // Si el loading = true, se muestra el icono de carga  
          // Si isLoading = false, se muestra el icono para volver 
          isLoading? 
            SpinPerfect(
              infinite: true,
              child: const Icon( Icons.refresh_rounded )
            ): FadeIn(child: const Icon( Icons.arrow_back_ios_new_outlined ))
        
      ),

    );
  }
}