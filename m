From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] ACPI: use NULL for ptrs
Date: Tue, 13 Feb 2007 16:11:36 -0800
Message-ID: <20070213161136.e8c8ac5b.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:60274 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087AbXBNAPx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 19:15:53 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, akpm <akpm@osdl.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix sparse warnings in ACPI:
drivers/acpi/osl.c:208:10: warning: Using plain integer as NULL pointer
drivers/acpi/tables/tbxface.c:411:49: warning: Using plain integer as NULL pointer
drivers/acpi/processor_core.c:1008:10: warning: Using plain integer as NULL pointer

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/acpi/osl.c            |    2 +-
 drivers/acpi/processor_core.c |    2 +-
 drivers/acpi/tables/tbxface.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.20-git9.orig/drivers/acpi/osl.c
+++ linux-2.6.20-git9/drivers/acpi/osl.c
@@ -205,7 +205,7 @@ void __iomem *acpi_os_map_memory(acpi_ph
 {
 	if (phys > ULONG_MAX) {
 		printk(KERN_ERR PREFIX "Cannot map memory that high\n");
-		return 0;
+		return NULL;
 	}
 	if (acpi_gbl_permanent_mmap)
 		/*
--- linux-2.6.20-git9.orig/drivers/acpi/processor_core.c
+++ linux-2.6.20-git9/drivers/acpi/processor_core.c
@@ -1005,7 +1005,7 @@ static int __init acpi_processor_init(vo
 #ifdef CONFIG_SMP
 	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_MADT, 0,
 				(struct acpi_table_header **)&madt)))
-		madt = 0;
+		madt = NULL;
 #endif
 
 	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
--- linux-2.6.20-git9.orig/drivers/acpi/tables/tbxface.c
+++ linux-2.6.20-git9/drivers/acpi/tables/tbxface.c
@@ -408,7 +408,7 @@ acpi_get_table(char *signature,
 		}
 
 		if (!acpi_gbl_permanent_mmap) {
-			acpi_gbl_root_table_list.tables[i].pointer = 0;
+			acpi_gbl_root_table_list.tables[i].pointer = NULL;
 		}
 
 		return (status);
