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
    context.read<GeneralController>().homeController.load();
  }


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
          physics: BouncingScrollPhysics(),
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
                    SizedBox(
                      height: 110,
                    )
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
