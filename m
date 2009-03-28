From: Len Brown <lenb@kernel.org>
Subject: [PATCH 74/98] ACPI: call acpi_debug_init() explicitly rather than as
 initcall
Date: Sat, 28 Mar 2009 00:31:49 -0400
Message-ID: <84f810c33f695e020776ce66c903e0b41872f1b2.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38305 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218AbZC1Edg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:36 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7002FA8NXCGJJ@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:34 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch makes acpi_init() call acpi_debug_init() directly.
Previously, both were subsys_initcalls.  acpi_debug_init()
must happen after acpi_init(), and it's better to call it
explicitly rather than rely on link ordering.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |    1 +
 drivers/acpi/debug.c    |   14 ++++++--------
 drivers/acpi/internal.h |    6 ++++++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index c133072..f32cfd6 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -883,6 +883,7 @@ static int __init acpi_init(void)
 	acpi_ec_init();
 	acpi_power_init();
 	acpi_system_init();
+	acpi_debug_init();
 	return result;
 }
 
diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
index 20223cb..9cb189f 100644
--- a/drivers/acpi/debug.c
+++ b/drivers/acpi/debug.c
@@ -297,17 +297,15 @@ acpi_system_write_debug(struct file *file,
 
 	return count;
 }
+#endif
 
-static int __init acpi_debug_init(void)
+int __init acpi_debug_init(void)
 {
+#ifdef CONFIG_ACPI_PROCFS
 	struct proc_dir_entry *entry;
 	int error = 0;
 	char *name;
 
-
-	if (acpi_disabled)
-		return 0;
-
 	/* 'debug_layer' [R/W] */
 	name = ACPI_SYSTEM_FILE_DEBUG_LAYER;
 	entry =
@@ -338,7 +336,7 @@ static int __init acpi_debug_init(void)
 	remove_proc_entry(ACPI_SYSTEM_FILE_DEBUG_LAYER, acpi_root_dir);
 	error = -ENODEV;
 	goto Done;
-}
-
-subsys_initcall(acpi_debug_init);
+#else
+	return 0;
 #endif
+}
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 4a35f6e..44b8402 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -3,6 +3,12 @@
 int acpi_scan_init(void);
 int acpi_system_init(void);
 
+#ifdef CONFIG_ACPI_DEBUG
+int acpi_debug_init(void);
+#else
+static inline int acpi_debug_init(void) { return 0; }
+#endif
+
 /* --------------------------------------------------------------------------
                                   Power Resource
    -------------------------------------------------------------------------- */
-- 
1.6.0.6

