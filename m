From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.35.stable] ACPI: install ACPI table handler before any
 dynamic tables being loaded
Date: Mon, 01 Nov 2010 23:18:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1011012309280.14926@localhost.localdomain>
References: <alpine.LFD.2.00.1011012306250.14926@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:44365 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab0KBDTK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Nov 2010 23:19:10 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LB8000RUMJH8HH2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Nov 2010 22:18:54 -0500 (CDT)
In-reply-to: <alpine.LFD.2.00.1011012306250.14926@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

upstream b1d248d96c71665c79befb81207f38f894c7c082

back-ported to 2.6.35

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |    6 ++++++
 drivers/acpi/internal.h |    1 +
 drivers/acpi/system.c   |   13 +++----------
 3 files changed, 10 insertions(+), 10 deletions(-)

Index: linux-2.6.35.y/drivers/acpi/bus.c
===================================================================
--- linux-2.6.35.y.orig/drivers/acpi/bus.c
+++ linux-2.6.35.y/drivers/acpi/bus.c
@@ -935,6 +935,12 @@ static int __init acpi_bus_init(void)
 		goto error1;
 	}
 
+	/*
+	 * _PDC control method may load dynamic SSDT tables,
+	 * and we need to install the table handler before that.
+	*/
+	acpi_system_sysfs_init();
+
 	acpi_early_processor_set_pdc();
 
 	/*
Index: linux-2.6.35.y/drivers/acpi/internal.h
===================================================================
--- linux-2.6.35.y.orig/drivers/acpi/internal.h
+++ linux-2.6.35.y/drivers/acpi/internal.h
@@ -23,6 +23,7 @@
 int init_acpi_device_notify(void);
 int acpi_scan_init(void);
 int acpi_system_init(void);
+int acpi_system_sysfs_init(void);
 
 #ifdef CONFIG_ACPI_DEBUG
 int acpi_debug_init(void);
Index: linux-2.6.35.y/drivers/acpi/system.c
===================================================================
--- linux-2.6.35.y.orig/drivers/acpi/system.c
+++ linux-2.6.35.y/drivers/acpi/system.c
@@ -164,7 +164,7 @@ acpi_sysfs_table_handler(u32 event, void
 	return AE_OK;
 }
 
-static int acpi_system_sysfs_init(void)
+int __init acpi_system_sysfs_init(void)
 {
 	struct acpi_table_attr *table_attr;
 	struct acpi_table_header *table_header = NULL;
@@ -627,13 +627,6 @@ static int acpi_system_procfs_init(void)
 
 int __init acpi_system_init(void)
 {
-	int result;
-
-	result = acpi_system_procfs_init();
-	if (result)
-		return result;
-
-	result = acpi_system_sysfs_init();
-
-	return result;
+	return acpi_system_procfs_init();
 }
+
