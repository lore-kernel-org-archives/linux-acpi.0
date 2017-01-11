From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ILK ACPI boot-up problem on HP 8100 SFF, bisected
Date: Wed, 11 Jan 2017 04:09:29 +0100
Message-ID: <1596185.GhUtjqxSKW@aspire.rjw.lan>
References: <1961608.33YkWy0F8T@fractal.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41883 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753110AbdAKDNs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Jan 2017 22:13:48 -0500
In-Reply-To: <1961608.33YkWy0F8T@fractal.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomi Sarvela <tomi.p.sarvela@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tuesday, January 10, 2017 12:07:36 PM Tomi Sarvela wrote:
> On Tuesday, 10 January 2017 10:46:50 EET Tomi Sarvela wrote:
> > On Monday, 9 January 2017 23:28:32 EET Rafael J. Wysocki wrote:
> > > On Mon, Jan 9, 2017 at 11:07 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > On Mon, Jan 9, 2017 at 5:01 PM, Tomi Sarvela <tomi.p.sarvela@intel.com> wrote:
> > > >> We have couple of Iron Lake machines here, and one started
> > > >> hanging around Christmas in early boot on ACPI initialization.
> > > >> Dmesg below, full dmesgs available on request.
> > > >> 
> > > >> Exact model of the machine is HP Compaq 8100 Elite Small Form
> > > >> Factor PC. BIOS update from 2010 to 2011 (newest) didn't change
> > > >> anything. HP Elite laptop (ILK m540) or Dell SFF PC (ILK 650)
> > > >> don't have this particular problem.
> > > >> 
> > > >> I've bisected the problem to the following commit:
> > > >> 
> > > >> ----
> > > >> commit 174cc7187e6f088942c8e74daa7baff7b44b33c9
> > > >> Author: Lv Zheng <lv.zheng@intel.com>
> > > >> Date:   Wed Dec 14 15:04:25 2016 +0800
> > > >> 
> > > >>     ACPICA: Tables: Back port acpi_get_table_with_size() and
> > > >>     early_acpi_os_unmap_memory() from Linux kernel
> > > >>     
> > > >>     ACPICA commit cac6790954d4d752a083e6122220b8a22febcd07
> > > >> 
> > > >> ----
> > > > 
> > > > Thanks for the report!
> > > > 
> > > > Does this patch make any difference:
> > > > https://patchwork.kernel.org/patch/9504277/ ?
> > > 
> > > Please also check this alternative patch from Paul:
> > > 
> > > https://patchwork.kernel.org/patch/9506033/
> > 
> > I've tested both patches on top of latest kernel head (separate
> > tries, to make it clear).
> > 
> > Neither patch does any difference. In both cases kernel still hangs
> > to the same spot in boot, and 5sec powerbutton or AC reboot is
> > needed.
> 
> This might help: there is dump after a while. I've been too hasty to reboot the machine to see this before.
> 

Thanks!

> 
> [    0.854462] ACPI: Added _OSI(Module Device)
> [    0.858701] ACPI: Added _OSI(Processor Device)
> [    0.863197] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.867952] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.893684] ACPI: Dynamic OEM Table Load:
> [    0.897758] ACPI: SSDT 0xFFFF8802122EBA78 0003BA (v01 COMPAQ CPU_TM2  00000001 MSFT 0100000E)
> [  247.066214] INFO: task swapper/0:1 blocked for more than 120 seconds.
> [  247.072707]       Not tainted 4.10.0-rc2-gfxbench+ #1
> [  247.077809] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  247.085731] swapper/0       D    0     1      0 0x00000000
> [  247.091271] Call Trace:
> [  247.093774]  ? __schedule+0x2c9/0xa60
> [  247.097489]  schedule+0x3b/0x90
> [  247.100685]  schedule_timeout+0x25b/0x4c0
> [  247.104750]  ? debug_smp_processor_id+0x17/0x20
> [  247.109334]  ? set_track+0x88/0x120
> [  247.112878]  ? trace_hardirqs_on_caller+0x122/0x1b0
> [  247.117808]  __down_timeout+0x81/0xd0
> [  247.121523]  down_timeout+0x47/0x50
> [  247.125065]  acpi_os_wait_semaphore+0x47/0x62
> [  247.129475]  acpi_ut_acquire_mutex+0x43/0x81
> [  247.133798]  acpi_get_table+0x2d/0x84
> [  247.137513]  acpi_table_attr_init+0xcd/0x100
> [  247.141834]  ? acpi_sysfs_table_handler+0x3e/0xb8
> [  247.146590]  acpi_sysfs_table_handler+0x5d/0xb8
> [  247.151174]  acpi_bus_table_handler+0x23/0x2a
> [  247.155583]  acpi_tb_install_standard_table+0xe0/0x213
> [  247.160773]  ? down_timeout+0x32/0x50
> [  247.164489]  acpi_tb_install_and_load_table+0x3a/0x82
> [  247.169592]  acpi_ex_load_op+0x194/0x201
> [  247.173568]  ? acpi_ex_resolve_operands+0x207/0x4dc
> [  247.178497]  acpi_ex_opcode_1A_1T_0R+0x25/0x46
> [  247.182993]  acpi_ds_exec_end_op+0xc8/0x3df
> [  247.187229]  acpi_ps_parse_loop+0x50e/0x560
> [  247.191465]  acpi_ps_parse_aml+0x93/0x276
> [  247.195526]  acpi_ps_execute_method+0x146/0x181
> [  247.200108]  acpi_ns_evaluate+0x1bb/0x247
> [  247.204170]  acpi_evaluate_object+0x178/0x274
> [  247.208581]  ? acpi_processor_set_pdc+0x88/0x17b
> [  247.213249]  acpi_processor_set_pdc+0x154/0x17b
> [  247.217833]  early_init_pdc+0x9a/0xa3
> [  247.221548]  ? up+0x2d/0x50
> [  247.224395]  acpi_ns_walk_namespace+0xdc/0x18e
> [  247.228891]  ? set_no_mwait+0x23/0x23
> [  247.232606]  ? set_no_mwait+0x23/0x23
> [  247.236321]  acpi_walk_namespace+0x97/0xcb
> [  247.240471]  ? acpi_sleep_proc_init+0x28/0x28
> [  247.244880]  ? rest_init+0x130/0x130
> [  247.248507]  acpi_early_processor_set_pdc+0x30/0x4a
> [  247.253436]  acpi_init+0x19f/0x315
> [  247.256891]  do_one_initcall+0x3f/0x170
> [  247.260781]  kernel_init_freeable+0x11d/0x1a3
> [  247.265191]  ? rest_init+0x130/0x130
> [  247.268822]  kernel_init+0x9/0x100
> [  247.272276]  ret_from_fork+0x27/0x40
> [  247.275904] 
> [  247.275904] Showing all locks held in the system:
> [  247.282179] 2 locks held by khungtaskd/34:
> [  247.286326]  #0:  (rcu_read_lock){......}, at: [<ffffffff811332cc>] watchdog+0x9c/0x600
> [  247.294423]  #1:  (tasklist_lock){.+.+..}, at: [<ffffffff810dae1d>] debug_show_all_locks+0x3d/0x1a0
> [  247.303562] 
> [  247.305105] =============================================
> [  247.305105] 
> 

Lv, can you have a look at this, please?

Thanks,
Rafael

