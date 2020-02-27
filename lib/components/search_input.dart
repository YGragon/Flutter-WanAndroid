import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_wanandroid/utils/shared_preferences.dart';
import 'package:meta/meta.dart';
// import 'package:flutter_wanandroid/resources/widget_name_to_icon.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import '../model/search_history.dart';

typedef String FormFieldFormatter<T>(T v);
typedef bool MaterialSearchFilter<T>(T v, String c);
typedef int MaterialSearchSort<T>(T a, T b, String c);
typedef Future<List<MaterialSearchResult>> MaterialResultsFinder(String c);
typedef void OnSubmit(String value);

/// 首页搜索框
class SearchInput extends StatelessWidget {
  final getResults;

  final ValueChanged<String> onSubmitted;

  final VoidCallback onSubmitPressed;

  SearchInput(this.getResults, this.onSubmitted, this.onSubmitPressed);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 40.0,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(4.0)),
      child: new Row(
        children: <Widget>[
          /// 搜索图标
          new Padding(
            padding: new EdgeInsets.only(right: 10.0, top: 3.0, left: 10.0),
            child: new Icon(Icons.search,
                size: 24.0, color: Theme.of(context).accentColor),
          ),
          new Expanded(
            child: new MaterialSearchInput(
              placeholder: '搜索点什么吧~',
              getResults: getResults,
            ),
          ),
        ],
      ),
    );
  }
}

/// 搜索框：自定义的组件
class MaterialSearchInput<T> extends StatefulWidget {
  /// 构造方法
  MaterialSearchInput({
    Key key,
    this.onSaved,
    this.validator,
    this.autovalidate,
    this.placeholder,
    this.formatter,
    this.results,
    this.getResults,
    this.filter,
    this.sort,
    this.onSelect,
  });

  /// 定义的变量，可以通过 widget. 去获取，比如：widget.placeholder
  final FormFieldSetter<T> onSaved;
  final FormFieldValidator<T> validator;
  final bool autovalidate;
  final String placeholder;
  final FormFieldFormatter<T> formatter;

  final List<MaterialSearchResult<T>> results;
  final MaterialResultsFinder getResults;
  final MaterialSearchFilter<T> filter;
  final MaterialSearchSort<T> sort;
  final ValueChanged<T> onSelect;

  @override
  _MaterialSearchInputState<T> createState() =>
      new _MaterialSearchInputState<T>();
}

class _MaterialSearchInputState<T> extends State<MaterialSearchInput<T>> {
  GlobalKey<FormFieldState<T>> _formFieldKey =
      new GlobalKey<FormFieldState<T>>();

  /// 搜索结果页面
  _buildMaterialSearchPage(BuildContext context) {
    return new _MaterialSearchPageRoute<T>(
        settings: new RouteSettings(
          name: 'material_search',
          isInitialRoute: false,
        ),
        builder: (BuildContext context) {
          return new Material(
            child: new MaterialSearch<T>(
              placeholder: widget.placeholder,
              results: widget.results,
              getResults: widget.getResults,
              filter: widget.filter,
              sort: widget.sort,
              onSelect: (dynamic value) => Navigator.of(context).pop(value),
            ),
          );
        });
  }

  /// 点击首页搜索后，跳转搜索页面
  _showMaterialSearch(BuildContext context) {
    Navigator.of(context)
        .push(_buildMaterialSearchPage(context))
        .then((dynamic value) {
      if (value != null) {
        _formFieldKey.currentState.didChange(value);
        widget.onSelect(value);
      }
    });
  }

  bool get autovalidate {
    return widget.autovalidate ??
        Form.of(context)?.widget?.autovalidate ??
        false;
  }

  /// 判输入框是否为空
  bool _isEmpty(field) {
    return field.value == null;
  }

  /// 搜索历史
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.subhead;
    // Material触摸水波效果
    return new InkWell(
      onTap: () => _showMaterialSearch(context),
      child: new FormField<T>(
        key: _formFieldKey,
        validator: widget.validator,
        onSaved: widget.onSaved,
        autovalidate: autovalidate,
        builder: (FormFieldState<T> field) {
          return new InputDecorator(
            isEmpty: _isEmpty(field),
            decoration: new InputDecoration(
              /// 提示文本
              labelText: widget.placeholder,
              border: InputBorder.none,
              errorText: field.errorText,
            ),
            child: _isEmpty(field)
                ? null
                : new Text(
                    widget.formatter != null
                        ? widget.formatter(field.value)
                        : field.value.toString(),
                    style: valueStyle),
          );
        },
      ),
    );
  }
}

/// 可以在搜索结果页面进行页面（widget）的切换
class _MaterialSearchPageRoute<T> extends MaterialPageRoute<T> {
  _MaterialSearchPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings: const RouteSettings(),
    maintainState: true,
    bool fullscreenDialog: false,
  })  : assert(builder != null),
        super(
            builder: builder,
            settings: settings,
            maintainState: maintainState,
            fullscreenDialog: fullscreenDialog);
}

/// 搜索结果
class MaterialSearch<T> extends StatefulWidget {
  /// 构造函数
  MaterialSearch({
    Key key,
    this.placeholder,
    this.results,
    this.getResults,
    this.filter,
    this.sort,
    this.limit: 10,
    this.onSelect,
    this.onSubmit,
    this.barBackgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.leading,
  })  : assert(() {
          if (results == null && getResults == null ||
              results != null && getResults != null) {
            throw new AssertionError(
                'Either provide a function to get the results, or the results.');
          }

          return true;
        }()),
        super(key: key);

  /// 声明的变量
  final String placeholder;

  final List<MaterialSearchResult<T>> results;
  final MaterialResultsFinder getResults;
  final MaterialSearchFilter<T> filter;
  final MaterialSearchSort<T> sort;
  final int limit;
  final ValueChanged<T> onSelect;
  final OnSubmit onSubmit;
  final Color barBackgroundColor;
  final Color iconColor;
  final Widget leading;

  @override
  _MaterialSearchState<T> createState() => new _MaterialSearchState<T>();
}

class _MaterialSearchState<T> extends State<MaterialSearch> {
  bool _loading = false;
  List<MaterialSearchResult<T>> _results = [];

  /// 输入框的内容
  String _criteria = '';
  TextEditingController _controller = new TextEditingController();

  /// 正则匹配搜索结果
  _filter(dynamic v, String c) {
    return v
        .toString()
        .toLowerCase()
        .trim()
        .contains(new RegExp(r'' + c.toLowerCase().trim() + ''));
  }

  /// 初始化数据
  @override
  void initState() {
    super.initState();

    if (widget.getResults != null) {
      _getResultsDebounced();
    }

    _controller.addListener(() {
      setState(() {
        _criteria = _controller.value.text;
        print("监听输入框的内容："+_criteria);
        if (widget.getResults != null) {
          _getResultsDebounced();
        }
      });
    });
  }

  /// 去抖操作
  Timer _resultsTimer;
  Future _getResultsDebounced() async {
    if (_results.length == 0) {
      /// 显示加载中进度条
      setState(() {
        _loading = true;
      });
    }

    if (_resultsTimer != null && _resultsTimer.isActive) {
      _resultsTimer.cancel();
    }

    /// 输入框变动之后 每间隔 400 ms 才搜素
    _resultsTimer = new Timer(new Duration(milliseconds: 400), () async {
      if (!mounted) {
        return;
      }

      setState(() {
        _loading = true;
      });

      /// 查询 widget 是否存在
      print("开始获取widget："+_criteria);
      var results = await widget.getResults(_criteria);

      if (!mounted) {
        return;
      }
      if (results != null) {
        /// 关闭加载中进度条，显示列表数据页面
        setState(() {
          _loading = false;
          _results = results;
        });
      }else{
        /// 关闭加载中进度条，显示暂无数据页面
        setState(() {
          _loading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _resultsTimer?.cancel();
  }

  /// 搜索结果显示
  Widget buildBody(List results) {
    if (_criteria.isEmpty) {
      return History();
    } else if (_loading) {
      return new Center(
          child: new Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: new CircularProgressIndicator()));
    }
    if (results.isNotEmpty) {
      var content =
          new SingleChildScrollView(child: new Column(children: results));
      return content;
    }
    return Center(child: Text("暂无数据"));
  }

  @override
  Widget build(BuildContext context) {
    /// (widget.results ?? _results) 表示 widget.results 为空则使用 results，否则使用 widget.results
    ///  .where(MaterialSearchResult result) 表示要过滤 MaterialSearchResult 中的值，也就是返回的结果是 MaterialSearchResult 中存在的值
    ///  返回的搜索列表数据
    var results =
        (widget.results ?? _results).where((MaterialSearchResult result) {
      if (widget.filter != null) {
        return widget.filter(result.value, _criteria);
      }
      //only apply default filter if used the `results` option
      //because getResults may already have applied some filter if `filter` option was omited.
      else if (widget.results != null) {
        return _filter(result.value, _criteria);
      }

      return true;
    }).toList();

    /// 对搜搜索结果排序
    if (widget.sort != null) {
      results.sort((a, b) => widget.sort(a.value, b.value, _criteria));
    }

    /// 限制每次搜索返回的个数
    results = results.take(widget.limit).toList();

    IconThemeData iconTheme =
        Theme.of(context).iconTheme.copyWith(color: widget.iconColor);

    return new Scaffold(
      appBar: new AppBar(
        leading: widget.leading,
        backgroundColor: widget.barBackgroundColor,
        iconTheme: iconTheme,

        /// 输入框
        title: new TextField(
          controller: _controller,
          autofocus: true,
          decoration:
              new InputDecoration.collapsed(hintText: widget.placeholder),
          style: Theme.of(context).textTheme.title,

          /// 软键盘的右下角显示确定按钮
          onSubmitted: (String value) {
            if (widget.onSubmit != null) {
              widget.onSubmit(value);
            }
          },
        ),

        /// 监听输入框的操作，显示右边的 X 按钮
        actions: _criteria.length == 0
            ? []
            : [
                new IconButton(
                    icon: new Icon(Icons.clear),

                    /// 清空输入框内容
                    onPressed: () {
                      setState(() {
                        _controller.text = _criteria = '';
                      });
                    }),
              ],
      ),

      /// 搜索结果显示页
      body: buildBody(results),
    );
  }
}

/// 搜索结果 item 布局
class MaterialSearchResult<T> extends StatelessWidget {
  const MaterialSearchResult(
      {Key key, this.value, this.text, this.icon, this.onTap})
      : super(key: key);

  final String value;
  final VoidCallback onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: this.onTap,
      child: new Container(
        height: 64.0,
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
        child: new Row(
          children: <Widget>[
            /// 左侧图标
            new Container(
                    width: 30.0,
                    margin: EdgeInsets.only(right: 10),
                    child: new Icon(icon)) ??
                null,
            /// widget 组件名称
            new Expanded(
                child: new Text(value,
                    style: Theme.of(context).textTheme.subhead)),
            /// widget 字
            new Text(text, style: Theme.of(context).textTheme.subhead)
          ],
        ),
      ),
    );
  }
}

class History extends StatefulWidget {
  const History() : super();

  @override
  _History createState() => _History();
}

// AppBar 默认的实例,有状态
class _History extends State<History> {
  SearchHistoryList searchHistoryList = new SearchHistoryList();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 历史记录
  buildChips(BuildContext context) {
    List<Widget> list = [];

    /// 获取历史搜索记录
    List<SearchHistory> historyList = searchHistoryList.getList();
    print("historyList> $historyList");
    Color bgColor = Theme.of(context).primaryColor;
    historyList.forEach((SearchHistory value) {
      Widget icon = CircleAvatar(
        backgroundColor: bgColor,
        child: Text(
          value.name.substring(0, 1),
          style: TextStyle(color: Colors.white),
        ),
      );
      // if (WidgetName2Icon.icons[value.name] != null) {
      //   icon = Icon(WidgetName2Icon.icons[value.name], size: 25);
      // }

      list.add(InkWell(
        onTap: () {
          Application.router.navigateTo(context, "${value.targetRouter}",
              transition: TransitionType.inFromRight);
        },
        child: Chip(
          avatar: icon,
          label: Text("${value.name}"),
        ),
      ));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> childList = buildChips(context);
    if (childList.length == 0) {
      return Center(
        child: Text("当前历史面板为空"),
      );
    }
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(12.0, 12, 12, 0),
          child: InkWell(
            onLongPress: () {
              searchHistoryList.clear();
            },
            child: Text('历史搜索'),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.topLeft,
          child: Wrap(
              spacing: 6.0, // gap between adjacent chips
              runSpacing: 0.0, // gap between lines
              children: childList),
        )
      ],
    );
  }
}
