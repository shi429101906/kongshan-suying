local iPhonePinyin = import 'Components/iPhonePinyin.libsonnet';
local temp26KeyLayout = import 'Components/Temp26KeyLayout.libsonnet';
local iPhoneAlphabetic = import 'Components/iPhoneAlphabetic.libsonnet';
local iPhoneNumeric = import 'Components/iPhoneNumeric.libsonnet';
local iPhoneNumericRowEn = import 'Components/iPhoneNumericRowEn.libsonnet';
local floatingKeyboard = import 'Components/FloatingKeyboard.libsonnet';
local settings = import 'Settings.libsonnet';

local lightFloatingKeyboardPortraitContent = floatingKeyboard.new(isDark=false, isPortrait=true);
local darkFloatingKeyboardPortraitContent = floatingKeyboard.new(isDark=true, isPortrait=true);
local lightFloatingKeyboardLandscapeContent = floatingKeyboard.new(isDark=false, isPortrait=false);
local darkFloatingKeyboardLandscapeContent = floatingKeyboard.new(isDark=true, isPortrait=false);


local nameToComponent = {
  pinyin: iPhonePinyin,
  alphabetic: iPhoneAlphabetic,
  numeric: iPhoneNumeric,
  [if !std.startsWith(settings.keyboardLayout, '26') then 'temp26Key']: temp26KeyLayout,
  [if settings.numericLayout == 'row' then 'numericRowEn']: iPhoneNumericRowEn,
};

local getFileName(componentName, isPortrait) = componentName + (if isPortrait then 'Portrait' else 'Landscape');
local getFileContent(component, isDark, isPortrait) = component.new(isDark, isPortrait);


local config = {
  [name]: {
    iPhone: {
      portrait: getFileName(name, isPortrait=true),
      landscape: getFileName(name, isPortrait=false),
    },
    iPad: {
      portrait: getFileName(name, isPortrait=true),
      landscape: getFileName(name, isPortrait=false),
      floating: getFileName(name, isPortrait=true),
    },
  } for name in std.objectFields(nameToComponent) + std.objectFields(lightFloatingKeyboardPortraitContent)
};

// std.toString 生成的内容紧凑，生成速度快，但不易阅读，适合发布时使用
// std.manifestYamlDoc 生成的内容格式化良好，易于阅读，但生成速度慢，也更占用内存，适合在电脑上调试时使用
// 如果想让 debug=true，需要在命令行中使用 --tla-code debug=true 参数传入
function(debug=false)
  local toString =
    if debug then
      function(x) std.manifestYamlDoc(x, indent_array_in_object=false, quote_keys=false)
    else
      function(x) std.toString(x);
{
  'config.yaml': std.manifestYamlDoc(config, indent_array_in_object=true, quote_keys=false),
} + {
  ['light/' + getFileName(name, isPortrait=true) + '.yaml']: toString(getFileContent(nameToComponent[name], isDark=false, isPortrait=true))
  for name in std.objectFields(nameToComponent)
} + {
  ['dark/' + getFileName(name, isPortrait=true) + '.yaml']: toString(getFileContent(nameToComponent[name], isDark=true, isPortrait=true))
  for name in std.objectFields(nameToComponent)
} + {
  ['light/' + getFileName(name, isPortrait=false) + '.yaml']: toString(getFileContent(nameToComponent[name], isDark=false, isPortrait=false))
  for name in std.objectFields(nameToComponent)
} + {
  ['dark/' + getFileName(name, isPortrait=false) + '.yaml']: toString(getFileContent(nameToComponent[name], isDark=true, isPortrait=false))
  for name in std.objectFields(nameToComponent)
} + {
  // 浮动键盘 light Portrait
  ['light/' + name + 'Portrait.yaml']: toString(lightFloatingKeyboardPortraitContent[name])
  for name in std.objectFields(lightFloatingKeyboardPortraitContent)
} + {
  // 浮动键盘 dark Portrait
  ['dark/' + name + 'Portrait.yaml']: toString(darkFloatingKeyboardPortraitContent[name])
  for name in std.objectFields(darkFloatingKeyboardPortraitContent)
} + {
  // 浮动键盘 light Landscape
  ['light/' + name + 'Landscape.yaml']: toString(lightFloatingKeyboardLandscapeContent[name])
  for name in std.objectFields(lightFloatingKeyboardLandscapeContent)
} + {
  // 浮动键盘 dark Landscape
  ['dark/' + name + 'Landscape.yaml']: toString(darkFloatingKeyboardLandscapeContent[name])
  for name in std.objectFields(darkFloatingKeyboardLandscapeContent)
}
