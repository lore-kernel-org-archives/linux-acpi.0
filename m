From: kleph <kleph@kleph.info>
Subject: PANIC at boot on Gigabyte GA-Q67M-D2H-B3
Date: Mon, 08 Oct 2012 20:03:47 +0200
Message-ID: <2665195.UXzpLIKQbe@arrakis>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hyperion.kleph.info ([88.163.77.66]:58417 "EHLO mail.kleph.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582Ab2JHSER (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Oct 2012 14:04:17 -0400
Received: from arrakis.localnet (arrakis.wired.lan [IPv6:2a01:e35:8a34:d420:1e6f:65ff:fef8:8324])
	by mail.kleph.info (Postfix) with ESMTPSA id 4408847BAB
	for <linux-acpi@vger.kernel.org>; Mon,  8 Oct 2012 20:04:16 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,    


I have a kernel panic when I try to boot the kernel on a gigabyte GQ-Q67M-D2H-
B3 motherboard.
I have made screen shots of the panic [1]

The board boots with acpi=off
I have found a MacOS forum that provided a custom dsdt table to allow the 
board to boot their OS.
I am using this custom DSDT[2] to allow linux to boot also.

It's just a quick and dirty workaround since I still have errors about ACPI in 
dmesg and the integrated intel GPU crash when I try to start X. (It seems to 
be usable in console with modest, BTW).
(I also have other issues with fan control after suspend to ram, but maybe 
it's unrelated, I need investigate further more).

Here is the error with a kernel 3.6.0 and the custom dsdt
(CONFIG_ACPI_DEBUG=y but acpi.debug_layer not specified)

[    0.182297] ACPI: Added _OSI(Module Device)
[    0.182557] ACPI: Added _OSI(Processor Device)
[    0.182819] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.183081] ACPI: Added _OSI(Processor Aggregator Device)
[    0.184236] ACPI: EC: Look up EC in DSDT
[    0.185408] ACPI: Executed 1 blocks of module-level executable AML code
[    0.188376] ------------[ cut here ]------------
[    0.188640] WARNING: at mm/page_alloc.c:2349 
__alloc_pages_nodemask+0x1d8/0x832()
[    0.189123] Hardware name: To be filled by O.E.M.
[    0.189381] Modules linked in:
[    0.189676] Pid: 1, comm: swapper/0 Tainted: G       A     3.6.0-gentoo #1
[    0.189937] Call Trace:
[    0.190193]  [<ffffffff8102e96f>] warn_slowpath_common+0x80/0x98
[    0.190452]  [<ffffffff8102e99c>] warn_slowpath_null+0x15/0x17
[    0.190710]  [<ffffffff810b249e>] __alloc_pages_nodemask+0x1d8/0x832
[    0.190970]  [<ffffffff810248e8>] ? __ioremap_caller+0x295/0x31d
[    0.191228]  [<ffffffff81024991>] ? ioremap_cache+0xf/0x11
[    0.191487]  [<ffffffff815be763>] ? acpi_os_map_memory+0x15a/0x174
[    0.196478]  [<ffffffff812e4741>] acpi_walk_namespace+0x8e/0xc8
[    0.196740]  [<ffffffff81ae56f1>] ? acpi_sleep_proc_init+0x2a/0x2a
[    0.197005]  [<ffffffff81ae5c37>] acpi_early_processor_set_pdc+0x3a/0x53
[    0.197269]  [<ffffffff81ae579e>] acpi_init+0xad/0x222
[    0.197531]  [<ffffffff81ae425e>] ? agp_intel_init+0x29/0x29
[    0.197796]  [<ffffffff810002df>] do_one_initcall+0x7a/0x12b
[    0.198058]  [<ffffffff81abec18>] kernel_init+0x139/0x1ca
[    0.198321]  [<ffffffff81abe4c7>] ? loglevel+0x31/0x31
[    0.198583]  [<ffffffff815db074>] kernel_thread_helper+0x4/0x10
[    0.198845]  [<ffffffff81abeadf>] ? start_kernel+0x335/0x335
[    0.199105]  [<ffffffff815db070>] ? gs_change+0xb/0xb
[    0.199367] ---[ end trace c783c03dffeffc8d ]---
[    0.199628] ACPI Error: Method parse/execution failed [\_PR_.OSC_] (Node 
ffff88024485e3e8), AE_NO_MEMORY (20120711/psparse-536)
[    0.200266] ACPI Error: Method parse/execution failed [\_PR_.PDC_] (Node 
ffff88024485e3c0), AE_NO_MEMORY (20120711/psparse-536)
[    0.200898] ACPI Error: Method parse/execution failed [\_PR_.P000._PDC] 
(Node ffff8802448625f0), AE_NO_MEMORY (20120711/psparse-536)
[    0.202078] ACPI: Interpreter enabled

(the full log is here[4] )

It does not seem to be a hardware problem, since the board is working with 
Windows 7.

I tried to extract the "native" DSDT from windows [3]



Does someone have any suggestions about to solve those issues or have 
successfully boot linux on this board ?


--
Regards,
kleph <kleph@kleph.info>



[1] http://hyperion.kleph.info/kernel_panic/jpg/kernel-3.6.0-orig-dsdt-0.jpg 
and the other pics in the directory
[2] http://hyperion.kleph.info/kernel_panic/dsdt/dsdt-custom.aml
[3] http://hyperion.kleph.info/kernel_panic/dsdt/dsdt-orig.aml
[4] http://hyperion.kleph.info/kernel_panic/dmesg_3.6.0-dsdt-custom.txt
