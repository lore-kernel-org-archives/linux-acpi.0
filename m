From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/22] ACPI: EC: Put install handlers into separate function.
Date: Fri,  9 Mar 2007 23:00:53 -0500
Message-ID: <11734992733686-git-send-email-lenb@kernel.org>
References: <11734992592550-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:16104 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2993173AbXCJEBS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Mar 2007 23:01:18 -0500
In-Reply-To: <11734992592550-git-send-email-lenb@kernel.org>
Message-Id: <87340f2d12cb87a5a1e6cebe714cf61cc501b588.1173498656.git.len.brown@intel.com>
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
 drivers/acpi/ec.c |   87 ++++++++++++++++------------------------------------
 1 files changed, 27 insertions(+), 60 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 1989631..399cedf 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -715,6 +715,28 @@ acpi_ec_io_ports(struct acpi_resource *resource, void *context)
 	return AE_OK;
 }
 
+static int ec_install_handlers(struct acpi_ec *ec)
+{
+	acpi_status status = acpi_install_gpe_handler(NULL, ec->gpe,
+						      ACPI_GPE_EDGE_TRIGGERED,
+						      &acpi_ec_gpe_handler, ec);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
+	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+
+	status = acpi_install_address_space_handler(ec->handle,
+						    ACPI_ADR_SPACE_EC,
+						    &acpi_ec_space_handler,
+						    &acpi_ec_space_setup, ec);
+	if (ACPI_FAILURE(status)) {
+		acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int acpi_ec_start(struct acpi_device *device)
 {
 	acpi_status status = AE_OK;
@@ -742,28 +764,7 @@ static int acpi_ec_start(struct acpi_device *device)
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "gpe=0x%02lx, ports=0x%2lx,0x%2lx",
 			  ec->gpe, ec->command_addr, ec->data_addr));
 
-	/*
-	 * Install GPE handler
-	 */
-	status = acpi_install_gpe_handler(NULL, ec->gpe,
-					  ACPI_GPE_EDGE_TRIGGERED,
-					  &acpi_ec_gpe_handler, ec);
-	if (ACPI_FAILURE(status)) {
-		return -ENODEV;
-	}
-	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
-	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
-
-	status = acpi_install_address_space_handler(ec->handle,
-						    ACPI_ADR_SPACE_EC,
-						    &acpi_ec_space_handler,
-						    &acpi_ec_space_setup, ec);
-	if (ACPI_FAILURE(status)) {
-		acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
-		return -ENODEV;
-	}
-
-	return AE_OK;
+	return ec_install_handlers(ec);
 }
 
 static int acpi_ec_stop(struct acpi_device *device, int type)
@@ -818,56 +819,22 @@ static int __init acpi_ec_get_real_ecdt(void)
 	ec_ecdt->gpe = ecdt_ptr->gpe;
 	ec_ecdt->uid = ecdt_ptr->uid;
 
-	status = acpi_get_handle(NULL, ecdt_ptr->id, &ec_ecdt->handle);
-	if (ACPI_FAILURE(status)) {
-		goto error;
-	}
-
+	ec_ecdt->handle = ACPI_ROOT_OBJECT;
 	return 0;
-      error:
-	ACPI_EXCEPTION((AE_INFO, status, "Could not use ECDT"));
-	kfree(ec_ecdt);
-	ec_ecdt = NULL;
-
-	return -ENODEV;
 }
 
 int __init acpi_ec_ecdt_probe(void)
 {
-	acpi_status status;
 	int ret;
 
 	ret = acpi_ec_get_real_ecdt();
 	if (ret)
 		return 0;
 
-	/*
-	 * Install GPE handler
-	 */
-	status = acpi_install_gpe_handler(NULL, ec_ecdt->gpe,
-					  ACPI_GPE_EDGE_TRIGGERED,
-					  &acpi_ec_gpe_handler, ec_ecdt);
-	if (ACPI_FAILURE(status)) {
-		goto error;
-	}
-	acpi_set_gpe_type(NULL, ec_ecdt->gpe, ACPI_GPE_TYPE_RUNTIME);
-	acpi_enable_gpe(NULL, ec_ecdt->gpe, ACPI_NOT_ISR);
-
-	status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
-						    ACPI_ADR_SPACE_EC,
-						    &acpi_ec_space_handler,
-						    &acpi_ec_space_setup,
-						    ec_ecdt);
-	if (ACPI_FAILURE(status)) {
-		acpi_remove_gpe_handler(NULL, ec_ecdt->gpe,
-					&acpi_ec_gpe_handler);
-		goto error;
-	}
-
-	return 0;
+	ret = ec_install_handlers(ec_ecdt);
+	if (!ret)
+		return 0;
 
-      error:
-	ACPI_EXCEPTION((AE_INFO, status, "Could not use ECDT"));
 	kfree(ec_ecdt);
 	ec_ecdt = NULL;
 
-- 
1.5.0.3.310.g05ef5
