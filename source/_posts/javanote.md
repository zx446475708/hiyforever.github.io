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

1. 奇偶判别使用 (i & 1) == 0

1. Random 非线程安全类，ThreadLocalRandom 线程安全类

1. DateFormat 非线程安全类，多线程访问应用 ThreadLocal 创建；无法识别毫秒格式

1. Date 和 Calendar 的月份从 0 开始，表示一月；星期从 1 开始，表示周日

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
