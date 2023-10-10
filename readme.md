
# Table of Contents

1.  [git 操作](#org05be72a)
    1.  [使.gitignore生效](#org80916c2)
    2.  [设置tag](#orga7ca2ec)
2.  [org 操作](#org5ea0aea)
    1.  [基本操作](#orgbd32f6e)
    2.  [org-agenda操作](#orgd112c8a)
    3.  [表格操作](#orgacec073)
3.  [用hugo写博客](#org8b4a862)
    1.  [安装 hugo + even主题](#org7fae1e6)
    2.  [emacs 安装 ox-hugo](#org2c92f35)
    3.  [eglot](#org3bdac42)
4.  [Workspace](#orgea2687f)
    1.  [Daily routine <code>[0%]</code>](#orgfb4f62d):Learn:
    2.  [Learn Emacs](#org55cb487):Emacs:


<a id="org05be72a"></a>

# git 操作


<a id="org80916c2"></a>

## 使.gitignore生效

-   State "WAITING"    from              <span class="timestamp-wrapper"><span class="timestamp">[2023-10-02 一 18:44] </span></span>   
    there is a meeting

    ~/.emacs.d $ git rm -r –-cached . #清除缓存
    ~/.emacs.d $ git add . #重新按照ignore的规则add所有的文件
    ~/.emacs.d $ git commit -m “update .gitignore” #提交和注释


<a id="orga7ca2ec"></a>

## 设置tag

    git tag [tagName]   # 创建tag, 名称为tagName
    git push origin [tagName] #推送到远端仓库


<a id="org5ea0aea"></a>

# org 操作


<a id="orgbd32f6e"></a>

## 基本操作

1.  使用\*设置标题级别
2.  设置任务状态: C-c C-t org-todo
3.  设置check boxes
4.  设置开始时间: C-c C-s org-schedule
5.  设置结束时间: C-c C-d org-deadline
6.  换行（格式同上一行）：org-mata-return
7.  设置logbook


<a id="orgd112c8a"></a>

## org-agenda操作

1.  设置持续时间(格式: 00:xx): e org-agenda-set-effort
2.  过滤持续时间: \_ org-agenda-filter-by-effort
3.  设置tag: : org-agenda-set-tags


<a id="orgacec073"></a>

## 表格操作

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
<th scope="col" class="org-left">&#xa0;</th>
<th scope="col" class="org-left">&#xa0;</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">创建表格</td>
<td class="org-left">org-table-create</td>
<td class="org-left">C-c &vert;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>


<a id="org8b4a862"></a>

# 用hugo写博客


<a id="org7fae1e6"></a>

## 安装 hugo + even主题


<a id="org2c92f35"></a>

## emacs 安装 ox-hugo

1.  <https://github.com/kaushalmodi/ox-hugo>
2.  org 转换成 markdown， author设置


<a id="org3bdac42"></a>

## eglot


<a id="orgea2687f"></a>

# Workspace


<a id="orgfb4f62d"></a>

## Daily routine <code>[0%]</code>     :Learn:

:LOGBOOK: - State "DONE"       from              <span class="timestamp-wrapper"><span class="timestamp">[2023-10-02 一 18:53]</span></span>

-   State "DONE"       from              <span class="timestamp-wrapper"><span class="timestamp">[2023-10-02 一 18:53]</span></span>

:END:

-   [ ] leetcode
-   [ ] exercise
-   [ ] coding


<a id="org55cb487"></a>

## TODO Learn Emacs     :Emacs:

<span class="timestamp-wrapper"><span class="timestamp">[2023-10-07 六 18:49]</span></span>

