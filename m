From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] ACPI / tables: Fix DSDT override mechanism
Date: Fri, 06 May 2016 01:27:09 +0200
Message-ID: <1946331.5n4iSuMqAq@vostro.rjw.lan>
References: <2164912.tYyYIWGPTW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53246 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752786AbcEEXX5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2016 19:23:57 -0400
In-Reply-To: <2164912.tYyYIWGPTW@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 5ae74f2cc2f1 (ACPI / tables: Move table override mechanisms to
tables.c) forgot to move the CONFIG_ACPI_CUSTOM_DSDT_FILE inclusion
directive from osl.c to tables.c.  Fix that.

Fixes: 5ae74f2cc2f1 (ACPI / tables: Move table override mechanisms to tables.c)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

A cosmetic change.

v1 -> v2: Move the new #include closer to the other #include directives in
          tables.c.

---
 drivers/acpi/osl.c    |    4 ----
 drivers/acpi/tables.c |    4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/tables.c
===================================================================
--- linux-pm.orig/drivers/acpi/tables.c
+++ linux-pm/drivers/acpi/tables.c
@@ -36,6 +36,10 @@
 #include <linux/memblock.h>
 #include "internal.h"
 
+#ifdef CONFIG_ACPI_CUSTOM_DSDT
+#include CONFIG_ACPI_CUSTOM_DSDT_FILE
+#endif
+
 #define ACPI_MAX_TABLES		128
 
 static char *mps_inti_flags_polarity[] = { "dfl", "high", "res", "low" };
Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -56,10 +56,6 @@ struct acpi_os_dpc {
 	struct work_struct work;
 };
 
-#ifdef CONFIG_ACPI_CUSTOM_DSDT
-#include CONFIG_ACPI_CUSTOM_DSDT_FILE
-#endif
-
 #ifdef ENABLE_DEBUGGER
 #include <linux/kdb.h>
 

