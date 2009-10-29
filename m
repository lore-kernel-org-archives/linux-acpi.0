From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 3/3]add platform-wide _OSC support
Date: Thu, 29 Oct 2009 11:05:05 +0800
Message-ID: <20091029030505.GC5150@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58518 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216AbZJ2DFC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Oct 2009 23:05:02 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, bjorn.helgaas@hp.com, kaneshige.kenji@jp.fujitsu.com, aystarik@gmail.com

Add platform-wide _OSC support.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/bus.c   |   26 ++++++++++++++++++++++++++
 include/linux/acpi.h |    7 +++++++
 2 files changed, 33 insertions(+)

Index: linux/drivers/acpi/bus.c
===================================================================
--- linux.orig/drivers/acpi/bus.c	2009-10-29 10:26:43.000000000 +0800
+++ linux/drivers/acpi/bus.c	2009-10-29 10:31:58.000000000 +0800
@@ -466,6 +466,30 @@ out_kfree:
 }
 EXPORT_SYMBOL(acpi_run_osc);
 
+static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
+static void acpi_bus_osc_support(void)
+{
+	u32 capbuf[2];
+	struct acpi_osc_context context = {
+		.uuid_str = sb_uuid_str,
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
@@ -856,6 +880,8 @@ static int __init acpi_bus_init(void)
 	status = acpi_ec_ecdt_probe();
 	/* Ignore result. Not having an ECDT is not fatal. */
 
+	acpi_bus_osc_support();
+
 	status = acpi_initialize_objects(ACPI_FULL_INITIALIZATION);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "Unable to initialize ACPI objects\n");
Index: linux/include/linux/acpi.h
===================================================================
--- linux.orig/include/linux/acpi.h	2009-10-29 10:29:30.000000000 +0800
+++ linux/include/linux/acpi.h	2009-10-29 10:31:06.000000000 +0800
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
