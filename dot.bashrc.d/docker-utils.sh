# Functions for common docker-related actions
# Only works on linux
[[ $(uname -s) =~ Linux ]] || return 0

[ -w /var/run/docker.sock ] && CMD_PREFIX="" || CMD_PREFIX="sudo "
DOCKER_CMD="${CMD_PREFIX}docker"

# Cleanup dangling images
function docker-cleanup {
    # docker images -f 'dangling=true' -q | xargs -r docker rmi
    $DOCKER_CMD images -f 'dangling=true' -q | xargs -r $DOCKER_CMD rmi
}

# List volumes in use by some container (emit volume ids)
function volumes-used {
    $DOCKER_CMD inspect $($DOCKER_CMD ps -aq) | jq -r '[.[] | .Mounts | map(select(has("Name")))] | add | map(.Name) | .[]' | sort -u
}

# List volumes not in use by any container (emit volume ids)
function volumes-unused {
    diff --old-line-format="" --new-line-format="%L" --unchanged-line-format="" <(volumes-used) <($DOCKER_CMD volume ls -q | sort)
}

# Convert a list of volume ids (stdin) to a list of volume paths
function volume-paths {
    ${CMD_PREFIX} xargs -I VOL docker volume inspect VOL | jq -r '.[0].Mountpoint'
}

# Filter a list of volumes (stdin) for empty directories (emit paths)
function filter-empty {
    volume-paths | sudo xargs -I DIR find DIR -maxdepth 0 -empty -exec echo {} \;
}

# Filter a list of volumes (stdin) for non-empty directories (emit paths)
function filter-nonempty {
    volume-paths | sudo xargs -I DIR find DIR -maxdepth 0 -not -empty -exec echo {} \;
}
