# Hadoop Cluster
### Version:
* Hadoop 3.3.1 (including YARN)
* Open JDK 8
* Hive 2.3.9
* Jupyter Notebook
* Spark 3.0.3
* Zookeeper 3.6.3

 <table>
  <tr>
    <td>Web UI</td>
    <td>Url</td>
  </tr>
  <tr>
    <td>NameNode</td>
    <td>http://localhost:9870  http://localhost:9870</td>
  </tr>
  <tr>
    <td>ResourceManager</td>
    <td>http://localhost:8088 http://localhost:8089</td>
  </tr><tr>
    <td>HistoryServer</td>
    <td>http://localhost:19888</td>
  </tr><tr>
    <td>JournalNode</td>
    <td>http://localhost:8480 http://localhost:8481 http://localhost:8482</td>
  </tr><tr>
    <td>JupyterLab</td>
    <td>http://localhost:8888</td>
  </tr>
  <tr>
    <td>Spark</td>
    <td>http://localhost:4040</td>
  </tr>
</table>

<br/><br/>
#### The consquence of building Hadoop Cluster:
1. source CreateImage.sh: It's a file creating needed images.
2. docker-compose up -d: Build these Hadoop containers.
3. source Startup.sh: It's the command lines to open Hadoop Cluster.
 
<br/><br/>
**本次專案重點回顧：**
1. 讓containers 之間有無密碼 ssh 的功能 <br/>
利用讀同個 image 解決
2. docker exec xxx -i /bin/bash 對指令的重要性
3. sed @@@ or sed /// => 指令用法
4. Docker ports 跟 expose 的不同
5. 針對 Hadoop ports 如何處理 
6. snap install docker 可安裝docker
