MOPDataConvert
==============

* a simple tool convert between bytes and BCD code. 
* written in Objective-C for IOS.


##APIS
```
//BCD码转换为十六进制数
+(NSString*)BCDToHEX:(NSData*)data;

//从字符串中取字节数组(将HEX转换为BCD)
+(NSData*)HEXToBCD:(NSString*)string;

//将HEX转化为可显示的字符
+(NSString*)HEXToUTF8:(NSString*)string;

//将可显示字符转化为HEX
+(NSString*)UTF8ToHEX:(NSString*)string;
```

