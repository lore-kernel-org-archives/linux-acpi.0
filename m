From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 07/10] ACPI: call init_acpi_device_notify() explicitly rather
	than as initcall
Date: Tue, 24 Mar 2009 16:50:09 -0600
Message-ID: <20090324225009.1262.3104.stgit@bob.kio>
References: <20090324224834.1262.65260.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:35779 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766AbZCXWuO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 18:50:14 -0400
In-Reply-To: <20090324224834.1262.65260.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>Li Shaohua <shaohua.li@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

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
 

