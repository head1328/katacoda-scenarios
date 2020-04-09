echo "start building the php example app..."

docker build -f ./1_Dockerfile -t php-app:example-1 .

docker images | grep "php-app:example-1"

echo "finish"