From: Zhu Guihua <zhugh.fnst@cn.fujitsu.com>
Subject: Re: [lkp] [x86, ACPI, cpu] f962c29c2f: BUG: unable to handle kernel
 paging request at 0000000000001b00
Date: Tue, 12 Apr 2016 15:59:38 +0800
Message-ID: <570CAAEA.5050608@cn.fujitsu.com>
References: <87pou38t30.fsf@yhuang-dev.intel.com> <57052962.4030507@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57052962.4030507@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, kernel test robot <ying.huang@linux.intel.com>
Cc: lkp@01.org, devel@acpica.org, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tang Chen <tangchen@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

On 04/06/2016 11:21 PM, Rafael J. Wysocki wrote:
> On 4/6/2016 2:43 AM, kernel test robot wrote:
>> FYI, we noticed the below changes on
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git 
>> linux-next
>> commit f962c29c2f5d80be28bd76e2c3fadf1ce97ccd76 ("x86, ACPI, 
>> cpu-hotplug: Set persistent cpuid <-> nodeid mapping when booting")
>>
>
> Thanks for the report.
>
> I've dropped the patch series that commit is part of from the 
> linux-next branch of linux-pm.git because of this problem.
>

I tried to reproduce this failure, but I failed.
I compiled linux-next branch source code of linux-pm.git with this 
config, then I
used qemu to boot a guest with my compiled kernel, it worked well.

QEMU command line is:
./x86_64-softmmu/qemu-system-x86_64 -hda /home/fedora21.img \
-kernel /home/linux-pm/arch/x86_64/boot/bzImage \
-m 512,slots=100,maxmem=100G -smp 2,maxcpus=100 -serial stdio -enable-kvm \
-initrd /home/initramfs-4.6.0-rc2-00250-g8767898.img -append 
"root=/dev/sda3 console=ttyS0

Anyone succeed?

Thanks,
Zhu

>
>> +------------------------------------------+------------+------------+
>> |                                          | 40d4d2e6c5 | f962c29c2f |
>> +------------------------------------------+------------+------------+
>> | boot_successes                           | 12         | 4          |
>> | boot_failures                            | 0          | 8          |
>> | BUG:unable_to_handle_kernel              | 0          | 8          |
>> | Oops                                     | 0          | 8          |
>> | RIP:__alloc_pages_nodemask               | 0          | 8          |
>> | Kernel_panic-not_syncing:Fatal_exception | 0          | 8          |
>> | backtrace:pcpu_balance_workfn            | 0          | 8          |
>> +------------------------------------------+------------+------------+
>>
>>
>>
>> [   10.413471] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
>> [   10.419886] RAPL PMU: hw unit of domain package 2^-16 Joules
>> [   10.426206] RAPL PMU: hw unit of domain dram 2^-16 Joules
>> [   10.433905] BUG: unable to handle kernel paging request at 
>> 0000000000001b00
>> [   10.441699] IP: [<ffffffff8117e350>] 
>> __alloc_pages_nodemask+0x210/0xc10
>> [   10.449097] PGD 0
>> [   10.451350] Oops: 0000 [#1] SMP
>> [   10.454972] Modules linked in:
>> [   10.458390] CPU: 12 PID: 407 Comm: kworker/12:1 Not tainted 
>> 4.6.0-rc1-00007-gf962c29 #1
>> [   10.467326] Hardware name: Intel Corporation S2600WP/S2600WP, BIOS 
>> SE5C600.86B.02.02.0002.122320131210 12/23/2013
>> [   10.478776] Workqueue: events pcpu_balance_workfn
>> [   10.484035] task: ffff88100d858000 ti: ffff88100d860000 task.ti: 
>> ffff88100d860000
>> [   10.492381] RIP: 0010:[<ffffffff8117e350>] [<ffffffff8117e350>] 
>> __alloc_pages_nodemask+0x210/0xc10
>> [   10.502491] RSP: 0000:ffff88100d863c28  EFLAGS: 00010286
>> [   10.508419] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
>> 0000000000000004
>> [   10.516383] RDX: 0000000080000000 RSI: 0000000000000d06 RDI: 
>> ffffffff81c9d430
>> [   10.524348] RBP: ffff88100d863d40 R08: 0000000000000000 R09: 
>> 0000000000000000
>> [   10.532312] R10: ffffffff81ca1e87 R11: ffffc90000076000 R12: 
>> 0000000000000003
>> [   10.540278] R13: 0000000000001b00 R14: 0000000000000000 R15: 
>> ffff88100d43e480
>> [   10.548243] FS:  0000000000000000(0000) GS:ffff881013400000(0000) 
>> knlGS:0000000000000000
>> [   10.557275] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   10.563687] CR2: 0000000000001b00 CR3: 000000103ee06000 CR4: 
>> 00000000001406e0
>> [   10.571652] Stack:
>> [   10.573894]  ffffc90000090fff ffffc90000091000 ffff881013002008 
>> 0000000000000001
>> [   10.582196]  8000000000000163 00000000ffffffff 00000000024082c2 
>> 0000000000400000
>> [   10.590492]  000000000000001e ffff880ffe57c0c0 ffff88100d863c88 
>> ffffffff811b7766
>> [   10.598794] Call Trace:
>> [   10.601527]  [<ffffffff811b7766>] ? map_vm_area+0x36/0x50
>> [   10.607553]  [<ffffffff81198ade>] pcpu_populate_chunk+0xae/0x340
>> [   10.614257]  [<ffffffff8119a118>] pcpu_balance_workfn+0x578/0x5b0
>> [   10.621060]  [<ffffffff81094be5>] process_one_work+0x155/0x440
>> [   10.627562]  [<ffffffff8109582e>] worker_thread+0x4e/0x4c0
>> [   10.633687]  [<ffffffff818f1b9b>] ? __schedule+0x34b/0x8b0
>> [   10.639809]  [<ffffffff810957e0>] ? rescuer_thread+0x350/0x350
>> [   10.646319]  [<ffffffff810957e0>] ? rescuer_thread+0x350/0x350
>> [   10.652831]  [<ffffffff8109ade4>] kthread+0xd4/0xf0
>> [   10.658276]  [<ffffffff818f6742>] ret_from_fork+0x22/0x40
>> [   10.664302]  [<ffffffff8109ad10>] ? kthread_park+0x60/0x60
>> [   10.670423] Code: d0 49 8b 04 24 48 85 c0 75 e0 65 ff 0d 22 f0 e8 
>> 7e eb 8b 31 d2 be 06 0d 00 00 48 c7 c7 30 d4 c9 81 e8 35 2c f2 ff e8 
>> 50 40 77 00 <49> 83 7d 00 00 0f 85 7c fe ff ff 31 c0 e9 6d ff ff ff 
>> 0f 1f 44
>> [   10.692137] RIP  [<ffffffff8117e350>] 
>> __alloc_pages_nodemask+0x210/0xc10
>> [   10.699627]  RSP <ffff88100d863c28>
>> [   10.703518] CR2: 0000000000001b00
>> [   10.707220] ---[ end trace bc83ef9ded88f808 ]---
>> [   10.712373] Kernel panic - not syncing: Fatal exception
>>
>>
>> Thanks,
>> Kernel Test Robot
>
>
>
> .
>
