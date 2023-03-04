#!/bin/sh
# n_nei=$1
# CUDA_VISIBLE_DEVICES=4 ./sc_search.sh 1e-4 ${n_nei}

# CUDA_VISIBLE_DEVICES=5 ./sc_search.sh 3e-4 ${n_nei}

# CUDA_VISIBLE_DEVICES=6 ./sc_search.sh 1e-3 ${n_nei}

# CUDA_VISIBLE_DEVICES=7 ./sc_search.sh 3e-3 ${n_nei}



CUDA_VISIBLE_DEVICES=0 ./sc_cotemp.sh AM_Games
CUDA_VISIBLE_DEVICES=1 ./sc_cotemp.sh AM_Office
CUDA_VISIBLE_DEVICES=2 ./sc_cotemp.sh AM_CD
CUDA_VISIBLE_DEVICES=3 ./sc_cotemp.sh AM_Pets
