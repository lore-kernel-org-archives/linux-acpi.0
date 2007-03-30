From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: Fw: Re: 2.6.21-rc4-mm1 + 4 hotfixes -- BUG: unable to handle
	kernel paging request at virtual address 6b6b6ceb -- EIP is at
	module_put+0x7/0x1f
Date: Fri, 30 Mar 2007 14:33:44 +0800
Message-ID: <1175236424.19154.7.camel@sli10-conroe.sh.intel.com>
References: <20070323051613.GA9560@kroah.com>
	 <1175053953.10369.2.camel@sli10-conroe.sh.intel.com>
	 <20070328041958.GA7669@kroah.com>
	 <20070327212719.68c7729f.akpm@linux-foundation.org>
	 <20070328045124.GA8156@kroah.com>
	 <1175058836.10661.6.camel@sli10-conroe.sh.intel.com>
	 <20070328052706.GA9459@kroah.com>
	 <1175060366.10661.13.camel@sli10-conroe.sh.intel.com>
	 <20070328055825.GA10064@kroah.com>
	 <1175064552.10661.17.camel@sli10-conroe.sh.intel.com>
	 <20070330051825.GB26194@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38057 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752666AbXC3Ggh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Mar 2007 02:36:37 -0400
In-Reply-To: <20070330051825.GB26194@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Brown, Len" <len.brown@intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org

On Thu, 2007-03-29 at 22:18 -0700, Greg KH wrote:
> On Wed, Mar 28, 2007 at 02:49:12PM +0800, Shaohua Li wrote:
> > On Tue, 2007-03-27 at 22:58 -0700, Greg KH wrote:
> > > On Wed, Mar 28, 2007 at 01:39:26PM +0800, Shaohua Li wrote:
> > > > On Tue, 2007-03-27 at 22:27 -0700, Greg KH wrote:
> > > > > 
> > > > > Putting more than one kobject in the same structure is a broken design.
> > > > > How can you control the lifetime rules properly if there are two
> > > > > reference counts for the same structure?  It doesn't work.
> > > > > 
> > > > > If you really need something like this, then just use a pointer to a
> > > > > kobject for one of them instead of embedding it.  Why do you need two
> > > > > different kobjects here?
> > > > Our data structure is something like below:
> > > > 
> > > > struct foo {
> > > > 	kobject kobja;
> > > > }
> > > > 
> > > > struct bar {
> > > > 	struct foo foo[];
> > > 
> > > Ick, don't do that...
> > why?
> > > > 	kobject kobjb
> 
> Because you have multiple kobjects in the same object.
> 
> It's just that simple, the lifetime rules for such a thing is almost
> impossible to track properly.  Don't do it!
> 
> > > > }
> > > > 
> > > > kobjb's .release will free struct bar. kobjb is the parent of kobja. if
> > > > you have a reference on kobja, then kobjb can't be released too, right?
> > > > So we only kobjb provide a .release to free the memory, kobja's .release
> > > > isn't required.
> > > 
> > > Why not just use the "normal" parent/child relationship with the
> > > kobjects like the rest of the kernel does?
> > I still didn't get the reason why we couldn't do this in the way of my
> > patch. As I said, there isn't risk to use 'freed memory'. I can make the
> > 'struct foo' a pointer, but this will mess the cpuidle driver.
> 
> Again, the main point is you can not have more than one reference count
> for the same structure.  It just does not work at all.
> 
> So please, fix the code, it is broken.
> 
> And yes, I know of other places in the kernel (scsi stack...) that
> violate this, but that only means that they are wrong, not that it is an
> excuse for you to do it also.
We don't use the kobject to track the reference count. But anyway, below
patch should make you happy.


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
+++ rc4-mm1/drivers/cpuidle/sysfs.c	2007-03-30 14:22:50.000000000 +0800
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
@@ -246,7 +254,8 @@ static struct attribute *cpuidle_state_d
 	NULL
 };
 
-#define kobj_to_state(k) container_of(k, struct cpuidle_state, kobj)
+#define kobj_to_state_obj(k) container_of(k, struct cpuidle_state_kobj, kobj)
+#define kobj_to_state(k) (kobj_to_state_obj(k)->state)
 #define attr_to_stateattr(a) container_of(a, struct cpuidle_state_attr, attr)
 static ssize_t cpuidle_state_show(struct kobject * kobj,
 	struct attribute * attr ,char * buf)
@@ -265,11 +274,27 @@ static struct sysfs_ops cpuidle_state_sy
 	.show = cpuidle_state_show,
 };
 
+static void cpuidle_state_sysfs_release(struct kobject *kobj)
+{
+	struct cpuidle_state_kobj *state_obj = kobj_to_state_obj(kobj);
+
+	complete(&state_obj->kobj_unregister);
+}
+
 static struct kobj_type ktype_state_cpuidle = {
 	.sysfs_ops = &cpuidle_state_sysfs_ops,
 	.default_attrs = cpuidle_state_default_attrs,
+	.release = cpuidle_state_sysfs_release,
 };
 
+static void inline cpuidle_free_state_kobj(struct cpuidle_device *device, int i)
+{
+	kobject_unregister(&device->kobjs[i]->kobj);
+	wait_for_completion(&device->kobjs[i]->kobj_unregister);
+	kfree(device->kobjs[i]);
+	device->kobjs[i] = NULL;
+}
+
 /**
  * cpuidle_add_driver_sysfs - adds driver-specific sysfs attributes
  * @device: the target device
@@ -277,24 +302,32 @@ static struct kobj_type ktype_state_cpui
 int cpuidle_add_driver_sysfs(struct cpuidle_device *device)
 {
 	int i, ret;
-	struct cpuidle_state *state;
+	struct cpuidle_state_kobj *kobj;
 
 	/* state statistics */
 	for (i = 0; i < device->state_count; i++) {
-		state = &device->states[i];
-		state->kobj.parent = &device->kobj;
-		state->kobj.ktype = &ktype_state_cpuidle;
-		kobject_set_name(&state->kobj, "state%d", i);
-		ret = kobject_register(&state->kobj);
-		if (ret)
+		kobj = kzalloc(sizeof(struct cpuidle_state_kobj), GFP_KERNEL);
+		if (!kobj)
+			goto error_state;
+		kobj->state = &device->states[i];
+		init_completion(&kobj->kobj_unregister);
+
+		kobj->kobj.parent = &device->kobj;
+		kobj->kobj.ktype = &ktype_state_cpuidle;
+		kobject_set_name(&kobj->kobj, "state%d", i);
+		ret = kobject_register(&kobj->kobj);
+		if (ret) {
+			kfree(kobj);
 			goto error_state;
+		}
+		device->kobjs[i] = kobj;
 	}
 
 	return 0;
 
 error_state:
 	for (i = i - 1; i >= 0; i--)
-		kobject_unregister(&device->states[i].kobj);
+		cpuidle_free_state_kobj(device, i);
 	return ret;
 }
 
@@ -307,7 +340,7 @@ void cpuidle_remove_driver_sysfs(struct 
 	int i;
 
 	for (i = 0; i < device->state_count; i++)
-		kobject_unregister(&device->states[i].kobj);
+		cpuidle_free_state_kobj(device, i);
 }
 
 /**
@@ -319,7 +352,7 @@ int cpuidle_add_sysfs(struct sys_device 
 	int cpu = sysdev->id;
 	struct cpuidle_device *dev;
 
-	dev = &per_cpu(cpuidle_devices, cpu);
+	dev = per_cpu(cpuidle_devices, cpu);
 	dev->kobj.parent = &sysdev->kobj;
 	dev->kobj.ktype = &ktype_cpuidle;
 	kobject_set_name(&dev->kobj, "%s", "cpuidle");
@@ -335,6 +368,6 @@ void cpuidle_remove_sysfs(struct sys_dev
 	int cpu = sysdev->id;
 	struct cpuidle_device *dev;
 
-	dev = &per_cpu(cpuidle_devices, cpu);
+	dev = per_cpu(cpuidle_devices, cpu);
 	kobject_unregister(&dev->kobj);
 }
Index: rc4-mm1/include/linux/cpuidle.h
===================================================================
--- rc4-mm1.orig/include/linux/cpuidle.h	2007-03-23 09:55:13.000000000 +0800
+++ rc4-mm1/include/linux/cpuidle.h	2007-03-30 14:05:28.000000000 +0800
@@ -41,8 +41,6 @@ struct cpuidle_state {
 
 	int (*enter)	(struct cpuidle_device *dev,
 			 struct cpuidle_state *state);
-
-	struct kobject	kobj;
 };
 
 /* Idle State Flags */
@@ -74,6 +72,12 @@ cpuidle_set_statedata(struct cpuidle_sta
 	state->driver_data = data;
 }
 
+struct cpuidle_state_kobj {
+	struct cpuidle_state *state;
+	struct completion kobj_unregister;
+	struct kobject kobj;
+};
+
 struct cpuidle_device {
 	unsigned int		status;
 	int			cpu;
@@ -81,6 +85,7 @@ struct cpuidle_device {
 	int			last_residency;
 	int			state_count;
 	struct cpuidle_state	states[CPUIDLE_STATE_MAX];
+	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
 	struct cpuidle_state	*last_state;
 
 	struct list_head 	device_list;
@@ -89,9 +94,7 @@ struct cpuidle_device {
 	void			*governor_data;
 };
 
-#define to_cpuidle_device(n) container_of(n, struct cpuidle_device, kobj);
-
-DECLARE_PER_CPU(struct cpuidle_device, cpuidle_devices);
+DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
 
 /* Device Status Flags */
 #define CPUIDLE_STATUS_DETECTED		 (0x1)
