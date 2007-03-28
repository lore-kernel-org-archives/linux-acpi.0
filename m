From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: Fw: Re: 2.6.21-rc4-mm1 + 4 hotfixes -- BUG: unable to handle
	kernel paging request at virtual address 6b6b6ceb -- EIP is at
	module_put+0x7/0x1f
Date: Wed, 28 Mar 2007 11:52:33 +0800
Message-ID: <1175053953.10369.2.camel@sli10-conroe.sh.intel.com>
References: <20070322095232.f992794a.akpm@linux-foundation.org>
	 <1174615467.23591.3.camel@sli10-conroe.sh.intel.com>
	 <20070323051613.GA9560@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3590 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753078AbXC1DzY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Mar 2007 23:55:24 -0400
In-Reply-To: <20070323051613.GA9560@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>, "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org

On Thu, 2007-03-22 at 22:16 -0700, Greg KH wrote:
> On Fri, Mar 23, 2007 at 10:04:26AM +0800, Shaohua Li wrote:
> > On Fri, 2007-03-23 at 01:52 +0800, Andrew Morton wrote:
> > > 
> > > It looks like the cpuidle patches are doing incorrect things
> > > with their kobject protocol.
> > Looks the goal to force kobject to be allocated dynamically is to
> > release the memory of the kobject. But in the cpuidle case, we don't
> > want to free the memory as it might be used soon.
> 
> What do you mean "used soon"?  Is this a time critical thing?
> 
> > I saw a lot of similar staff too, like 'cpu_devices' in
> > arch/i386/kernel/topology.c.
> 
> The point is that kobjects should be created dynamically as they can be
> referenced by different threads at different times, so you need to let
> it manage the reference counting logic for you.  Don't create them
> statically, it's almost always wrong.
> 
> Note, one valid use of static kobject is in struct bus_type and in some
> class definitions.
> 
> So this should probably be fixed.
Ok, below patch should fix the issue.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Index: rc4-mm1/drivers/acpi/processor_idle.c
===================================================================
--- rc4-mm1.orig/drivers/acpi/processor_idle.c	2007-03-23 08:58:51.000000000 +0800
+++ rc4-mm1/drivers/acpi/processor_idle.c	2007-03-28 09:23:24.000000000 +0800
@@ -623,7 +623,7 @@ int acpi_processor_cst_has_changed(struc
 		return -ENODEV;
 
 	acpi_processor_get_power_info(pr);
-	return cpuidle_force_redetect(&per_cpu(cpuidle_devices, pr->id));
+	return cpuidle_force_redetect(per_cpu(cpuidle_devices, pr->id));
 }
 
 /* proc interface */
Index: rc4-mm1/drivers/cpuidle/cpuidle.c
===================================================================
--- rc4-mm1.orig/drivers/cpuidle/cpuidle.c	2007-03-23 09:52:48.000000000 +0800
+++ rc4-mm1/drivers/cpuidle/cpuidle.c	2007-03-28 09:22:41.000000000 +0800
@@ -18,7 +18,7 @@
 
 #include "cpuidle.h"
 
-DEFINE_PER_CPU(struct cpuidle_device, cpuidle_devices);
+DEFINE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
 EXPORT_PER_CPU_SYMBOL_GPL(cpuidle_devices);
 
 DEFINE_MUTEX(cpuidle_lock);
@@ -34,7 +34,7 @@ static void (*pm_idle_old)(void);
  */
 static void cpuidle_idle_call(void)
 {
-	struct cpuidle_device *dev = &__get_cpu_var(cpuidle_devices);
+	struct cpuidle_device *dev = __get_cpu_var(cpuidle_devices);
 
 	struct cpuidle_state *target_state;
 	int next_state;
@@ -117,7 +117,7 @@ static int cpuidle_add_device(struct sys
 	int cpu = sys_dev->id;
 	struct cpuidle_device *dev;
 
-	dev = &per_cpu(cpuidle_devices, cpu);
+	dev = per_cpu(cpuidle_devices, cpu);
 
 	mutex_lock(&cpuidle_lock);
 	if (cpu_is_offline(cpu)) {
@@ -125,6 +125,16 @@ static int cpuidle_add_device(struct sys
 		return 0;
 	}
 
+	if (!dev) {
+		dev = kzalloc(sizeof(struct cpuidle_device), GFP_KERNEL);
+		if (!dev) {
+			mutex_unlock(&cpuidle_lock);
+			return -ENOMEM;
+		}
+		init_completion(&dev->kobj_unregister);
+		per_cpu(cpuidle_devices, cpu) = dev;
+	}
+
 	if (dev->status & CPUIDLE_STATUS_DETECTED) {
 		mutex_unlock(&cpuidle_lock);
 		return 0;
@@ -153,7 +163,7 @@ static int __cpuidle_remove_device(struc
 {
 	struct cpuidle_device *dev;
 
-	dev = &per_cpu(cpuidle_devices, sys_dev->id);
+	dev = per_cpu(cpuidle_devices, sys_dev->id);
 
 	if (!(dev->status & CPUIDLE_STATUS_DETECTED)) {
 		return 0;
@@ -166,6 +176,9 @@ static int __cpuidle_remove_device(struc
 		cpuidle_detach_driver(dev);
 	cpuidle_remove_sysfs(sys_dev);
 	list_del(&dev->device_list);
+	wait_for_completion(&dev->kobj_unregister);
+	per_cpu(cpuidle_devices, sys_dev->id) = NULL;
+	kfree(dev);
 
 	return 0;
 }
Index: rc4-mm1/drivers/cpuidle/sysfs.c
===================================================================
--- rc4-mm1.orig/drivers/cpuidle/sysfs.c	2007-03-23 09:34:01.000000000 +0800
+++ rc4-mm1/drivers/cpuidle/sysfs.c	2007-03-28 11:45:56.000000000 +0800
@@ -210,8 +210,16 @@ static struct sysfs_ops cpuidle_sysfs_op
 	.store = cpuidle_store,
 };
 
+static void cpuidle_sysfs_release(struct kobject *kobj)
+{
+	struct cpuidle_device *dev = kobj_to_cpuidledev(kobj);
+
+	complete(&dev->kobj_unregister);
+}
+
 static struct kobj_type ktype_cpuidle = {
 	.sysfs_ops = &cpuidle_sysfs_ops,
+	.release = cpuidle_sysfs_release,
 };
 
 struct cpuidle_state_attr {
@@ -265,9 +273,15 @@ static struct sysfs_ops cpuidle_state_sy
 	.show = cpuidle_state_show,
 };
 
+static void cpuidle_state_sysfs_release(struct kobject *kobj)
+{
+	/* Nothing required to do here, just workaround kobject warning*/
+}
+
 static struct kobj_type ktype_state_cpuidle = {
 	.sysfs_ops = &cpuidle_state_sysfs_ops,
 	.default_attrs = cpuidle_state_default_attrs,
+	.release = cpuidle_state_sysfs_release,
 };
 
 /**
@@ -319,7 +333,7 @@ int cpuidle_add_sysfs(struct sys_device 
 	int cpu = sysdev->id;
 	struct cpuidle_device *dev;
 
-	dev = &per_cpu(cpuidle_devices, cpu);
+	dev = per_cpu(cpuidle_devices, cpu);
 	dev->kobj.parent = &sysdev->kobj;
 	dev->kobj.ktype = &ktype_cpuidle;
 	kobject_set_name(&dev->kobj, "%s", "cpuidle");
@@ -335,6 +349,6 @@ void cpuidle_remove_sysfs(struct sys_dev
 	int cpu = sysdev->id;
 	struct cpuidle_device *dev;
 
-	dev = &per_cpu(cpuidle_devices, cpu);
+	dev = per_cpu(cpuidle_devices, cpu);
 	kobject_unregister(&dev->kobj);
 }
Index: rc4-mm1/include/linux/cpuidle.h
===================================================================
--- rc4-mm1.orig/include/linux/cpuidle.h	2007-03-23 09:55:13.000000000 +0800
+++ rc4-mm1/include/linux/cpuidle.h	2007-03-28 11:32:56.000000000 +0800
@@ -89,9 +89,7 @@ struct cpuidle_device {
 	void			*governor_data;
 };
 
-#define to_cpuidle_device(n) container_of(n, struct cpuidle_device, kobj);
-
-DECLARE_PER_CPU(struct cpuidle_device, cpuidle_devices);
+DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
 
 /* Device Status Flags */
 #define CPUIDLE_STATUS_DETECTED		 (0x1)
