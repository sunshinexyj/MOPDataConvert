//
//  MOPDataConvert.m
//  PackTest
//
//  Created by yiju on 13-4-2.
//  Copyright (c) 2013年 com.sunyard. All rights reserved.
//

#import "MOPDataConvert.h"

@implementation MOPDataConvert

//从字符串中取字节数组(将HEX转换为BCD)
+(NSData*)HEXToBCD:(NSString*)string
{
    NSString *hexString=[[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0) {
        return nil;
    }
    Byte tempbyt[1]={0};
    NSMutableData* bytes=[NSMutableData data];
    for(int i=0;i<[hexString length];i++)
    {
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            return nil;
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            return nil;
        
        tempbyt[0] = int_ch1+int_ch2;  ///将转化后的数放入Byte数组里
        [bytes appendBytes:tempbyt length:1];
    }
    return bytes;
}

//BCD码转换为十六进制数
+(NSString*)BCDToHEX:(NSData*)data
{
    Byte* byt=(Byte*)[data bytes];
    
    NSString* ret=@"";
    for (int i=0; i<[data length]; i++) {
        //将byte中的高低4位分别转为char添加到返回数据中
        ret=[ret stringByAppendingFormat:@"%c", [self BCD2Char:(byt[i]>>4)]];
        ret=[ret stringByAppendingFormat:@"%c", [self BCD2Char:byt[i]]];
    }
    return ret;
}


//一个BCD码转为hex中的char 只取传入参数的低4位
+(char)BCD2Char:(Byte)byt{
    byt=byt & 0x0f;
    switch (byt) {
        case 10:
            return 'A';
            break;
        case 11:
            return 'B';
            break;
        case 12:
            return 'C';
            break;
        case 13:
            return 'D';
            break;
        case 14:
            return 'E';
            break;
        case 15:
            return 'F';
            break;
        default:
            return byt+'0';
            break;
    }
}

//将HEX转化为可显示的字符
+(NSString*)HEXToUTF8:(NSString*)string
{
    NSData* bcd=[self HEXToBCD:string];
    char* temp=malloc(([bcd length]+1)*sizeof(char));
    memset(temp, 0, ([bcd length]+1)*sizeof(char));
    memcpy(temp, [bcd bytes], [bcd length]);
    NSString *str = [NSString stringWithUTF8String:temp];
    free(temp);
    return str;
}

//将可显示字符转化为HEX
+(NSString*)UTF8ToHEX:(NSString*)string
{
    char* temp=(char*)[string UTF8String];
    NSData* data=[NSData dataWithBytes:temp length:[string length]];
    return [self BCDToHEX:data];
    
}

@end
