From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] ACPI: Export acpi_check_resource_conflict() (update)
Date: Wed, 7 Nov 2007 15:01:49 +0100
Message-ID: <200711071501.49241.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:42278 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756780AbXKGOAE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Nov 2007 09:00:04 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Export acpi_check_resource_conflict(), sometimes drivers already have
a struct resource at hand so no need to use the wrappers to build a new
one.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
This is an update of a patch I sent previously, so that it applies
fine on top of the <linux/acpi.h> cleanup patch I just sent. Andrew,
this replaces export-acpi_check_resource_conflict.patch in your tree.

 drivers/acpi/osl.c   |    3 ++-
 include/linux/acpi.h |    7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

--- linux-2.6.24-rc2.orig/drivers/acpi/osl.c	2007-11-07 14:25:11.000000000 +0100
+++ linux-2.6.24-rc2/drivers/acpi/osl.c	2007-11-07 14:25:19.000000000 +0100
@@ -1097,7 +1097,7 @@ __setup("acpi_enforce_resources=", acpi_
 
 /* Check for resource conflicts between ACPI OperationRegions and native
  * drivers */
-static int acpi_check_resource_conflict(struct resource *res)
+int acpi_check_resource_conflict(struct resource *res)
 {
 	struct acpi_res_list *res_list_elem;
 	int ioport;
@@ -1147,6 +1147,7 @@ static int acpi_check_resource_conflict(
 	}
 	return 0;
 }
+EXPORT_SYMBOL(acpi_check_resource_conflict);
 
 int acpi_check_region(resource_size_t start, resource_size_t n,
 		      const char *name)
--- linux-2.6.24-rc2.orig/include/linux/acpi.h	2007-11-07 14:25:16.000000000 +0100
+++ linux-2.6.24-rc2/include/linux/acpi.h	2007-11-07 14:25:33.000000000 +0100
@@ -195,6 +195,8 @@ extern int pnpacpi_disabled;
 #define PXM_INVAL	(-1)
 #define NID_INVAL	(-1)
 
+int acpi_check_resource_conflict(struct resource *res);
+
 int acpi_check_region(resource_size_t start, resource_size_t n,
 		      const char *name);
 
@@ -213,6 +215,11 @@ static inline int acpi_boot_table_init(v
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

-- 
Jean Delvare
Suse L3
