From: Venkatesh Pallipadi <venki@google.com>
Subject: [PATCH] cpuidle: Remove module_get/put of registered driver
Date: Mon, 14 Jun 2010 15:33:37 -0700
Message-ID: <1276554817-3259-1-git-send-email-venki@google.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:1541 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757143Ab0FNWhS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jun 2010 18:37:18 -0400
Received: from kpbe14.cbf.corp.google.com (kpbe14.cbf.corp.google.com [172.25.105.78])
	by smtp-out.google.com with ESMTP id o5EMbG2L030450
	for <linux-acpi@vger.kernel.org>; Mon, 14 Jun 2010 15:37:16 -0700
Received: from pwj3 (pwj3.prod.google.com [10.241.219.67])
	by kpbe14.cbf.corp.google.com with ESMTP id o5EMavm3022360
	for <linux-acpi@vger.kernel.org>; Mon, 14 Jun 2010 15:37:15 -0700
Received: by pwj3 with SMTP id 3so3621466pwj.7
        for <linux-acpi@vger.kernel.org>; Mon, 14 Jun 2010 15:37:15 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI list <linux-acpi@vger.kernel.org>, Venkatesh Pallipadi <venki@google.com>

cpuidle is doing a try_module_get() of the driver during register_device
and module_put() during unregister_device. This is being overly safe as
there is already a cpuidle_lock mutex that prevents concurrent operations.

This puts a needless restriction on the drivers registering with cpuidle,
as they cannot be rmmod'd, when then have unregister_device being
called in their module_exit path. rmmod will not call exit function
as there is still a refcnt for that driver and the driver never gets
a chance to decrement the refcnt through unregister_device.

Remove both try_module_get and module_put in cpuidle.

Without this change, with acpi processor driver compiled as a loadable module:
modprobe processor; rmmod processor
ERROR: Module processor is in use

With this change, rmmod processor succeeds without any errors.

Signed-off-by: Venkatesh Pallipadi <venki@google.com>
---
 drivers/cpuidle/cpuidle.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 1994885..c318692 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -275,8 +275,6 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
 
 	if (!sys_dev)
 		return -EINVAL;
-	if (!try_module_get(cpuidle_driver->owner))
-		return -EINVAL;
 
 	init_completion(&dev->kobj_unregister);
 
@@ -284,10 +282,8 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
 
 	per_cpu(cpuidle_devices, dev->cpu) = dev;
 	list_add(&dev->device_list, &cpuidle_detected_devices);
-	if ((ret = cpuidle_add_sysfs(sys_dev))) {
-		module_put(cpuidle_driver->owner);
+	if ((ret = cpuidle_add_sysfs(sys_dev)))
 		return ret;
-	}
 
 	dev->registered = 1;
 	return 0;
@@ -341,8 +337,6 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
 	per_cpu(cpuidle_devices, dev->cpu) = NULL;
 
 	cpuidle_resume_and_unlock();
-
-	module_put(cpuidle_driver->owner);
 }
 
 EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
-- 
1.7.0.1

