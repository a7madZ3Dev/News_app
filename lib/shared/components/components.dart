import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder/conditional_builder.dart';

import '../../models/article_model.dart';
import '../../modules/web_view/webView.dart';

// form field
Widget defaultFormField({
  TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
  bool readOnly = false,
  bool showCursor = true,
  FocusNode focusNodeField,
  Color fillColor,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      showCursor: showCursor,
      readOnly: readOnly,
      focusNode: focusNodeField,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: fillColor,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

// for single item  on mobile
Widget buildArticleItem(Article article, BuildContext context) => InkWell(
      onTap: () {
        navigateTo(
          context,
          WebViewScreen(article.articleUrl),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                // image: DecorationImage(
                //   image: NetworkImage('${article.imageUrl}'),
                //   fit: BoxFit.cover,
                //   onError: (exception, stackTrace) {
                //     return Icon(Icons.error);
                //   },
                // ),
              ),
              child: article.imageUrl != null
                  ? Image.network(
                      article.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace stackTrace) {
                        return Image(
                          image: AssetImage(
                            'assets/placeholder.png',
                          ),
                          height: 120.0,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image(
                      image: AssetImage(
                        'assets/placeholder.png',
                      ),
                      height: 120.0,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article.title}',
                        style: Theme.of(context).textTheme.headline6,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMd().format(article.publishedAt),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
          ],
        ),
      ),
    );

//separator widget
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

// for single item  on mobile
Widget buildArticleDeskTopItem(Article article, BuildContext context) =>
    InkWell(
      onTap: () {
        navigateTo(
          context,
          WebViewScreen(article.articleUrl),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  child: article.imageUrl != null
                      ? Image.network(
                          article.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            return Image(
                              image: AssetImage(
                                'assets/placeholder.png',
                              ),
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image(
                          image: AssetImage(
                            'assets/placeholder.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${article.title}',
                style: Theme.of(context).textTheme.subtitle1,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                DateFormat.yMMMd().format(article.publishedAt),
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );

//created for the mobile screen
Widget articleBuilder(List<Article> list, BuildContext context,
        {isSearch = false}) =>
    ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length,
      ),
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

//created for the deskTop screen
Widget articleBuilderDeskTop(List<Article> list, BuildContext context,
        {isSearch = false}) =>
    ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => GridView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildArticleDeskTopItem(list[index], context),
        itemCount: list.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.height * 0.50,
          childAspectRatio: 3 / 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
      ),
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

// push to another screen
void navigateTo(BuildContext context, Widget widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
