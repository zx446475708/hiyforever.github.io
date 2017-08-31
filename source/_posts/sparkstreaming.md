---
title: Spark Streaming入门实践
date: 2017-08-24 17:34:02
updated: 2017-08-31 15:35:05
categories:
    - java
    - spark
    - spark streaming
tags:
    - java
    - spark
    - spark streaming
    - hermes kafka
---
消费hermes kafkas数据，实时跟踪用户行为
<!-- more -->

## 初始化Spark配置
``` java
String appName = "MyAppName";
final String checkpointDir = "hdfs:///user/checkpoint/" + appName;
final long batchInterval = 60; // 数据采集时间范围（秒）

final SparkConf sparkConf = new SparkConf().setAppName(appName);
JavaStreamingContext ssc = JavaStreamingContext.getOrCreate(checkpointDir, () -> {
  // 新建spark streaming context
  JavaStreamingContext jssc = new JavaStreamingContext(sparkConf, Durations.seconds(batchInterval));
  jssc.sparkContext().setLogLevel("error");
  jssc.checkpoint(checkpointDir);
  return jssc;
});
```

## 创建Kafka输入离散流
``` java
JavaPairInputDStream<String, Pageview> stringPageviewPairInputDStream = KafkaUtils.createDirectStream(
  ssc,
  ...
);
```

## 数据预处理
``` java
// 过滤无关数据
JavaPairDStream<String, Pageview> stringPageviewPairDStream = stringPageviewPairInputDStream.filter(pageviewFilterFunction);

// 去除重复数据
stringPageviewPairDStream = stringPageviewPairDStream.reduceByKey(pageviewDistinctFunction);
```

## 用户行为跟踪处理
``` java
// 处理用户访问情况
stringPageviewPairDStream = stringPageviewPairDStream.updateStateByKey((Function2<List<Pageview>, Optional<Pageview>, Optional<Pageview>>) (v1, v2) -> {
  // 没有新访问的情况，考虑是否继续追踪该用户
  if (v1.isEmpty()) {
    if (v2.isPresent() && System.currentTimeMillis() - v2.get().getTimestamp() > TIMEOUT) {
      Pageview oldPageview = v2.get();
      ...
      return Optional.absent();
    }
    return v2;
  }

  // 有新访问的情况，考虑是否符合要求
  Pageview newPageview = v1.get(0);
  ...
  if (isReady) {
    return Optional.of(newPageview);
  }

  // 新访问不合要求，且过去没有访问的情况
  if (!v2.isPresent()) {
    return Optional.absent();
  }

  // 新访问不合要求，且过去有访问的情况，更新访问时间
  Pageview oldPageview = v2.get();
  oldPageview.setTimestamp(newPageview.getTimestamp());
  return Optional.of(oldPageview);
});
```

## 启动Spark应用
``` java
stringPageviewPairDStream.print(0);

ssc.start();

try {
  ssc.awaitTermination();
} catch (InterruptedException e) {
  LOGGER.error(e);
}
```

## Spark Streaming性能指标及配置
* 关键性能指标
    * Scheduling Delay: Kafka队列数据读取时间，若太高需增大batch interval
    * Processing Time: 数据处理时间，若太高请优化代码，或增加资源分配

* 配置参数
    * spark.default.parallelism: 并行度，取决于任务数量，也就是一共需要多少线程来执行这些任务，一般为所有机器CPU总数的2\~3倍，即每个CPU开2\~3个线程，以充分利用CPU资源
    * spark.sql.shuffle.partitions: 分区数，取决于kafka队列的分区数，若每个分区数据量不大，可适当减少这个值
    * spark.streaming.concurrentJobs: 并行作业数量
