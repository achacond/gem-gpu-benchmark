
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
	module load CUDA/6.5.14
fi

if [[ -n $(hostname | grep node028) ]]; then
	binary_launcher="sbatch"
	cmake_bin="cmake28"

	source /etc/profile.d/modules.sh
	module load gcc/4.9.1
	module load cuda/6.5
fi

if [[ -n $(hostname | grep robin) ]]; then
	binary_launcher="sbatch"
	cmake_bin="cmake28"

	source /etc/profile.d/modules.sh
	module load gcc/4.9.1
	module load cuda/6.5
fi

if [[ -n $(hostname | grep huberman) ]]; then
	binary_launcher="sbatch"
	cmake_bin="cmake28"

	source /etc/profile.d/modules.sh
	module load gcc/4.9.1
	module load cuda/6.5
fi

