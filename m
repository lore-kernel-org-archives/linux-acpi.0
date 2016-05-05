From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / tables: Fix DSDT override mechanism
Date: Thu, 05 May 2016 17:22:23 +0200
Message-ID: <2164912.tYyYIWGPTW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 5ae74f2cc2f1 (ACPI / tables: Move table override mechanisms to
tables.c) forgot to move the CONFIG_ACPI_CUSTOM_DSDT_FILE inclusion
directive from osl.c to tables.c.  Fix that.

Fixes: 5ae74f2cc2f1 (ACPI / tables: Move table override mechanisms to tables.c)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Commit 5ae74f2cc2f1 is in linux-next now.

---
 drivers/acpi/osl.c    |    4 ----
 drivers/acpi/tables.c |    4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/tables.c
===================================================================
--- linux-pm.orig/drivers/acpi/tables.c
+++ linux-pm/drivers/acpi/tables.c
@@ -45,6 +45,10 @@ static struct acpi_table_desc initial_ta
 
 static int acpi_apic_instance __initdata;
 
+#ifdef CONFIG_ACPI_CUSTOM_DSDT
+#include CONFIG_ACPI_CUSTOM_DSDT_FILE
+#endif
+
 /*
  * Disable table checksum verification for the early stage due to the size
  * limitation of the current x86 early mapping implementation.
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
 
