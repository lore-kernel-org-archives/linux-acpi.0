From: Len Brown <lenb@kernel.org>
Subject: [PATCH 090/112] ACPI: Export acpi_check_resource_conflict
Date: Thu,  7 Feb 2008 04:34:52 -0500
Message-ID: <443dea72d5f428170de6d6e3c4c1a1e2b7632b65.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18844 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758383AbYBGJgv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:51 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Jean Delvare <jdelvare@suse.de>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Export acpi_check_resource_conflict(), sometimes drivers already have
a struct resource at hand so no need to use the wrappers to build a new
one.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c   |    3 ++-
 include/linux/acpi.h |    8 ++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 222f7b1..bc1604b 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1157,7 +1157,7 @@ __setup("acpi_enforce_resources=", acpi_enforce_resources_setup);
 
 /* Check for resource conflicts between ACPI OperationRegions and native
  * drivers */
-static int acpi_check_resource_conflict(struct resource *res)
+int acpi_check_resource_conflict(struct resource *res)
 {
 	struct acpi_res_list *res_list_elem;
 	int ioport;
@@ -1207,6 +1207,7 @@ static int acpi_check_resource_conflict(struct resource *res)
 	}
 	return 0;
 }
+EXPORT_SYMBOL(acpi_check_resource_conflict);
 
 int acpi_check_region(resource_size_t start, resource_size_t n,
 		      const char *name)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 893f90a..a031df8 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -25,6 +25,7 @@
 #ifndef _LINUX_ACPI_H
 #define _LINUX_ACPI_H
 
+#include <linux/ioport.h>	/* for struct resource */
 
 #ifdef	CONFIG_ACPI
 
@@ -217,6 +218,8 @@ extern int pnpacpi_disabled;
 #define PXM_INVAL	(-1)
 #define NID_INVAL	(-1)
 
+int acpi_check_resource_conflict(struct resource *res);
+
 int acpi_check_region(resource_size_t start, resource_size_t n,
 		      const char *name);
 int acpi_check_mem_region(resource_size_t start, resource_size_t n,
@@ -234,6 +237,11 @@ static inline int acpi_boot_table_init(void)
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
1.5.4.23.gef5b9

