  import 'package:flutter/material.dart';
  import 'package:universal_html/html.dart' as html;
  class PageProvider extends ChangeNotifier{
    PageController scrollController = PageController();

    List<String> _pages = ['home','about','pricing','contact','location'];
    int _currentIndex=0;

    createScrollController(String routeName){
      scrollController = PageController(initialPage:getPageIndex(routeName) );
      html.document.title = _pages[getPageIndex(routeName)];
      scrollController.addListener(() {
        final pageIndex = (scrollController.page ?? 0).round();
        if(pageIndex != _currentIndex){
          html.window.history.pushState(null, 'none', '#/${_pages[pageIndex]}');
          html.document.title = _pages[pageIndex];
        }
      });
    }

    getPageIndex(String routeName){
      return (_pages.indexOf(routeName) == -1)
              ? 0
              : _pages.indexOf(routeName);
    }


    goTo(int index){
      html.window.history.pushState(null, 'none', '#/${_pages[index]}');
      
      scrollController.animateToPage(
        index, 
        duration: Duration(milliseconds: 300), 
        curve: Curves.easeInOut);
    }

  }