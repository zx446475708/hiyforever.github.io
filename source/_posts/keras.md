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
---
开始你的第一次keras深度学习训练。
<!-- more -->

## 基于多层神经网络的二分类模型

### 导入所需要的python库
``` python
import numpy as np
from keras.models import Sequential
from keras.layers import Dense
from sklearn.metrics import roc_auc_score
```

### 导入你的数据
``` python
x_train = np.random.random((10, 3))
y_train = np.random.randint(2, size=(10, 1))
```
或通过文件导入
``` python
x_train = np.genfromtxt(x_train_path, delimiter=',')
y_train = np.genfromtxt(y_train_path, delimiter=',')
```

### 建立你的模型
``` python
model = Sequential()
```

#### 模型的网络层设定
``` python
model.add(Dense(64, input_dim=3, activation='tanh'))
model.add(Dense(1, activation='sigmoid'))
```

#### 模型的网络配置设定
``` python
model.compile(loss='binary_crossentropy', optimizer='rmsprop')
```

### 训练你的模型
``` python
model.fit(x_train, y_train, epochs=20, batch_size=5)
```

### 评估你的模型

#### 导入你的测试数据
``` python
x_test = np.random.random((10, 3))
y_test = np.random.randint(2, size=(10, 1))
```

#### 预测你的数据
``` python
y_prob = model.predict(x_test)
```

#### 计算你的模型预测AUC值
``` python
roc_auc_score(y_test, y_prob)
```
