From: Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH] ACPICA: cleanup method properly on error
Date: Fri, 29 Jul 2016 09:13:39 +0200
Message-ID: <579B0223.1010500@oracle.com>
References: <1469201709-10518-1-git-send-email-vegard.nossum@oracle.com>
 <1AE640813FDE7649BE1B193DEA596E883BC07E8C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:43110 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbcG2HNr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jul 2016 03:13:47 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BC07E8C@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On 07/29/2016 06:47 AM, Zheng, Lv wrote:
> Hi, Vegard
>
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> owner@vger.kernel.org] On Behalf Of Vegard Nossum
>> Subject: [PATCH] ACPICA: cleanup method properly on error
>>
>> If the call to acpi_ds_init_aml_walk() fails, then we have to undo the
>> walk state push done by acpi_ds_create_walk_state(). Otherwise, the new
>> walk state (which has just been freed) will remain on the thread's
>> walk_state_list and be dereferenced in acpi_ps_parse_aml() when we try
>> to get the new state.
> [Lv Zheng]
> I haven't looked into the detail.
> Let me first ask simple questions and present simple concerns in order to move this discussion on.
>
>>
>> You can observe this when reading e.g.
>>
>>      /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0F:01/status
> [Lv Zheng]
> Do you mean you have real issues related to this?
> If so, could provide the .config and dmesg for us?

Yes, I wouldn't send a patch otherwise. I don't have an issue as in "my
kernel is throwing these errors and I don't know why", but I found it
with KASAN + trinity + fault injection for slab. So in order to trigger
the bug you really have to run out of memory (which in theory could
happen on a real running system, right? Otherwise why do we check the
kmalloc() return values.)

==================================================================
BUG: KASAN: use-after-free in acpi_ps_parse_aml+0x264/0x692 at addr 
ffff88004f255b98
Read of size 8 by task trinity-c2/5482
=============================================================================
BUG kmalloc-1024 (Not tainted): kasan: bad access detected
-----------------------------------------------------------------------------

Disabling lock debugging due to kernel taint
INFO: Allocated in acpi_ds_create_walk_state+0x74/0x1ff age=572 cpu=3 
pid=5482
	___slab_alloc+0x480/0x4b0
	__slab_alloc.isra.57+0x56/0x80
	kmem_cache_alloc+0x1af/0x1e0
	acpi_ds_create_walk_state+0x74/0x1ff
	acpi_ds_call_control_method+0xc3/0x3ef
	acpi_ps_parse_aml+0x20f/0x692
	acpi_ps_execute_method+0x498/0x4f6
	acpi_ns_evaluate+0x662/0x858
	acpi_evaluate_object+0x37d/0x6d5
	acpi_evaluate_integer+0x9e/0xfb
	status_show+0x91/0xda
	dev_attr_show+0x40/0xc0
	sysfs_kf_seq_show+0x23c/0x490
	kernfs_seq_show+0x113/0x1a0
	traverse+0x2b9/0x850
	seq_read+0x7cc/0x1180
INFO: Freed in acpi_ds_delete_walk_state+0x1da/0x1e5 age=95 cpu=3 pid=5482
	__slab_free+0x17a/0x250
	kfree+0x128/0x140
	acpi_ds_delete_walk_state+0x1da/0x1e5
	acpi_ds_call_control_method+0x3dd/0x3ef
	acpi_ps_parse_aml+0x20f/0x692
	acpi_ps_execute_method+0x498/0x4f6
	acpi_ns_evaluate+0x662/0x858
	acpi_evaluate_object+0x37d/0x6d5
	acpi_evaluate_integer+0x9e/0xfb
	status_show+0x91/0xda
	dev_attr_show+0x40/0xc0
	sysfs_kf_seq_show+0x23c/0x490
	kernfs_seq_show+0x113/0x1a0
	traverse+0x2b9/0x850
	seq_read+0x7cc/0x1180
	kernfs_fop_read+0x331/0x4d0
INFO: Slab 0xffffea00013c9400 objects=24 used=24 fp=0x          (null) 
flags=0x200000000004080
INFO: Object 0xffff88004f255830 @offset=22576 fp=0xffff88005fec5648

Bytes b4 ffff88004f255820: 00 00 00 00 00 00 00 00 31 9e 4b 00 01 00 00 
00  ........1.K.....
Object ffff88004f255830: 48 56 ec 5f 00 88 ff ff 00 02 00 00 00 00 ad de 
  HV._............
Object ffff88004f255840: 40 58 25 4f 00 88 ff ff 40 58 25 4f 00 88 ff ff 
  @X%O....@X%O....
Object ffff88004f255850: 50 58 25 4f 00 88 ff ff 50 58 25 4f 00 88 ff ff 
  PX%O....PX%O....
Object ffff88004f255860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255870: 00 00 00 00 00 00 00 00 00 02 00 00 00 00 ad de 
  ................
Object ffff88004f255880: 80 58 25 4f 00 88 ff ff 80 58 25 4f 00 88 ff ff 
  .X%O.....X%O....
Object ffff88004f255890: 00 00 00 00 01 00 00 00 30 58 25 4f 00 88 ff ff 
  ........0X%O....
Object ffff88004f2558a0: c0 78 ab 83 ff ff ff ff 00 00 00 00 00 00 00 00 
  .x..............
Object ffff88004f2558b0: fd ff ff ff 04 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f2558c0: 00 00 00 00 00 00 00 00 fa 0d 5c 00 00 00 00 00 
  ..........\.....
Object ffff88004f2558d0: fa 0d 5c 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ..\.............
Object ffff88004f2558e0: 00 00 00 00 00 00 00 00 fa 0d 5c 00 00 00 00 00 
  ..........\.....
Object ffff88004f2558f0: e1 e5 b2 db 37 fb ff ff 01 00 00 00 70 00 00 00 
  ....7.......p...
Object ffff88004f255900: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255910: 00 00 00 00 00 00 00 00 05 00 00 00 00 00 00 00 
  ................
Object ffff88004f255920: ae 79 93 03 00 00 00 00 00 00 00 00 00 00 00 00 
  .y..............
Object ffff88004f255930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255960: 00 00 00 00 00 00 00 00 00 00 00 00 18 00 00 00 
  ................
Object ffff88004f255970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f2559a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f2559b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f2559c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f2559d0: c0 72 e7 13 00 88 ff ff 00 00 00 00 00 00 00 00 
  .r..............
Object ffff88004f2559e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f2559f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255a10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255a30: e0 55 ec 5f 00 88 ff ff 00 00 00 00 00 00 00 00 
  .U._............
Object ffff88004f255a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255a50: 01 00 00 00 00 00 00 00 58 5a 25 4f 00 88 ff ff 
  ........XZ%O....
Object ffff88004f255a60: 58 5a 25 4f 00 88 ff ff 00 00 00 00 00 00 00 00 
  XZ%O............
Object ffff88004f255a70: 00 00 00 00 00 00 00 00 78 5a 25 4f 00 88 ff ff 
  ........xZ%O....
Object ffff88004f255a80: 78 5a 25 4f 00 88 ff ff 90 62 96 ba 00 88 ff ff 
  xZ%O.....b......
Object ffff88004f255a90: ff ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255ab0: 01 00 00 00 00 00 00 00 b8 5a 25 4f 00 88 ff ff 
  .........Z%O....
Object ffff88004f255ac0: b8 5a 25 4f 00 88 ff ff 00 00 00 00 00 00 00 00 
  .Z%O............
Object ffff88004f255ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255ae0: 00 00 00 00 00 00 00 00 e8 5a 25 4f 00 88 ff ff 
  .........Z%O....
Object ffff88004f255af0: e8 5a 25 4f 00 88 ff ff 00 00 00 00 00 00 00 00 
  .Z%O............
Object ffff88004f255b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255b10: 10 5b 25 4f 00 88 ff ff 10 5b 25 4f 00 88 ff ff 
  .[%O.....[%O....
Object ffff88004f255b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255b40: 00 00 00 00 00 00 00 00 e0 57 2b 81 ff ff ff ff 
  .........W+.....
Object ffff88004f255b50: 00 00 00 00 00 00 00 00 58 5b 25 4f 00 88 ff ff 
  ........X[%O....
Object ffff88004f255b60: 58 5b 25 4f 00 88 ff ff 00 00 00 00 00 00 00 00 
  X[%O............
Object ffff88004f255b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255b80: 00 00 00 00 00 00 00 00 b8 56 ec 5f 00 88 ff ff 
  .........V._....
Object ffff88004f255b90: 50 33 29 81 ff ff ff ff 20 f1 a8 83 ff ff ff ff 
  P3)..... .......
Object ffff88004f255ba0: 3b d8 25 00 00 00 00 00 70 46 29 81 ff ff ff ff 
  ;.%.....pF).....
Object ffff88004f255bb0: 20 40 2b 81 ff ff ff ff 00 00 00 00 00 00 00 00 
   @+.............
Object ffff88004f255bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
Object ffff88004f255c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  ................
CPU: 3 PID: 5482 Comm: trinity-c2 Tainted: G    B           4.7.0-rc7+ #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
Ubuntu-1.8.2-1ubuntu1 04/01/2014
  ffffea00013c9400 ffff880094acf460 ffffffff81971441 ffff88011a807180
  ffff88004f255830 ffff880094acf490 ffffffff8139788d ffff88011a807180
  ffffea00013c9400 ffff88004f255830 dffffc0000000000 ffff880094acf4b8
Call Trace:
  [<ffffffff81971441>] dump_stack+0x65/0x84
  [<ffffffff8139788d>] print_trailer+0x10d/0x1a0
  [<ffffffff8139b40f>] object_err+0x2f/0x40
  [<ffffffff8139f6cf>] kasan_report_error+0x21f/0x520
  [<ffffffff81b3d6c8>] ? acpi_ut_remove_reference+0x51/0x54
  [<ffffffff8139fb0e>] __asan_report_load8_noabort+0x3e/0x40
  [<ffffffff81b2d116>] ? acpi_ps_parse_aml+0x264/0x692
  [<ffffffff81b2d116>] acpi_ps_parse_aml+0x264/0x692
  [<ffffffff81b42612>] ? acpi_ut_create_internal_object_dbg+0x1e/0x16a
  [<ffffffff81b2eb52>] acpi_ps_execute_method+0x498/0x4f6
  [<ffffffff81b418d5>] ? acpi_ut_acquire_mutex+0x73/0x108
  [<ffffffff81b1e8a1>] acpi_ns_evaluate+0x662/0x858
  [<ffffffff8139c1be>] ? __kmalloc+0x11e/0x250
  [<ffffffff81b26051>] ? acpi_os_allocate_zeroed+0x2d/0x2f
  [<ffffffff81b26734>] acpi_evaluate_object+0x37d/0x6d5
  [<ffffffff81b263b7>] ? acpi_ns_get_device_callback+0x364/0x364
  [<ffffffff8198e59c>] ? number+0x71c/0xa70
  [<ffffffff81accaac>] acpi_evaluate_integer+0x9e/0xfb
  [<ffffffff81acca0e>] ? acpi_extract_package+0x807/0x807
  [<ffffffff83294def>] ? _raw_spin_unlock_irqrestore+0x1f/0x40
  [<ffffffff819cea32>] ? debug_object_activate+0x1f2/0x470
  [<ffffffff83294def>] ? _raw_spin_unlock_irqrestore+0x1f/0x40
  [<ffffffff81aced1d>] status_show+0x91/0xda
  [<ffffffff81acec8c>] ? acpi_eject_store+0x247/0x247
  [<ffffffff83294def>] ? _raw_spin_unlock_irqrestore+0x1f/0x40
  [<ffffffff819cea32>] ? debug_object_activate+0x1f2/0x470
  [<ffffffff83294def>] ? _raw_spin_unlock_irqrestore+0x1f/0x40
  [<ffffffff81fbfc00>] dev_attr_show+0x40/0xc0
  [<ffffffff8139e921>] ? memset+0x31/0x40
  [<ffffffff81fbfbc0>] ? dev_uevent_name+0xd0/0xd0
  [<ffffffff8152b34c>] sysfs_kf_seq_show+0x23c/0x490
  [<ffffffff81526b13>] kernfs_seq_show+0x113/0x1a0
  [<ffffffff8152720b>] ? kernfs_seq_start+0x6b/0x170
  [<ffffffff81439bd9>] traverse+0x2b9/0x850
  [<ffffffff81439920>] ? seq_buf_alloc+0x40/0x40
  [<ffffffff81158240>] ? __might_sleep+0x90/0x1a0
  [<ffffffff8143ab2c>] seq_read+0x7cc/0x1180
  [<ffffffff8143a360>] ? seq_open+0x1f0/0x1f0
  [<ffffffff81158240>] ? __might_sleep+0x90/0x1a0
  [<ffffffff81482a60>] ? __fsnotify_update_child_dentry_flags+0x50/0x50
  [<ffffffff81158240>] ? __might_sleep+0x90/0x1a0
  [<ffffffff81528c41>] kernfs_fop_read+0x331/0x4d0
  [<ffffffff813cffc4>] do_loop_readv_writev+0x134/0x210
  [<ffffffff817aec98>] ? security_file_permission+0x148/0x1a0
  [<ffffffff81528910>] ? kernfs_fop_write+0x400/0x400
  [<ffffffff81528910>] ? kernfs_fop_write+0x400/0x400
  [<ffffffff813d26d5>] do_readv_writev+0x565/0x660
  [<ffffffff811dba03>] ? enqueue_hrtimer+0xd3/0x110
  [<ffffffff813d2170>] ? rw_verify_area+0x2b0/0x2b0
  [<ffffffff83294dbc>] ? _raw_spin_unlock_irq+0x1c/0x30
  [<ffffffff811e03d6>] ? do_setitimer+0x336/0x540
  [<ffffffff811db500>] ? run_local_timers+0x20/0x20
  [<ffffffff813d6497>] vfs_readv+0x67/0xa0
[main] kernel be [<ffffffff813d6856>] do_preadv+0x126/0x170
  [<ffffffff813d6d40>] ? SyS_writev+0x10/0x10
  [<ffffffff813d6d4c>] SyS_preadv+0xc/0x10
  [<ffffffff8100334c>] do_syscall_64+0x19c/0x410
  [<ffffffff812c0ac8>] ? context_tracking_enter+0x18/0x20
  [<ffffffff832954e5>] entry_SYSCALL64_slow_path+0x25/0x25
Memory state around the buggy address:
  ffff88004f255a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
came tainted! (32/0) Last seed was 343033073
  ffff88004f255b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 >ffff88004f255b80: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
                             ^
  ffff88004f255c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88004f255c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
ACPI Error:
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 3 PID: 5482 Comm: trinity-c2 Tainted: G    B           4.7.0-rc7+ #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
Ubuntu-1.8.2-1ubuntu1 04/01/2014
task: ffff88004f3b6600 ti: ffff880094ac8000 task.ti: ffff880094ac8000
RIP: 0010:[<ffffffff81b25933>]  [<ffffffff81b25933>] 
acpi_ns_validate_handle+0x49/0x69
RSP: 0018:ffff880094acf400  EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 000000000025d83b RCX: 0000000000000000
RDX: 000000000004bb08 RSI: ffff880094acf468 RDI: 000000000025d843
RBP: ffff880094acf408 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000010 R11: fffffbfff07fd285 R12: 000000000025d83b
R13: ffff880094acf468 R14: ffffffff83557880 R15: ffffffff83557880
FS:  00007f355296c700(0000) GS:ffff88011af80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f355296c9d0 CR3: 0000000094878000 CR4: 00000000000006e0
DR0: 00007f3550b67000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Stack:
  0000000000000001 ffff880094acf438 ffffffff81b1ff68 1ffff10012959e89
  000000000025d83b 000000000000021e ffffffff83557880 ffff880094acf4c8
  ffffffff81b24bbd 0000000041b58ab3 ffffffff8391384b ffffffff81b24b3b
Call Trace:
  [<ffffffff81b1ff68>] acpi_ns_handle_to_pathname+0x15/0x87
  [<ffffffff81b24bbd>] acpi_ns_print_node_pathname+0x82/0xde
  [<ffffffff81b24b3b>] ? kzalloc+0x11/0x11
  [<ffffffff81b3e95e>] acpi_ut_method_error+0xbb/0x115
  [<ffffffff81b3e8a3>] ? acpi_ut_namespace_error+0x156/0x156
  [<ffffffff8139fb0e>] ? __asan_report_load8_noabort+0x3e/0x40
  [<ffffffff81b2d163>] acpi_ps_parse_aml+0x2b1/0x692
  [<ffffffff81b42612>] ? acpi_ut_create_internal_object_dbg+0x1e/0x16a
  [<ffffffff81b2eb52>] acpi_ps_execute_method+0x498/0x4f6
  [<ffffffff81b418d5>] ? acpi_ut_acquire_mutex+0x73/0x108
  [<ffffffff81b1e8a1>] acpi_ns_evaluate+0x662/0x858
  [<ffffffff8139c1be>] ? __kmalloc+0x11e/0x250
  [<ffffffff81b26051>] ? acpi_os_allocate_zeroed+0x2d/0x2f
  [<ffffffff81b26734>] acpi_evaluate_object+0x37d/0x6d5
  [<ffffffff81b263b7>] ? acpi_ns_get_device_callback+0x364/0x364
  [<ffffffff8198e59c>] ? number+0x71c/0xa70
  [<ffffffff81accaac>] acpi_evaluate_integer+0x9e/0xfb
  [<ffffffff81acca0e>] ? acpi_extract_package+0x807/0x807
  [<ffffffff83294def>] ? _raw_spin_unlock_irqrestore+0x1f/0x40
  [<ffffffff819cea32>] ? debug_object_activate+0x1f2/0x470
  [<ffffffff83294def>] ? _raw_spin_unlock_irqrestore+0x1f/0x40
  [<ffffffff81aced1d>] status_show+0x91/0xda
  [<ffffffff81acec8c>] ? acpi_eject_store+0x247/0x247
  [<ffffffff83294def>] ? _raw_spin_unlock_irqrestore+0x1f/0x40
  [<ffffffff819cea32>] ? debug_object_activate+0x1f2/0x470
  [<ffffffff83294def>] ? _raw_spin_unlock_irqrestore+0x1f/0x40
  [<ffffffff81fbfc00>] dev_attr_show+0x40/0xc0
  [<ffffffff8139e921>] ? memset+0x31/0x40
  [<ffffffff81fbfbc0>] ? dev_uevent_name+0xd0/0xd0
  [<ffffffff8152b34c>] sysfs_kf_seq_show+0x23c/0x490
  [<ffffffff81526b13>] kernfs_seq_show+0x113/0x1a0
  [<ffffffff8152720b>] ? kernfs_seq_start+0x6b/0x170
  [<ffffffff81439bd9>] traverse+0x2b9/0x850
  [<ffffffff81439920>] ? seq_buf_alloc+0x40/0x40
  [<ffffffff81158240>] ? __might_sleep+0x90/0x1a0
  [<ffffffff8143ab2c>] seq_read+0x7cc/0x1180
  [<ffffffff8143a360>] ? seq_open+0x1f0/0x1f0
  [<ffffffff81158240>] ? __might_sleep+0x90/0x1a0
  [<ffffffff81482a60>] ? __fsnotify_update_child_dentry_flags+0x50/0x50
  [<ffffffff81158240>] ? __might_sleep+0x90/0x1a0
  [<ffffffff81528c41>] kernfs_fop_read+0x331/0x4d0
  [<ffffffff813cffc4>] do_loop_readv_writev+0x134/0x210
  [<ffffffff817aec98>] ? security_file_permission+0x148/0x1a0
  [<ffffffff81528910>] ? kernfs_fop_write+0x400/0x400
  [<ffffffff81528910>] ? kernfs_fop_write+0x400/0x400
  [<ffffffff813d26d5>] do_readv_writev+0x565/0x660
  [<ffffffff811dba03>] ? enqueue_hrtimer+0xd3/0x110
  [<ffffffff813d2170>] ? rw_verify_area+0x2b0/0x2b0
  [<ffffffff83294dbc>] ? _raw_spin_unlock_irq+0x1c/0x30
  [<ffffffff811e03d6>] ? do_setitimer+0x336/0x540
  [<ffffffff811db500>] ? run_local_timers+0x20/0x20
  [<ffffffff813d6497>] vfs_readv+0x67/0xa0
  [<ffffffff813d6856>] do_preadv+0x126/0x170
  [<ffffffff813d6d40>] ? SyS_writev+0x10/0x10
  [<ffffffff813d6d4c>] SyS_preadv+0xc/0x10
  [<ffffffff8100334c>] do_syscall_64+0x19c/0x410
  [<ffffffff812c0ac8>] ? context_tracking_enter+0x18/0x20
  [<ffffffff832954e5>] entry_SYSCALL64_slow_path+0x25/0x25
Code: 09 84 48 89 fa 48 c1 ea 03 80 3c 02 00 74 05 e8 b4 a1 87 ff 48 8b 
05 fd 78 57 02 eb 2b 48 89 fb 48 8d 7f 08 48 89 fa 48 c1 ea 03 <8a> 04 
02 84 c0 74 09 84 c0 7f 05 e8 cd a0 87 ff 80 7b 08 0f b8
RIP  [<ffffffff81b25933>] acpi_ns_validate_handle+0x49/0x69
  RSP <ffff880094acf400>
---[ end trace 76905f856f3713a5 ]---
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled

>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
>> ---
>>   drivers/acpi/acpica/dsmethod.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/acpi/acpica/dsmethod.c
>> b/drivers/acpi/acpica/dsmethod.c
>> index 47c7b52..44b50a6 100644
>> --- a/drivers/acpi/acpica/dsmethod.c
>> +++ b/drivers/acpi/acpica/dsmethod.c
>> @@ -596,6 +596,8 @@ cleanup:
>>   	/* On error, we must terminate the method properly */
>>
>>   	acpi_ds_terminate_control_method(obj_desc, next_walk_state);
>> +	if (thread)
>> +		acpi_ds_pop_walk_state(thread);
>>   	acpi_ds_delete_walk_state(next_walk_state);
> [Lv Zheng]
> It seems, if acpi_ds_create_walk_state() fails, acpi_ds_delete_walk_state() will be invoked.
> So they are paired. Fixing this in acpi_ds_delete_walk_state() could help to fix all of them.
> Given the fix is useful, why don't you do this in acpi_ds_delete_walk_state()?

I don't know the code well enough to say if that is correct (and a
better fix), but I will try to do that and see if I run into any other
problems.

Thanks for looking at this,


Vegard
