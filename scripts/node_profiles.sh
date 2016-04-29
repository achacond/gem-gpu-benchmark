
# node default parameters
binary_launcher="bash"
cmake_bin="cmake"
num_threads=`grep -c ^processor /proc/cpuinfo`
export CUDA_VISIBLE_DEVICES=0


# node specific parameters
if [[ -n $(hostname | grep aopccuda) ]]; then
	binary_launcher="bash"
	cmake_bin="cmake"

	source /etc/profile.d/module.sh
	module load GCC/4.9.1
	module load CUDA/7.5.18
fi

if [[ -n $(hostname | grep node028) ]]; then
	binary_launcher="sbatch"
	cmake_bin="cmake28"

	source /opt/Modules/3.2.9/init/Modules4bash.sh
	module load gcc/4.9.1
	module load cuda/7.5
	module load likwid/4.0.1
fi

if [[ -n $(hostname | grep robin) ]]; then
	binary_launcher="sbatch"
	cmake_bin="cmake28"

	source /opt/Modules/3.2.9/init/Modules4bash.sh
	module load gcc/4.9.1
	module load cuda/7.5
	module load likwid/4.0.1
fi

if [[ -n $(hostname | grep huberman) ]]; then
	binary_launcher="sbatch"
	cmake_bin="cmake28"

	export CUDA_VISIBLE_DEVICES=0
	source /opt/Modules/3.2.9/init/Modules4bash.sh
	module load gcc/4.9.1
	module load cuda/7.5
	module load likwid/4.0.1
fi

if [[ -n $(hostname | grep bane) ]]; then
	binary_launcher="sbatch"
	cmake_bin="cmake"

	export CUDA_VISIBLE_DEVICES=0
	source /opt/Modules/3.2.9/init/Modules4bash.sh
	module load gcc/4.9.1
	module load cuda/7.5
	module load likwid/4.0.1
fi

