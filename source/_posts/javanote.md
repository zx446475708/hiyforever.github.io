---
title: Java 日常笔记
date: 2017-07-15 18:47:33
updated: 2017-07-15 18:47:33
categories:
    - java
tags:
    - java
---
Java 中一些常被忽略的地方。
<!-- more -->

1. float/double 因精度问题，不能用于大数计算
    ```java
    System.out.println(123456789f); 
    System.out.println(12345678909876543d);
    System.out.println(true ? 123456789 : 1f);
    ```
    输出
    ```console
    1.23456792E8
    1.2345678909876544E16
    1.23456792E8
    ```

1. float 与 double 之间因精度问题，不能比较
    ```java
    System.out.println(3.3 > 3.3f);
    ```
    输出
    ```console
    true
    ```

1. 计算 BigDecimal 应使用字符串进行初始化构造，使用 compareTo 进行比较
    ```java
    BigDecimal a = new BigDecimal(2.1).subtract(new BigDecimal(1.2));
    BigDecimal b = new BigDecimal(0.9);
    System.out.println(a.equals(b));
    System.out.println(a.compareTo(b));
    System.out.println(a.doubleValue() == b.doubleValue());

    BigDecimal c = new BigDecimal("2.1").subtract(new BigDecimal("1.20"));
    BigDecimal d = new BigDecimal("0.9");
    System.out.println(c.equals(d));
    System.out.println(c.compareTo(d));
    System.out.println(c.doubleValue() == d.doubleValue());
    ```
    输出
    ```console
    false
    1
    false
    false
    0
    true
    ```

1. 奇偶判别使用 (i & 1) == 0；判断 2 指数 (i & (i - 1)) == 0

1. Random 从 Jdk 1.7 开始为线程安全类，ThreadLocalRandom 效率更高，SecureRandom 更随机

1. DateFormat 非线程安全类（原因：calendar），多线程访问应用 ThreadLocal 创建；DateFormat 无法识别毫秒格式，使用 SimpleDateFormat 指定具体格式识别

1. Date 和 Calendar 的月份从 0 开始，表示一月；星期从 1 开始，表示周日；Date 无时区，new Date(0) 为标准零时，即北京时间 8 点， Calendar 默认当地时区，Calendar.getInstance().clear() 为当地时间零时

1. equals 重写规则
    ```java
    @Override
    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj == null || this.getClass() != obj.getClass() || this.hashCode() != obj.hashCode()) {
            return false;
        }
        return ...;
    }

    @Override
    public int hashCode() {
        return ...;
    }
    ```
1. 文件读写
    ```java
    new FileInputStream("fileName");  // 无缓冲字节输入流
    new BufferedInputStream(new FileInputStream("fileName"));  // 缓冲字节输入流
    
    new PrintStream("fileName");  // 无缓冲字节输出流（内部 FileOutputStream，需要注意部分方法并非字节输出流，或直接用 FileOutputStream）
    new PrintStream(new BufferedOutputStream(new FileOutputStream("fileName")));  // 缓冲字节输出流（需要注意部分方法并非字节输出流，或直接用 BufferedOutputStream）
    
    new Scanner(new BufferedReader(new FileReader("fileName")));  // 缓冲字符输入流（或直接用 BufferedReader）
    
    new PrintWriter("fileName");  // 缓冲字符输出流（内部 BufferedWriter）
    ```
1. Stack extends Vector，用 Deque 吧

1. 复合赋值符号向下赋值时隐含自动转型，编译器不会报错，但不利于阅读
    ```java
    byte b = 0;
    int i = 128;
    b += i;  // 相当于 b = (byte) (b + i);
    System.out.println(b);
    ```
    输出
    ```console
    -128
    ```
    
1. byte[] 转 String 需指定字符集，因为默认字符集根据平台而定，是不确定的

1. 移位操作的移位数会自动取余，int 的 % 32，long 的 % 64
    ```java
    System.out.println(-1 << 32);
    System.out.println(-1 << 31 << 1);
    ```
    输出
    ```console
    -1
    0
    ```
    
