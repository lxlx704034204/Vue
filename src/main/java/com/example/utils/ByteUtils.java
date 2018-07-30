package com.example.utils;

//import method.TimeToBCD;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class ByteUtils {
    private static ByteBuffer buffer = ByteBuffer.allocate(8);

    /**
     * 构造新字节时需要与的值表
     * @author jayxu
     */
    private static final byte[] BUILD_BYTE_TABLE = new byte[]{(byte) 128, (byte) 64, (byte) 32, (byte) 16, (byte) 8, (byte) 4, (byte) 2, (byte) 1};

    private static final char[] HEX_CHAR = {'0', '1', '2', '3', '4', '5',
            '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};

    private ByteUtils() {
    }

    /**
     * short转换到字节数组
     *
     * @param number 需要转换的数据。
     * @return 转换后的字节数组。
     */
    public static byte[] shortToByteArr(short number) {
        byte[] b = new byte[2];
        for (int i = 1; i >= 0; i--) {
            b[i] = (byte) (number % 256);
            number >>= 8;
        }
        return b;
    }

    /**
     * short转byte[]
     *
     * @param b
     * @param s
     * @param index
     */
    public static void byteArrToShort(byte b[], short s, int index) {
        b[index + 1] = (byte) (s >> 8);
        b[index + 0] = (byte) (s >> 0);
    }

    /**
     * 字节到short转换
     *
     * @param b short的字节数组
     * @return short数值。
     */
    public static short byteToShort(byte[] b) {
        return (short) ((((b[0] & 0xff) << 8) | b[1] & 0xff));
    }

    /**
     * 整型转换到字节数组
     *
     * @param number 整形数据。
     * @return 整形数据的字节数组。
     */
    public static byte[] intToByteArr(int number) {
        byte[] b = new byte[4];
        for (int i = 3; i >= 0; i--) {
            b[i] = (byte) (number % 256);
            number >>= 8;
        }
        return b;
    }
    /**
     * int转byte
     * @param x
     * @return
     */
    public static byte intToByte(int x) {
        return (byte) x;
    }
    /**
     * 字节数组到整型转换
     *
     * @param b 整形数据的字节数组。
     * @return 字节数组转换成的整形数据。
     */
    public static int byteArrToInt(byte[] b) {
        return ((((b[0] & 0xff) << 24) | ((b[1] & 0xff) << 16) | ((b[2] & 0xff) << 8) | (b[3] & 0xff)));
    }
    /**
     * byte转int
     * @param b
     * @return
     */
    public static int byteToInt(byte b) {
        //Java的byte是有符号，通过 &0xFF转为无符号
        return b & 0xFF;
    }
    /**
     * long转换到字节数组
     *
     * @param number 长整形数据。
     * @return 长整形转换成的字节数组。
     */
    public static byte[] longToByteArr(long number) {
        byte[] b = new byte[8];
        for (int i = 7; i >= 0; i--) {
            b[i] = (byte) (number % 256);
            number >>= 8;
        }
        return b;
    }

    /**
     * 字节数组到整型的转换
     *
     * @param b 长整形字节数组。
     * @return 长整形数据。
     */
    public static long byteArrToLong(byte[] b) {
        return ((((long) b[0] & 0xff) << 56) | (((long) b[1] & 0xff) << 48) | (((long) b[2] & 0xff) << 40) | (((long) b[3] & 0xff) << 32) | (((long) b[4] & 0xff) << 24)
                | (((long) b[5] & 0xff) << 16) | (((long) b[6] & 0xff) << 8) | ((long) b[7] & 0xff));
        //or

//        buffer.put(b, 0, b.length);
//        buffer.flip();//need flip
//        return buffer.getLong();
    }

    /**
     * double转换到字节数组
     *
     * @param d 双精度浮点。
     * @return 双精度浮点的字节数组。
     */
    public static byte[] doubleToByte(double d) {
        byte[] bytes = new byte[8];
        long l = Double.doubleToLongBits(d);
        for (int i = 0; i < bytes.length; i++) {
            bytes[i] = Long.valueOf(l).byteValue();
            l = l >> 8;
        }
        return bytes;
    }

    /**
     * 字节数组到double转换
     *
     * @param b 双精度浮点字节数组。
     * @return 双精度浮点数据。
     */
    public static double byteToDouble(byte[] b) {
        long l;
        l = b[0];
        l &= 0xff;
        l |= ((long) b[1] << 8);
        l &= 0xffff;
        l |= ((long) b[2] << 16);
        l &= 0xffffff;
        l |= ((long) b[3] << 24);
        l &= 0xffffffffl;
        l |= ((long) b[4] << 32);
        l &= 0xffffffffffl;

        l |= ((long) b[5] << 40);
        l &= 0xffffffffffffl;
        l |= ((long) b[6] << 48);
        l &= 0xffffffffffffffl;

        l |= ((long) b[7] << 56);

        return Double.longBitsToDouble(l);
    }

    /**
     * float转换到字节数组
     *
     * @param d 浮点型数据。
     * @return 浮点型数据转换后的字节数组。
     */
    public static byte[] floatToByte(float d) {
        byte[] bytes = new byte[4];
        int l = Float.floatToIntBits(d);
        for (int i = 0; i < bytes.length; i++) {
            bytes[i] = Integer.valueOf(l).byteValue();
            l = l >> 8;
        }
        return bytes;
    }

    /**
     * 字节数组到float的转换
     *
     * @param b 浮点型数据字节数组。
     * @return 浮点型数据。
     */
    public static float byteToFloat(byte[] b) {
        int l;
        l = b[0];
        l &= 0xff;
        l |= ((long) b[1] << 8);
        l &= 0xffff;
        l |= ((long) b[2] << 16);
        l &= 0xffffff;
        l |= ((long) b[3] << 24);
        l &= 0xffffffffl;

        return Float.intBitsToFloat(l);
    }

    /**
     * 字符串到字节数组转换
     *
     * @param s       字符串。
     * @param charset 字符编码
     * @return 字符串按相应字符编码编码后的字节数组。
     */
    public static byte[] stringToByte(String s, Charset charset) {
        return s.getBytes(charset);
    }

    /**
     * 字节数组带字符串的转换
     *
     * @param b       字符串按指定编码转换的字节数组。
     * @param charset 字符编码。
     * @return 字符串。
     */
    public static String byteArrToString(byte[] b, Charset charset) {
        return new String(b, charset);
    }

    /**
     * 对象转换成字节数组。
     *
     * @param obj 字节数组。
     * @return 对象实例相应的序列化后的字节数组。
     * @throws IOException
     */
    public static byte[] objectToByte(Object obj) throws IOException {
        ByteArrayOutputStream buff = new ByteArrayOutputStream();
        ObjectOutputStream out = new ObjectOutputStream(buff);
        out.writeObject(obj);
        try {
            return buff.toByteArray();
        } finally {
            out.close();
        }
    }

    /**
     * 序死化字节数组转换成实际对象。
     *
     * @param b 字节数组。
     * @return 对象。
     * @throws IOException
     * @throws ClassNotFoundException
     */
    public static Object byteToObject(byte[] b) throws IOException, ClassNotFoundException {
        ByteArrayInputStream buff = new ByteArrayInputStream(b);
        ObjectInputStream in = new ObjectInputStream(buff);
        Object obj = in.readObject();
        try {
            return obj;
        } finally {
            in.close();
        }
    }

    /**
     * 比较两个字节的每一个bit位是否相等.
     *
     * @param a 比较的字节.
     * @param b 比较的字节
     * @return ture 两个字节每一位都相等,false有至少一位不相等.
     */
    public static boolean equalsByte(byte a, byte b) {
        return Arrays.equals(byteToBitArray(a), byteToBitArray(b));
    }

    /**
     * 比较两个数组中的每一个字节,两个字节必须二进制字节码每一位都相同才表示两个 byte相同.
     *
     * @param a 比较的字节数组.
     * @param b 被比较的字节数.
     * @return ture每一个元素的每一位两个数组都是相等的, false至少有一位不相等.
     */
    public static boolean equalsByteArr(byte[] a, byte[] b) {
        if (a == b) {
            return true;
        }
        if (a == null || b == null) {
            return false;
        }

        int length = a.length;
        if (b.length != length) {
            return false;
        }

        for (int count = 0; count < a.length; count++) {
            if (!equalsByte(a[count], b[count])) {
                return false;
            }
        }
        return true;
    }

    /**
     * 返回某个字节的bit组成的字符串.
     *
     * @param b 字节.
     * @return Bit位组成的字符串.
     */
    public static String bitString(byte b) {
        StringBuilder buff = new StringBuilder();
        boolean[] array = byteToBitArray(b);
        for (int i = 0; i < array.length; i++) {
            buff.append(array[i] ? 1 : 0);
        }
        return buff.toString();
    }

    /**
     * 计算出给定byte中的每一位,并以一个布尔数组返回. true表示为1,false表示为0.
     *
     * @param b 字节.
     * @return 指定字节的每一位bit组成的数组.
     */
    public static boolean[] byteToBitArray(byte b) {
        boolean[] buff = new boolean[8];
        int index = 0;
        for (int i = 7; i >= 0; i--) {
            buff[index++] = ((b >>> i) & 1) == 1;
        }
        return buff;
    }

    /**
     * 返回指定字节中指定bit位,true为1,false为0. 指定的位从0-7,超出将抛出数据越界异常.
     *
     * @param b     需要判断的字节.
     * @param index 字节中指定位.
     * @return 指定位的值.
     */
    public static boolean byteBitValue(byte b, int index) {
        return byteToBitArray(b)[index];
    }

    /**
     * 根据布尔数组表示的二进制构造一个新的字节.
     *
     * @param values 布尔数组,其中true表示为1,false表示为0.
     * @return 构造的新字节.
     */
    public static byte buildNewByte(boolean[] values) {
        byte b = 0;
        for (int i = 0; i < 8; i++) {
            if (values[i]) {
                b |= BUILD_BYTE_TABLE[i];
            }
        }
        return b;
    }

    /**
     * 将指定字节中的某个bit位替换成指定的值,true代表1,false代表0.
     *
     * @param b        需要被替换的字节.
     * @param index    位的序号,从0开始.超过7将抛出越界异常.
     * @param newValue 新的值.
     * @return 替换好某个位值的新字节.
     */
    public static byte changeByteBitValue(byte b, int index, boolean newValue) {
        boolean[] bitValues = byteToBitArray(b);
        bitValues[index] = newValue;
        return buildNewByte(bitValues);
    }

    /**
     * 将指定的IP地址转换成字节表示方式. IP数组的每一个数字都不能大于255,否则将抛出IllegalArgumentException异常.
     *
     * @param address IP地址数组.
     * @return IP地址字节表示方式.
     */
    public static byte[] ipAddressBytes(String address) {
        if (address == null || address.length() < 0 || address.length() > 15) {
            throw new IllegalArgumentException("Invalid IP address.");
        }

        final int ipSize = 4;// 最大IP位数
        final char ipSpace = '.';// IP数字的分隔符
        int[] ipNums = new int[ipSize];
        StringBuilder number = new StringBuilder();// 当前操作的数字
        StringBuilder buff = new StringBuilder(address);
        int point = 0;// 当前操作的数字下标,最大到3.
        char currentChar;
        for (int i = 0; i < buff.length(); i++) {
            currentChar = buff.charAt(i);
            if (ipSpace == currentChar) {
                // 当前位置等于最大于序号后,还有字符没有处理表示这是一个错误的IP.
                if (point == ipSize - 1 && buff.length() - (i + 1) > 0) {
                    throw new IllegalArgumentException("Invalid IP address.");
                }
                ipNums[point++] = Integer.parseInt(number.toString());
                number.delete(0, number.length());
            } else {
                number.append(currentChar);
            }
        }
        ipNums[point] = Integer.parseInt(number.toString());

        byte[] ipBuff = new byte[ipSize];
        int pointNum = 0;
        for (int i = 0; i < 4; i++) {
            pointNum = Math.abs(ipNums[i]);
            if (pointNum > 255) {
                throw new IllegalArgumentException("Invalid IP address.");
            }
            ipBuff[i] = (byte) (pointNum & 0xff);
        }

        return ipBuff;
    }


    /**
     * 从byte[]中抽取新的byte[]
     * @param data - 元数据
     * @param start - 开始位置
     * @param end - 结束位置
     * @return 新byte[]
     */
    public static byte[] getByteArr(byte[]data,int start ,int end){
        byte[] ret=new byte[end-start];
        for(int i=0;(start+i)<end;i++){
            ret[i]=data[start+i];
        }
        return ret;
    }


    /**
     * 流转换为byte[]
     * @param inStream
     * @return
     */
    public static byte[] readInputStream(InputStream inStream) {
        ByteArrayOutputStream outStream = null;
        try {
            outStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[1024];
            byte[] data = null;
            int len = 0;
            while ((len = inStream.read(buffer)) != -1) {
                outStream.write(buffer, 0, len);
            }
            data = outStream.toByteArray();
            return data;
        }catch (IOException e) {
            return null;
        } finally {
            try {
                if (outStream != null) {
                    outStream.close();
                }
                if (inStream != null) {
                    inStream.close();
                }
            } catch (IOException e) {
                return null;
            }
        }
    }
    /**
     * byte[]转inputstream
     * @param b
     * @return
     */
    public static InputStream readByteArr(byte[] b){
        return new ByteArrayInputStream(b);
    }

    /**
     * byte数组转换为Stirng
     * @param s1 -数组
     * @param encode -字符集
     * @param err -转换错误时返回该文字
     * @return
     */
    public static String getString(byte[] s1,String encode,String err){
        try {
            return new String(s1,encode);
        } catch (UnsupportedEncodingException e) {
            return err==null?null:err;
        }
    }
    /**
     * byte数组转换为Stirng
     * @param s1-数组
     * @param encode-字符集
     * @return
     */
    public static String getString(byte[] s1,String encode){
        return getString(s1,encode,null);
    }

    /**
     * byte数组转hex字符串
     *
     * @param bytes
     * @return
     */
    public static String byteArrToHexStr(byte[] bytes) {
        char[] buf = new char[bytes.length * 2];
        int index = 0;
        for(byte b : bytes) { // 利用位运算进行转换
            buf[index++] = HEX_CHAR[b >>> 4 & 0xf];
            buf[index++] = HEX_CHAR[b & 0xf];
        }

        return new String(buf);
    }

    /**
     * 字节数组转16进制字符串,各元素用空格分隔
     * @param b
     * @return
     */
    public static String byteArrToHexString(byte[] b){
        String result="";
        for (int i=0; i < b.length; i++) {
            result += Integer.toString( ( b[i] & 0xff ) + 0x100, 16).substring(1)+" ";
        }
        return result;
    }

    /**
     * 16进制字符创转int
     * @param hexString
     * @return
     */
    public static int hexStringToInt(String hexString){
        return Integer.parseInt(hexString,16);
    }

    /**
     * 十进制转二进制
     * @param i
     * @return
     */
    public static String intToBinary(int i){
        return Integer.toBinaryString(i);
    }

    /**
     * 将16进制字符串转换为byte[]
     *
     * @param str
     * @return
     */
    public static byte[] hexStrtoByteArr(String str) {
        if(str == null || str.trim().equals("")) {
            return new byte[0];
        }

        byte[] bytes = new byte[str.length() / 2];
        for(int i = 0; i < str.length() / 2; i++) {
            String subStr = str.substring(i * 2, i * 2 + 2);
            bytes[i] = (byte) Integer.parseInt(subStr, 16);
        }

        return bytes;
    }

    /*-------zhangliang 20180511 add start----------------------------------------------------------*/

    /**
     * byte数组转为集合
     * @param pac 需要转转换的数据。
     * @return 消息结构体。
     */
    public static List<Byte> byteArrayToList(byte[] pac){
        List<Byte> list = new ArrayList<Byte>();
        int len = pac.length;
        for(int i = 0;i<len;i++){
            list.add(pac[i]);
        }
        return list;
    }

    /**
     * Byte集合转为byte数组
     * @param  list 需要转转换的数据。
     * @return 消息结构体。
     */
    public static byte[] ListTobyteArray(List<Byte> list){
        byte[] b = new byte[list.size()];
        int len = b.length;
        for(int i = 0;i<len;i++){
            b[i]=list.get(i);
        }
        return b;
    }

    //循环合并字符数组
    public static byte[] cycMergeArrays(List<byte[]> list) {

        int totalLen = 0;
        for(int i=0;i<list.size();i++){
            totalLen +=  list.get(i).length; //字符总长度
        }

        byte[] finalBs = new byte[totalLen];
        int len = 0;
        for(int i=0;i<list.size();i++){
            System.arraycopy(list.get(i), 0, finalBs, len, list.get(i).length);
            len += list.get(i).length;
        }

        return finalBs;
    }

    /**
     * 合并数组
     * @param a,b 消息头和消息体组合成的byte[]。
     * @return 校验码。
     */
    public static byte[] mergeArrays(byte[] a,byte[] b) {
        int len = a.length+b.length;
        byte[] c = new byte[len];
        if(len==c.length){
            System.arraycopy(a, 0, c, 0, a.length);
            System.arraycopy(b, 0, c, a.length, b.length);
        }
        return c;
    }

    /**
     * 提取数组中的一段
     * @param arrays 需要提取的数组
     * @param begin 从begin开始提取
     * @param len 提取长度
     * @return 提取内容。
     */
    public static byte[] extractArrays(byte[] arrays,int begin,int len){
        byte[] b = new byte[len];
        System.arraycopy(arrays, begin, b, 0, len);
        return b;
    }

    /**
     * byte[] to 十六进制 string (包含0x)
     * @param bs
     * @return
     */
    public static String bytesToHexString(byte[] bs){
        StringBuilder stringBuilder = new StringBuilder("0x");
        if (bs == null || bs.length <= 0) {
            return null;
        }
        for (int i = 0; i < bs.length; i++) {
            String str = Integer.toHexString((bs[i] & 0x000000FF) | 0xFFFFFF00).substring(6);
            if (str.length() < 2) {
                stringBuilder.append(0);
            }
            stringBuilder.append(str);
        }
        return stringBuilder.toString();
    }

    /**
     * 将16进制字符串(包含0x)转换为byte[]
     * @param str
     * @return
     */
    public static byte[] hexStringToBytes(String str) {

        if(str == null || str.trim().equals("")) {
            return new byte[0];
        }

        if(str.length()>2 && "0x".equals(str.substring(0,2))){
            str = str.substring(2,str.length());
        }

        if(str.length()<4){
            DecimalFormat df = new DecimalFormat("00");
            str = df.format(Integer.parseInt(str));
        }
        byte[] bytes = new byte[str.length() / 2];
        for(int i = 0; i < str.length() / 2; i++) {
            String subStr = str.substring(i * 2, i * 2 + 2);
            bytes[i] = (byte) Integer.parseInt(subStr, 16);
        }

        return bytes;
    }

    //高位在前，低位在后  byte[]转int
    public static int bytes2int(byte[] bytes){
        int result = 0;
        if(bytes.length == 4){
            int a = (bytes[0] & 0xff) << 24;
            int b = (bytes[1] & 0xff) << 16;
            int c = (bytes[2] & 0xff) << 8;
            int d = (bytes[3] & 0xff);
            result = a | b | c | d;
        }
        return result;
    }

    /**
     * byte数组转换为二进制字符串
     * **/
    public static String bytesTo2Str(byte [] b)
    {
        StringBuffer result = new StringBuffer();
        for(int i = 0;i<b.length;i++)
        {
            result.append(Long.toString(b[i] & 0xff, 2));
        }
        return result.toString();
    }

    /**
     * byte数组转换为二进制字符串,每个字节以","隔开
     * **/
    public static String bytesTo2BitStr(byte [] b)
    {
        StringBuffer result = new StringBuffer();
        for(int i = 0;i<b.length;i++)
        {
            result.append(Long.toString(b[i] & 0xff, 2)+",");
        }
        return result.toString().substring(0, result.length()-1);
    }

    /**
     * 将二进制字符串补全
     * @param str
     */
    public static String bToBit(String str){
        String a[]=str.split(",");
        String bString="";
        String cString="00000000";
        for (int i = 0; i < a.length; i++) {
            if(a[i].length()<8){
                bString=bString+cString.substring(a[i].length())+a[i];
            }
        }
        return bString;
    }

    /**
     * 将当前时间变为BCD时间byte[]
     */
//    public static byte[] BCD2bytes() {
//        byte[] reportTime = new byte[6];//BCD时间
//        Date now = new Date();//当前时间
//        SimpleDateFormat sdf = new SimpleDateFormat("YYMMddHHmmss");
//        String nowTime = sdf.format(now);
//        //System.out.println("nowTime:"+nowTime);
//        byte[] bcd = TimeToBCD.str2Bcd(nowTime);
//        //System.out.println("nowTimeBCD:"+Arrays.toString(bcd));
//        for (int i = 0; i < bcd.length; i++) {
//            reportTime[i] = bcd[i];
//        }
//        return reportTime;
//    }

    public static short getShort(byte[] buf, boolean asc)
    {
        if (buf == null)
        {
            throw new IllegalArgumentException("byte array is null!");
        }
        if (buf.length > 2)
        {
            throw new IllegalArgumentException("byte array size > 2 !");
        }
        short r = 0;
        if (asc)
            for (int i = buf.length - 1; i >= 0; i--)
            {
                r <<= 8;
                r |= (buf[i] & 0x00ff);
            }
        else
            for (int i = 0; i < buf.length; i++)
            {
                r <<= 8;
                r |= (buf[i] & 0x00ff);
            }
        return r;
    }
    /*-------zhangliang 20180511 add end----------------------------------------------------------*/


}

