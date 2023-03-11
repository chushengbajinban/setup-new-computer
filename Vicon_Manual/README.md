### Step 0 注意事项

- 设置右上角`View Type`为`Data Collection`

<img title="" src="./README_fig/2022-11-08-15-21-31-48ba90763ba37c2b8e8d247e064802d.jpg" alt="" width="535" data-align="inline">

- 当这一块出现`*`时要保存

<img title="" src="./README_fig/2022-11-08-15-24-14-c86c072a84b38a4a1eb635b78ff639d.png" alt="" width="534">

- `Trial Type` 选项选择`pose`

有时候无法capture时，可以选择**重新选择**一下`pose`(至今不知道机理是啥)

<img title="" src="./README_fig/2022-11-08-15-25-35-a30210b3df83ebaccd95f692d42f8a6.jpg" alt="" width="238">    <img title="" src="./README_fig/2022-11-08-15-26-24-d942ad98bb5d0a089a9f1e475e0aec3.png" alt="loading-ag-205" width="196">

- 选择`kinematic fit`

<img title="" src="./README_fig/2022-11-08-15-30-25-0633176eafa93b4a7157776718ff7cc.jpg" alt="" width="103">

- 尽量一个一个地放入被建刚体

- 记得校准`vicon`

### Step 1

新建`subject`

<img title="" src="./README_fig/2022-11-08-15-32-24-0e16382aa51d8d92ea1b9796b9837bb.png" alt="" width="487">

<img title="" src="./README_fig/2022-11-08-15-32-36-db7483845af8264f1236bf6727efa6b.png" alt="" width="487">

### Step2

捕捉图像

<img title="" src="./README_fig/2022-11-08-15-34-30-898e0f3518fe7a80d494d9c6fb9b0b2.png" alt="" width="484">

### Step3

重构刚体

<img title="" src="./README_fig/2022-11-08-15-35-02-58cd27a8fa1a7dd8ab69003df28ec42.png" alt="" width="474">

### Step4

构建`Segments`，需要命名（与`subjects`的名字一致？）

点击一下`create`后开始构建坐标系

<img title="" src="./README_fig/2022-11-08-15-37-07-85b6d41142ddd36d9830082746a4ae5.png" alt="" width="471">

选择的第一个点为`origin`,

第一个点指向第二个点的向量为`z`轴负方向，可得`xy`平面

第一个点指向第三个点在`xy`平面上的投影为`y`轴正方向

`x`轴由右手螺旋法则确定

<img title="" src="./README_fig/2022-11-08-15-38-48-df00765ec14d749699b9b8b09e14f11.png" alt="" width="421">

<img title="" src="./README_fig/2022-11-08-15-38-57-9d612e2b3a78c4545c96076b0872ded.png" alt="" width="423">

刚体构建完毕后再次点击`create`

<img title="" src="./README_fig/2022-11-08-15-42-12-68e596bf071fd98e530749edeb91d62.png" alt="" width="424">

### Step5

选择`Go Live`，确保`subjects`的名称后面没有`*`，勾选`subjects`，将刚体放入`vicon`场地，即可获得数据

<img title="" src="./README_fig/2022-11-08-15-42-59-9d10799617119bb858150993e5631d9.png" alt="" width="383">
