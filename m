From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime GPEs not saved over suspend/resume if type != "platform"
Date: Wed, 25 Oct 2006 20:54:31 +0200
Message-ID: <200610252054.32945.rjw@sisk.pl>
References: <1C601A6A3344064EB423D0C1E83B717B5C5954@pdsmsx411.ccr.corp.intel.com> <453F9252.9060404@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:17878 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161367AbWJYSzh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Oct 2006 14:55:37 -0400
In-Reply-To: <453F9252.9060404@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>

On Wednesday, 25 October 2006 18:35, Alexey Starikovskiy wrote:
> Here is a least intrusive patch by my opinion...
> Just copy pm_disk_mode from pm_ops supplied by platform.
> ACPI sets it to PM_DISK_PLATFORM if it has S4,
> and it should be zero otherwise, patch does not copy it then.

Well, I think the appended patch is sufficient.

If "platform" is unavailable it has no effect and works like "shutdown".

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c |    8 +++++---
 kernel/power/main.c |    2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6.19-rc2-mm2/kernel/power/main.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/power/main.c
+++ linux-2.6.19-rc2-mm2/kernel/power/main.c
@@ -28,7 +28,7 @@
 DECLARE_MUTEX(pm_sem);
 
 struct pm_ops *pm_ops;
-suspend_disk_method_t pm_disk_mode = PM_DISK_SHUTDOWN;
+suspend_disk_method_t pm_disk_mode = PM_DISK_PLATFORM;
 
 /**
  *	pm_set_ops - Set the global power method table. 
Index: linux-2.6.19-rc2-mm2/kernel/power/disk.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/power/disk.c
+++ linux-2.6.19-rc2-mm2/kernel/power/disk.c
@@ -61,9 +61,11 @@ static void power_down(suspend_disk_meth
 
 	switch(mode) {
 	case PM_DISK_PLATFORM:
-		kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
-		error = pm_ops->enter(PM_SUSPEND_DISK);
-		break;
+		if (pm_ops && pm_ops->enter) {
+			kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
+			error = pm_ops->enter(PM_SUSPEND_DISK);
+			break;
+		}
 	case PM_DISK_SHUTDOWN:
 		kernel_power_off();
 		break;
