
# Table of Contents

1.  [git 操作](#org7cd225a)
    1.  [使.gitignore生效](#orgf043557)
    2.  [设置tag](#orgc4f30ea)
2.  [org 操作](#org8feef97)
    1.  [基本操作](#org3f247d7)
    2.  [org-agenda操作](#orgddc817a)
    3.  [表格操作](#org4cb8032)
    4.  [链接操作](#org811b0bc)
        1.  [文件链接](#orgdae532f)
3.  [用hugo写博客](#org9cfca3c)
    1.  [安装 hugo + even主题](#orgf2a14ac)
    2.  [emacs 安装 ox-hugo](#orgc77319e)
    3.  [eglot](#org6598859)
    4.  [](#orge6a8f09)
4.  [detail](#orgb9d11b2)
    1.  [org-insert-heading-respect-content](#orga87d256)
5.  [Workspace](#orgb347db6)
    1.  [Daily routine <code>[0%]</code>](#orga252564):Learn:
    2.  [Learn Emacs](#org179c86d):Emacs:



<a id="org7cd225a"></a>

# git 操作


<a id="orgf043557"></a>

## 使.gitignore生效

    ~/.emacs.d $ git rm -r –-cached . #清除缓存
    ~/.emacs.d $ git add . #重新按照ignore的规则add所有的文件
    ~/.emacs.d $ git commit -m “update .gitignore” #提交和注释


<a id="orgc4f30ea"></a>

## 设置tag

    git tag [tagName]   # 创建tag, 名称为tagName
    git push origin [tagName] #推送到远端仓库


<a id="org8feef97"></a>

# org 操作


<a id="org3f247d7"></a>

## 基本操作

1.  使用\*设置标题级别
2.  设置任务状态: C-c C-t org-todo
3.  设置check boxes
4.  设置结束时间: C-c C-d org-deadline
5.  换行（格式同上一行）：org-mata-return
6.  设置logbook

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">操作名</th>
<th scope="col" class="org-left">指令</th>
<th scope="col" class="org-left">快捷键</th>
<th scope="col" class="org-left">detail</th>
<th scope="col" class="org-left">&#xa0;</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">插入同级标题</td>
<td class="org-left">org-insert-heading-respect-content</td>
<td class="org-left">C-RET</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">插入次级标题</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">标题级别变更</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">标题树级别变更</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>

<>


<a id="orgddc817a"></a>

## org-agenda操作

1.  设置持续时间(格式: 00:xx): e org-agenda-set-effort
2.  过滤持续时间: \_ org-agenda-filter-by-effort
3.  设置tag: : org-agenda-set-tags


<a id="org4cb8032"></a>

## 表格操作

一定一定要学会使用表格，表格更加直观，可以在表格中增加链接，链接到详细说明处。
如果使用evil-mode，可能有些快捷键不起作用，但是指令还是可以使用

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">&#xa0;</th>
<th scope="col" class="org-left">操作名</th>
<th scope="col" class="org-left">指令</th>
<th scope="col" class="org-left">快捷键</th>
<th scope="col" class="org-left">备注</th>
<th scope="col" class="org-left">其他</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">基础操作</td>
<td class="org-left">创建表格</td>
<td class="org-left">org-table-create</td>
<td class="org-left">C-c &vert;</td>
<td class="org-left">可以指定表格大小比如 4x3</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">遍历表格</td>
<td class="org-left">org-cycle</td>
<td class="org-left">TAB</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">反向遍历</td>
<td class="org-left">org-shiftab</td>
<td class="org-left">S-TAB</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">插入行</td>
<td class="org-left">org-table-insert-row</td>
<td class="org-left">RET</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">插入分隔行</td>
<td class="org-left">org-table-insert-hline</td>
<td class="org-left">C-c -</td>
<td class="org-left">org-ctrl-c-minus</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">插入列</td>
<td class="org-left">org-table-insert-column</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">整行上移</td>
<td class="org-left">org-metaup</td>
<td class="org-left">M-&lt;up&gt;</td>
<td class="org-left">up为向向上键</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">整行下移</td>
<td class="org-left">org-metadown</td>
<td class="org-left">M-&lt;down&gt;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">整列左移</td>
<td class="org-left">org-metaleft</td>
<td class="org-left">M-&lt;left&gt;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">整列右移</td>
<td class="org-left">org-metaright</td>
<td class="org-left">M-&lt;right&gt;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">当前内容下移</td>
<td class="org-left">org-meta-return</td>
<td class="org-left">M-RET</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left">进阶操作</td>
<td class="org-left">插入静态时间戳</td>
<td class="org-left">org-time-stamp-inactive</td>
<td class="org-left">C-c !</td>
<td class="org-left">时间戳不会改变</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">插入动态时间戳</td>
<td class="org-left">org-time-stamp</td>
<td class="org-left">C-c .</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>


<a id="org811b0bc"></a>

## 链接操作

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">操作名</th>
<th scope="col" class="org-left">指令</th>
<th scope="col" class="org-left">快捷键</th>
<th scope="col" class="org-left">备注</th>
<th scope="col" class="org-left">&#xa0;</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">创建链接</td>
<td class="org-left">org-insert-link</td>
<td class="org-left">C-c C-l</td>
<td class="org-left">可以直接按照格式写</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">展开链接</td>
<td class="org-left">org-toggle-link-display</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">跳转到链接</td>
<td class="org-left">org-open-at-point</td>
<td class="org-left">C-c C-o</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">补全</td>
<td class="org-left">completion-at-point</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">[[*]特殊操作</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>


<a id="orgdae532f"></a>

### 文件链接

我第一次想用链接，是在使用表格的时候，表格的有点是直观，缺点就是可容纳信息较少，所以我想着，把
复杂的内容单独写在一个headline中，在增加一个链接方便跳转。
网上的资料大都不太全，所以最终还是找到官方文档：

1.  <https://orgmode.org/manual/Link-Format.html>
2.  <https://orgmode.org/manual/Internal-Links.html>
3.  <https://orgmode.org/manual/Search-Options.html>

如果从来没用用过 org-mode 的 Hyperlinks可以先看第一篇文章。
简单来说链接其实就是特殊的纯文本：

    [[LINK][DESCRIPTION]]
    
    举例：
    1. [[http://www.baidu.com][这个链接会指向百度]]
    2. [[file::~/code/main.cc][这个链接指向一个本地文件]]

"LINK" 表示链接内容， DESCRIPTION 为用来展示的名字, 跳转是通过指令org-open-at-point。

紧接着第二篇文章，就讲了内部链接，我没太看懂，而且实践也没有成功。
这里简单总结一下，说不定以后就能明白了：

    主要格式为以下三种
    1. [[#my-custom-id]]
    2. [[*some section]]
    3. [[target]] 

三种格式，
my-custom-id应该是一种特定的id,但是我不知道怎么设置

\*some section 就是指一个标题(headline)，文章里还提到了一种简单写法，即先写括号和星号,然后按 M-TAB,
所有的标题就会出现在一个 buffer 中，然后选择想要的即可。
原文：
To insert a link targeting a headline, in-buffer completion can be used. Just type a star followed by a few optional letters into the buffer and press M-TAB.
All headlines in the current buffer are offered as completions.

第三种格式，target 即表示一个标记，只要在两个尖括号你的内容都可以是一个标记

    比如这篇文章有如下两行：
    <<这是一个标记>>
    [[这是一个标记]]  那么这个链接就会跳到上面那一行

但是我没有成功过。

第三篇文章讲的是文件链接，其实内部链接也是文件链接的一种，我尝试了一下，确实可行。

    举例：
    [[file:~/code/main.c::255]]
    [[file:~/xx.org::My Target]]
    [[file:~/xx.org::*My Target]]
    [[file:~/xx.org::#my-custom-id]]
    [[file:~/xx.org::/regexp/]]
    [[attachment:main.c::255]]

主要是多了一个file前缀，应该很好理解，那么我想链接到当前文件的某个标题可以这样：

    * headline1
    ** 1.1
    ** 1.2
    ** 这是 1.3
    * headline2
    ** 2.1
    
    [[file:::1.1]]  这个会跳转到  "标题1.1"
    [[file:::这是 1.3]] 这个会跳转到标题 "这是 1.3"

最终发现其实很简单，不过目前也只会跳转到标题，其他的花里胡哨的功能还不会


<a id="org9cfca3c"></a>

# 用hugo写博客


<a id="orgf2a14ac"></a>

## 安装 hugo + even主题


<a id="orgc77319e"></a>

## emacs 安装 ox-hugo

1.  <https://github.com/kaushalmodi/ox-hugo>
2.  org 转换成 markdown， author设置


<a id="org6598859"></a>

## eglot


<a id="orge6a8f09"></a>

## 


<a id="orgb9d11b2"></a>

# detail


<a id="orga87d256"></a>

## org-insert-heading-respect-content

这个指令会插入同级标题，会往上找到距离当前光标最近的标题，然后插入同级标题。
大家可以自行尝试，在文章的一级/二级/ 三级标题处，正文处分别按下C-RET 快捷键盘看看效果。


<a id="orgb347db6"></a>

# Workspace


<a id="orga252564"></a>

## Daily routine <code>[0%]</code>     :Learn:

:LOGBOOK: - State "DONE"       from              <span class="timestamp-wrapper"><span class="timestamp">[2023-10-02 一 18:53]</span></span>

-   State "DONE"       from              <span class="timestamp-wrapper"><span class="timestamp">[2023-10-02 一 18:53]</span></span>

:END:

-   [ ] leetcode
-   [ ] exercise
-   [ ] coding


<a id="org179c86d"></a>

## TODO Learn Emacs     :Emacs:

<span class="timestamp-wrapper"><span class="timestamp">[2023-10-07 六 18:49]</span></span>

