---
title: Spring Boot使用笔记
date: 2017-08-24 09:47:02
updated: 2017-08-24 09:47:02
categories:
    - java
    - spring
    - spring boot
tags:
    - java
    - spring
    - spring boot
    - spring mvc
    - spring data jpa
---
Spring Boot从入门到入坑
<!-- more -->

## 项目结构
完整的Spring Boot项目一般拥有以下目录结构
``` css
root
├─build.gradle
└─src
   ├─main
   │  ├─java/com/spring/boot
   │  │  ├─Application.java
   │  │  ├─controller
   │  │  │  └─GreetingController.java
   │  │  ├─repository
   │  │  │  ├─GreetingRepository.java
   │  │  │  └─impl
   │  │  │     └─GreetingRepositoryImpl.java
   │  │  ├─service
   │  │  │  ├─GreetingService.java
   │  │  │  └─impl
   │  │  │     ├─GreetingServiceImpl.java
   │  │  │     └─ExceptionHandlerServiceImpl.java
   │  │  ├─entity
   │  │  │  └─Greeting.java
   │  │  ├─json
   │  │  │  └─GreetingJson.java
   │  │  ├─enums
   │  │  │  └─GreetingEnum.java
   │  │  ├─exception
   │  │  │  └─GreetingException.java
   │  │  ├─config
   │  │  │  ├─InitializingBeanConfig.java
   │  │  │  ├─SchedulingConfig.java
   │  │  │  └─WebSecurityConfig.java
   │  │  └─utils
   │  └─resources
   │     ├─application.properties
   │     └─data.sql
   └─test/java/cn/ibm/qrepmonitor
         └─ApplicationTests.java
```

## Gradle安装
Spring Boot的build.gradle文件包含以下内容
``` gradle
plugins {
    id 'org.springframework.boot' version '1.5.2.RELEASE'
    id 'java'
}

jar {
	baseName = 'ProjectName'
	version = '1.0'
}

sourceCompatibility = 1.8

tasks.withType(JavaCompile) {
	options.encoding = "UTF-8"
}

repositories {
	jcenter()
}

dependencies {
	compile('org.springframework.boot:spring-boot-starter-web')
    runtime('org.springframework.boot:spring-boot-devtools')
	testCompile('org.springframework.boot:spring-boot-starter-test')
}
```
其它常用依赖
``` gradle
compile('org.springframework.boot:spring-boot-starter-security')
compile('org.springframework.security.oauth:spring-security-oauth2')
compile('org.springframework.boot:spring-boot-starter-data-jpa')
```
自定义本地依赖
``` gradle
compile(fileTree(dir: 'lib', include: '*.jar'))
```
