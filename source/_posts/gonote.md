---
title: Go 日常笔记
date: 2017-12-08 12:23:33
updated: 2017-12-08 12:23:33
categories:
    - go
tags:
    - go
---
Go 中一些常被忽略的地方。
<!-- more -->

1. append 在切片容量不足时，会返回一个新的切片，且不改变原切片的任何值
    ```go
    s := []int{1, 2}
    s1 := append(s[:1], 3)
    println(s, s1)
    fmt.Println(s, s1)
    
    s2 := append(s[:1], 4, 5)
    println(s, s2)
    fmt.Println(s, s2)
    ```
    输出
    ```console
    [2/2]0x10410020 [2/2]0x10410020
    [1 3] [1 3]
    [2/2]0x10410020 [3/4]0x10410050
    [1 3] [1 4 5]
    ```

