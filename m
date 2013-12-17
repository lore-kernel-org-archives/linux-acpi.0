From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 11/11] drivers: acpi: Include header file in debugfs.c and
 rectify prototype declaration in internal.h
Date: Tue, 17 Dec 2013 15:06:54 +0530
Message-ID: <37de640470c91e2e54ab68a158e19dde3938f18a.1387271324.git.rashika.kheria@gmail.com>
References: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:42736 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab3LQJhE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2013 04:37:04 -0500
Content-Disposition: inline
In-Reply-To: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, josh@joshtriplett.org

Include header file internal.h in debugfs.c and change the return
value's type in header file internal.h.

This eliminates the following warning in debugfs.c:
drivers/acpi/debugfs.c:16:13: warning: no previous prototype for =E2=80=
=98acpi_debugfs_init=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/acpi/debugfs.c  |    3 +++
 drivers/acpi/internal.h |    2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/debugfs.c b/drivers/acpi/debugfs.c
index b55d6a2..96bcaf7 100644
--- a/drivers/acpi/debugfs.c
+++ b/drivers/acpi/debugfs.c
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/debugfs.h>
 #include <acpi/acpi_drivers.h>
+#include "internal.h"
=20
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("debugfs");
@@ -13,7 +14,9 @@ ACPI_MODULE_NAME("debugfs");
 struct dentry *acpi_debugfs_dir;
 EXPORT_SYMBOL_GPL(acpi_debugfs_dir);
=20
+#ifdef  CONFIG_DEBUG_FS
 void __init acpi_debugfs_init(void)
 {
 	acpi_debugfs_dir =3D debugfs_create_dir("acpi", NULL);
 }
+#endif
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 8ef9787..c2e35bd 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -63,7 +63,7 @@ void acpi_scan_hotplug_enabled(struct acpi_hotplug_pr=
ofile *hotplug, bool val);
=20
 #ifdef CONFIG_DEBUG_FS
 extern struct dentry *acpi_debugfs_dir;
-int acpi_debugfs_init(void);
+void acpi_debugfs_init(void);
 #else
 static inline void acpi_debugfs_init(void) { return; }
 #endif
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
