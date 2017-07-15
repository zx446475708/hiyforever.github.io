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
```
输出
```console
1.23456792E8
1.2345678909876544E16
```
