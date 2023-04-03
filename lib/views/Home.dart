import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/articleModel.dart';
import 'package:newsapp/models/categorydata.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsapp/views/article_Model.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _isloading = true;
  @override
  void initState(){
    super.initState();
    categories = getCategories();
    getNews();
  }
  getNews()async{
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _isloading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Flutter", style: TextStyle(color: Colors.black,
                fontSize: 25, fontWeight: FontWeight.bold),),
            Text("News",style: TextStyle(color: Colors.blue,
                fontSize: 25, fontWeight: FontWeight.bold))
          ],
        ),
      ),
      body: _isloading ? Center(
        child: Container(
          child: const CircularProgressIndicator(),
        ),
      )
      :
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              /// Categories
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: ListView.builder(
                  itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return MyImages(
                        Imageurl: categories[index].imageUrl,
                        CategoryName: categories[index].categoryName,
                      );
                    }),
              ),
              /// blogs
              Container(
                padding:const  EdgeInsets.only(top: 16),
                child: ListView.builder(
                  itemCount: articles.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context,index){
                    return Blogtile(
                        imageurl: articles[index].urlToImage,
                        title: articles[index].title,
                        description: articles[index].description,
                      url: articles[index].url,
                    );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class MyImages extends StatelessWidget {
  final Imageurl, CategoryName;
  MyImages({ this.Imageurl, this.CategoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: Imageurl, width: 120, height: 60,fit: BoxFit.cover,)),
            Container(
              height: 60,
              width: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
                child: Text(CategoryName,style:const  TextStyle(fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.white),))
          ],
        ),
      ),
    );
  }
}
class Blogtile extends StatelessWidget {
  String imageurl, title, description, url;
  Blogtile({required this.imageurl,required this.title,required this.description,required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(
          postUrl: url,
        )));
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
                child: Image.network(imageurl)),
            const SizedBox(height: 10,),
            Text(title, style: const TextStyle(
              fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87),),
           const  SizedBox(height: 5,),
            Text(description,style: const TextStyle(
                color: Colors.black26),),
          ],
        ),
      ),
    );
  }
}



