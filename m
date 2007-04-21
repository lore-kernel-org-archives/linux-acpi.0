From: "Guilherme Salgado" <gsalgado@gmail.com>
Subject: Thinkpad suspend-to-disk regression
Date: Sat, 21 Apr 2007 12:30:31 -0300
Message-ID: <3d7cf86d0704210830m7ae78a85u3f362a2cbb1bf3b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:17927 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbXDUPad (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Apr 2007 11:30:33 -0400
Received: by an-out-0708.google.com with SMTP id b33so1291295ana
        for <linux-acpi@vger.kernel.org>; Sat, 21 Apr 2007 08:30:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi there,

I recently noticed that my thinkpad T60 would lose the sound after
being suspended to disk (https://launchpad.net/bugs/80893), requiring
a cold restart to fix it. After some git-bisect work I found this
regression was a consequence of
http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commitdiff;h=9185cfa92507d07ac787bc73d06c42222eec7239
(patch inlined here)

Is there any chance of fixing the regression this introduced without
reverting it? Please let me know if you want any other info or have a
patch for me to try.

Cheers,
Guilherme

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index 0b00f56..88fc5d7 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -60,9 +60,11 @@ static void power_down(suspend_disk_method_t mode)
 {
 	switch(mode) {
 	case PM_DISK_PLATFORM:
-		kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
-		pm_ops->enter(PM_SUSPEND_DISK);
-		break;
+		if (pm_ops && pm_ops->enter) {
+			kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
+			pm_ops->enter(PM_SUSPEND_DISK);
+			break;
+		}
 	case PM_DISK_SHUTDOWN:
 		kernel_power_off();
 		break;
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 500eb87..ff3a618 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -29,7 +29,7 @@
 DEFINE_MUTEX(pm_mutex);

 struct pm_ops *pm_ops;
-suspend_disk_method_t pm_disk_mode = PM_DISK_SHUTDOWN;
+suspend_disk_method_t pm_disk_mode = PM_DISK_PLATFORM;

 /**
  *	pm_set_ops - Set the global power method table.
