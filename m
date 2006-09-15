From: "Roger Lucas" <roger@planbit.co.uk>
Subject: Kernel eats memory with LG-81  motherboard , acpi_operand possible culprit?
Date: Fri, 15 Sep 2006 13:19:10 +0100
Message-ID: <20060915121912.852C112EDE@bluewhale.planbit.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 82-71-36-240.dsl.in-addr.zen.co.uk ([82.71.36.240]:48516 "EHLO
	bluewhale.planbit.co.uk") by vger.kernel.org with ESMTP
	id S1751342AbWIOMTO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Sep 2006 08:19:14 -0400
Received: from wolverine (unknown [192.168.1.127])
	by bluewhale.planbit.co.uk (Postfix) with ESMTP id 852C112EDE
	for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2006 13:19:12 +0100 (BST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I am running Linux kernel 2.6.16.20 with ACPI active on a Abit LG-81
motherboard.  Over time, the system slowly runs out of memory.  Checking
with "top" suggests that none of the processes are to blame since there
aren't that many running...

top - 13:14:52 up 14 days, 20:45,  2 users,  load average: 0.23, 0.18, 0.17
Tasks:  70 total,   1 running,  69 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.7% us,  0.6% sy,  0.0% ni, 97.9% id,  0.7% wa,  0.0% hi,  0.0% si
Mem:    508780k total,   496700k used,    12080k free,     2432k buffers
Swap:        0k total,        0k used,        0k free,    10700k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
    1 root      16   0  1588  124   56 S  0.0  0.0   0:01.27 init
    2 root      34  19     0    0    0 S  0.0  0.0   0:00.85 ksoftirqd/0
    3 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 watchdog/0
    4 root      10  -5     0    0    0 S  0.0  0.0   0:00.00 events/0
    5 root      10  -5     0    0    0 S  0.0  0.0   0:00.00 khelper
    6 root      10  -5     0    0    0 S  0.0  0.0   0:00.00 kthread
    8 root      10  -5     0    0    0 S  0.0  0.0   0:01.78 kblockd/0
    9 root      10  -5     0    0    0 S  0.0  0.0  62:14.03 kacpid
  140 root      15   0     0    0    0 S  0.0  0.0   0:34.30 pdflush
  141 root      15   0     0    0    0 S  0.0  0.0   0:20.82 pdflush
  143 root      15  -5     0    0    0 S  0.0  0.0   0:00.00 aio/0
  142 root      15   0     0    0    0 S  0.0  0.0   0:36.16 kswapd0
  733 root      10  -5     0    0    0 S  0.0  0.0   0:00.00 kseriod
 1131 root      10  -5     0    0    0 S  0.0  0.0   0:00.00 khubd
 1438 root      10  -5     0    0    0 S  0.0  0.0   0:00.00 kpsmoused
 1637 root      10  -5     0    0    0 S  0.0  0.0   0:10.21 ata/0
 1713 root      11  -5     0    0    0 S  0.0  0.0   0:00.00 scsi_eh_0
 1714 root      11  -5     0    0    0 S  0.0  0.0   0:00.00 scsi_eh_1
 4033 root      10  -5     0    0    0 S  0.0  0.0   1:11.54 md0_raid1
 4230 root      12  -4  2212  276   96 S  0.0  0.1   0:00.26 udevd
 5945 root      15   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
 5949 root      10  -5     0    0    0 S  0.0  0.0   1:01.63 reiserfs/0
 6280 daemon    15   0  1688   80    0 S  0.0  0.0   0:00.00 portmap
 6480 root      16   0  2332  360  228 S  0.0  0.1   0:27.96 syslogd
 6483 root      15   0  2340  892   40 S  0.0  0.2   0:00.08 klogd
 6488 root      16   0 19784  528  288 S  0.0  0.1   2:13.92 apcupsd
 6496 root      15   0  3332 1668 1064 S  0.0  0.3   0:24.06 openvpn
 6557 root      21   0  2316   76    0 S  0.0  0.0   0:00.00 inetd
 6658 www-data  21   0  1756   76    0 S  0.0  0.0   0:00.00 daemon-helper
 6661 root      22   0  1756   76    0 S  0.0  0.0   0:00.00 daemon-helper
 6767 root      16   0  3744  336  144 S  0.0  0.1   0:00.06 master
 6769 postfix   17   0  3080  472  280 S  0.0  0.1   0:00.13 qmgr
 6775 root      16   0  5620  900  432 S  0.0  0.2   0:01.68 nmbd
 6777 root      15   0  8256  900  280 S  0.0  0.2   0:00.19 smbd
 6786 root      18   0  8256  608    4 S  0.0  0.1   0:00.00 smbd
 6788 root      16   0  3548  404  160 S  0.0  0.1   0:00.01 sshd
 6810 root      18   0  2452   96    0 S  0.0  0.0   0:00.00 rpc.statd
 6819 root      16   0  1900  452  128 S  0.0  0.1   0:00.82 mdadm
 6850 root      10  -5     0    0    0 S  0.0  0.0   1:10.77 kcryptd/0
 6873 root      16   0  1956  480  304 S  0.0  0.1   0:00.79 chronyd
 6876 root      16   0  1820  264  124 S  0.0  0.1   0:01.13 cron
 6884 root      16   0  1868  196   88 S  0.0  0.0   0:00.00 egor
 6932 root      16   0  1584   68    0 S  0.0  0.0   0:00.00 getty
 6933 root      16   0  1580   64    0 S  0.0  0.0   0:00.00 getty
 6934 root      16   0  1584   68    0 S  0.0  0.0   0:00.00 getty
 6935 root      16   0  1580   64    0 S  0.0  0.0   0:00.00 getty
 6936 root      16   0  1580   64    0 S  0.0  0.0   0:00.00 getty
 6937 root      16   0  1580   64    0 S  0.0  0.0   0:00.00 getty
22615 root      16   0 12096 1400   56 S  0.0  0.3   0:00.03 apache2
22621 www-data  21   0 12096 1356    0 S  0.0  0.3   0:00.00 apache2
22622 www-data  21   0 12096 1356    0 S  0.0  0.3   0:00.00 apache2
22623 www-data  21   0 12096 1356    0 S  0.0  0.3   0:00.00 apache2
22624 www-data  21   0 12096 1356    0 S  0.0  0.3   0:00.00 apache2
22625 www-data  21   0 12096 1356    0 S  0.0  0.3   0:00.00 apache2
23215 lp        19   0  2532  116    0 S  0.0  0.0   0:00.00 lpd
11442 root      16   0  8964 2912 1812 S  0.0  0.6   0:04.24 smbd
11784 root      16   0  8696 1500  736 S  0.0  0.3   0:00.66 smbd
11816 root      16   0  8852 1812  880 S  0.0  0.4   0:02.18 smbd
11831 root      16   0  8816 1864  928 S  0.0  0.4   0:00.95 smbd
11890 root      16   0  8852 2752 1748 S  0.0  0.5   0:02.16 smbd
12005 root      16   0  8696 1692  944 S  0.0  0.3   0:01.16 smbd
12049 root      16   0  8848 2728 1772 S  0.0  0.5   0:02.74 smbd
12066 root      16   0  9004 1944  940 S  0.0  0.4   0:03.46 smbd
14385 root      15   0 14688 1152  760 S  0.0  0.2   0:00.12 sshd
14388 root      15   0  3064 1348  920 S  0.0  0.3   0:00.04 bash
14698 root      25   0  1584  472  388 S  0.0  0.1   0:00.00 acpid
15650 postfix   16   0  3052 1132  960 S  0.0  0.2   0:00.00 pickup
15847 root      15   0 14688 1832 1440 S  0.0  0.4   0:00.01 sshd
15850 root      15   0  3084 1668 1224 S  0.0  0.3   0:00.01 bash
16070 root      15   0  2128  948  736 R  0.0  0.2   0:00.00 top


When I looked into the kernel slabinfo, however, I saw that acpi had
allocated over 10 million acpi_operand blocks of 40 bytes each!  I suspect
that this is the culprit.

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab>
<pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata
<active_slabs> <num_slabs> <sharedavail>
dm-snapshot-in       128    134     56   67    1 : tunables  120   60    0 :
slabdata      2      2      0
dm-snapshot-ex         0      0     24  145    1 : tunables  120   60    0 :
slabdata      0      0      0
dm-crypt_io          256    616     68   56    1 : tunables  120   60    0 :
slabdata     11     11      0
fib6_nodes             5    113     32  113    1 : tunables  120   60    0 :
slabdata      1      1      0
ip6_dst_cache          4     15    256   15    1 : tunables  120   60    0 :
slabdata      1      1      0
ndisc_cache            1     15    256   15    1 : tunables  120   60    0 :
slabdata      1      1      0
RAWv6                  4      6    640    6    1 : tunables   54   27    0 :
slabdata      1      1      0
UDPv6                  0      0    640    6    1 : tunables   54   27    0 :
slabdata      0      0      0
tw_sock_TCPv6          0      0    128   30    1 : tunables  120   60    0 :
slabdata      0      0      0
request_sock_TCPv6      0      0    128   30    1 : tunables  120   60    0
: slabdata      0      0      0
TCPv6                  4      7   1152    7    2 : tunables   24   12    0 :
slabdata      1      1      0
ip_fib_alias          12    113     32  113    1 : tunables  120   60    0 :
slabdata      1      1      0
ip_fib_hash           12    113     32  113    1 : tunables  120   60    0 :
slabdata      1      1      0
dm_tio              1037   2030     16  203    1 : tunables  120   60    0 :
slabdata     10     10      0
dm_io               1037   2028     20  169    1 : tunables  120   60    0 :
slabdata     12     12      0
scsi_cmd_cache        10     10    384   10    1 : tunables   54   27    0 :
slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 :
slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 :
slabdata      8      8      0
sgpool-32             34     40    512    8    1 : tunables   54   27    0 :
slabdata      5      5      0
sgpool-16             33     45    256   15    1 : tunables  120   60    0 :
slabdata      3      3      0
sgpool-8              36     60    128   30    1 : tunables  120   60    0 :
slabdata      2      2      0
scsi_io_context        0      0    104   37    1 : tunables  120   60    0 :
slabdata      0      0      0
uhci_urb_priv         37     92     40   92    1 : tunables  120   60    0 :
slabdata      1      1      0
reiser_inode_cache     38    216    420    9    1 : tunables   54   27    0
: slabdata     24     24      0
ext3_inode_cache       3      8    492    8    1 : tunables   54   27    0 :
slabdata      1      1      0
ext3_xattr             0      0     48   78    1 : tunables  120   60    0 :
slabdata      0      0      0
journal_handle         0      0     20  169    1 : tunables  120   60    0 :
slabdata      0      0      0
journal_head           1     72     52   72    1 : tunables  120   60    0 :
slabdata      1      1      0
revoke_table           2    254     12  254    1 : tunables  120   60    0 :
slabdata      1      1      0
revoke_record          0      0     16  203    1 : tunables  120   60    0 :
slabdata      0      0      0
ext2_inode_cache    4997   5064    472    8    1 : tunables   54   27    0 :
slabdata    628    633      0
ext2_xattr             0      0     48   78    1 : tunables  120   60    0 :
slabdata      0      0      0
isofs_inode_cache      0      0    372   10    1 : tunables   54   27    0 :
slabdata      0      0      0
UNIX                  87    100    384   10    1 : tunables   54   27    0 :
slabdata     10     10      0
ip_mrt_cache           0      0    128   30    1 : tunables  120   60    0 :
slabdata      0      0      0
tcp_bind_bucket        9    203     16  203    1 : tunables  120   60    0 :
slabdata      1      1      0
inet_peer_cache        0      0     64   59    1 : tunables  120   60    0 :
slabdata      0      0      0
secpath_cache          0      0    128   30    1 : tunables  120   60    0 :
slabdata      0      0      0
xfrm_dst_cache         0      0    384   10    1 : tunables   54   27    0 :
slabdata      0      0      0
ip_dst_cache          24     60    256   15    1 : tunables  120   60    0 :
slabdata      4      4      0
arp_cache             12     30    128   30    1 : tunables  120   60    0 :
slabdata      1      1      0
RAW                    2      7    512    7    1 : tunables   54   27    0 :
slabdata      1      1      0
UDP                   11     14    512    7    1 : tunables   54   27    0 :
slabdata      2      2      0
tw_sock_TCP            0      0    128   30    1 : tunables  120   60    0 :
slabdata      0      0      0
request_sock_TCP       0      0     64   59    1 : tunables  120   60    0 :
slabdata      0      0      0
TCP                   15     16   1024    4    1 : tunables   54   27    0 :
slabdata      4      4      0
flow_cache             0      0    128   30    1 : tunables  120   60    0 :
slabdata      0      0      0
msi_cache              1      1   3840    1    1 : tunables   24   12    0 :
slabdata      1      1      0
cfq_ioc_pool           0      0     48   78    1 : tunables  120   60    0 :
slabdata      0      0      0
cfq_pool               0      0     96   40    1 : tunables  120   60    0 :
slabdata      0      0      0
crq_pool               0      0     48   78    1 : tunables  120   60    0 :
slabdata      0      0      0
deadline_drq           0      0     52   72    1 : tunables  120   60    0 :
slabdata      0      0      0
as_arq                40    118     64   59    1 : tunables  120   60    0 :
slabdata      2      2      0
configfs_dir_cache      0      0     48   78    1 : tunables  120   60    0
: slabdata      0      0      0
romfs_inode_cache      0      0    352   11    1 : tunables   54   27    0 :
slabdata      0      0      0
dnotify_cache          4    169     20  169    1 : tunables  120   60    0 :
slabdata      1      1      0
dquot                  0      0    128   30    1 : tunables  120   60    0 :
slabdata      0      0      0
eventpoll_pwq          0      0     36  101    1 : tunables  120   60    0 :
slabdata      0      0      0
eventpoll_epi          0      0    128   30    1 : tunables  120   60    0 :
slabdata      0      0      0
inotify_event_cache      0      0     28  127    1 : tunables  120   60    0
: slabdata      0      0      0
inotify_watch_cache      1    101     36  101    1 : tunables  120   60    0
: slabdata      1      1      0
kioctx                 0      0    256   15    1 : tunables  120   60    0 :
slabdata      0      0      0
kiocb                  0      0    128   30    1 : tunables  120   60    0 :
slabdata      0      0      0
fasync_cache           6    203     16  203    1 : tunables  120   60    0 :
slabdata      1      1      0
shmem_inode_cache    767   1098    436    9    1 : tunables   54   27    0 :
slabdata    122    122      0
posix_timers_cache      0      0     96   40    1 : tunables  120   60    0
: slabdata      0      0      0
uid_cache              4     59     64   59    1 : tunables  120   60    0 :
slabdata      1      1      0
blkdev_ioc            44    127     28  127    1 : tunables  120   60    0 :
slabdata      1      1      0
blkdev_queue          32     32    928    4    1 : tunables   54   27    0 :
slabdata      8      8      0
blkdev_requests       25    110    176   22    1 : tunables  120   60    0 :
slabdata      5      5      0
biovec-(256)         260    260   3072    2    2 : tunables   24   12    0 :
slabdata    130    130      0
biovec-128           264    265   1536    5    2 : tunables   24   12    0 :
slabdata     53     53      0
biovec-64            290    290    768    5    1 : tunables   54   27    0 :
slabdata     58     58      0
biovec-16            275    285    256   15    1 : tunables  120   60    0 :
slabdata     19     19      0
biovec-4             306    354     64   59    1 : tunables  120   60    0 :
slabdata      6      6      0
biovec-1             285   1624     16  203    1 : tunables  120   60    0 :
slabdata      8      8      0
bio                  285   1200    128   30    1 : tunables  120   60    0 :
slabdata     40     40      0
sock_inode_cache     136    140    384   10    1 : tunables   54   27    0 :
slabdata     14     14      0
skbuff_fclone_cache     10     10    384   10    1 : tunables   54   27    0
: slabdata      1      1      0
skbuff_head_cache    240    240    256   15    1 : tunables  120   60    0 :
slabdata     16     16      0
file_lock_cache       66     88     88   44    1 : tunables  120   60    0 :
slabdata      2      2      0
acpi_operand      10366560 10366560     40   92    1 : tunables  120   60
0 : slabdata 112680 112680      0
acpi_parse_ext        61     84     44   84    1 : tunables  120   60    0 :
slabdata      1      1      0
acpi_parse            63    127     28  127    1 : tunables  120   60    0 :
slabdata      1      1      0
acpi_state            63     78     48   78    1 : tunables  120   60    0 :
slabdata      1      1      0
proc_inode_cache      79    220    360   11    1 : tunables   54   27    0 :
slabdata     20     20      0
sigqueue               0      0    144   27    1 : tunables  120   60    0 :
slabdata      0      0      0
radix_tree_node     1401   1792    276   14    1 : tunables   54   27    0 :
slabdata    128    128      0
bdev_cache            27     27    448    9    1 : tunables   54   27    0 :
slabdata      3      3      0
sysfs_dir_cache     4800   4876     40   92    1 : tunables  120   60    0 :
slabdata     53     53      0
mnt_cache             23     30    128   30    1 : tunables  120   60    0 :
slabdata      1      1      0
inode_cache         1197   1353    344   11    1 : tunables   54   27    0 :
slabdata    123    123      0
dentry_cache        6059   7409    124   31    1 : tunables  120   60    0 :
slabdata    239    239      0
filp                 792    960    192   20    1 : tunables  120   60    0 :
slabdata     48     48      0
names_cache            1      1   4096    1    1 : tunables   24   12    0 :
slabdata      1      1      0
idr_layer_cache      139    145    136   29    1 : tunables  120   60    0 :
slabdata      5      5      0
buffer_head          598   1368     52   72    1 : tunables  120   60    0 :
slabdata     19     19      0
mm_struct             54     54    448    9    1 : tunables   54   27    0 :
slabdata      6      6      0
vm_area_struct      2369   2464     88   44    1 : tunables  120   60    0 :
slabdata     55     56      0
fs_cache              49    113     32  113    1 : tunables  120   60    0 :
slabdata      1      1      0
files_cache           49     63    448    9    1 : tunables   54   27    0 :
slabdata      7      7      0
signal_cache          80     80    384   10    1 : tunables   54   27    0 :
slabdata      8      8      0
sighand_cache         72     72   1344    3    1 : tunables   24   12    0 :
slabdata     24     24      0
task_struct           71     84   1312    3    1 : tunables   24   12    0 :
slabdata     28     28      0
anon_vma             533   1017      8  339    1 : tunables  120   60    0 :
slabdata      3      3      0
pgd                   50     50   4096    1    1 : tunables   24   12    0 :
slabdata     50     50      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 :
slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 :
slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 :
slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 :
slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 :
slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 :
slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 :
slabdata      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4    0 :
slabdata      0      0      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 :
slabdata      0      0      0
size-8192             76     76   8192    1    2 : tunables    8    4    0 :
slabdata     76     76      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0
size-4096            231    231   4096    1    1 : tunables   24   12    0 :
slabdata    231    231      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 :
slabdata      0      0      0
size-2048            271    280   2048    2    1 : tunables   24   12    0 :
slabdata    140    140      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 :
slabdata      0      0      0
size-1024            188    188   1024    4    1 : tunables   54   27    0 :
slabdata     47     47      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 :
slabdata      0      0      0
size-512             277    288    512    8    1 : tunables   54   27    0 :
slabdata     36     36      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 :
slabdata      0      0      0
size-256             795    795    256   15    1 : tunables  120   60    0 :
slabdata     53     53      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    0 :
slabdata      0      0      0
size-128            1097   1170    128   30    1 : tunables  120   60    0 :
slabdata     39     39      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    0 :
slabdata      0      0      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60    0 :
slabdata      0      0      0
size-64             1775   3599     64   59    1 : tunables  120   60    0 :
slabdata     61     61      0
size-32             3494   5650     32  113    1 : tunables  120   60    0 :
slabdata     50     50      0
kmem_cache           150    150    128   30    1 : tunables  120   60    0 :
slabdata      5      5      0

Can anyone explain what is going on and how I can stop it?

I appreciate that I could run the box without ACPI, but that kind of defeats
its while purpose.  Is it possible to tell if this is a BIOS issue, a kernel
issue or an ACPI module issue from the above information?

All assistance greatly appreciated.

Best regards,

Roger

