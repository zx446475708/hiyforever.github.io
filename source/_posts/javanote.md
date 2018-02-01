---
title: Java 日常笔记
date: 2017-07-15 18:47:33
updated: 2018-01-06 22:50:46
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

1. Math.abs(Integer.MIN_VALUE) < 0

1. 奇偶判别使用 (i & 1) == 0；判断 2 指数 (i & (i - 1)) == 0

1. Random 从 Java7 开始为线程安全类，ThreadLocalRandom 效率更高，SecureRandom 更随机

1. Thread.join 调用 wait 方法，释放了当前对象锁

1. DateFormat 非线程安全类（原因：Calendar），多线程访问应用 ThreadLocal 创建；DateFormat 无法识别毫秒格式，使用 SimpleDateFormat 指定具体格式识别；Java8 用 DateTimeFormatter 代替，线程安全类

1. Date 和 Calendar 的月份从 0 开始，表示一月；星期从 1 开始，表示周日；Date 无时区，new Date(0) 为标准零时，即北京时间 8 点， Calendar 默认当地时区，Calendar.getInstance().clear() 为当地时间零时；Java8 用 java.time 包代替，线程安全类

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

1. 复合赋值隐含自动转型，编译器不会报错，但不利于阅读
    ```java
    byte b = 0;
    short i = 128;
    b += i;  // 相当于 b = (byte) (b + i); 注意 b + i 会先提升 int 类型
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

1. 实现不同接口同一方法抛出的异常取交集的子集
    ```java
    interface interface1 {
        void throwsException() throws FileNotFoundException, IOException;
    }

    interface interface2 {
        void throwsException() throws IOException, ClassNotFoundException;
    }

    class Class implements interface1, interface2 {

        @Override
        public void throwsException() throws ClosedChannelException {
        }
    }
    ```

1. 成员变量与动态代码块中的异常在构造函数中抛出
    ```java
    boolean bool = throwsException();
    {
        throwsException();
    }

    public Class() throws Exception {
    }

    public static boolean throwsException() throws Exception {
        throw new Exception();
    }
    ```

1. try-with-resources
    ```java
    public static void main(String[] args) {
        // since java7
        try (InputStream inputStream = new FileInputStream("fileName");
            OutputStream outputStream = new FileOutputStream("fileName")) {
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) { // throw by close method
        }

        // before java7
        InputStream inputStream = null;
        OutputStream outputStream = null;
        try {
            inputStream = new FileInputStream("fileName");
            outputStream = new FileOutputStream("fileName");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } finally { // try to close by Closeable
            close(inputStream, outputStream);
        }
    }
    
    /**
     * Try to close resources which implements {@link Closeable}
     * 
     * @param closeables methods which implements {@link Closeable}
     */
    private static void close(Closeable... closeables) {
        for (Closeable closeable : closeables) {
            if (closeable != null) {
                try {
                    closeable.close();
                } catch (Exception e) {
                }
            }
        }
    }
    ```

1. 重载参数就近
    ```java
    public static void main(String[] args) {
        func(null); // call func(B b)
    }

    class A {
    }

    class B extends A {
    }

    public static void func(A a) {
    }

    public static void func(B b) {
    }
    ```

1. 类变量初始化->类变量从上到下依次赋值
    ```java
    public class Class {
        private static Class clazz = new Class();
        private static int num = 1;

        private Class() {
            System.out.println(num);
        }
    }
    ```
    输出
    ```console
    0
    ```

1. 重写类的调用
    ```java
    public class A {
        public int override() {
            return 1;
        }

        public void callOverride() {
            System.out.println(override());
        }

        public static void main(String[] args) {
            new B().callOverride();
        }
    }

    class B extends A {
        @Override
        public int override() {
            return 2;
        }
    }
    ```
    输出
    ```console
    2
    ```

1. 被遮蔽的方法不会重载
    ```java
    void wake() {
    }

    void sleep() {
    }

    class Class {
        void sleep(int time) {
            wake();  // correct
            sleep();  // error
        }
    };
    ```

1. 动态内部类的构造器具有一个隐藏参数，反射构建时需指明
    ```java
    Inner.class.getConstructor(Outer.class).newInstance(new Outer());
    ```
