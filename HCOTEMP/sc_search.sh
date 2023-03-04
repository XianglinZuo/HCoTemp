#!/bin/sh
lr=$1 n_scale=$2

# n_scale=5
python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 1e-4 --period --neighbor_train ${n_scale} >train_office_hgdc_p6_b32lr${lr}wd1e-4hdp0.5nei${n_scale}sc5nf128.txt 2>&1 &&

python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 3e-4 --period --neighbor_train ${n_scale} >train_office_hgdc_p6_b32lr${lr}wd3e-4hdp0.5nei${n_scale}sc5nf128.txt 2>&1 &&

python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 1e-3 --period --neighbor_train ${n_scale} >train_office_hgdc_p6_b32lr${lr}wd1e-3hdp0.5nei${n_scale}sc5nf128.txt 2>&1 &&

python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 3e-3 --period --neighbor_train ${n_scale} >train_office_hgdc_p6_b32lr${lr}wd3e-3hdp0.5nei${n_scale}sc5nf128.txt 2>&1 &&

# n_scale=2
python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 1e-4 --period --neighbor_train ${n_scale} --neighbor_scale 2 >train_office_hgdc_p6_b32lr${lr}wd1e-4hdp0.5nei${n_scale}sc2nf128.txt 2>&1 &&

python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 3e-4 --period --neighbor_train ${n_scale}  --neighbor_scale 2 >train_office_hgdc_p6_b32lr${lr}wd3e-4hdp0.5nei${n_scale}sc2nf128.txt 2>&1 &&

python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 1e-3 --period --neighbor_train ${n_scale}  --neighbor_scale 2 >train_office_hgdc_p6_b32lr${lr}wd1e-3hdp0.5nei${n_scale}sc2nf128.txt 2>&1 &&

python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 3e-3 --period --neighbor_train ${n_scale}  --neighbor_scale 2 >train_office_hgdc_p6_b32lr${lr}wd3e-3hdp0.5nei${n_scale}sc2nf128.txt 2>&1 &

# # NF=64
# python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --NF 64 --lr ${lr} --weight_decay 1e-4 --period --neighbor_train ${n_scale} >train_cd_hgdc_p6_b32lr${lr}wd1e-4hdp0.5nei${n_scale}sc5nf64.txt 2>&1 &&

# python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --NF 64 --lr ${lr} --weight_decay 3e-4 --period --neighbor_train ${n_scale} >train_cds_hgdc_p6_b32lr${lr}wd3e-4hdp0.5nei${n_scale}sc5nf64.txt 2>&1 &&

# python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --NF 64 --lr ${lr} --weight_decay 1e-3 --period --neighbor_train ${n_scale} >train_cds_hgdc_p6_b32lr${lr}wd1e-3hdp0.5nei${n_scale}sc5nf64.txt 2>&1 &&

# python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --NF 64 --lr ${lr} --weight_decay 3e-3 --period --neighbor_train ${n_scale} >train_cds_hgdc_p6_b32lr${lr}wd3e-3hdp0.5nei${n_scale}sc5nf64.txt 2>&1 &





## n_neighbor=200 n_scale=4
#python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 1e-4 --period --han_dropout 0.5 --neighbor_train 4 >train_cd_hgdc_p6_b32lr${lr}wd1e-4hdp0.5nei${n_scale}sc4.txt 2>&1 &&
#
#python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 3e-4 --period --han_dropout 0.5 --neighbor_train 4 >train_cd_hgdc_p6_b32lr${lr}wd3e-4hdp0.5nei${n_scale}sc4.txt 2>&1 &&
#
#python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 1e-3 --period --han_dropout 0.5 --neighbor_train 4 >train_cd_hgdc_p6_b32lr${lr}wd1e-3hdp0.5nei${n_scale}sc4.txt 2>&1 &&
#
#python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 3e-3 --period --han_dropout 0.5 --neighbor_train 4 >train_cd_hgdc_p6_b32lr${lr}wd3e-3hdp0.5nei${n_scale}sc4.txt 2>&1 &&
#
## n_neighbor=200 n_scale=3
#python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 1e-4 --period --han_dropout 0.5 --neighbor_train 3 >train_cd_hgdc_p6_b32lr${lr}wd1e-4hdp0.5nei${n_scale}sc3.txt 2>&1 &&
#
#python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 3e-4 --period --han_dropout 0.5 --neighbor_train 3 >train_cd_hgdc_p6_b32lr${lr}wd3e-4hdp0.5nei${n_scale}sc3.txt 2>&1 &&
#
#python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 1e-3 --period --han_dropout 0.5 --neighbor_train 3 >train_cd_hgdc_p6_b32lr${lr}wd1e-3hdp0.5nei${n_scale}sc3.txt 2>&1 &&
#
#python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr ${lr} --weight_decay 3e-3 --period --han_dropout 0.5 --neighbor_train 3 >train_cd_hgdc_p6_b32lr${lr}wd3e-3hdp0.5nei${n_scale}sc3.txt 2>&1 &

# python rec_run_hg_v2.py --train --test --epochs 3 --batch_train 32 --batch_eval 64 --lr 1e-4 --weight_decay 3e-3 --period --neighbor_train 200 >train_cd_hgdc_p6_b32lr1e-4wd3e-3hdp0.5nei200sc5.txt 2>&1 &