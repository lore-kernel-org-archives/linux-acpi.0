From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] acpi-cpufreq: fix a memleak when unloading acpi-cpufreq
 driver
Date: Tue, 12 Oct 2010 09:09:37 +0800
Message-ID: <1286845777.2111.4082.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19327 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753658Ab0JLBMY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Oct 2010 21:12:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, toralf.foerster@gmx.de


[ACPI-FREQ] fix memory leak in acpi_cpufreq driver

We didn't free per_cpu(acfreq_data, cpu)->freq_table
when acpi_freq driver is unloaded.

Resulting in the following messages in /sys/kernel/debug/kmemleak:

unreferenced object 0xf6450e80 (size 64):
  comm "modprobe", pid 1066, jiffies 4294677317 (age 19290.453s)
  hex dump (first 32 bytes):
    00 00 00 00 e8 a2 24 00 01 00 00 00 00 9f 24 00  ......$.......$.
    02 00 00 00 00 6a 18 00 03 00 00 00 00 35 0c 00  .....j.......5..
  backtrace:
    [<c123ba97>] kmemleak_alloc+0x27/0x50
    [<c109f96f>] __kmalloc+0xcf/0x110
    [<f9da97ee>] acpi_cpufreq_cpu_init+0x1ee/0x4e4 [acpi_cpufreq]
    [<c11cd8d2>] cpufreq_add_dev+0x142/0x3a0
    [<c11920b7>] sysdev_driver_register+0x97/0x110
    [<c11cce56>] cpufreq_register_driver+0x86/0x140
    [<f9dad080>] 0xf9dad080
    [<c1001130>] do_one_initcall+0x30/0x160
    [<c10626e9>] sys_init_module+0x99/0x1e0
    [<c1002d97>] sysenter_do_call+0x12/0x26
    [<ffffffff>] 0xffffffff

https://bugzilla.kernel.org/show_bug.cgi?id=15807#c21

Tested-by: Toralf Forster <toralf.foerster@gmx.de>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ linux-2.6/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -701,6 +701,7 @@ static int acpi_cpufreq_cpu_exit(struct 
 		per_cpu(acfreq_data, policy->cpu) = NULL;
 		acpi_processor_unregister_performance(data->acpi_data,
 						      policy->cpu);
+		kfree(data->freq_table);
 		kfree(data);
 	}
 


