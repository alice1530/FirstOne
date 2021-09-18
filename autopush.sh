#!/bin/bash

#github地址，ssh方式
github_url='git@github.com:alice1530/FirstOne.git'

#文件存放绝对位置， /xxx/bb/ccc
file_path='/root/zzzautopush/update.sh'

###获取项目名称
tmp1="${github_url##*/}"
repository_name="${tmp1%%.*}"

###本地仓库位置
local_path="$PWD/$repository_name/"

###时间格式
DATA_TIME=`date +'%Y年%m月%d日 %H:%M:%S'`

git config --global user.email "you@example.com"
git config --global user.name "Your Name"

#echo $tmp1
#echo $local_path

if [[ ${github_url} =~ 'https://' ]];then
  echo "---请使用ssh方式的git---"
  exit 1
fi

push_code(){
  
  cd $local_path
  
  # 复制文件到仓库
  /usr/bin/cp -r $file_path  $local_path
  
  git add .

  git commit -m "auto push $DATE_TIME "

  git push origin

  if [ $? != 0 ];then
      echo "代码推送失败！"
  else
      echo "代码推送成功！"
  fi

}

if [ ! -d "$local_path" ];then
  echo "文件夹不存在,开始克隆..."
  git clone $github_url $repository_name 
  #mkdir -p $local_path
  if [ $? != 0 ];then
      echo "克隆失败！"
  else
      echo "克隆成功！开始执行推送操作..."
      push_code
  fi

else
  echo "文件夹已经存在,开始执行推送操作..."
  push_code
fi


#exit 0

#DATA_TIME=`date +'%Y年%m月%d日 %H:%M:%S'`





#cd /ql/config/wskey_sigm_list/

#git add .
#sleep 1

#git commit -m  "auto_commit $dt"
#sleep 1

#git push

