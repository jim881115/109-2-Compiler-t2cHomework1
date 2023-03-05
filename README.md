# Programming Languages and Compilers t2c Homework 1
## Question decription
Use lex (or flex) and yacc (or bison) to implement a front end (including a lexical analyzer and a syntax recognizer) of the compiler for the T language.
* See an attached file for the lexical rules in details.
* You are requested to separate the C code, the Lex specification, the Yacc specification into distinct files.

# Report
## Problem description
　　使用 flex 和 bison 實現 T 語言編譯器(包含詞法分析器和語法識別器)

## Highlight of the way you write the program
　　只要修改老師給的資料夾裡的 t_lex.l 與 t_parse.y
* t_lex.l
　　<br/>token 在上方已經宣告好了，如下圖，只需要照著對應的名稱新增即可
![](https://i.imgur.com/p50OX5T.png)
　　<br/>須注意 ID、DIG 與 RNUM 因為是集合，所以要用大括弧 {} 包住。如下圖增加了三行
![](https://i.imgur.com/XLK14Yd.png)
* t_parse.y
　　<br/>這部分就照著講義上的規則打就好了，需要注意的部分就是有遞迴的地方須要想一下怎麼打，老師打好的部分也有遞迴範例可以參考。還有也要注意有 * 號與中括弧 [] 的部分，基本上就是仔細的一步一步打就沒問題。

## The program listing
* t_lex.l
* t_parse.y

## Test run results
　　將上面兩個檔案完成後，接下來要進行 parse，但在 parse 前需照著講義完成以下步驟：
1. 用 bison 將 t_parse.y 編譯成 t_parse.c 和生成標頭檔 t_parse.h
2. 用 flex 將 t_lex.l 編譯成 t_lex.c
3. 用 gcc 將 t_parse.c、t_lex.c 與 t2c.c 分別編譯成 t_parse.o、t_lex.o 與 t2c.o
4. 用 gcc 將 3.編譯後的.o 檔進行 link
5. 接下來打上 parse test.t 即可進行 parse
　　<br/>對 test.t parse 結果如下圖
<br/>![](https://i.imgur.com/vJndRQu.png)
<br/>過程略...
<br/>![](https://i.imgur.com/WeCFyHw.png)
　　<br/>結果是 Parsed OK！

## Discussion
　　在打 t_parse.y 時非常混亂，因為規則蠻多條的，要非常細心。在最後進行 parse 時一直出現 syntax error，回去找也找不到問題，在與同學討論後才發現，
我在打<PrimaryExpr -> Num>這條規則時，Integer or Real numbers 不是用上面定義的名稱，然後沒發現，就一直找不到問題在哪。其他的遞迴部分只要想一
下就打出來了。<br/>
　　而在打 t_lex.l 時，原本在 return 前沒有打上 sscanf，之後再與同學討論後才知道那也要打上，才解決問題成功進行 parse。
