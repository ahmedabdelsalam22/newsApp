import 'package:flutter/material.dart';
import 'package:flutter_app/modules/web_view/web_view_screen.dart';
import 'package:transparent_image/transparent_image.dart';

void navigateTo(context,widget)
{
  Navigator.push(context,MaterialPageRoute(builder: (context)=>widget));
}

Widget defaultFormField
    ({
  TextEditingController controller,
  TextInputType type,
  Function OnSubmitt,
  Function OnChange,
  Function validate,
  String labelText,
  IconData prefix,
  IconData suffix,
  Function onTap,
  bool isClickable=true,
  bool isPassword =false,
  Function suffixpressed

})

{
  return TextFormField(
    controller:controller,
    keyboardType: type,
    onFieldSubmitted:OnSubmitt,
    onChanged: OnChange,
    validator: validate,
    onTap: onTap,
    enabled: isClickable,
    obscureText: isPassword,
    decoration: InputDecoration(
      labelText: labelText,
      border:const OutlineInputBorder(),
      prefixIcon: Icon(prefix),

      suffixIcon: suffix != null? IconButton(
        icon: Icon(suffix),onPressed: suffixpressed,
      ):null,
    ) ,

  );
}



Widget buildArticleItem(article,context){
  return InkWell(
    onTap: (){
      navigateTo(context, WebViewScreen(article['url']));
    },
    child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 130,height: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    placeholder: kTransparentImage,
                    image:article['urlToImage']??'https://picsum.photos/250?image=9',
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Expanded(
                      child: Text(article['title'],
                        maxLines: 4,overflow: TextOverflow.ellipsis,
                        style:Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      article['publishedAt'],
                      style:Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
            )
          ],
        )
    ),
  );
}


Widget separatedDivider(){
  return Padding(
      padding: const EdgeInsets.all(18.0),
   child: Container(
  width: double.infinity,height: 1,
  color: Colors.grey[300],
  ),
  );
}