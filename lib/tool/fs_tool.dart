
class FSTool {
  // 如何解决英文单词被整体截断呢？
  // 将单词的每个字符切割开，插入宽度0的占位字符，打破系统默认的机制，这样就可以以字符为单位省略了
  // 需要注意。这种方式相当于修改了文本的内容，一般文本最大一行显示可以用，如果文本支持2行以及以上的显示的话，
  // 将会导致换行不再按照字符进行而按照单词进行
  static String toCharacterBreakStr(String word) {
    if (word.isEmpty) {
      return word;
    }
    String breakWord = '';
    for (var element in word.runes) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    }
    return breakWord;
  }
}