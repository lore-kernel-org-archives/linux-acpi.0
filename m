From: Daniel Borkmann <daniel@iogearbox.net>
Subject: ACPI, WARNING: CPU: 1 PID: 538 at kernel/sched/core.c:7389 __might_sleep+0x7f/0x90()
Date: Thu, 06 Aug 2015 11:57:05 +0200
Message-ID: <55C32F71.9070009@iogearbox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www62.your-server.de ([213.133.104.62]:35957 "EHLO
	www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbbHFJ5H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Aug 2015 05:57:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net

This one seems to trigger during booting (I'm using net.git tree).
Not sure if that is fixed already, if it is, sorry for the noise ...

[...]
[   27.483399] EXT4-fs (dm-1): re-mounted. Opts: (null)
[   27.970316] systemd-udevd[528]: starting version 208
[   29.250980] ACPI: SBS HC: EC = 0xffff880263f99a40, offset = 0x20, query_bit = 0x10
[   29.468909] ------------[ cut here ]------------
[   29.468920] WARNING: CPU: 1 PID: 538 at kernel/sched/core.c:7389 __might_sleep+0x7f/0x90()
[   29.468926] do not call blocking ops when !TASK_RUNNING; state=2 set at [<ffffffff810ed7b3>] prepare_to_wait_event+0x63/0x100
[   29.468929] Modules linked in: sbs(+) sbshc apple_bl nfsd auth_rpcgss nfs_acl lockd grace sunrpc i915 i2c_algo_bit drm_kms_helper drm i2c_core video
[   29.468954] CPU: 1 PID: 538 Comm: systemd-udevd Not tainted 4.2.0-rc4+ #115
[   29.468956] Hardware name: Apple Inc. MacBookAir5,1/Mac-66F35F19FE2A0D05, BIOS MBA51.88Z.00EF.B02.1211271028 11/27/2012
[   29.468959]  ffffffff81c53c73 ffff88008203f848 ffffffff817ef504 0000000000000000
[   29.468965]  ffff88008203f898 ffff88008203f888 ffffffff8109e11a 0000000000000001
[   29.468970]  ffffffff81c54cd4 0000000000000268 0000000000000000 ffff88025b973580
[   29.468975] Call Trace:
[   29.468981]  [<ffffffff817ef504>] dump_stack+0x4c/0x65
[   29.468985]  [<ffffffff8109e11a>] warn_slowpath_common+0x8a/0xc0
[   29.468989]  [<ffffffff8109e196>] warn_slowpath_fmt+0x46/0x50
[   29.468993]  [<ffffffff810ed7b3>] ? prepare_to_wait_event+0x63/0x100
[   29.468996]  [<ffffffff810ed7b3>] ? prepare_to_wait_event+0x63/0x100
[   29.469000]  [<ffffffff810ca77f>] __might_sleep+0x7f/0x90
[   29.469005]  [<ffffffff817f55c8>] mutex_lock_nested+0x38/0x3d0
[   29.469010]  [<ffffffff810f60cd>] ? trace_hardirqs_on+0xd/0x10
[   29.469015]  [<ffffffff81471160>] acpi_ec_transaction+0x74/0x335
[   29.469019]  [<ffffffff8147146e>] acpi_ec_read+0x4d/0x59
[   29.469024]  [<ffffffff814714a7>] ec_read+0x2d/0x45
[   29.469027]  [<ffffffff810ed7e5>] ? prepare_to_wait_event+0x95/0x100
[   29.469032]  [<ffffffffa02272a4>] smb_check_done+0x22/0x32 [sbshc]
[   29.469037]  [<ffffffffa0227464>] acpi_smbus_transaction+0x1b0/0x28b [sbshc]
[   29.469041]  [<ffffffff810ed850>] ? prepare_to_wait_event+0x100/0x100
[   29.469045]  [<ffffffffa022755a>] acpi_smbus_read+0x1b/0x1d [sbshc]
[   29.469050]  [<ffffffffa0295041>] acpi_ac_get_present+0x2d/0x62 [sbs]
[   29.469055]  [<ffffffffa0295640>] acpi_sbs_add+0xb3/0x1f8 [sbs]
[   29.469059]  [<ffffffff8146c6a6>] acpi_device_probe+0x4b/0xf9
[   29.469064]  [<ffffffff815161df>] driver_probe_device+0x1ef/0x440
[   29.469068]  [<ffffffff815164c4>] __driver_attach+0x94/0xa0
[   29.469072]  [<ffffffff81516430>] ? driver_probe_device+0x440/0x440
[   29.469077]  [<ffffffff81513f44>] bus_for_each_dev+0x64/0xa0
[   29.469080]  [<ffffffff81515b8e>] driver_attach+0x1e/0x20
[   29.469085]  [<ffffffff815156d3>] bus_add_driver+0x1d3/0x290
[   29.469088]  [<ffffffffa029a000>] ? 0xffffffffa029a000
[   29.469091]  [<ffffffff815174f0>] driver_register+0x60/0xe0
[   29.469096]  [<ffffffff8146ce41>] acpi_bus_register_driver+0x3b/0x43
[   29.469100]  [<ffffffffa029a019>] acpi_sbs_init+0x19/0x1000 [sbs]
[   29.469105]  [<ffffffff8100211d>] do_one_initcall+0xad/0x1e0
[   29.469109]  [<ffffffff817eac38>] ? do_init_module+0x28/0x1ec
[   29.469114]  [<ffffffff817eac71>] do_init_module+0x61/0x1ec
[   29.469118]  [<ffffffff81140453>] load_module+0x1e23/0x27d0
[   29.469122]  [<ffffffff8113bf50>] ? m_show+0x190/0x190
[   29.469128]  [<ffffffff81141000>] SyS_finit_module+0x80/0xb0
[   29.469133]  [<ffffffff817f9f6e>] entry_SYSCALL_64_fastpath+0x12/0x76
[   29.469136] ---[ end trace 316ff42163c9d52b ]---
[   29.499775] random: nonblocking pool is initialized
[...]
