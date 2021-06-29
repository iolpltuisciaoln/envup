#
# DOCKER ALIASES. Fancy way
#

alias dex="docker exec -i -t"

dps() {
    # Docker ps
    #
    docker ps -a --format "{{.Names}};({{.Image}});{{.Ports}}" | sort -r | column -t -s ";" -W 4 | fzf +s --preview-window hidden
}

dsh() {
    # Shell into docker container, start if not started
    #
    local cid
    cid=$(docker ps -a --format "{{.Names}};({{.Image}});{{.Ports}}" | sort | column -t -s ";" -W 4 | fzf +s --preview-window hidden)
    cid=$(echo $cid | awk '{print $1}')
    [ -n "$cid" ] && docker start "$cid" && docker exec -it "$cid" sh
}

ds() {
    # Stahp Docker container
    #
    local cid
    cid=$(docker ps -a --format "{{.Names}};({{.Image}});{{.Ports}}" | sort | column -t -s ";" -W 4 | fzf +s --preview-window hidden)
    cid=$(echo $cid | awk '{print $1}')
    [ -n "$cid" ] && docker stop "$cid"
}

function dnames-fn {
    # helpin routine
    for ID in $(docker ps | awk '{print $1}' | grep -v 'CONTAINER'); do
        docker inspect $ID | grep Name | head -1 | awk '{print $2}' | sed 's/,//g' | sed 's%/%%g' | sed 's/"//g'
    done
}

function drm() {
    # Delete Docker container
    #
    local cid
    cid=$(docker ps -a | sed 1d | fzf --preview-window hidden -q "$1" | awk '{print $1}')
    [ -n "$cid" ] && docker rm "$cid"
}

function drmi() {
    # Delete Docker image
    #
    docker images | sed 1d | fzf -q "$1" --no-sort -m --tac --preview-window hidden | awk '{ print $3 }' | xargs -r docker rmi
}

function dip {
    # List Docker containers along with their ip-addresses
    #
    echo "IP addresses of all named running containers"

    for DOC in $(dnames-fn); do
        IP=$(docker inspect $DOC | grep -m3 IPAddress | cut -d '"' -f 4 | tr -d "\n")
        OUT+=$DOC'\t'$IP'\n'
    done
    echo -e $OUT | column -t
    unset $OUT
}

function dl-fn {
    docker logs $1
}

function dlf-fn {
    docker logs -f $1
}

alias dl=dl-fn
alias dlf='dlf-fn'
alias dpsa="docker ps -a"
alias dcu="docker-compose up"
alias dcud="docker-compose up -d"
alias dcd="docker-compose down"
alias dcr="docker-compose restart"