From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 08/10] ACPI: call acpi_sleep_proc_init() explicitly rather
	than as initcall
Date: Tue, 24 Mar 2009 16:50:14 -0600
Message-ID: <20090324225014.1262.93418.stgit@bob.kio>
References: <20090324224834.1262.65260.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:35801 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840AbZCXWuQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 18:50:16 -0400
In-Reply-To: <20090324224834.1262.65260.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>Li Shaohua <shaohua.li@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

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

