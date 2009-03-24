From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 06/10] ACPI: call acpi_debug_init() explicitly rather than as
	initcall
Date: Tue, 24 Mar 2009 16:50:03 -0600
Message-ID: <20090324225003.1262.39890.stgit@bob.kio>
References: <20090324224834.1262.65260.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:41631 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbZCXWuG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 18:50:06 -0400
In-Reply-To: <20090324224834.1262.65260.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>Li Shaohua <shaohua.li@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

This patch makes acpi_init() call acpi_debug_init() directly.
Previously, both were subsys_initcalls.  acpi_debug_init()
must happen after acpi_init(), and it's better to call it
explicitly rather than rely on link ordering.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
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

