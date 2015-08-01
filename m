From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH] ACPI: fix acpi_debugfs_init prototype
Date: Sat,  1 Aug 2015 21:32:17 +0800
Message-ID: <1438435937-28886-1-git-send-email-nicolas.iooss_linux@m4x.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:57146 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbHANmK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Aug 2015 09:42:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Nicolas Iooss <nicolas.iooss_linux@m4x.org>

acpi_debugfs_init function is declared with return type int in
drivers/acpi/internal.h when CONFIG_DEBUG_FS is enabled, but its
definition in drivers/acpi/debugfs.c has return type void. This is due
to commit aecad432fd68 ("ACPI: Cleanup custom_method debug stuff"),
which changed the return type from int to void without updating the
declaration.

Fix this inconsistency by updating acpi_debugfs_init prototype.  While
at it, include internal.h in debugfs.c so that the compiler can check
that the declaration and definition remain compatible.

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 drivers/acpi/debugfs.c  | 2 ++
 drivers/acpi/internal.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/debugfs.c b/drivers/acpi/debugfs.c
index 6b1919f6bd82..68bb305b977f 100644
--- a/drivers/acpi/debugfs.c
+++ b/drivers/acpi/debugfs.c
@@ -7,6 +7,8 @@
 #include <linux/debugfs.h>
 #include <linux/acpi.h>
 
+#include "internal.h"
+
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("debugfs");
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 4683a96932b9..4b348df3056d 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -70,7 +70,7 @@ void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, bool val);
 
 #ifdef CONFIG_DEBUG_FS
 extern struct dentry *acpi_debugfs_dir;
-int acpi_debugfs_init(void);
+void acpi_debugfs_init(void);
 #else
 static inline void acpi_debugfs_init(void) { return; }
 #endif
-- 
2.5.0

