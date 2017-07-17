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

1. 计算 double/float 的 BigDecimal 应使用 doubleValue/floatValue 方法取实际值进行比较
    ```java
    BigDecimal a = new BigDecimal(1.1).multiply(new BigDecimal(2));
    BigDecimal b = new BigDecimal(2.2);

    System.out.println(a.equals(b));
    System.out.println(a.doubleValue() == b.doubleValue());
    ```
    输出
    ```console
    false
    true
    ```

1. Calendar和DateFormat皆非线程安全类

1. Date和Calendar的月份从0开始，表示一月；星期从1开始，表示周日

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
