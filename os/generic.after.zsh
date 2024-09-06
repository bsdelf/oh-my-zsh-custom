function docker-clean() {
    filter="-f status=created"
    createdIds=$(docker ps -a $(printf "$filter") -q | sort | uniq | paste -s -d " " -)
    if [ ! -z "$createdIds" ]; then
        printf "Remove created containers:\n$createdIds\n"
        docker rm $(printf "$createdIds")
    fi

    filter=""
    for i in $(seq 1 255); do
        filter="$filter -f exited=$i"
    done
    exitedIds=$(docker ps -a $(printf "$filter") -q | sort | uniq | paste -s -d " " -)
    if [ ! -z "$exitedIds" ]; then
        printf "Remove aborted containers:\n$exitedIds\n"
        docker rm $(printf "$exitedIds")
    fi

    ids=$(docker images -f dangling=true -q | sort | uniq | paste -s -d " " -)
    if [ ! -z "$ids" ]; then
        printf "Remove dangling images:\n$ids\n"
        docker rmi $(printf "$ids")
    fi
}

function docker-volume-purge() {
    ids=$(docker volume ls -q)
    if [ ! -z "$ids" ]; then
        docker volume rm $(printf "$ids")
    fi
}

function docker-swagger() {
    if [ ! -f "$1" ]; then
        echo "File does not exist!"
        return 1
    fi
    file=$(realpath "$1")

    port=""
    for i in $(seq 1 3); do
        port=$(shuf -i 2000-65000 -n 1)
        nc -w 2 -vz localhost $port 2>&1 | grep -q refused
        if [ $? -eq 0 ]; then
            break
        else
            port=""
        fi
    done
    if [ -z $port ]; then
        echo "No port available!"
        return 1
    fi
    url="http://localhost:$port"


    name=$(printf "swagger-%s" $(uuidgen))
    function cleanup {
        trap - SIGHUP SIGINT SIGTERM
        echo "Stopping swagger..."
        docker kill $name
    }
    trap cleanup SIGHUP SIGINT SIGTERM
    echo "Launching $name with $1"
    docker run --name $name -p $port:8080 -e SWAGGER_JSON=/api.yaml -v "$file":/api.yaml --rm swaggerapi/swagger-ui &
    pid=$!

    for i in $(seq 1 10); do
        if ps -p $pid > /dev/null; then
            nc -w 2 -vz localhost $port 2>&1 | grep -q open
            if [ $? -eq 0 ]; then
                break
            else
                echo "Waiting swagger to be ready..."
                sleep 1
            fi
        else
            echo "Failed to launch swagger!"
            return 1
        fi
    done

    echo "Please visit: $url"
    $OPEN_COMMAND "$url"
    wait $pid
}
