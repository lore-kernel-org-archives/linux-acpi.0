From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] SFI: fix compilation warnings
Date: Mon,  9 Dec 2013 11:09:21 +0200
Message-ID: <1386580161-27718-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi @ vger . kernel . org" <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

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

The patch add linux/acpi.h to the top of file.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes to v2:
- fix for build when ACPI=3Dn, SFI=3Dy
 drivers/sfi/sfi_acpi.c   | 2 +-
 include/linux/sfi_acpi.h | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/sfi/sfi_acpi.c b/drivers/sfi/sfi_acpi.c
index 5e753d7..5589ec5 100644
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
 #include "sfi_core.h"
diff --git a/include/linux/sfi_acpi.h b/include/linux/sfi_acpi.h
index 2cfcb79..ecc2344 100644
--- a/include/linux/sfi_acpi.h
+++ b/include/linux/sfi_acpi.h
@@ -60,7 +60,9 @@
 #define _LINUX_SFI_ACPI_H
=20
 #ifdef CONFIG_SFI
-#include <acpi/acpi.h>	/* FIXME: inclusion should be removed */
+
+#include <acpi/acpi.h>
+#include <linux/acpi.h>
=20
 extern int sfi_acpi_table_parse(char *signature, char *oem_id,
 				char *oem_table_id,
--=20
1.8.4.4
