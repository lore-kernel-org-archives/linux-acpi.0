From: Len Brown <len.brown@intel.com>
Subject: [PATCH 011/105] ACPI: EC: Cleanup of EC initialization
Date: Sun, 29 Apr 2007 00:50:11 -0400
Message-ID: <11778223151972-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57052 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754594AbXD2Ev4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:51:56 -0400
In-Reply-To: <11778223143898-git-send-email-len.brown@intel.com>
Message-Id: <01f2246269639f6aa93086719a8dbec26cb68e98.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   32 +++++++++++++-------------------
 1 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 187981a..2a17229 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1,6 +1,8 @@
 /*
- *  acpi_ec.c - ACPI Embedded Controller Driver ($Revision: 38 $)
+ *  ec.c - ACPI Embedded Controller Driver (v2.0)
  *
+ *  Copyright (C) 2006, 2007 Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
+ *  Copyright (C) 2006 Denis Sadykov <denis.m.sadykov@intel.com>
  *  Copyright (C) 2004 Luming Yu <luming.yu@intel.com>
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
@@ -94,7 +96,6 @@ static struct acpi_driver acpi_ec_driver = {
 /* External interfaces use first EC only, so remember */
 static struct acpi_ec {
 	acpi_handle handle;
-	unsigned long uid;
 	unsigned long gpe;
 	unsigned long command_addr;
 	unsigned long data_addr;
@@ -525,13 +526,11 @@ static int acpi_ec_read_info(struct seq_file *seq, void *offset)
 	if (!ec)
 		goto end;
 
-	seq_printf(seq, "gpe:                 0x%02x\n", (u32) ec->gpe);
-	seq_printf(seq, "ports:                   0x%02x, 0x%02x\n",
-		   (u32) ec->command_addr, (u32) ec->data_addr);
-	seq_printf(seq, "use global lock:         %s\n",
+	seq_printf(seq, "gpe:\t\t\t0x%02x\n", (u32) ec->gpe);
+	seq_printf(seq, "ports:\t\t\t0x%02x, 0x%02x\n",
+		   (unsigned)ec->command_addr, (unsigned)ec->data_addr);
+	seq_printf(seq, "use global lock:\t%s\n",
 		   ec->global_lock ? "yes" : "no");
-	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
-
       end:
 	return 0;
 }
@@ -655,15 +654,13 @@ static int acpi_ec_add(struct acpi_device *device)
 
 static int acpi_ec_remove(struct acpi_device *device, int type)
 {
-	struct acpi_ec *ec = NULL;
+	struct acpi_ec *ec;
 
 	if (!device)
 		return -EINVAL;
 
 	ec = acpi_driver_data(device);
-
 	acpi_ec_remove_fs(device);
-
 	acpi_driver_data(device) = NULL;
 	if (ec == first_ec)
 		first_ec = NULL;
@@ -671,7 +668,6 @@ static int acpi_ec_remove(struct acpi_device *device, int type)
 	/* Don't touch boot EC */
 	if (boot_ec != ec)
 		kfree(ec);
-
 	return 0;
 }
 
@@ -680,22 +676,20 @@ ec_parse_io_ports(struct acpi_resource *resource, void *context)
 {
 	struct acpi_ec *ec = context;
 
-	if (resource->type != ACPI_RESOURCE_TYPE_IO) {
+	if (resource->type != ACPI_RESOURCE_TYPE_IO)
 		return AE_OK;
-	}
 
 	/*
 	 * The first address region returned is the data port, and
 	 * the second address region returned is the status/command
 	 * port.
 	 */
-	if (ec->data_addr == 0) {
+	if (ec->data_addr == 0)
 		ec->data_addr = resource->data.io.minimum;
-	} else if (ec->command_addr == 0) {
+	else if (ec->command_addr == 0)
 		ec->command_addr = resource->data.io.minimum;
-	} else {
+	else
 		return AE_CTRL_TERMINATE;
-	}
 
 	return AE_OK;
 }
@@ -708,6 +702,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
 					  &acpi_ec_gpe_handler, ec);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
+
 	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
 	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
 
@@ -825,7 +820,6 @@ int __init acpi_ec_ecdt_probe(void)
 	boot_ec->command_addr = ecdt_ptr->control.address;
 	boot_ec->data_addr = ecdt_ptr->data.address;
 	boot_ec->gpe = ecdt_ptr->gpe;
-	boot_ec->uid = ecdt_ptr->uid;
 	boot_ec->handle = ACPI_ROOT_OBJECT;
 
 	ret = ec_install_handlers(boot_ec);
-- 
1.5.2.rc0.34.gda94
