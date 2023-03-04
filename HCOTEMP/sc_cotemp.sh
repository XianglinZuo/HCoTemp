#!/bin/sh
# dataset=$1 port=$2

# python rec_main.py --model Static_COTEMP --prepare --epochs 5 --task ${dataset} >prep_${dataset}_sc.txt 2>&1 &&

# python rec_main.py --model Dynamic_COTEMP --prepare --epochs 5 --task ${dataset} --dynamic >prep_${dataset}_sc_dyn.txt 2>&1 &&

# # n_neighbor=200 n_scale=5
# python -m torch.distributed.launch --nproc_per_node=1 --master_port ${port} rec_run.py --model Dynamic_COTEMP --train --test --epochs 3 --task ${dataset} --period --P 6 >train_${dataset}_dc_p6_b32n1lr1e-4wd3e-4.txt 2>&1 &&

# python -m torch.distributed.launch --nproc_per_node=1 --master_port ${port} rec_run.py --model Dynamic_ID --train --test --epochs 3 --task ${dataset} --period --P 6 >train_${dataset}_di_p6_b32n1lr1e-4wd3e-4.txt 2>&1 &&

# python -m torch.distributed.launch --nproc_per_node=1 --master_port ${port} rec_run.py --model Dynamic_COTEMP --train --test --epochs 3 --task ${dataset} --dynamic >train_${dataset}_dc_dyn_b32n1lr1e-4wd3e-4.txt 2>&1 &&

# python -m torch.distributed.launch --nproc_per_node=1 --master_port ${port} rec_run.py --model Dynamic_ID --train --test --epochs 3 --task ${dataset} --dynamic >train_${dataset}_di_dyn_b32n1lr1e-4wd3e-4.txt 2>&1 &&

# python -m torch.distributed.launch --nproc_per_node=1 --master_port ${port} rec_run.py --model Static_COTEMP --train --test --epochs 3 --task ${dataset} >train_${dataset}_sc_b32n1lr1e-4wd3e-4.txt 2>&1 &&

# python -m torch.distributed.launch --nproc_per_node=1 --master_port ${port} rec_run.py --model Static_ID --train --test --epochs 3 --task ${dataset} >train_${dataset}_si_b32n1lr1e-4wd3e-4.txt 2>&1 &

dataset=$1

# python rec_run.py --model Static_ID --train --test --epochs 3 --weight_decay 3e-4 --task ${dataset} >train_${dataset}_si_b32n1lr1e-4wd3e-4.txt 2>&1 &&

# python rec_run.py --model Static_COTEMP --train --test --epochs 3 --weight_decay 3e-4 --task ${dataset} >train_${dataset}_sc_b32n1lr1e-4wd3e-4.txt 2>&1 &&

# python rec_run.py --model Dynamic_ID --train --test --epochs 3 --weight_decay 3e-4 --task ${dataset} --period --P 6 >train_${dataset}_di_p6_b32n1lr1e-4wd3e-4.txt 2>&1 &&

# python rec_run.py --model Dynamic_COTEMP --train --test --epochs 3 --weight_decay 3e-4 --task ${dataset} --period --P 6 >train_${dataset}_dc_p6_b32n1lr1e-4wd3e-4.txt 2>&1 &&

# python rec_run.py --model Dynamic_ID --train --test --epochs 3 --weight_decay 3e-4 --task ${dataset} --period --P 4 >train_${dataset}_di_p4_b32n1lr1e-4wd3e-4.txt 2>&1 &&

# python rec_run.py --model Dynamic_COTEMP --train --test --epochs 3 --weight_decay 3e-4 --task ${dataset} --period --P 4 >train_${dataset}_dc_p4_b32n1lr1e-4wd3e-4.txt 2>&1 &&

python rec_run.py --model Dynamic_ID --train --test --epochs 3 --weight_decay 3e-4 --task ${dataset} --dynamic >train_${dataset}_di_dyn_b32n1lr1e-4wd3e-4.txt 2>&1 &&

python rec_run.py --model Dynamic_COTEMP --train --test --epochs 3 --weight_decay 3e-4 --task ${dataset} --dynamic >train_${dataset}_dc_dyn_b32n1lr1e-4wd3e-4.txt 2>&1 &
