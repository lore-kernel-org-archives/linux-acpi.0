From: akpm@linux-foundation.org
Subject: [patch 1/4] cuidle: fix boot hang
Date: Mon, 26 Mar 2007 21:38:46 -0800
Message-ID: <200703270538.l2R5ckE5007930@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:39764 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933997AbXC0FkF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Mar 2007 01:40:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, venkatesh.pallipadi@intel.com, larry.finger@lwfinger.net

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Patch for cpuidle boot hang reported by Larry Finger here.
http://www.ussg.iu.edu/hypermail/linux/kernel/0703.2/2025.html

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Larry Finger <larry.finger@lwfinger.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/cpuidle/cpuidle.c |   26 +++++++++++++++++++-------
 drivers/cpuidle/driver.c  |    4 ++--
 2 files changed, 21 insertions(+), 9 deletions(-)

diff -puN drivers/cpuidle/cpuidle.c~cpuidle-fix-boot-hang drivers/cpuidle/cpuidle.c
--- a/drivers/cpuidle/cpuidle.c~cpuidle-fix-boot-hang
+++ a/drivers/cpuidle/cpuidle.c
@@ -119,6 +119,7 @@ static int cpuidle_add_device(struct sys
 
 	dev = &per_cpu(cpuidle_devices, cpu);
 
+	dev->cpu = cpu;
 	mutex_lock(&cpuidle_lock);
 	if (cpu_is_offline(cpu)) {
 		mutex_unlock(&cpuidle_lock);
@@ -129,15 +130,26 @@ static int cpuidle_add_device(struct sys
 		mutex_unlock(&cpuidle_lock);
 		return 0;
 	}
-	dev->status |= CPUIDLE_STATUS_DETECTED;
-	list_add(&dev->device_list, &cpuidle_detected_devices);
-	cpuidle_add_sysfs(sys_dev);
-	if (cpuidle_curr_driver)
-		cpuidle_attach_driver(dev);
-	if (cpuidle_curr_governor)
-		cpuidle_attach_governor(dev);
+	if (cpuidle_curr_driver) {
+		if (cpuidle_attach_driver(dev))
+			goto err_ret;
+	}
+
+	if (cpuidle_curr_governor) {
+		if (cpuidle_attach_governor(dev)) {
+			cpuidle_detach_driver(dev);
+			goto err_ret;
+		}
+	}
+
 	if (cpuidle_device_can_idle(dev))
 		cpuidle_install_idle_handler();
+
+	list_add(&dev->device_list, &cpuidle_detected_devices);
+	cpuidle_add_sysfs(sys_dev);
+	dev->status |= CPUIDLE_STATUS_DETECTED;
+
+err_ret:
 	mutex_unlock(&cpuidle_lock);
 
 	return 0;
diff -puN drivers/cpuidle/driver.c~cpuidle-fix-boot-hang drivers/cpuidle/driver.c
--- a/drivers/cpuidle/driver.c~cpuidle-fix-boot-hang
+++ a/drivers/cpuidle/driver.c
@@ -37,8 +37,8 @@ int cpuidle_attach_driver(struct cpuidle
 	ret = cpuidle_curr_driver->init(dev);
 	if (ret) {
 		module_put(cpuidle_curr_driver->owner);
-		printk(KERN_ERR "cpuidle: driver %s failed to attach to cpu %d\n",
-			cpuidle_curr_driver->name, dev->cpu);
+		printk(KERN_INFO "cpuidle: driver %s failed to attach to "
+			"cpu %d\n", cpuidle_curr_driver->name, dev->cpu);
 	} else {
 		if (dev->status & CPUIDLE_STATUS_GOVERNOR_ATTACHED)
 			cpuidle_rescan_device(dev);
_
