d=`curl -Ss https://www.bt.cn/api/index/get_date`
if [ "$d" = "" ];then
    echo '时间同步失败!';
    echo $d;
fi
date -s "$d"
echo "时间同步成功!"
