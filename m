From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [LKP] [PATCH v2 0/4] Revert works for the mapping of cpuid <->
 nodeid
Date: Thu, 16 Mar 2017 16:14:57 +0800
Message-ID: <20170316081457.GB13054@aaronlu.sh.intel.com>
References: <1487580471-17665-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <20170221010218.GA9932@yexl-desktop>
 <20170221071059.GA19410@yexl-desktop>
 <61b3eb11-29cb-0048-e705-47c280aac892@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <61b3eb11-29cb-0048-e705-47c280aac892@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Ye Xiaolong <xiaolong.ye@intel.com>, cl@linux.com, x86@kernel.org, akpm@linux-foundation.org, rafael@kernel.org, peterz@infradead.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hpa@zytor.com, tj@kernel.org, izumi.taku@jp.fujitsu.com, tglx@linutronix.de, lkp@01.org, mingo@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 22, 2017 at 09:56:51AM +0800, Dou Liyang wrote:
> Hi, Xiaolong
> 
> At 02/21/2017 03:10 PM, Ye Xiaolong wrote:
> > On 02/21, Ye Xiaolong wrote:
> > > On 02/20, Dou Liyang wrote:
> > > > Currently, We make the mapping of "cpuid <-> nodeid" fixed at the booting time.
> > > > It keeps consistent with the WorkQueue and avoids some bugs which may be caused
> > > > by the dynamic assignment.
> > > > As we know, It is implemented by the patches as follows: 2532fc318d, f7c28833c2,
> > > > 8f54969dc8, 8ad893faf2, dc6db24d24, which depend on ACPI table. Simply speaking:
> > > > 
> > > > Step 1. Make the "Logical CPU ID <-> Processor ID/UID" fixed Using MADT:
> > > > We generate the logical CPU IDs by the Local APIC/x2APIC IDs orderly and
> > > > get the mapping of Processor ID/UID <-> Local Apic ID directly in MADT.
> > > > So, we get the mapping of
> > > > *Processor ID/UID <-> Local Apic ID <-> Logical CPU ID*
> > > > 
> > > > Step 2. Make the "Processor ID/UID <-> Node ID(_PXM)" fixed Using DSDT:
> > > > The maaping of "Processor ID/UID <-> Node ID(_PXM)" is ready-made in
> > > > each entities. we just use it directly.
> > > > 
> > > > So, at last we get the maaping of *Node ID <-> Logical CPU ID* according to
> > > > step1 and step2:
> > > > *Node ID(_PXM) <-> Processor ID/UID <-> Local Apic ID <-> Logical CPU ID*
> > > > 
> > > > But, The ACPI table is unreliable and it is very risky that we use the entity
> > > > which isn't related to a physical device at booting time. Here has already two
> > > > bugs we found.
> > > > 1. Duplicated Processor IDs in DSDT.
> > > > 	It has been fixed by commit 8e089eaa19, fd74da217d.
> > > > 2. The _PXM in DSDT is inconsistent with the one in MADT.
> > > > 	It may cause the bug, which is shown in:
> > > > 		https://lkml.org/lkml/2017/2/12/200
> > > > There may be more later. We shouldn't just only fix them everytime, we should
> > > > solve this problem from the source to avoid such problems happend again and
> > > > again.
> > > > 
> > > > Now, a simple and easy way is found, we revert our patches. Do the Step 2
> > > > at hot-plug time, not at booting time where we did some useless work.
> > > > 
> > > > It also can make the mapping of "cpuid <-> nodeid" fixed and avoid excessive
> > > > use of the ACPI table.
> > > > 
> > > > We have tested them in our box: Fujitsu PQ2000 with 2 nodes for hot-plug.
> > > > To Xiaolong:
> > > > 	Please help me to test it in the special machine.
> > > 
> > > Got it, I'll queue the tests on the previous machine and let you know the result
> > > once I get it.
> > 
> > Previous kernel panic and incomplete run issue (described in [1]) in 0day
> > system is gone with this series.
> > 
> 
> Thanks very much, I am glad to hear that!
> 
> > Tested-by: Xiaolong Ye <xiaolong.ye@intel.com>
> > 
> 
> I will add it in my next version.

What is the status of the patch?

I still get oops during boot on a EP machine with today's Linus tree's
head commit 69eea5a4ab9c("Merge branch 'for-linus' of git://git.kernel.dk/linux-block")

The first oops call trace:

... ...
[    8.599850] pci_bus 0000:80: on NUMA node 2
[    8.605611] ACPI: Enabled 4 GPEs in block 00 to 3F
[    8.645521] BUG: unable to handle kernel paging request at 000000000001f768
[    8.653585] IP: get_partial_node+0x2c/0x1f0
[    8.659302] PGD 0 
[    8.659303] 
[    8.663724] Oops: 0000 [#1] SMP
[    8.667499] Modules linked in:
[    8.671181] CPU: 60 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc1 #1
[    8.678554] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS SE5C610.86B.01.01.0008.021120151325 02/11/2015
[    8.690672] task: ffff88202bc10000 task.stack: ffffc9000002c000
[    8.697542] RIP: 0010:get_partial_node+0x2c/0x1f0
[    8.703844] RSP: 0000:ffffc9000002fb20 EFLAGS: 00010006
[    8.709944] RAX: 0000000000000002 RBX: 0000000000000000 RCX: 00000000014080c0
[    8.718184] RDX: ffff88203281f740 RSI: 000000000001f760 RDI: ffff88202e548280
[    8.726422] RBP: ffffc9000002fbc0 R08: 0000000000000000 R09: 0000000100220022
[    8.734661] R10: ffffea0080a99600 R11: 0000000000000000 R12: ffff88202e548280
[    8.742896] R13: ffffea0080a991c0 R14: ffff88202e548280 R15: ffff88203281f730
[    8.751144] FS:  0000000000000000(0000) GS:ffff882032800000(0000) knlGS:0000000000000000
[    8.760633] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.767312] CR2: 000000000001f768 CR3: 0000000001e09000 CR4: 00000000001406e0
[    8.775550] Call Trace:
[    8.778548]  ? acpi_os_release_lock+0xe/0x10
[    8.783590]  ? acpi_ut_update_ref_count+0x5a/0x6b3
[    8.789210]  ___slab_alloc+0x28a/0x4b0
[    8.793660]  ? __kernfs_new_node+0x41/0xc0
[    8.798505]  ? __kernfs_new_node+0x41/0xc0
[    8.803348]  __slab_alloc+0x20/0x40
[    8.807501]  kmem_cache_alloc+0x17f/0x1c0
[    8.812231]  __kernfs_new_node+0x41/0xc0
[    8.816882]  kernfs_new_node+0x26/0x50
[    8.821338]  __kernfs_create_file+0x2c/0xa0
[    8.826269]  sysfs_add_file_mode_ns+0x99/0x180
[    8.831500]  sysfs_create_file_ns+0x2a/0x30
[    8.836433]  bus_create_file+0x47/0x70
[    8.840893]  bus_register+0xe4/0x280
[    8.845157]  ? sfi_init+0x1b0/0x1b0
[    8.849321]  ? set_debug_rodata+0x12/0x12
[    8.854064]  pnp_init+0x10/0x12
[    8.857829]  do_one_initcall+0x43/0x180
[    8.862383]  ? set_debug_rodata+0x12/0x12
[    8.867118]  kernel_init_freeable+0x19d/0x22a
[    8.872259]  ? rest_init+0x90/0x90
[    8.876324]  kernel_init+0xe/0x100
[    8.880389]  ret_from_fork+0x2c/0x40
[    8.884643] Code: 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 f0 48 83 ec 70 48 85 f6 48 c7 44 24 20 00 00 00 00 0f 84 87 01 00 00 <48> 83 7e 08 00 0f 84 7c 01 00 00 48 89 f3 49 89 fd 48 89 f7 89 
[    8.906422] RIP: get_partial_node+0x2c/0x1f0 RSP: ffffc9000002fb20
[    8.914356] CR2: 000000000001f768
... ...

Thanks,
Aaron
