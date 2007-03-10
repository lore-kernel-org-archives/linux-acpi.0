From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/22] ACPI: EC: Cleanup of EC initialization
Date: Fri,  9 Mar 2007 23:00:57 -0500
Message-ID: <1173499277354-git-send-email-lenb@kernel.org>
References: <11734992592550-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:23753 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1767761AbXCJEBT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Mar 2007 23:01:19 -0500
In-Reply-To: <11734992592550-git-send-email-lenb@kernel.org>
Message-Id: <2f11ffb10877e93e24ae042649666b78dd9985e6.1173498657.git.len.brown@intel.com>
In-Reply-To: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
References: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
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
1.5.0.3.310.g05ef5
