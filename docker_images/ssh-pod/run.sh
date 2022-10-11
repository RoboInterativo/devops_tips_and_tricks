docker run --name web1 -h web1   \
--rm  -d -p 1022:22  myssh

docker run --name web2 -h web2   \
--rm  -d -p 2022:22  myssh

docker run --name lb1 -h lb1   \
--rm  -d -p 3022:22 -p 80:80 myssh
