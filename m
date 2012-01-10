From: Josh Boyer <jwboyer@redhat.com>
Subject: 3.1 Panic on power event
Date: Tue, 10 Jan 2012 11:59:34 -0500
Message-ID: <20120110165850.GA3015@zod.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39679 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088Ab2AJQ7h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Jan 2012 11:59:37 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: kernel-team@fedoraproject.org

Hi All,

We've had a report [1] from a user that the 3.1.6 kernel panics if they
plug or unplug their machine.  The oops seems to come from an issue
somewhere in the acpi notification stack.  The relevant backtrace
functions are (transcribed from a jpeg):

acpi_ac_notify
acpi_device_notify
acpi_ev_notify_dispatch
acpi_os_execute_deferred

Looking at the dmesg during boot, it seems this machine is also
triggering an oops for duplicate registration of an ACAD device.  You
can find the backtraces for that below.

Looking at the acpidump output [2], I noticed that there is indeed two
Device(ACAD) entries in the DSDT.  The first is under the system bus and
the second is under PCI0.  The problem seems to stem from some
Notify(ACAD) entries, but ACAD is ambiguous.  I'm guessing the ACPI code
is getting an event for the device that wasn't set up properly?

I'm by no means an ACPI expert, so I'd really appreciate thoughts and
review.

josh

[1] https://bugzilla.redhat.com/show_bug.cgi?id=772730
[2] https://bugzilla.redhat.com/attachment.cgi?id=551677

Duplicate device oopses:

ACPI: Deprecated procfs I/F for AC is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[    2.766097] ACPI: AC Adapter [ACAD] (off-line)
[    2.826203] ACPI: Deprecated procfs I/F for AC is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[    2.826231] ------------[ cut here ]------------
[    2.826253] WARNING: at fs/proc/generic.c:586 proc_register+0x10f/0x1f0()
[    2.826261] Hardware name: Inspiron 1090
[    2.826268] proc_dir_entry 'ac_adapter/ACAD' already registered
[    2.826275] Modules linked in:
[    2.826287] Pid: 1, comm: swapper Not tainted 3.1.6-1.fc16.x86_64 #1
[    2.826295] Call Trace:
[    2.826315]  [<ffffffff8106b73f>] warn_slowpath_common+0x7f/0xc0
[    2.826359]  [<ffffffff8106b836>] warn_slowpath_fmt+0x46/0x50
[    2.826373]  [<ffffffff811d5bbf>] proc_register+0x10f/0x1f0
[    2.826387]  [<ffffffff811d619f>] proc_mkdir_mode+0x3f/0x60
[    2.826400]  [<ffffffff811d61d6>] proc_mkdir+0x16/0x20
[    2.826414]  [<ffffffff8132b5e8>] acpi_ac_add+0xc2/0x1b8
[    2.826429]  [<ffffffff81308d22>] acpi_device_probe+0x4e/0x11c
[    2.826444]  [<ffffffff8138ba2c>] driver_probe_device+0x9c/0x2b0
[    2.826456]  [<ffffffff8138bceb>] __driver_attach+0xab/0xb0
[    2.826469]  [<ffffffff8138bc40>] ? driver_probe_device+0x2b0/0x2b0
[    2.826483]  [<ffffffff8138bc40>] ? driver_probe_device+0x2b0/0x2b0
[    2.826497]  [<ffffffff8138a8ac>] bus_for_each_dev+0x5c/0x90
[    2.826510]  [<ffffffff8138b63e>] driver_attach+0x1e/0x20
[    2.826523]  [<ffffffff8138b240>] bus_add_driver+0x1b0/0x2a0
[    2.826539]  [<ffffffff81bb06ad>] ? acpi_initialize_subsystem+0xa9/0xa9
[    2.826551]  [<ffffffff8138c246>] driver_register+0x76/0x140
[    2.826563]  [<ffffffff81063070>] ? try_to_wake_up+0x290/0x290
[    2.826576]  [<ffffffff81bb06ad>] ? acpi_initialize_subsystem+0xa9/0xa9
[    2.826590]  [<ffffffff813095a4>] acpi_bus_register_driver+0x43/0x45
[    2.826603]  [<ffffffff81bb06e0>] acpi_ac_init+0x33/0x4f
[    2.826617]  [<ffffffff81002042>] do_one_initcall+0x42/0x180
[    2.826632]  [<ffffffff81b7ecf3>] kernel_init+0xde/0x158
[    2.826644]  [<ffffffff810636d7>] ? schedule_tail+0x27/0xb0
[    2.826659]  [<ffffffff815dee34>] kernel_thread_helper+0x4/0x10
[    2.826672]  [<ffffffff81b7ec15>] ? start_kernel+0x3c0/0x3c0
[    2.826685]  [<ffffffff815dee30>] ? gs_change+0x13/0x13
[    2.826706] ---[ end trace 82bc55f036371117 ]---
[    2.826762] ------------[ cut here ]------------
[    2.826776] WARNING: at fs/sysfs/dir.c:455 sysfs_add_one+0xc1/0xf0()
[    2.826784] Hardware name: Inspiron 1090
[    2.826790] sysfs: cannot create duplicate filename '/class/power_supply/ACAD'
[    2.826797] Modules linked in:
[    2.826808] Pid: 1, comm: swapper Tainted: G        W   3.1.6-1.fc16.x86_64 #1
[    2.826815] Call Trace:
[    2.826829]  [<ffffffff8106b73f>] warn_slowpath_common+0x7f/0xc0
[    2.826842]  [<ffffffff8106b836>] warn_slowpath_fmt+0x46/0x50
[    2.826855]  [<ffffffff811e2411>] sysfs_add_one+0xc1/0xf0
[    2.826869]  [<ffffffff811e2dc5>] sysfs_do_create_link+0x135/0x220
[    2.826881]  [<ffffffff811e1561>] ? sysfs_add_file_mode+0x61/0xb0
[    2.826895]  [<ffffffff811e2ec3>] sysfs_create_link+0x13/0x20
[    2.826908]  [<ffffffff81388b06>] device_add+0x2b6/0x680
[    2.826923]  [<ffffffff812aa3e8>] ? kobject_set_name+0x38/0x40
[    2.826938]  [<ffffffff814514a8>] power_supply_register+0xf8/0x140
[    2.826952]  [<ffffffff8132b6ae>] acpi_ac_add+0x188/0x1b8
[    2.826965]  [<ffffffff81308d22>] acpi_device_probe+0x4e/0x11c
[    2.826979]  [<ffffffff8138ba2c>] driver_probe_device+0x9c/0x2b0
[    2.826991]  [<ffffffff8138bceb>] __driver_attach+0xab/0xb0
[    2.827004]  [<ffffffff8138bc40>] ? driver_probe_device+0x2b0/0x2b0
[    2.827052]  [<ffffffff8138bc40>] ? driver_probe_device+0x2b0/0x2b0
[    2.827066]  [<ffffffff8138a8ac>] bus_for_each_dev+0x5c/0x90
[    2.827079]  [<ffffffff8138b63e>] driver_attach+0x1e/0x20
[    2.827092]  [<ffffffff8138b240>] bus_add_driver+0x1b0/0x2a0
[    2.827106]  [<ffffffff81bb06ad>] ? acpi_initialize_subsystem+0xa9/0xa9
[    2.827118]  [<ffffffff8138c246>] driver_register+0x76/0x140
[    2.827129]  [<ffffffff81063070>] ? try_to_wake_up+0x290/0x290
[    2.827143]  [<ffffffff81bb06ad>] ? acpi_initialize_subsystem+0xa9/0xa9
[    2.827156]  [<ffffffff813095a4>] acpi_bus_register_driver+0x43/0x45
[    2.827169]  [<ffffffff81bb06e0>] acpi_ac_init+0x33/0x4f
[    2.827182]  [<ffffffff81002042>] do_one_initcall+0x42/0x180
[    2.827195]  [<ffffffff81b7ecf3>] kernel_init+0xde/0x158
[    2.827207]  [<ffffffff810636d7>] ? schedule_tail+0x27/0xb0
[    2.827221]  [<ffffffff815dee34>] kernel_thread_helper+0x4/0x10
[    2.827234]  [<ffffffff81b7ec15>] ? start_kernel+0x3c0/0x3c0
[    2.827247]  [<ffffffff815dee30>] ? gs_change+0x13/0x13
[    2.827255] ---[ end trace 82bc55f036371118 ]---
[    2.887119] ACPI: AC Adapter [ACAD] (off-line)

