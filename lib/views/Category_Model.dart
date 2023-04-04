import 'package:flutter/material.dart';
import 'package:newsapp/helper/news.dart';
import '../models/articles.dart';
//import 'Home.dart';
import 'WebviewModel.dart';
 class CategoryNews extends StatefulWidget {
   String category;
   CategoryNews({ required this.category});

   @override
   State<CategoryNews> createState() => _CategoryNewsState();
 }

 class _CategoryNewsState extends State<CategoryNews> {
   bool _isloading = true;
   List<ArticleModel> articles = <ArticleModel>[];
   @override
   void initState(){
     super.initState();
     getCategoryNews();
   }
   getCategoryNews()async{
     CategoryNewsclass newsclass = CategoryNewsclass();
     await newsclass.getCategoryNews(
       category: widget.category,
     );
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
             Text("India", style: TextStyle(color: Colors.black,
                 fontSize: 25, fontWeight: FontWeight.bold),),
             Text("News",style: TextStyle(color: Colors.blue,
                 fontSize: 25, fontWeight: FontWeight.bold))
           ],
         ),
       ),
       body: _isloading ? Center(
         child: Container(
           child: CircularProgressIndicator(),
         ),
       ) :
       SingleChildScrollView(
         child: Container(
           margin: const EdgeInsets.only(top: 10,right: 15,left: 15),
           child: Column(
             children: [
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
