From: Tomi Sarvela <tomi.p.sarvela@intel.com>
Subject: Re: ILK ACPI boot-up problem on HP 8100 SFF, bisected
Date: Wed, 18 Jan 2017 15:25:49 +0200
Message-ID: <1771449.3Vm8lxD6tb@fractal.fi.intel.com>
References: <1961608.33YkWy0F8T@fractal.fi.intel.com> <1596185.GhUtjqxSKW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6904 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751842AbdARN00 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Jan 2017 08:26:26 -0500
In-Reply-To: <1596185.GhUtjqxSKW@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wednesday, 11 January 2017 04:09:29 EET Rafael J. Wysocki wrote:
> On Tuesday, January 10, 2017 12:07:36 PM Tomi Sarvela wrote:
> > 
> > This might help: there is dump after a while. I've been too hasty
> > to reboot the machine to see this before.
> Thanks!

Has there been any progress or interest towards tracking down this particular problem?

Tested with  4.10-rc3. Boot hangs to the same point, dmesg INFO bursts like below come with ~120sec intervals.

Best regards,

Tomi Sarvela

> > [    0.854462] ACPI: Added _OSI(Module Device)
> > [    0.858701] ACPI: Added _OSI(Processor Device)
> > [    0.863197] ACPI: Added _OSI(3.0 _SCP Extensions)
> > [    0.867952] ACPI: Added _OSI(Processor Aggregator Device)
> > [    0.893684] ACPI: Dynamic OEM Table Load:
> > [    0.897758] ACPI: SSDT 0xFFFF8802122EBA78 0003BA (v01 COMPAQ
> > CPU_TM2  00000001 MSFT 0100000E) [  247.066214] INFO: task
> > swapper/0:1 blocked for more than 120 seconds. [  247.072707]    
> >   Not tainted 4.10.0-rc2-gfxbench+ #1
> > [  247.077809] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message. [  247.085731] swapper/0       D    0    
> > 1      0 0x00000000 [  247.091271] Call Trace:
> > [  247.093774]  ? __schedule+0x2c9/0xa60
> > [  247.097489]  schedule+0x3b/0x90
> > [  247.100685]  schedule_timeout+0x25b/0x4c0
> > [  247.104750]  ? debug_smp_processor_id+0x17/0x20
> > [  247.109334]  ? set_track+0x88/0x120
> > [  247.112878]  ? trace_hardirqs_on_caller+0x122/0x1b0
> > [  247.117808]  __down_timeout+0x81/0xd0
> > [  247.121523]  down_timeout+0x47/0x50
> > [  247.125065]  acpi_os_wait_semaphore+0x47/0x62
> > [  247.129475]  acpi_ut_acquire_mutex+0x43/0x81
> > [  247.133798]  acpi_get_table+0x2d/0x84
> > [  247.137513]  acpi_table_attr_init+0xcd/0x100
> > [  247.141834]  ? acpi_sysfs_table_handler+0x3e/0xb8
> > [  247.146590]  acpi_sysfs_table_handler+0x5d/0xb8
> > [  247.151174]  acpi_bus_table_handler+0x23/0x2a
> > [  247.155583]  acpi_tb_install_standard_table+0xe0/0x213
> > [  247.160773]  ? down_timeout+0x32/0x50
> > [  247.164489]  acpi_tb_install_and_load_table+0x3a/0x82
> > [  247.169592]  acpi_ex_load_op+0x194/0x201
> > [  247.173568]  ? acpi_ex_resolve_operands+0x207/0x4dc
> > [  247.178497]  acpi_ex_opcode_1A_1T_0R+0x25/0x46
> > [  247.182993]  acpi_ds_exec_end_op+0xc8/0x3df
> > [  247.187229]  acpi_ps_parse_loop+0x50e/0x560
> > [  247.191465]  acpi_ps_parse_aml+0x93/0x276
> > [  247.195526]  acpi_ps_execute_method+0x146/0x181
> > [  247.200108]  acpi_ns_evaluate+0x1bb/0x247
> > [  247.204170]  acpi_evaluate_object+0x178/0x274
> > [  247.208581]  ? acpi_processor_set_pdc+0x88/0x17b
> > [  247.213249]  acpi_processor_set_pdc+0x154/0x17b
> > [  247.217833]  early_init_pdc+0x9a/0xa3
> > [  247.221548]  ? up+0x2d/0x50
> > [  247.224395]  acpi_ns_walk_namespace+0xdc/0x18e
> > [  247.228891]  ? set_no_mwait+0x23/0x23
> > [  247.232606]  ? set_no_mwait+0x23/0x23
> > [  247.236321]  acpi_walk_namespace+0x97/0xcb
> > [  247.240471]  ? acpi_sleep_proc_init+0x28/0x28
> > [  247.244880]  ? rest_init+0x130/0x130
> > [  247.248507]  acpi_early_processor_set_pdc+0x30/0x4a
> > [  247.253436]  acpi_init+0x19f/0x315
> > [  247.256891]  do_one_initcall+0x3f/0x170
> > [  247.260781]  kernel_init_freeable+0x11d/0x1a3
> > [  247.265191]  ? rest_init+0x130/0x130
> > [  247.268822]  kernel_init+0x9/0x100
> > [  247.272276]  ret_from_fork+0x27/0x40
> > [  247.275904]
> > [  247.275904] Showing all locks held in the system:
> > [  247.282179] 2 locks held by khungtaskd/34:
> > [  247.286326]  #0:  (rcu_read_lock){......}, at:
> > [<ffffffff811332cc>] watchdog+0x9c/0x600 [  247.294423]  #1: 
> > (tasklist_lock){.+.+..}, at: [<ffffffff810dae1d>]
> > debug_show_all_locks+0x3d/0x1a0 [  247.303562]
> > [  247.305105] =============================================
> > [  247.305105]
> 
> Lv, can you have a look at this, please?
> 
> Thanks,
> Rafael


