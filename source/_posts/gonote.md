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

1. 值方法可通过指针和值调用， 而指针方法只能通过指针来调用；值方法针对对象副本，每次调用都会先进行内存复制
    ```go
    type Int int

    func (i *Int) String() string {
        return "My String()"
    }

    func main() {
        var i Int
        fmt.Println(i, &i)
    }
    ```
    输出
    ```console
    0 My String()
    ```

1. 接口类型并不能屏蔽非接口方法
    ```go
    type Int int

    func (i *Int) String() string {
        return "My String()"
    }

    func (i *Int) Error() string {
        return "My Error()"
    }

    func main() {
	    var i Int
        var s fmt.Stringer = &i
        fmt.Println(&i, s)
    }
    ```
    输出
    ```console
    My Error() My Error()
    ```
1. 向满 channel 发数据和从空 channel 取数据，只有在没有 goroutine 运行时（注：这里运行指的非 asleep 状态，读写 channel 的阻塞态算 asleep，time.Sleep 不算，select 所有分支都阻塞时算 asleep）会报错，有其它 goroutine 运行时才会阻塞

1. 关闭的 channel 在缓冲区没有清空时，仍能正常取数据，第二参数返回 true
    ```go
    c := make(chan int)
    c <- 1
    close(c)
    i, ok := <-c
    println(i, ok)
    i, ok = <-c
    println(i, ok)
    ```
    输出
    ```console
    1 true
    0 false
    ```
