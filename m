From: Len Brown <lenb@kernel.org>
Subject: [PATCH 75/98] ACPI: call init_acpi_device_notify() explicitly rather
 than as initcall
Date: Sat, 28 Mar 2009 00:31:50 -0400
Message-ID: <0e46517d9660ee6ae0a0c5d8a4e50451bc84d61d.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50062 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254AbZC1Edh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:37 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700D198NYW4FA@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:35 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch makes acpi_init() call init_acpi_device_notify() directly.
Previously, init_acpi_device_notify() was an arch_initcall (sequence 3),
so it was called before acpi_init() (a subsys_initcall at sequence 4).

init_acpi_device_notify() sets the platform_notify and
platform_notify_remove function pointers.  These pointers
are not used until acpi_init() enumerates ACPI devices in
this path:

    acpi_init()
	    acpi_scan_init()
		acpi_bus_scan()
		    acpi_add_single_object()
			acpi_device_register()
			    device_add()
				<use platform_notify>

So it is sufficient to have acpi_init() call init_acpi_device_notify()
directly before it enumerates devices.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |    1 +
 drivers/acpi/glue.c     |    6 +-----
 drivers/acpi/internal.h |    1 +
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index f32cfd6..db9eca8 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -855,6 +855,7 @@ static int __init acpi_init(void)
 		acpi_kobj = NULL;
 	}
 
+	init_acpi_device_notify();
 	result = acpi_bus_init();
 
 	if (!result) {
diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 5479b9f..8bd2c2a 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -286,10 +286,8 @@ static int acpi_platform_notify_remove(struct device *dev)
 	return 0;
 }
 
-static int __init init_acpi_device_notify(void)
+int __init init_acpi_device_notify(void)
 {
-	if (acpi_disabled)
-		return 0;
 	if (platform_notify || platform_notify_remove) {
 		printk(KERN_ERR PREFIX "Can't use platform_notify\n");
 		return 0;
@@ -298,5 +296,3 @@ static int __init init_acpi_device_notify(void)
 	platform_notify_remove = acpi_platform_notify_remove;
 	return 0;
 }
-
-arch_initcall(init_acpi_device_notify);
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 44b8402..8a45dd8 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -1,5 +1,6 @@
 /* For use by Linux/ACPI infrastructure, not drivers */
 
+int init_acpi_device_notify(void);
 int acpi_scan_init(void);
 int acpi_system_init(void);
 
-- 
1.6.0.6

