---
title: Hello World - Keras
date: 2017-06-27 23:47:33
updated: 2017-06-27 23:47:33
categories:
    - deep learning
    - keras
tags:
    - deep learning
    - keras
    - 二分类
---
基于多层神经网络的二分类模型，开始你的第一次keras深度学习训练。
关于环境搭建，请见[Keras安装教程](http://keras-cn.readthedocs.io/en/latest/for_beginners/keras_linux/#_5)。
<!-- more -->

## 导入所需的python库
``` python
import numpy as np
from keras.models import Sequential
from keras.layers import Dense
from sklearn.metrics import roc_auc_score
```

## 导入你的数据
``` python
x_train = np.random.random((10, 3))
y_train = np.random.randint(2, size=(10, 1))
```
或通过文件导入
``` python
x_train = np.genfromtxt(x_train_path, delimiter=',')
y_train = np.genfromtxt(y_train_path, delimiter=',')
```

## 建立你的模型
``` python
model = Sequential()
```

* 模型的网络层设定
``` python
model.add(Dense(128, input_dim=3, activation='tanh'))
model.add(Dense(64, activation='relu'))
model.add(Dense(1, activation='sigmoid'))
```

* 模型的网络配置设定
``` python
model.compile(loss='binary_crossentropy', optimizer='rmsprop')
```

## 训练你的模型
``` python
model.fit(x_train, y_train, epochs=20, batch_size=5)
```

## 评估你的模型

* 导入你的测试数据
``` python
x_test = np.random.random((10, 3))
y_test = np.random.randint(2, size=(10, 1))
```

* 预测你的数据
``` python
y_prob = model.predict(x_test)
```

* 计算你的模型预测AUC值
``` python
auc = roc_auc_score(y_test, y_prob)
print("AUC: " + str(auc))
```

* 其它评价指标
``` python
y_test_positive = np.sum(y_test)
y_prob_binary = y_prob > threshold
sensitivity = recall_score(y_test, y_prob_binary)
specifity = 1 - (np.sum(y_prob_binary) - sensitivity * y_test_positive) / (y_test.shape[0] - y_test_positive)
f1 = f1_score(y_test, y_prob_binary)

print("Sensitivity: " + str(sensitivity))
print("Specifity: " + str(specifity))
print("F1: " + str(f1))
```
