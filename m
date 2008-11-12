From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: [Linux 2.6.28-rc4] BUG: using smp_processor_id() in preemptible [00000000] code: suspend_to_disk/2934
Date: Wed, 12 Nov 2008 19:30:13 +0100
Message-ID: <8db1092f0811121030t1977b3bbu8340b582694d1e65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:48519 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbYKLSaQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2008 13:30:16 -0500
Received: by qw-out-2122.google.com with SMTP id 3so310002qwe.37
        for <linux-acpi@vger.kernel.org>; Wed, 12 Nov 2008 10:30:14 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, linux-acpi@vger.kernel.org

-rc3 works OK

I have this bug during suspend to disk:

[  188.592151] Enabling non-boot CPUs ...
[  188.592151] SMP alternatives: switching to SMP code
[  188.666058] BUG: using smp_processor_id() in preemptible [00000000]
code: suspend_to_disk/2934
[  188.666064] caller is native_sched_clock+0x2b/0x80
[  188.666067] Pid: 2934, comm: suspend_to_disk Not tainted 2.6.28-rc4 #1
[  188.666069] Call Trace:
[  188.666074]  [<c02556ff>] debug_smp_processor_id+0xbf/0xd0
[  188.666077]  [<c010a2db>] native_sched_clock+0x2b/0x80
[  188.666080]  [<c03ae3a0>] init_idle+0x88/0x11a
[  188.666083]  [<c03ad206>] native_cpu_up+0x4a6/0x75a
[  188.666086]  [<c01de808>] sysfs_add_file_mode+0x58/0x90
[  188.666089]  [<c03ad4ba>] do_fork_idle+0x0/0x19
[  188.666092]  [<c014864e>] notifier_call_chain+0x3e/0x80
[  188.666095]  [<c03ae99a>] _cpu_up+0x6a/0x103
[  188.666097]  [<c03a1e75>] enable_nonboot_cpus+0x65/0xa0
[  188.666101]  [<c02cd240>] device_pm_unlock+0x0/0x10
[  188.666105]  [<c0159ba7>] hibernation_snapshot+0x137/0x200
[  188.666107]  [<c0158dff>] freeze_processes+0x4f/0xa0
[  188.666110]  [<c0159d4f>] hibernate+0xdf/0x190
[  188.666112]  [<c0158910>] state_store+0x0/0xd0
[  188.666115]  [<c01589c2>] state_store+0xb2/0xd0
[  188.666117]  [<c0158910>] state_store+0x0/0xd0
[  188.666120]  [<c024b1d4>] kobj_attr_store+0x24/0x30
[  188.666122]  [<c01de221>] sysfs_write_file+0xa1/0x110
[  188.666124]  [<c01de180>] sysfs_write_file+0x0/0x110
[  188.666127]  [<c0198e38>] vfs_write+0xa8/0x140
[  188.666129]  [<c0198fa1>] sys_write+0x41/0x80
[  188.666131]  [<c0103f49>] sysenter_do_call+0x12/0x21
[  188.666133]  [<c03b0000>] acpi_processor_start+0x690/0x69a
[  188.666136] Booting processor 1 APIC 0x1 ip 0x6000
[  188.590718] Initializing CPU#1

dmesg and config:
http://unixy.pl/maciek/download/kernel/2.6.28-rc4_smp/

-- 
Maciej Rutecki
http://www.maciek.unixy.pl
