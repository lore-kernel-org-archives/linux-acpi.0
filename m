From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/14] ACPI 2.0 / ECDT: Split EC_FLAGS_HANDLERS_INSTALLED
Date: Sat,  6 Feb 2016 11:53:21 +0800
Message-ID: <3706539038f21c13e9344eb8297516aab433f917.1454730660.git.lv.zheng@intel.com>
References: <cover.1454730659.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59437 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbcBFDxZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Feb 2016 22:53:25 -0500
In-Reply-To: <cover.1454730659.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch splits EC_FLAGS_HANDLERS_INSTALLED so that address space handler
can be installed when it is not possible to install GPE handler during
early stage.
This patch also tunes address space handler installation, making it
happening earlier than GPE handler installation for the same purpose.

Since acpi_ec_start()/acpi_ec_stop() will be entered multiple times after
applying this change, it is also required to protect acpi_enable_gpe()/
acpi_disable_gpe() invocations.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   96 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 41 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index b420fb4..b8f474b 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -105,8 +105,8 @@ enum ec_command {
 enum {
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
 	EC_FLAGS_QUERY_GUARDING,	/* Guard for SCI_EVT check */
-	EC_FLAGS_HANDLERS_INSTALLED,	/* Handlers for GPE and
-					 * OpReg are installed */
+	EC_FLAGS_GPE_HANDLER_INSTALLED,	/* GPE handler installed */
+	EC_FLAGS_EC_HANDLER_INSTALLED,	/* OpReg handler installed */
 	EC_FLAGS_STARTED,		/* Driver is started */
 	EC_FLAGS_STOPPED,		/* Driver is stopped */
 	EC_FLAGS_COMMAND_STORM,		/* GPE storms occurred to the
@@ -367,7 +367,8 @@ static inline void acpi_ec_clear_gpe(struct acpi_ec *ec)
 static void acpi_ec_submit_request(struct acpi_ec *ec)
 {
 	ec->reference_count++;
-	if (ec->reference_count == 1)
+	if (test_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags) &&
+	    ec->reference_count == 1)
 		acpi_ec_enable_gpe(ec, true);
 }
 
@@ -376,7 +377,8 @@ static void acpi_ec_complete_request(struct acpi_ec *ec)
 	bool flushed = false;
 
 	ec->reference_count--;
-	if (ec->reference_count == 0)
+	if (test_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags) &&
+	    ec->reference_count == 0)
 		acpi_ec_disable_gpe(ec, true);
 	flushed = acpi_ec_flushed(ec);
 	if (flushed)
@@ -1287,52 +1289,64 @@ static int ec_install_handlers(struct acpi_ec *ec)
 {
 	acpi_status status;
 
-	if (test_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags))
-		return 0;
-	status = acpi_install_gpe_raw_handler(NULL, ec->gpe,
-				  ACPI_GPE_EDGE_TRIGGERED,
-				  &acpi_ec_gpe_handler, ec);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
 	acpi_ec_start(ec, false);
-	status = acpi_install_address_space_handler(ec->handle,
-						    ACPI_ADR_SPACE_EC,
-						    &acpi_ec_space_handler,
-						    NULL, ec);
-	if (ACPI_FAILURE(status)) {
-		if (status == AE_NOT_FOUND) {
-			/*
-			 * Maybe OS fails in evaluating the _REG object.
-			 * The AE_NOT_FOUND error will be ignored and OS
-			 * continue to initialize EC.
-			 */
-			pr_err("Fail in evaluating the _REG object"
-				" of EC device. Broken bios is suspected.\n");
-		} else {
-			acpi_ec_stop(ec, false);
-			acpi_remove_gpe_handler(NULL, ec->gpe,
-				&acpi_ec_gpe_handler);
-			return -ENODEV;
+
+	if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
+		status = acpi_install_address_space_handler(ec->handle,
+							    ACPI_ADR_SPACE_EC,
+							    &acpi_ec_space_handler,
+							    NULL, ec);
+		if (ACPI_FAILURE(status)) {
+			if (status == AE_NOT_FOUND) {
+				/*
+				 * Maybe OS fails in evaluating the _REG
+				 * object. The AE_NOT_FOUND error will be
+				 * ignored and OS * continue to initialize
+				 * EC.
+				 */
+				pr_err("Fail in evaluating the _REG object"
+					" of EC device. Broken bios is suspected.\n");
+			} else {
+				acpi_ec_stop(ec, false);
+				return -ENODEV;
+			}
+		}
+		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
+	}
+
+	if (!test_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags)) {
+		status = acpi_install_gpe_raw_handler(NULL, ec->gpe,
+					  ACPI_GPE_EDGE_TRIGGERED,
+					  &acpi_ec_gpe_handler, ec);
+		/* This is not fatal as we can poll EC events */
+		if (ACPI_SUCCESS(status)) {
+			set_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags);
+			if (test_bit(EC_FLAGS_STARTED, &ec->flags) &&
+			    ec->reference_count >= 1)
+				acpi_ec_enable_gpe(ec, true);
 		}
 	}
 
-	set_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags);
 	return 0;
 }
 
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
-	if (!test_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags))
-		return;
 	acpi_ec_stop(ec, false);
-	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
-				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
-		pr_err("failed to remove space handler\n");
-	if (ACPI_FAILURE(acpi_remove_gpe_handler(NULL, ec->gpe,
-				&acpi_ec_gpe_handler)))
-		pr_err("failed to remove gpe handler\n");
-	clear_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags);
+
+	if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
+		if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
+					ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
+			pr_err("failed to remove space handler\n");
+		clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
+	}
+
+	if (test_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags)) {
+		if (ACPI_FAILURE(acpi_remove_gpe_handler(NULL, ec->gpe,
+					&acpi_ec_gpe_handler)))
+			pr_err("failed to remove gpe handler\n");
+		clear_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags);
+	}
 }
 
 static int acpi_ec_add(struct acpi_device *device)
@@ -1434,7 +1448,7 @@ ec_parse_io_ports(struct acpi_resource *resource, void *context)
 
 int __init acpi_boot_ec_enable(void)
 {
-	if (!boot_ec || test_bit(EC_FLAGS_HANDLERS_INSTALLED, &boot_ec->flags))
+	if (!boot_ec)
 		return 0;
 	if (!ec_install_handlers(boot_ec)) {
 		first_ec = boot_ec;
-- 
1.7.10

