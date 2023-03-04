import random

import ujson as json
import os
import pandas as pd
from tqdm import tqdm
from rec_util import dump_pkl


class BasicParser(object):
    def __init__(self, file_path, user_in, item_in, T, P, data_type):
        print("Generating {} samples...".format(data_type))
        user_path = os.path.join(file_path, user_in)
        self.ulines = open(user_path, 'r').readlines()
        item_path = os.path.join(file_path, item_in)
        self.ilines = open(item_path, 'r').readlines()
        self.NU = len(self.ulines)
        self.NI = len(self.ilines)
        self.T = T
        self.P = P
        print("Initial users {} items {}".format(self.NU, self.NI))

    def parse_record(self, user_out, item_out, ulen_out, ilen_out):
        print("Parsing user records...")
        urecords, urec_length = [], []
        for line in self.ulines:
            urecords.append(json.loads(line))
        for uid, record in tqdm(enumerate(urecords), total=len(urecords)):
            uid = str(uid + 1)
            u_len = len(record[uid])  # 每个用户有几个月的记录
            if u_len == 0:
                print(uid)
            if u_len >= self.T:
                record[uid] = record[uid][:self.T]
                u_len = self.T
            else:
                for i in range(self.T - u_len):
                    record[uid].append([0])
            urec_length.append(u_len)
        print("Parsing item records...")
        irecords, irec_length = [], []
        for line in self.ilines:
            irecords.append(json.loads(line))
        for iid, record in tqdm(enumerate(irecords), total=len(irecords)):
            iid = str(iid + 1)
            i_len = len(record[iid])
            if i_len == 0:
                print(iid)
            if i_len >= self.T:
                record[iid] = record[iid][:self.T]
                i_len = self.T
            else:
                for i in range(self.T - i_len):
                    record[iid].append([0])
            irec_length.append(i_len)

        # dump_pkl(user_out, urecords)
        # dump_pkl(item_out, irecords)
        # dump_pkl(ulen_out, urec_length)
        # dump_pkl(ilen_out, irec_length)

    def parse_set(self, file_path, name_in, name_out, data_type, task):
        print("Generating {} samples...".format(data_type))

        col_type = {"uids": 'Int32', "Int32": 'str', "labels": 'Float32'}
        full_path = os.path.join(file_path, name_in)
        raw = pd.read_csv(full_path, sep=',', dtype=col_type)
        uids, iids, labels = [], [], []
        for i, row in tqdm(raw.iterrows(), total=len(raw)):
            uid, iid, label = row['uids'], row['iids'], row['labels']
            # 扩展到长度T后，与record emb相加
            if task == 'static':
                uids.append([uid] * self.T)
                iids.append([iid] * self.T)
            elif task == 'dynamic':
                uids.append([t * self.NU + uid for t in range(self.T)])
                iids.append([t * self.NI + iid for t in range(self.T)])
            else:
                uids.append([t % self.P * self.NU + uid for t in range(self.T)])
                iids.append([t % self.P * self.NI + iid for t in range(self.T)])
            labels.append(label)

        processed = {'uids': uids, 'iids': iids, 'labels': labels}
        dump_pkl(name_out, processed)
        print("Dump done!")

    def gen_neg_set(self, file_path, test_in, test_out, data_type, task, train_in):
        print("Generating {} negative samples...".format(data_type))

        urecords, irecords = {}, {}
        user_ids, item_ids = [], []
        for uline in self.ulines:
            u_rec = json.loads(uline)
            uid = list(u_rec.keys())[0]
            user_ids.append(uid)
            item_lst = []
            for x in u_rec[uid]:
                item_lst.extend(x)
            urecords[uid] = item_lst
        for iline in self.ilines:
            i_rec = json.loads(iline)
            iid = list(i_rec.keys())[0]
            item_ids.append(iid)
            user_lst = []
            for x in i_rec[iid]:
                user_lst.extend(x)
            irecords[iid] = user_lst

        col_type = {"uids": 'str', "iids": 'str', "labels": 'Float64'}
        train_raw = pd.read_csv(os.path.join(file_path, train_in), sep=',', dtype=col_type)
        for i, row in train_raw.iterrows():
            uid, iid, label = row['uids'], row['iids'], row['labels']
            if row['labels'] == 0:
                continue
            urecords[uid].append(iid)

        raw = pd.read_csv(os.path.join(file_path, test_in), sep=',', dtype=col_type)
        test_urecords = {}
        for i, row in raw.iterrows():
            uid, iid, label = row['uids'], row['iids'], row['labels']
            if label == 0:
                continue
            if uid in test_urecords:
                test_urecords[uid].append(iid)
            else:
                test_urecords[uid] = [iid]
        uids, iids, labels = [], [], []
        for i, row in raw.iterrows():
            uid, iid, label = row['uids'], row['iids'], row['labels']
            if label == 0:
                continue
            uids.extend([uid] * 100)
            iids.append(iid)
            labels.append(label)
            neg_lst = list(random.sample(set(item_ids) - (set(urecords[uid]) | set(test_urecords[uid])), 99))
            iids.extend(neg_lst)
            labels.extend([0] * 99)

        df = pd.DataFrame({'uids': uids, 'iids': iids, 'labels': labels})
        df.to_csv(os.path.join(file_path, 'test_neg.csv'), sep=',', index=False)


class DynamicParser(BasicParser):
    def parse_record(self, user_out, item_out, ulen_out, ilen_out):
        print("Parsing user records...")
        urecords, urec_length = [], []
        for line in self.ulines:
            urecords.append(json.loads(line))
        for uid, record in tqdm(enumerate(urecords), total=len(urecords)):
            uid = str(uid + 1)
            u_len = len(record[uid])
            # u_raw_length.append(u_len)
            if u_len >= self.T:
                record[uid] = record[uid][:self.T]
                u_len = self.T
            else:
                for i in range(self.T - u_len):
                    record[uid].append([0])
            for t in range(u_len):
                # record[uid][t] 第t月与user有交互的item list
                for idx, ut_i in enumerate(record[uid][t]):
                    record[uid][t][idx] = t * self.NI + ut_i  # 按第t月寻找组 按id偏移 方便id对应到item的第t个月的embedding
            urec_length.append(u_len)
        print("Parsing item records...")
        irecords, irec_length = [], []
        for line in self.ilines:
            irecords.append(json.loads(line))
        for iid, record in tqdm(enumerate(irecords), total=len(irecords)):
            iid = str(iid + 1)
            i_len = len(record[iid])
            # i_raw_length.append(i_len)
            if i_len >= self.T:
                record[iid] = record[iid][: self.T]
                i_len = self.T
            else:
                for i in range(self.T - i_len):
                    record[iid].append([0])
            for t in range(i_len):
                for idx, it_u in enumerate(record[iid][t]):
                    record[iid][t][idx] = t * self.NU + it_u
            irec_length.append(i_len)

        # dump_pkl(user_out, urecords)
        # dump_pkl(item_out, irecords)
        # dump_pkl(ulen_out, urec_length)
        # dump_pkl(ilen_out, irec_length)


class PeriodParser(BasicParser):
    def parse_record(self, user_out, item_out, ulen_out, ilen_out):
        print("Parsing user records...")
        urecords, urec_length = [], []
        for line in self.ulines:  # each line is the records of an user, key=user_id value=records
            urecords.append(json.loads(line))
        for uid, record in tqdm(enumerate(urecords), total=len(urecords)):
            uid = str(uid + 1)
            u_len = len(record[uid])  # each sublist is the records in a month
            # u_raw_length.append(u_len)
            if u_len >= self.T:
                record[uid] = record[uid][:self.T]
                u_len = self.T
            else:
                for i in range(self.T - u_len):
                    record[uid].append([0])
            for t in range(u_len):
                for idx, ut_i in enumerate(record[uid][t]):
                    record[uid][t][idx] = t % self.P * self.NI + ut_i  # 按第t月寻找组 按id偏移
            urec_length.append(u_len)
        print("Parsing item records...")
        irecords, irec_length = [], []
        for line in self.ilines:
            irecords.append(json.loads(line))
        for iid, record in tqdm(enumerate(irecords), total=len(irecords)):
            iid = str(iid + 1)
            i_len = len(record[iid])
            # i_raw_length.append(i_len)
            if i_len >= self.T:
                record[iid] = record[iid][:self.T]
                i_len = self.T
            else:
                for i in range(self.T - i_len):
                    record[iid].append([0])
            for t in range(i_len):
                for idx, it_u in enumerate(record[iid][t]):
                    record[iid][t][idx] = t % self.P * self.NU + it_u
            irec_length.append(i_len)

        # dump_pkl(user_out, urecords)
        # dump_pkl(item_out, irecords)
        # dump_pkl(ulen_out, urec_length)
        # dump_pkl(ilen_out, irec_length)


def run_prepare(config, flags):
    if config.dynamic:
        parser = DynamicParser(config.raw_dir, config.user_record_file, config.item_record_file,
                               config.T, config.P, 'record')
        parser.parse_record(flags.user_record_file, flags.item_record_file,
                            flags.user_length_file, flags.item_length_file)
        task = 'dynamic'
        # num_user, num_item = dynamic_parser.NU, dynamic_parser.NI
        # parse_dynamic_set(config.raw_dir, config.train_file, config.T, num_user, num_item, flags.train_file, 'train')
        # parse_dynamic_set(config.raw_dir, config.valid_file, config.T, num_user, num_item, flags.valid_file, 'valid')
        # parse_dynamic_set(config.raw_dir, config.test_file, config.T, num_user, num_item, flags.test_file, 'test')
    elif config.period:
        parser = PeriodParser(config.raw_dir, config.user_record_file, config.item_record_file,
                              config.T, config.P, 'record')
        parser.parse_record(flags.user_record_file, flags.item_record_file,
                            flags.user_length_file, flags.item_length_file)
        task = 'period'
        # num_user, num_item = period_parser.NU, period_parser.NI
        # parse_period_set(config.raw_dir, config.train_file, config.T, config.P, num_user, num_item, flags.train_file,
        #                  'train')
        # parse_period_set(config.raw_dir, config.valid_file, config.T, config.P, num_user, num_item, flags.valid_file,
        #                  'valid')
        # parse_period_set(config.raw_dir, config.test_file, config.T, config.P, num_user, num_item, flags.test_file,
        #                  'test')
    else:
        parser = BasicParser(config.raw_dir, config.user_record_file, config.item_record_file,
                             config.T, config.P, 'record')
        parser.parse_record(flags.user_record_file, flags.item_record_file,
                            flags.user_length_file, flags.item_length_file)
        task = 'static'
        # parse_set(config.raw_dir, config.train_file, config.T, flags.train_file, 'train')
        # parse_set(config.raw_dir, config.valid_file, config.T, flags.valid_file, 'valid')
        # parse_set(config.raw_dir, config.test_file, config.T, flags.test_file, 'test')

    parser.parse_set(config.raw_dir, config.test_file, flags.test_file, 'test', task)
    # parser.gen_neg_set(config.raw_dir, config.test_file, flags.test_file, 'test', task, config.train_file)
    # parser.parse_set(config.raw_dir, config.train_file, flags.train_file, 'train', task)
    # parser.parse_set(config.raw_dir, config.valid_file, flags.valid_file, 'valid', task)
