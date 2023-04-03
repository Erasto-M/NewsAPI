import 'dart:convert';

import '../models/articleModel.dart';
import 'package:http/http.dart'as http;

class News{
  List<ArticleModel> news = <ArticleModel>[];
  Future<void> getNews()async{
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=fbe2ae39bfe643dabc8731941c75d4b2";
    var response = await  http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(jsonData['status']=="ok"){
      jsonData["articles"].forEach((element){
        if(element["author"] !=null && element['content']!= null && element['description'] !=null && element['urlToImage'] != null &&
            element['title']!=null && element['content'] !=null && element['url'] !=null && element['publishedAt']!=null){
          ArticleModel articlemodel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element["urlToImage"],
            //publishedAt: element["publishedAt"],
            content: element['content'],
          );
          news.add(articlemodel);
        }
      });
    }
  }
}