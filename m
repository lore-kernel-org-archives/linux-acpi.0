From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 3/3] add platform-wide _OSC support
Date: Tue, 27 Oct 2009 14:37:22 +0800
Message-ID: <20091027063722.GC22237@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15112 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756201AbZJ0GhT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Oct 2009 02:37:19 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Add platform-wide _OSC support. Currently enabled two bits for processor
aggregator device and _PR3 support.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/bus.c   |   27 +++++++++++++++++++++++++++
 include/linux/acpi.h |    7 +++++++
 2 files changed, 34 insertions(+)

Index: linux/drivers/acpi/bus.c
===================================================================
--- linux.orig/drivers/acpi/bus.c	2009-10-27 14:02:30.000000000 +0800
+++ linux/drivers/acpi/bus.c	2009-10-27 14:26:47.000000000 +0800
@@ -416,6 +416,31 @@ out_kfree:
 }
 EXPORT_SYMBOL(acpi_run_osc);
 
+static u8 sb_uuid[] = {0x6e, 0xb0, 0x11, 0x08, 0x27, 0x4a, 0xf9, 0x44,
+		0x8d, 0x60, 0x3c, 0xbb, 0xc2, 0x2e, 0x7b, 0x48};
+static void acpi_bus_osc_support(void)
+{
+	u32 capbuf[2];
+	struct acpi_osc_context context = {
+		.uuid = sb_uuid,
+		.rev = 1,
+		.cap.length = 8,
+		.cap.pointer = capbuf,
+	};
+	acpi_handle handle;
+
+	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
+	capbuf[OSC_SUPPORT_TYPE] = OSC_SB_PR3_SUPPORT; /* _PR3 is in use */
+#ifdef CONFIG_ACPI_PROCESSOR_AGGREGATOR
+	capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_PAD_SUPPORT;
+#endif
+	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
+		return;
+	if (ACPI_SUCCESS(acpi_run_osc(handle, &context)))
+		kfree(context.ret.pointer);
+	/* do we need to check the returned cap? Sounds no */
+}
+
 /* --------------------------------------------------------------------------
                                 Event Management
    -------------------------------------------------------------------------- */
@@ -806,6 +831,8 @@ static int __init acpi_bus_init(void)
 	status = acpi_ec_ecdt_probe();
 	/* Ignore result. Not having an ECDT is not fatal. */
 
+	acpi_bus_osc_support();
+
 	status = acpi_initialize_objects(ACPI_FULL_INITIALIZATION);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "Unable to initialize ACPI objects\n");
Index: linux/include/linux/acpi.h
===================================================================
--- linux.orig/include/linux/acpi.h	2009-10-27 14:06:40.000000000 +0800
+++ linux/include/linux/acpi.h	2009-10-27 14:10:39.000000000 +0800
@@ -273,6 +273,13 @@ struct acpi_osc_context {
 
 acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 
+/* platform-wide _OSC bits */
+#define OSC_SB_PAD_SUPPORT		1
+#define OSC_SB_PPC_OST_SUPPORT		2
+#define OSC_SB_PR3_SUPPORT		4
+#define OSC_SB_CPUHP_OST_SUPPORT	8
+#define OSC_SB_APEI_SUPPORT		16
+
 /* PCI defined _OSC bits */
 /* _OSC DW1 Definition (OS Support Fields) */
 #define OSC_EXT_PCI_CONFIG_SUPPORT		1
