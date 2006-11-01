From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] swsusp: Use platform mode by default
Date: Wed, 1 Nov 2006 13:23:14 +0100
Message-ID: <200611011323.14830.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:21424 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1946852AbWKAMY6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Nov 2006 07:24:58 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org, Stefan Seyfried <seife@suse.de>

It has been reported that on some systems the functionality after a resume
from disk is limited if the system is simply powered off during the suspend
instead of using the ACPI S4 suspend (aka platform mode).

Unfortunately the default is currently to power off the system during the
suspend so the users of these systems experience problems after the resume
if they don't switch to the platform mode explicitly.  This patch makes swsusp
use the platform mode by default to avoid such situations.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c |    8 +++++---
 kernel/power/main.c |    2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6.19-rc4-mm1/kernel/power/main.c
===================================================================
--- linux-2.6.19-rc4-mm1.orig/kernel/power/main.c
+++ linux-2.6.19-rc4-mm1/kernel/power/main.c
@@ -29,7 +29,7 @@
 DECLARE_MUTEX(pm_sem);
 
 struct pm_ops *pm_ops;
-suspend_disk_method_t pm_disk_mode = PM_DISK_SHUTDOWN;
+suspend_disk_method_t pm_disk_mode = PM_DISK_PLATFORM;
 
 /**
  *	pm_set_ops - Set the global power method table. 
Index: linux-2.6.19-rc4-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.19-rc4-mm1.orig/kernel/power/disk.c
+++ linux-2.6.19-rc4-mm1/kernel/power/disk.c
@@ -62,9 +62,11 @@ static void power_down(suspend_disk_meth
 
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
