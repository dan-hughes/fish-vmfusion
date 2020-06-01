function __fish_print_vctl_images --description 'Print a list of vctl images'
    vctl images | command awk 'NR>=4 {print $1}'
end

function __fish_print_vctl_containers --description 'Print a list of vctl containers' -a select
	switch $select
		case running
			vctl ps --all | grep running | command awk '{print $1}'
		case stopped
			vctl ps --all | grep stopped | command awk '{print $1}'
		case all
			vctl ps --all | command awk 'NR>=4 {print $1}'
	end
end

# general
complete -c vctl -s h -l help -f -d 'Help for command'

# subcommands
# build
complete -c vctl -f -n '__fish_use_subcommand' -a build -d 'Build a container image from a Dockerfile'
complete -c vctl -f -n '__fish_seen_subcommand_from build' -l builder-mem -d 'Limit on memory available to the builder (in MB, must be a multiple of 4) (default 4096)'
complete -c vctl -f -n '__fish_seen_subcommand_from build' -s c -l credential -d 'Path to the file storing private registry authentication credentials'
complete -c vctl -n '__fish_seen_subcommand_from build' -s f -l file -d "Path to the target Dockerfile to build from (Default: PATH/Dockerfile)"
complete -c vctl -f -n '__fish_seen_subcommand_from build' -l no-local-cache -d 'Do not use local storage as cache for base image'
complete -c vctl -f -n '__fish_seen_subcommand_from build' -s t -l tag -d 'Name of the container image to build'
# complete -c vctl -f -n '__fish_seen_subcommand_from build' 

# create
complete -c vctl -f -n '__fish_use_subcommand' -a create -d 'Create a new container from a container image'
complete -c vctl -f -n '__fish_seen_subcommand_from create' -l entrypoint -d 'Override the default entrypoint of the container image'
complete -c vctl -F -n '__fish_seen_subcommand_from create' -s e -l env -d 'Environment variables to set in the container'
complete -c vctl -f -n '__fish_seen_subcommand_from create' -l hostname -d 'Host name of the container'
complete -c vctl -f -n '__fish_seen_subcommand_from create' -s i -l interactive -d 'Keep STDIN open even if not attached'
complete -c vctl -f -n '__fish_seen_subcommand_from create' -s l -l label -d 'Set additional labels to the container (e.g. foo=bar)'
complete -c vctl -f -n '__fish_seen_subcommand_from create' -s n -l name -d 'Assign a name to the container'
complete -c vctl -f -n '__fish_seen_subcommand_from create' -s r -l privileged -d 'Run the container with extended privileges'
complete -c vctl -f -n '__fish_seen_subcommand_from create' -s p -l publish -d 'Bind host network ports to container ports'
complete -c vctl -f -n '__fish_seen_subcommand_from create' -s t -l tty -d 'Allocate a terminal for the container'
complete -c vctl -f -n '__fish_seen_subcommand_from create' -s v -l volume -d 'Bind host folders to container folders'
complete -c vctl -f -n '__fish_seen_subcommand_from create' -s w -l workdir -d 'Working directory of the new process'
complete -c vctl -f -n '__fish_seen_subcommand_from create' -a '(__fish_print_vctl_images)'

# describe
complete -c vctl -f -n '__fish_use_subcommand' -a describe -d 'Show details of a container'
complete -c vctl -f -n '__fish_seen_subcommand_from describe' -s h -l help -d 'Help for describe'
complete -c vctl -f -n '__fish_seen_subcommand_from describe' -a '(__fish_print_vctl_containers all)'

# exec
complete -c vctl -f -n '__fish_use_subcommand' -a exec -d 'Execute a command within a running container'
complete -c vctl -f -n '__fish_seen_subcommand_from exec' -s i -l interactive -d 'Keep STDIN open even if not attached'
complete -c vctl -f -n '__fish_seen_subcommand_from exec' -s t -l tty -d 'Allocate a terminal for the container'
complete -c vctl -f -n '__fish_seen_subcommand_from exec' -a '(__fish_print_vctl_containers running)'

# execvm
complete -c vctl -f -n '__fish_use_subcommand' -a execvm -d 'Execute a command within a running virtual machine that hosts container'
complete -c vctl -f -n '__fish_seen_subcommand_from execvm' -s c -l container -d 'Use container as the identifier of the virtual machine hosting it'
complete -c vctl -f -n '__fish_seen_subcommand_from execvm' -s s -l sh -d 'Shell into the virtual machine'
complete -c vctl -F -n '__fish_seen_subcommand_from execvm; and not __fish_seen_argument -s c -l container' -a '(__fish_complete_suffix .vmx)'
complete -c vctl -f -n '__fish_seen_subcommand_from execvm; and __fish_seen_argument -s c -l container' -a '(__fish_print_vctl_containers running)'

# help
complete -c vctl -f -n '__fish_use_subcommand' -a help -d 'Help about any command'
complete -c vctl -f -n '__fish_seen_subcommand_from help' 

# images
complete -c vctl -f -n '__fish_use_subcommand' -a images -d 'List container images'
complete -c vctl -f -n '__fish_seen_subcommand_from images' -s d -l digests -d "Show digests"
complete -c vctl -f -n '__fish_seen_subcommand_from images' 

# ps
complete -c vctl -f -n '__fish_use_subcommand' -a ps -d 'List containers'
complete -c vctl -f -n '__fish_seen_subcommand_from ps' -s a -l all -d "Show all containers (Default only shows running containers)"
complete -c vctl -f -n '__fish_seen_subcommand_from ps' -s l -l label -d "Filter containers with additional labels (e.g. foo=bar)"
complete -c vctl -f -n '__fish_seen_subcommand_from ps' -a '(__fish_print_vctl_containers running)'

# pull
complete -c vctl -f -n '__fish_use_subcommand' -a pull -d 'Pull a container image from a registry'
complete -c vctl -f -n '__fish_seen_subcommand_from pull' -l http -d "Use plain http to connect remote registry (Default uses https)"
complete -c vctl -f -n '__fish_seen_subcommand_from pull' -s a -l password -d "Password used to connect remote registry"
complete -c vctl -f -n '__fish_seen_subcommand_from pull' -l password-stdin -d "Read password from stdin"
complete -c vctl -f -n '__fish_seen_subcommand_from pull' -l skip-ssl-check -d "Skip ssl certificate validation"
complete -c vctl -f -n '__fish_seen_subcommand_from pull' -s u -l username -d "Username used to connect remote registry"
complete -c vctl -f -n '__fish_seen_subcommand_from pull' -a '(__fish_print_vctl_images)'

# push
complete -c vctl -f -n '__fish_use_subcommand' -a push -d 'Push a container image to a registry'
complete -c vctl -f -n '__fish_seen_subcommand_from push' -l http -d "Use plain http to connect remote registry (Default uses https)"
complete -c vctl -f -n '__fish_seen_subcommand_from push' -s a -l password -d "Password used to connect remote registry"
complete -c vctl -f -n '__fish_seen_subcommand_from push' -l password-stdin -d "Read password from stdin"
complete -c vctl -f -n '__fish_seen_subcommand_from push' -l skip-ssl-check -d "Skip ssl certificate validation"
complete -c vctl -f -n '__fish_seen_subcommand_from push' -s u -l username -d "Username used to connect remote registry"
complete -c vctl -f -n '__fish_seen_subcommand_from push' -a '(__fish_print_vctl_images)'

# rm
complete -c vctl -f -n '__fish_use_subcommand' -a rm -d 'Remove one or more containers'
complete -c vctl -f -n '__fish_seen_subcommand_from rm' -s a -l all -d "Delete all containers"
complete -c vctl -f -n '__fish_seen_subcommand_from rm' -s f -l force -d "Force removal of container regardless of its status"
complete -c vctl -f -n '__fish_seen_subcommand_from rm' 
complete -c vctl -f -n '__fish_seen_subcommand_from rm' -a '(__fish_print_vctl_containers all)'

# rmi
complete -c vctl -f -n '__fish_use_subcommand' -a rmi -d 'Remove one or more container images'
complete -c vctl -f -n '__fish_seen_subcommand_from rmi' -s a -l all -d "Delete all images"
complete -c vctl -f -n '__fish_seen_subcommand_from rmi' -s f -l force -d "Force removal of image regardless of its status"
complete -c vctl -f -n '__fish_seen_subcommand_from rmi' -a '(__fish_print_vctl_images)'

# run
complete -c vctl -f -n '__fish_use_subcommand' -a run -d 'Run a new container from a container image'
complete -c vctl -f -n '__fish_seen_subcommand_from run' -s c -l cpus -d "Number of CPU cores (default 2)"
complete -c vctl -f -n '__fish_seen_subcommand_from run' -s d -l detach -d "Run the container in background"
complete -c vctl -f -n '__fish_seen_subcommand_from run' -l entrypoint -d "Override the default entrypoint of the container image"
complete -c vctl -f -n '__fish_seen_subcommand_from run' -s e -l env -d "Environment variables to set in the container"
complete -c vctl -f -n '__fish_seen_subcommand_from run' -l hostname -d "Host name of the container"
complete -c vctl -f -n '__fish_seen_subcommand_from run' -s i -l interactive -d "Keep STDIN open even if not attached"
complete -c vctl -f -n '__fish_seen_subcommand_from run' -l keepVM -d "[EXPERIMENTAL] Keep the host virtual machine running after container stops"
complete -c vctl -f -n '__fish_seen_subcommand_from run' -s l -l label -d "Set additional labels to the container (e.g. foo=bar)"
complete -c vctl -f -n '__fish_seen_subcommand_from run' -s m -l memory -d "Limit on memory available to the container (in MB, must be a multiple of 4) (default 512)"
complete -c vctl -f -n '__fish_seen_subcommand_from run' -s n -l name -d "Assign a name to the container"
complete -c vctl -f -n '__fish_seen_subcommand_from run' -s r -l privileged -d "Run the container with extended privileges"
complete -c vctl -f -n '__fish_seen_subcommand_from run' -s p -l publish -d "Bind host network ports to container ports"
complete -c vctl -f -n '__fish_seen_subcommand_from run' -s t -l tty -d "Allocate a terminal for the container"
complete -c vctl -f -n '__fish_seen_subcommand_from run' -s v -l volume -d "Bind host folders to container folders"
complete -c vctl -f -n '__fish_seen_subcommand_from run' -s w -l workdir -d "Working directory of the new process"
complete -c vctl -f -n '__fish_seen_subcommand_from run' -a '(__fish_print_vctl_images)'

# start
complete -c vctl -f -n '__fish_use_subcommand' -a start -d 'Start an existing container'
complete -c vctl -f -n '__fish_seen_subcommand_from start' -s c -l cpus -d "Number of CPU cores (default 2)"
complete -c vctl -f -n '__fish_seen_subcommand_from start' -s d -l detach -d "Run the container in background"
complete -c vctl -f -n '__fish_seen_subcommand_from start' -l keepVM -d "[EXPERIMENTAL] Keep the host virtual machine running after container stops"
complete -c vctl -f -n '__fish_seen_subcommand_from start' -s m -l memory -d "Limit on memory available to the container (in MB, must be a multiple of 4) (default 512)"
complete -c vctl -f -n '__fish_seen_subcommand_from start' -a '(__fish_print_vctl_containers stopped)'

# stop
complete -c vctl -f -n '__fish_use_subcommand' -a stop -d 'Stop a container'
complete -c vctl -f -n '__fish_seen_subcommand_from stop' -a '(__fish_print_vctl_containers running)'

# system
complete -c vctl -f -n '__fish_use_subcommand' -a system -d "Manage the Nautilus Container Engine"
# system config
complete -c vctl -f -n '__fish_seen_subcommand_from system; and not __fish_seen_subcommand_from config info start stop' -a config -d "Config and initialize the system environment for the Nautilus Container Engine"
complete -c vctl -f -n '__fish_seen_subcommand_from system; and __fish_seen_subcommand_from config' -l cache-location -d "Specify the cache file location (default "$HOME/.vctl")"
complete -c vctl -f -n '__fish_seen_subcommand_from system; and __fish_seen_subcommand_from config' -l mount-name -d "Mount name for container storage (default \"Fusion Container Storage\")"
complete -c vctl -f -n '__fish_seen_subcommand_from system; and __fish_seen_subcommand_from config' -s s -l storage -d "Container storage size (default "128g")"
complete -c vctl -f -n '__fish_seen_subcommand_from system; and __fish_seen_subcommand_from config' -s c -l vm-cpus -d "CPU cores of base virtual machine that hosts container (default 2)"
complete -c vctl -f -n '__fish_seen_subcommand_from system; and __fish_seen_subcommand_from config' -s m -l vm-mem -d "Memory size (MB) for virtual machine that hosts container (default 1024)"
complete -c vctl -f -n '__fish_seen_subcommand_from system; and __fish_seen_subcommand_from config'
# system info
complete -c vctl -f -n '__fish_seen_subcommand_from system; and not __fish_seen_subcommand_from config info start stop' -a info -d "Display the Nautilus Container Engine information"
complete -c vctl -f -n '__fish_seen_subcommand_from system; and __fish_seen_subcommand_from info'
# system start
complete -c vctl -f -n '__fish_seen_subcommand_from system; and not __fish_seen_subcommand_from config info start stop' -a start -d "Start the Nautilus Container Engine"
complete -c vctl -f -n '__fish_seen_subcommand_from system; and __fish_seen_subcommand_from start' -s c -l compact -d "Compact container storage upon start"
complete -c vctl -f -n '__fish_seen_subcommand_from system; and __fish_seen_subcommand_from start' -s l -l log-level -d "Log level for Nautilus Container Engine (default "info")"
complete -c vctl -f -n '__fish_seen_subcommand_from system; and __fish_seen_subcommand_from start; and __fish_seen_argument -s l -l log-level' -a "trace debug info warn error fatal panic"
complete -c vctl -F -n '__fish_seen_subcommand_from system; and __fish_seen_subcommand_from start' -l log-location -d "Log location for Nautilus Container Engine (default "$HOME/.vctl/containerd.log")"
complete -c vctl -f -n '__fish_seen_subcommand_from system; and __fish_seen_subcommand_from start'
# system stop
complete -c vctl -f -n '__fish_seen_subcommand_from system; and not __fish_seen_subcommand_from config info start stop' -a stop -d "Stop the Nautilus Container Engine"
complete -c vctl -f -n '__fish_seen_subcommand_from system; and __fish_seen_subcommand_from stop' -s c -l compact -d "Compact container storage upon stop"
complete -c vctl -f -n '__fish_seen_subcommand_from system; and __fish_seen_subcommand_from stop' -s f -l force -d "Force quit the Nautilus Container Engine and terminate backend virtual machines"
complete -c vctl -f -n '__fish_seen_subcommand_from system; and __fish_seen_subcommand_from stop'

# tag
complete -c vctl -f -n '__fish_use_subcommand' -a tag -d "Tag container images"
complete -c vctl -f -n '__fish_seen_subcommand_from tag' -s f -l force -d "Replace an existing image if the TARGET_IMAGE name has been taken" 
complete -c vctl -f -n '__fish_seen_subcommand_from tag' -a '(__fish_print_vctl_images)'

# version 
complete -c vctl -f -n '__fish_use_subcommand' -a version -d "Print the version of vctl"
complete -c vctl -f -n '__fish_seen_subcommand_from version' 
