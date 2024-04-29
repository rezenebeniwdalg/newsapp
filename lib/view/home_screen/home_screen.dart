import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app_with_proider_jann/controller/home_screen_controller.dart';
import 'package:news_app_with_proider_jann/view/home_screen/details.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
       context.read<HomeScreenController>().getdatabycat();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeScreenController>();
    return DefaultTabController(
      length: provider.categories.length,
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     context.read<HomeScreenController>().getdatabycat();
        //   },
        // ),
        appBar: AppBar(bottom: TabBar(
          isScrollable: true,
          onTap: (value) {

            context.read<HomeScreenController>().
            oncatselect(value);
          },
          tabs: List.generate(provider.categories.length, (index) => Tab(child: Text("${provider.categories[index]}"),))),),
        body: provider.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: provider.resbyCategory?.articles?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> details()));
                      },
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            provider.resbyCategory?.articles?[index].urlToImage != null || provider.resbyCategory!.articles![index].urlToImage!.isEmpty ?SizedBox():
                            Container(
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                               child:  CachedNetworkImage(
        imageUrl: "${provider.resbyCategory?.articles?[index].urlToImage}",
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Image.asset("assets/No-Image-Placeholder.png"),
     ),
                                // child: Image.network("${provider.resbyCategory?.articles?[index].urlToImage}",fit: BoxFit.cover,)
                                )),
                                SizedBox(height: 10,),
                            Text("${provider.resbyCategory?.articles?[index].title?.toUpperCase()}",style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                             Text("${provider.resbyCategory?.articles?[index].description?.toUpperCase()}"),
                            // Image(image: provider.resModel?.articles?[index].urlToImage),
                          ],
                        ),
                      ),
                    ),
                  );
                  // return ListTile(
                  //   title: Text(provider.resModel?.articles?[index].title ?? ""),
                    
                  // );
                },
              ),
      ),
    );
  }
}
