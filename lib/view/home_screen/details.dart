import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_with_proider_jann/model/new_api_res_model.dart';

class details extends StatelessWidget {
  const details({super.key,required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          article.urlToImage == null || article.urlToImage == "" ?SizedBox():
                          Container(
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                             child:  CachedNetworkImage(
                            imageUrl: "${article.urlToImage}",
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Image.asset("assets/No-Image-Placeholder.png"),
                         ),
                              // child: Image.network("${provider.resbyCategory?.articles?[index].urlToImage}",fit: BoxFit.cover,)
                              )),
                              SizedBox(height: 10,),
                          Text("${article.title?.toUpperCase()}",style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                           Text("${article.description?.toUpperCase()}"),
                          // Image(image: provider.resModel?.articles?[index].urlToImage),
                        ],
                      ),
                    ),
                  )
    );
  }
}