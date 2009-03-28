From: Len Brown <lenb@kernel.org>
Subject: [PATCH 76/98] ACPI: call acpi_sleep_proc_init() explicitly rather than
 as initcall
Date: Sat, 28 Mar 2009 00:31:51 -0400
Message-ID: <9cee43e07940bee13462e63bd75ce4430b155886.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:35043 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755592AbZC1Edp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:45 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700DZ18NZRTDW@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:36 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch makes acpi_init() call acpi_sleep_proc_init() directly.
Previously, acpi_sleep_proc_init() was a late_initcall (sequence 7),
apparently to make sure that the /proc hierarchy already exists:

    2003/02/13 12:38:03-06:00 mochel
    acpi sleep: demote sleep proc file creation.

    - Make acpi_sleep_proc_init() a late_initcall(), and not called from
      acpi_sleep_init(). This guarantees that the acpi proc hierarchy is at
      least there when we create the dang file.

This should no longer be an issue because acpi_bus_init() (called early
in acpi_init()) creates acpi_root_dir (/proc/acpi).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |    1 +
 drivers/acpi/internal.h |    6 ++++++
 drivers/acpi/proc.c     |    7 +------
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index db9eca8..a812e84 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -885,6 +885,7 @@ static int __init acpi_init(void)
 	acpi_power_init();
 	acpi_system_init();
 	acpi_debug_init();
+	acpi_sleep_proc_init();
 	return result;
 }
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 8a45dd8..8870e5f 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -33,3 +33,9 @@ int acpi_boot_ec_enable(void);
                                   Suspend/Resume
   -------------------------------------------------------------------------- */
 extern int acpi_sleep_init(void);
+
+#ifdef CONFIG_ACPI_SLEEP
+int acpi_sleep_proc_init(void);
+#else
+static inline int acpi_sleep_proc_init(void) { return 0; }
+#endif
diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 428c911..05dfdc9 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -496,11 +496,8 @@ static u32 rtc_handler(void *context)
 }
 #endif				/* HAVE_ACPI_LEGACY_ALARM */
 
-static int __init acpi_sleep_proc_init(void)
+int __init acpi_sleep_proc_init(void)
 {
-	if (acpi_disabled)
-		return 0;
-
 #ifdef	CONFIG_ACPI_PROCFS
 	/* 'sleep' [R/W] */
 	proc_create("sleep", S_IFREG | S_IRUGO | S_IWUSR,
@@ -527,5 +524,3 @@ static int __init acpi_sleep_proc_init(void)
 
 	return 0;
 }
-
-late_initcall(acpi_sleep_proc_init);
-- 
1.6.0.6

