import 'package:flutter/material.dart';
import 'package:recorder/Controllers/HomeController.dart';
import 'package:recorder/Controllers/GeneralController.dart';
import 'package:recorder/models/AudioModel.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/UI/Pages/Home/widgets/AudioPreviewWidget.dart';
import 'package:recorder/UI/Pages/Home/widgets/CollectionsWidget.dart';
import 'package:recorder/UI/widgets/Appbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    load();
  }

  load()async{
    context.read<GeneralController>().homeController.load();
    setState(() {

    });
    initSize();
  }

  double hAll;
  double hEmptyView= 48.0+58.0+38.0+105.0+24.0;
  bool isScroll = true;

  initSize(){
    hAll = 64 +48 +24 +44 + ((MediaQuery.of(context).size.width / 2 - 43 / 2)*240/183);
    hEmptyView = 48.0+58.0+38.0+105.0+24.0;
    bool isScrollStep = (hAll > MediaQuery.of(context).size.height+hEmptyView)||
        (context.read<GeneralController>().collectionsController.audiosAll != null &&
            context.read<GeneralController>().collectionsController.audiosAll.isNotEmpty );
    if(isScrollStep != isScroll)
      setState(() {
      isScroll = isScrollStep;
    });
  }




  //64 48 24 44 ((MediaQuery.of(context).size.width / 2 - 43 / 2)) * 240 / 183
  //

  @override
  Widget build(BuildContext context) {



    return SafeArea(
      child: Scaffold(
        backgroundColor: cBackground.withOpacity(0.0),
        appBar: MyAppBar(
          buttonMore: false,
          buttonBack: false,
          buttonMenu: true,
          padding: 11,
          tapLeftButton: (){
            context.read<GeneralController>().setMenu(true);
          },
        ),
        body: SingleChildScrollView(
          physics: (context.read<GeneralController>().collectionsController.audiosAll != null && context.read<GeneralController>().collectionsController.audiosAll.isNotEmpty )?BouncingScrollPhysics():((64 +48 +24 +44 + ((MediaQuery.of(context).size.width / 2 - 43 / 2)*240/183))+hEmptyView > MediaQuery.of(context).size.height)?BouncingScrollPhysics():NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: StreamBuilder<HomeState>(
              stream: context.read<GeneralController>().homeController.stream,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Collections(
                      onAddCollection: (){
                        context.read<GeneralController>().setPage(1);
                        context.read<GeneralController>().collectionsController.addCollection();
                      },
                      onTapCollection: (item){
                        context.read<GeneralController>().setPage(1);
                        context.read<GeneralController>().collectionsController.view(item);
                      },
                      loading: (snapshot.data == null?true:snapshot.data.loading??false),
                      items: (snapshot.data == null?[]:snapshot.data.collections),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 44.0),
                      child: AudioPreview(
                        loading: (snapshot.data == null?true:snapshot.data.loading??false),
                        items:  (snapshot.data == null?[]:snapshot.data.audios),
                      ),
                    ),
                    (context.read<GeneralController>().collectionsController.audiosAll != null && context.read<GeneralController>().collectionsController.audiosAll.isNotEmpty )?SizedBox(height: 110,):((64 +48 +24 +44 + ((MediaQuery.of(context).size.width / 2 - 43 / 2)*240/183))+hEmptyView > MediaQuery.of(context).size.height)?SizedBox(height: 0,):SizedBox(height: 0,),

                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
