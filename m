From: akpm@linux-foundation.org
Subject: [patch 6/7] Export acpi_check_resource_conflict
Date: Mon, 04 Feb 2008 23:31:23 -0800
Message-ID: <200802050731.m157V5I3009699@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57950 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753442AbYBEHcx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Feb 2008 02:32:53 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, trenn@suse.de, bjorn.helgaas@hp.com, jdelvare@suse.de, khali@linux-fr.org, mhoffman@lightlink.com

From: Thomas Renninger <trenn@suse.de>

Export acpi_check_resource_conflict(), sometimes drivers already have
a struct resource at hand so no need to use the wrappers to build a new
one.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/osl.c   |    3 ++-
 include/linux/acpi.h |    8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/osl.c~export-acpi_check_resource_conflict drivers/acpi/osl.c
--- a/drivers/acpi/osl.c~export-acpi_check_resource_conflict
+++ a/drivers/acpi/osl.c
@@ -1161,7 +1161,7 @@ __setup("acpi_enforce_resources=", acpi_
 
 /* Check for resource conflicts between ACPI OperationRegions and native
  * drivers */
-static int acpi_check_resource_conflict(struct resource *res)
+int acpi_check_resource_conflict(struct resource *res)
 {
 	struct acpi_res_list *res_list_elem;
 	int ioport;
@@ -1211,6 +1211,7 @@ static int acpi_check_resource_conflict(
 	}
 	return 0;
 }
+EXPORT_SYMBOL(acpi_check_resource_conflict);
 
 int acpi_check_region(resource_size_t start, resource_size_t n,
 		      const char *name)
diff -puN include/linux/acpi.h~export-acpi_check_resource_conflict include/linux/acpi.h
--- a/include/linux/acpi.h~export-acpi_check_resource_conflict
+++ a/include/linux/acpi.h
@@ -25,6 +25,7 @@
 #ifndef _LINUX_ACPI_H
 #define _LINUX_ACPI_H
 
+#include <linux/ioport.h>	/* for struct resource */
 
 #ifdef	CONFIG_ACPI
 
@@ -223,6 +224,8 @@ extern int pnpacpi_disabled;
 #define PXM_INVAL	(-1)
 #define NID_INVAL	(-1)
 
+int acpi_check_resource_conflict(struct resource *res);
+
 int acpi_check_region(resource_size_t start, resource_size_t n,
 		      const char *name);
 int acpi_check_mem_region(resource_size_t start, resource_size_t n,
@@ -240,6 +243,11 @@ static inline int acpi_boot_table_init(v
 	return 0;
 }
 
+static inline int acpi_check_resource_conflict(struct resource *res)
+{
+	return 0;
+}
+
 static inline int acpi_check_region(resource_size_t start, resource_size_t n,
 				    const char *name)
 {
_
