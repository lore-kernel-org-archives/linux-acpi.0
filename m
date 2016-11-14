From: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH] acpi: Use NULL from <linux/stddef.h>
Date: Mon, 14 Nov 2016 08:50:39 -0800
Message-ID: <4f698429-49cf-689a-9eb5-978b182bb4bb@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-sn1nam02on0055.outbound.protection.outlook.com ([104.47.36.55]:26943
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753274AbcKNRZB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Nov 2016 12:25:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Use the definition of NULL from <linux/stddef.h> instead of
redefining NULL. Additionally, change (void *)NULL into NULL.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 include/acpi/actypes.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 1d798ab..f019641 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -44,6 +44,8 @@
 #ifndef __ACTYPES_H__
 #define __ACTYPES_H__
 
+#include <linux/stddef.h> /* NULL */
+
 /* acpisrc:struct_defs -- for acpisrc conversion */
 
 /*
@@ -437,10 +439,6 @@ typedef u64 acpi_physical_address;
 #endif
 #define TRUE                            (1 == 1)
 
-#ifndef NULL
-#define NULL                            (void *) 0
-#endif
-
 /*
  * Miscellaneous types
  */
@@ -530,9 +528,9 @@ typedef u64 acpi_integer;
 
 /* Pointer/Integer type conversions */
 
-#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) NULL,(acpi_size) i)
-#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) NULL)
-#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) NULL)
+#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR(void, NULL, (acpi_size) i)
+#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF(p, NULL)
+#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF(&(((d *) 0)->f), NULL)
 #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
 #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
 
-- 
2.10.1

