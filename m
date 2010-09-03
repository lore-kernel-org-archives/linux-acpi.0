From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Another bad usage of smp_processor_id
Date: Fri, 03 Sep 2010 14:01:02 +0800
Message-ID: <1283493662.2111.3158.camel@rui>
References: <1283077579.5529.2.camel@maxim-laptop>
	 <1283336736.3564.0.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35121 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800Ab0ICF5w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Sep 2010 01:57:52 -0400
In-Reply-To: <1283336736.3564.0.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Maxim,

please try this patch and see if the problem still exists. :)

On Wed, 2010-09-01 at 18:25 +0800, Maxim Levitsky wrote:
> On Sun, 2010-08-29 at 13:26 +0300, Maxim Levitsky wrote: 
> > Hi,
> > 
> > Now that I applied the patch that makes NMI watchdog not trigger this,
> > the amount of backtraces reduced, so I finally notice that on resume:
> > 
> > [ 3226.997285] Back to C!
> > [ 3226.997285] PM: Restoring platform NVS memory
> > [ 3226.997285] CPU0: Thermal monitoring handled by SMI
> > [ 3226.997285] Enabling non-boot CPUs ...
> > [ 3227.000076] BUG: using smp_processor_id() in preemptible [00000000] code: pm-suspend/5185
> > [ 3227.000085] caller is thermal_throttle_add_dev+0x20/0xa4
> > [ 3227.000091] Pid: 5185, comm: pm-suspend Tainted: P            2.6.36-rc2+ #132
> > [ 3227.000096] Call Trace:
> > [ 3227.000104]  [<ffffffff811e6242>] debug_smp_processor_id+0xd2/0xf0
> > [ 3227.000110]  [<ffffffff813a0174>] thermal_throttle_add_dev+0x20/0xa4
> > [ 3227.000117]  [<ffffffff813a0244>] thermal_throttle_cpu_callback+0x4c/0xb7
> > [ 3227.000123]  [<ffffffff81063c61>] notifier_call_chain+0x51/0x80
> > [ 3227.000130]  [<ffffffff810425d2>] ? cpu_maps_update_begin+0x12/0x20
> > [ 3227.000136]  [<ffffffff81063d19>] __raw_notifier_call_chain+0x9/0x10
> > [ 3227.000141]  [<ffffffff8104258b>] __cpu_notify+0x1b/0x30
> > [ 3227.000147]  [<ffffffff813a29d4>] _cpu_up+0x6e/0x10d
> > [ 3227.000153]  [<ffffffff81396335>] enable_nonboot_cpus+0x95/0xc0
> > [ 3227.000160]  [<ffffffff8107ffcc>] suspend_devices_and_enter+0x10c/0x1e0
> > [ 3227.000166]  [<ffffffff810801bc>] enter_state+0x11c/0x190
> > [ 3227.000172]  [<ffffffff8107f821>] state_store+0x91/0x100
> > [ 3227.000179]  [<ffffffff811d7a87>] kobj_attr_store+0x17/0x20
> > [ 3227.000185]  [<ffffffff8114a392>] sysfs_write_file+0xf2/0x170
> > [ 3227.000192]  [<ffffffff810df658>] vfs_write+0xc8/0x190
> > [ 3227.000198]  [<ffffffff810df7ff>] sys_write+0x4f/0x90
> > [ 3227.000205]  [<ffffffff81002deb>] system_call_fastpath+0x16/0x1b
> > [ 3227.000328] lockdep: fixing up alternatives.
> > [ 3227.000332] SMP alternatives: switching to SMP code
> > 

Don't use smp_processor_id() when preempt enabled.

Maxim got this on resume,

[ 3226.997285] Back to C!
[ 3226.997285] PM: Restoring platform NVS memory
[ 3226.997285] CPU0: Thermal monitoring handled by SMI
[ 3226.997285] Enabling non-boot CPUs ...
[ 3227.000076] BUG: using smp_processor_id() in preemptible [00000000] code: pm-suspend/5185
[ 3227.000085] caller is thermal_throttle_add_dev+0x20/0xa4
[ 3227.000091] Pid: 5185, comm: pm-suspend Tainted: P            2.6.36-rc2+ #132
[ 3227.000096] Call Trace:
[ 3227.000104]  [<ffffffff811e6242>] debug_smp_processor_id+0xd2/0xf0
[ 3227.000110]  [<ffffffff813a0174>] thermal_throttle_add_dev+0x20/0xa4
[ 3227.000117]  [<ffffffff813a0244>] thermal_throttle_cpu_callback+0x4c/0xb7
[ 3227.000123]  [<ffffffff81063c61>] notifier_call_chain+0x51/0x80
[ 3227.000130]  [<ffffffff810425d2>] ? cpu_maps_update_begin+0x12/0x20
[ 3227.000136]  [<ffffffff81063d19>] __raw_notifier_call_chain+0x9/0x10
[ 3227.000141]  [<ffffffff8104258b>] __cpu_notify+0x1b/0x30
[ 3227.000147]  [<ffffffff813a29d4>] _cpu_up+0x6e/0x10d
[ 3227.000153]  [<ffffffff81396335>] enable_nonboot_cpus+0x95/0xc0
[ 3227.000160]  [<ffffffff8107ffcc>] suspend_devices_and_enter+0x10c/0x1e0
[ 3227.000166]  [<ffffffff810801bc>] enter_state+0x11c/0x190
[ 3227.000172]  [<ffffffff8107f821>] state_store+0x91/0x100
[ 3227.000179]  [<ffffffff811d7a87>] kobj_attr_store+0x17/0x20
[ 3227.000185]  [<ffffffff8114a392>] sysfs_write_file+0xf2/0x170
[ 3227.000192]  [<ffffffff810df658>] vfs_write+0xc8/0x190
[ 3227.000198]  [<ffffffff810df7ff>] sys_write+0x4f/0x90
[ 3227.000205]  [<ffffffff81002deb>] system_call_fastpath+0x16/0x1b
[ 3227.000328] lockdep: fixing up alternatives.
[ 3227.000332] SMP alternatives: switching to SMP code

Reported-by: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/cpu/mcheck/therm_throt.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

Index: linux-2.6/arch/x86/kernel/cpu/mcheck/therm_throt.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/cpu/mcheck/therm_throt.c	2010-09-03 10:43:29.000000000 +0800
+++ linux-2.6/arch/x86/kernel/cpu/mcheck/therm_throt.c	2010-09-03 13:38:45.000000000 +0800
@@ -202,14 +202,16 @@
 
 #ifdef CONFIG_SYSFS
 /* Add/Remove thermal_throttle interface for CPU device: */
-static __cpuinit int thermal_throttle_add_dev(struct sys_device *sys_dev)
+static __cpuinit int thermal_throttle_add_dev(unsigned int cpu)
 {
 	int err;
-	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
+	struct sys_device *sys_dev;
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
 
+	sys_dev=get_cpu_sysdev(cpu);
 	err = sysfs_create_group(&sys_dev->kobj, &thermal_attr_group);
 	if (err)
-		return err;
+		goto end;
 
 	if (cpu_has(c, X86_FEATURE_PLN))
 		err = sysfs_add_file_to_group(&sys_dev->kobj,
@@ -224,11 +226,14 @@
 					&attr_package_power_limit_count.attr,
 					thermal_attr_group.name);
 
+end:
+	put_cpu();
 	return err;
 }
 
-static __cpuinit void thermal_throttle_remove_dev(struct sys_device *sys_dev)
+static __cpuinit void thermal_throttle_remove_dev(unsigned int cpu)
 {
+	struct sys_device *sys_dev=get_cpu_sysdev(cpu);
 	sysfs_remove_group(&sys_dev->kobj, &thermal_attr_group);
 }
 
@@ -242,16 +247,13 @@
 			      void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
-	struct sys_device *sys_dev;
 	int err = 0;
 
-	sys_dev = get_cpu_sysdev(cpu);
-
 	switch (action) {
 	case CPU_UP_PREPARE:
 	case CPU_UP_PREPARE_FROZEN:
 		mutex_lock(&therm_cpu_lock);
-		err = thermal_throttle_add_dev(sys_dev);
+		err = thermal_throttle_add_dev(cpu);
 		mutex_unlock(&therm_cpu_lock);
 		WARN_ON(err);
 		break;
@@ -260,7 +262,7 @@
 	case CPU_DEAD:
 	case CPU_DEAD_FROZEN:
 		mutex_lock(&therm_cpu_lock);
-		thermal_throttle_remove_dev(sys_dev);
+		thermal_throttle_remove_dev(cpu);
 		mutex_unlock(&therm_cpu_lock);
 		break;
 	}
@@ -287,7 +289,7 @@
 #endif
 	/* connect live CPUs to sysfs */
 	for_each_online_cpu(cpu) {
-		err = thermal_throttle_add_dev(get_cpu_sysdev(cpu));
+		err = thermal_throttle_add_dev(cpu);
 		WARN_ON(err);
 	}
 #ifdef CONFIG_HOTPLUG_CPU


