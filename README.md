# SearchDemo
搜索UISearchViewController
从远程仓库clone项目失败

修改地址https 为git（一般情况下都可行）

android studio push失败

Failed with error: fatal: Authentication failed for…… 
采用Git Gui来提交push代码

Git回退远程仓库版本

首先通过Git Gui来clone下来

git init生成.git
1
克隆远程仓库
cd ...
git clone url

clone的地址为默认当前定位地址  cd到指定目录
1
2
3
4
5
GitHub基本操作

新建一个仓库

前往https://github.com new 一个仓库

1、在项目根目录下打开 git-cmd.exe 
git init    生成  .git目录

2、将本地项目加入到暂存区
git add .  (不要忘记点)

3、暂缓区文件提交本地仓库
git commit -m "说明"

4、将本地仓库与github 远程仓库关联
git remote add origin xxx.git从远程仓库中粘贴过来。

5、本地文件上传到github服务器
git pull --rebase origin master(本地文件中不存在README.md时添加)

6、代码合并  
git push -u -origin master
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
7、查看状态 
git satus

8、查看代码修改内容 
git diff 查看代码内容

git rm 删除的文件

git push origin master(代码提交到服务器)

8、同步到服务器 先同步到本地 git pull 
—>git checkout url 冲突文件路径

设置版本分支

1、提交设置版本
git tag version
git push 
git push --tags
1
2
3
4
版本代码通过compile 依赖导入

在Project工程build.gradle文件中添加maven 依赖
buildscript {
    repositories {
        mavenCentral()
    }

    dependencies {
        ……
        /*添加github 依赖 compile*/
        classpath 'com.github.dcendents:android-maven-gradle-plugin:version'
        ……
    }

}
1
2
3
4
5
6
7
8
9
10
11
12
13
version设置 参考 https://github.com/dcendents/android-maven-gradle-plugin


