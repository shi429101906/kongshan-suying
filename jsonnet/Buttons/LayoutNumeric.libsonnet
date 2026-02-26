# =====================================
# 此文件用于自定义键盘按键功能。
# 可根据需要修改下方内容，调整各类按键的行为
# 修改完成后，保存本文件，然后回到皮肤界面，
# 长按皮肤，选择「运行 main.jsonnet」生效。
#
# 包含九宫格数字键盘和行式数字键盘中的按键
# =====================================

local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local settings = import '../Settings.libsonnet';

{
  local root = self,

  // 数字键
  oneButton: {
    name: 'oneButton',
    params: {
      action: { character: '1' },
    },
  },
  twoButton: {
    name: 'twoButton',
    params: {
      action: { character: '2' },
    },
  },
  threeButton: {
    name: 'threeButton',
    params: {
      action: { character: '3' },
    },
  },
  fourButton: {
    name: 'fourButton',
    params: {
      action: { character: '4' },
    },
  },
  fiveButton: {
    name: 'fiveButton',
    params: {
      action: { character: '5' },
    },
  },
  sixButton: {
    name: 'sixButton',
    params: {
      action: { character: '6' },
    },
  },
  sevenButton: {
    name: 'sevenButton',
    params: {
      action: { character: '7' },
    },
  },
  eightButton: {
    name: 'eightButton',
    params: {
      action: { character: '8' },
    },
  },
  nineButton: {
    name: 'nineButton',
    params: {
      action: { character: '9' },
    },
  },
  zeroButton: {
    name: 'zeroButton',
    params: {
      action: { character: '0' },
    },
  },

  numericButtons: [
    self.oneButton, self.twoButton, self.threeButton,
    self.fourButton, self.fiveButton, self.sixButton,
    self.sevenButton, self.eightButton, self.nineButton,
    self.zeroButton,
  ],

  // 数字键盘空格
  numericSpaceButton: {
    name: 'numericSpaceButton',
    params: {
      action: 'space',
      systemImageName: 'space',
    },
  },

  // 数字键盘等号
  numericEqualButton: {
    name: 'numericEqualButton',
    params: {
      // 在我的方案中，这个符号是计算器前缀符号，所以用 character 而不是 symbol
      action: { character: '=' },
    },
  },

  // 数字键盘冒号
  numericColonButton: {
    name: 'numericColonButton',
    params: {
      action: { symbol: ':' },
    },
  },

  // 数字键小数点符号
  dotButton: {
    name: 'dotButton',
    params: {
      action: { symbol: '.' },

      // 使用方案中的计算器时，通常会有一个计算器前缀（或算式）在 preedit 中，
      // 此时就把小数点交给 rime 处理
      whenPreeditChanged: { action: { character: '.' } }
    },
  },

  // 数字键盘符号列表
  numericSymbolsCollection: {
    name: 'numericSymbolsCollection',
    params: {
      type: 'numericSymbols',
    },
  },

  // 数字键盘横向时全部部分视图
  numericCategorySymbolCollection: {
    name: 'numericCategorySymbolCollection',
    params: {
      type: 'categorySymbols',
    },
  },

  // 以下符号是给“行式布局”的数字键盘使用的
  // 连接号(减号)
  hyphenButton: {
    name: 'hyphenButton',
    params: {
      action:
        // 注音布局的数字键盘中，此符号被注音方案占用，所以用 symbol 直接上屏
        if settings.keyboardLayout=='bopomofo' then
          { symbol: '-' }
        else
          { character: '-' },
    },
  },
  // 斜杠
  forwardSlashButton: {
    name: 'forwardSlashButton',
    params: {
      action: { symbol: '/' },
    },
  },
  // 冒号
  colonButton: {
    name: 'colonButton',
    params: {
      action: { character: ':' },
    },
  },

  // 中文冒号
  chineseColonButton: {
    name: 'chineseColonButton',
    params: {
      action: { symbol: '：' },
    },
  },

  // 分号
  semicolonButton: {
    name: 'semicolonButton',
    params: {
      action: { character: ';' },
    },
  },

  // 中文分号
  chineseSemicolonButton: {
    name: 'chineseSemicolonButton',
    params: {
      action: { symbol: '；' },
    },
  },

  // 左括号
  leftParenthesisButton: {
    name: 'leftParenthesisButton',
    params: {
      action: { character: '(' },
    },
  },

  // 右括号
  rightParenthesisButton: {
    name: 'rightParenthesisButton',
    params: {
      action: { character: ')' },
    },
  },

  // 中文左括号
  leftChineseParenthesisButton: {
    name: 'leftChineseParenthesisButton',
    params: {
      action: { symbol: '（' },
    },
  },

  // 中文右括号
  rightChineseParenthesisButton: {
    name: 'rightChineseParenthesisButton',
    params: {
      action: { symbol: '）' },
    },
  },

  // 美元符号
  dollarButton: {
    name: 'dollarButton',
    params: {
      action: { symbol: '$' },
    },
  },

  // 人民币符号
  rmbButton: {
    name: 'rmbButton',
    params: {
      action: { symbol: '¥' },
    },
  },

  // 地址符号
  atButton: {
    name: 'atButton',
    params: {
      action: { symbol: '@' },
    },
  },

  // “ 双引号(有方向性的引号)
  leftCurlyQuoteButton: {
    name: 'leftCurlyQuoteButton',
    params: {
      action: { symbol: '“' },
    },
  },
  // ” 双引号(有方向性的引号)
  rightCurlyQuoteButton: {
    name: 'rightCurlyQuoteButton',
    params: {
      action: { symbol: '”' },
    },
  },
  // " 直引号(没有方向性的引号)
  straightQuoteButton: {
    name: 'straightQuoteButton',
    params: {
      action: { symbol: '"' },
    },
  },

  // '*' 符号
  asteriskButton: {
    name: 'asteriskButton',
    params: {
      action: { character: '*' },
    },
  },
  // + 符号
  plusButton: {
    name: 'plusButton',
    params: {
      action: { character: '+' },
    },
  },
  chineseCommaButton: {
    name: 'chineseCommaButton',
    params: {
      action: { symbol: '，' },
      swipeUp: { action: { symbol: '。' } },
    },
  },
  chinesePeriodButton: {
    name: 'chinesePeriodButton',
    params: {
      action: { symbol: '。' },
    },
  },
  periodButton: {
    name: 'periodButton',
    params: {
      action: { character: '.' },
      swipeUp: { action: { character: ',' } },
    },
  },

  // 顿号(只在中文中使用)
  ideographicCommaButton: {
    name: 'ideographicCommaButton',
    params: {
      action: { symbol: '、' },
    },
  },
  // 中文问号
  chineseQuestionMarkButton: {
    name: 'questionMarkButton',
    params: {
      action: { symbol: '？' },
    },
  },
  // 英文问号
  questionMarkButton: {
    name: 'questionMarkEnButton',
    params: {
      action: { symbol: '?' },
    },
  },
  // 中文感叹号
  chineseExclamationMarkButton: {
    name: 'chineseExclamationMarkButton',
    params: {
      action: { symbol: '！' },
    },
  },
  // 英文感叹号
  exclamationMarkButton: {
    name: 'exclamationMarkButton',
    params: {
      action: { symbol: '!' },
    },
  },
  // ' 直撇号(单引号)
  apostropheButton: {
    name: 'apostropheButton',
    params: {
      action: { symbol: "'" },
    },
  },
  // 中文左单引号(有方向性的单引号)
  leftSingleQuoteButton: {
    name: 'leftSingleQuoteButton',
    params: {
      action: { symbol: '‘' },
      swipeUp: { action: { symbol: '“' } },
    },
  },
  // 中文右单引号(有方向性的单引号)
  rightSingleQuoteButton: {
    name: 'rightSingleQuoteButton',
    params: {
      action: { symbol: '’' },
    },
  },
  // 井号
  hashButton: {
    name: 'hashButton',
    params: {
      action: { symbol: '#' },
    },
  },
}
