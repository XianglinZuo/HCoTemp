#!/bin/sh
# dataset=$1
# python rec_main.py --model Static_ID --prepare --epochs 5 --task ${dataset} >prep_${dataset}_si.txt 2>&1 &&
# python rec_main.py --model Static_COTEMP --prepare --epochs 5 --task ${dataset} >prep_${dataset}_sc.txt 2>&1 &&

# python rec_main.py --model Dynamic_ID_GRAPH --prepare --epochs 5 --task ${dataset} --period --P 4 >prep_${dataset}_dig_p4.txt 2>&1 &&
# python rec_main.py --model Dynamic_COTEMP_GRAPH --prepare --epochs 5 --task ${dataset} --period --P 4 >prep_${dataset}_dcg_p4.txt 2>&1 &
# python rec_main.py --model Dynamic_ID_GRAPH --prepare --epochs 5 --task ${dataset} --period --P 6 >prep_${dataset}_dig_p6.txt 2>&1 &&
# python rec_main.py --model Dynamic_COTEMP_GRAPH --prepare --epochs 5 --task ${dataset} --period --P 6 >prep_${dataset}_dcg_p6.txt 2>&1 &

# python rec_main.py --model Dynamic_ID --prepare --epochs 5 --task ${dataset} --dynamic >prep_${dataset}_di.txt 2>&1 &&
# python rec_main.py --model Dynamic_COTEMP --prepare --epochs 5 --task ${dataset} --dynamic >prep_${dataset}_dc.txt 2>&1 &&

# python rec_main.py --model Dynamic_COTEMP --prepare --epochs 5 --task AM_Games --period --P 4 >prep_AM_Games_dcg_p4.txt 2>&1 &&
# python rec_main.py --model Dynamic_COTEMP --prepare --epochs 5 --task AM_Office --period --P 4 >prep_AM_Office_dcg_p4.txt 2>&1 &&
# python rec_main.py --model Dynamic_COTEMP --prepare --epochs 5 --task AM_CD --period --P 4 >prep_AM_CD_dcg_p4.txt 2>&1 &&
# python rec_main.py --model Dynamic_COTEMP --prepare --epochs 5 --task AM_Pets --period --P 4 >prep_AM_Pets_dcg_p4.txt 2>&1 &

# CUDA_VISIBLE_DEVICES=0,1,2,3 nohup python -m torch.distributed.launch --nproc_per_node=4  rec_run.py --model Dynamic_ID --train --epochs 3 --weight_decay 3e-4 --task AM_Games --dynamic --batch_train 8 --batch_eval 8 >train_AM_Games_di_dyn_b8n4lr1e-4wd3e-4.txt 2>&1 &&

# CUDA_VISIBLE_DEVICES=0,1,2,3 nohup python -m torch.distributed.launch --nproc_per_node=4  rec_run.py --model Dynamic_COTEMP --train --epochs 3 --weight_decay 3e-4 --task AM_Games --dynamic --batch_train 8 --batch_eval 8 >train_AM_Games_dc_dyn_b8n4lr1e-4wd3e-4.txt 2>&1 &&

# CUDA_VISIBLE_DEVICES=0,1,2,3 nohup python -m torch.distributed.launch --nproc_per_node=4  rec_run.py --model Dynamic_ID --train --epochs 3 --weight_decay 3e-4 --task AM_Office --dynamic --batch_train 8 --batch_eval 8 >train_AM_Office_di_dyn_b8n4lr1e-4wd3e-4.txt 2>&1 &&

CUDA_VISIBLE_DEVICES=0,1,2,3 nohup python -m torch.distributed.launch --nproc_per_node=4  rec_run.py --model Dynamic_COTEMP --train --epochs 3 --weight_decay 3e-4 --task AM_Office --dynamic --batch_train 8 --batch_eval 8 >train_AM_Office_dc_dyn_b8n4lr1e-4wd3e-4.txt 2>&1 &&

CUDA_VISIBLE_DEVICES=0,1,2,3 nohup python -m torch.distributed.launch --nproc_per_node=4  rec_run.py --model Dynamic_ID --train --epochs 3 --weight_decay 3e-4 --task AM_CD --dynamic --batch_train 8 --batch_eval 8 >train_AM_CD_di_dyn_b8n4lr1e-4wd3e-4.txt 2>&1 &&

CUDA_VISIBLE_DEVICES=0,1,2,3 nohup python -m torch.distributed.launch --nproc_per_node=4  rec_run.py --model Dynamic_COTEMP --train --epochs 3 --weight_decay 3e-4 --task AM_CD --dynamic --batch_train 8 --batch_eval 8 >train_AM_CD_dc_dyn_b8n4lr1e-4wd3e-4.txt 2>&1 &&

CUDA_VISIBLE_DEVICES=0,1,2,3 nohup python -m torch.distributed.launch --nproc_per_node=4  rec_run.py --model Dynamic_ID --train --epochs 3 --weight_decay 3e-4 --task AM_Pets --dynamic --batch_train 8 --batch_eval 8 >train_AM_Pets_di_dyn_b8n4lr1e-4wd3e-4.txt 2>&1 &&

CUDA_VISIBLE_DEVICES=0,1,2,3 nohup python -m torch.distributed.launch --nproc_per_node=4  rec_run.py --model Dynamic_COTEMP --train --epochs 3 --weight_decay 3e-4 --task AM_Pets --dynamic --batch_train 8 --batch_eval 8 >train_AM_Pets_dc_dyn_b8n4lr1e-4wd3e-4.txt 2>&1 &
