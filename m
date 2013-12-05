From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] SFI: fix compilation warnings
Date: Thu,  5 Dec 2013 19:26:37 +0200
Message-ID: <1386264397-27319-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18404 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756938Ab3LER1I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Dec 2013 12:27:08 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

When build kernel with make W=3D1 we get the following compiler error.

In file included from drivers/sfi/sfi_acpi.c:66:0:
include/linux/sfi_acpi.h: In function =E2=80=98acpi_sfi_table_parse=E2=80=
=99:
include/linux/sfi_acpi.h:72:2: error: implicit declaration of function =
=E2=80=98acpi_table_parse=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]
  if (!acpi_table_parse(signature, handler))
  ^
  cc1: some warnings being treated as errors

The patch changes acpi/acpi.h inclusion to linux/acpi.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/sfi/sfi_acpi.c   | 2 +-
 include/linux/sfi_acpi.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sfi/sfi_acpi.c b/drivers/sfi/sfi_acpi.c
index 0c9f419..d4dfcbe 100644
--- a/drivers/sfi/sfi_acpi.c
+++ b/drivers/sfi/sfi_acpi.c
@@ -60,7 +60,7 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
=20
 #include <linux/kernel.h>
-#include <acpi/acpi.h>	/* FIXME: inclusion should be removed */
+#include <linux/acpi.h>
=20
 #include <linux/sfi.h>
 #include <linux/sfi_acpi.h>
diff --git a/include/linux/sfi_acpi.h b/include/linux/sfi_acpi.h
index 2cfcb79..c9cab82 100644
--- a/include/linux/sfi_acpi.h
+++ b/include/linux/sfi_acpi.h
@@ -60,7 +60,7 @@
 #define _LINUX_SFI_ACPI_H
=20
 #ifdef CONFIG_SFI
-#include <acpi/acpi.h>	/* FIXME: inclusion should be removed */
+#include <linux/acpi.h>
=20
 extern int sfi_acpi_table_parse(char *signature, char *oem_id,
 				char *oem_table_id,
--=20
1.8.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
