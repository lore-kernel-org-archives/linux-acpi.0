From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 6/9] ACPI: EC: move acpi_ec_start() after acpi_ec_add()
Date: Mon, 22 Jun 2009 14:41:30 -0600
Message-ID: <20090622204130.32761.90486.stgit@bob.kio>
References: <20090622204016.32761.47464.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:47218 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbZFVUl1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2009 16:41:27 -0400
In-Reply-To: <20090622204016.32761.47464.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>

This patch rearranges ec_install_handlers() and acpi_ec_start() so
acpi_ec_start() ends up just after acpi_ec_add().  A subsequent patch
will merge them.

Code movement only; no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/ec.c |  112 +++++++++++++++++++++++++++--------------------------
 1 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 391f331..8b387a4 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -788,6 +788,42 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 	return AE_CTRL_TERMINATE;
 }
 
+static int ec_install_handlers(struct acpi_ec *ec)
+{
+	acpi_status status;
+	if (test_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags))
+		return 0;
+	status = acpi_install_gpe_handler(NULL, ec->gpe,
+				  ACPI_GPE_EDGE_TRIGGERED,
+				  &acpi_ec_gpe_handler, ec);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
+	acpi_enable_gpe(NULL, ec->gpe);
+	status = acpi_install_address_space_handler(ec->handle,
+						    ACPI_ADR_SPACE_EC,
+						    &acpi_ec_space_handler,
+						    NULL, ec);
+	if (ACPI_FAILURE(status)) {
+		if (status == AE_NOT_FOUND) {
+			/*
+			 * Maybe OS fails in evaluating the _REG object.
+			 * The AE_NOT_FOUND error will be ignored and OS
+			 * continue to initialize EC.
+			 */
+			printk(KERN_ERR "Fail in evaluating the _REG object"
+				" of EC device. Broken bios is suspected.\n");
+		} else {
+			acpi_remove_gpe_handler(NULL, ec->gpe,
+				&acpi_ec_gpe_handler);
+			return -ENODEV;
+		}
+	}
+
+	set_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags);
+	return 0;
+}
+
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
@@ -842,6 +878,26 @@ static int acpi_ec_add(struct acpi_device *device)
 	return 0;
 }
 
+static int acpi_ec_start(struct acpi_device *device)
+{
+	struct acpi_ec *ec;
+	int ret = 0;
+
+	if (!device)
+		return -EINVAL;
+
+	ec = acpi_driver_data(device);
+
+	if (!ec)
+		return -EINVAL;
+
+	ret = ec_install_handlers(ec);
+
+	/* EC is fully operational, allow queries */
+	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
+	return ret;
+}
+
 static int acpi_ec_remove(struct acpi_device *device, int type)
 {
 	struct acpi_ec *ec;
@@ -888,62 +944,6 @@ ec_parse_io_ports(struct acpi_resource *resource, void *context)
 	return AE_OK;
 }
 
-static int ec_install_handlers(struct acpi_ec *ec)
-{
-	acpi_status status;
-	if (test_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags))
-		return 0;
-	status = acpi_install_gpe_handler(NULL, ec->gpe,
-				  ACPI_GPE_EDGE_TRIGGERED,
-				  &acpi_ec_gpe_handler, ec);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
-	acpi_enable_gpe(NULL, ec->gpe);
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
-			printk(KERN_ERR "Fail in evaluating the _REG object"
-				" of EC device. Broken bios is suspected.\n");
-		} else {
-			acpi_remove_gpe_handler(NULL, ec->gpe,
-				&acpi_ec_gpe_handler);
-			return -ENODEV;
-		}
-	}
-
-	set_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags);
-	return 0;
-}
-
-static int acpi_ec_start(struct acpi_device *device)
-{
-	struct acpi_ec *ec;
-	int ret = 0;
-
-	if (!device)
-		return -EINVAL;
-
-	ec = acpi_driver_data(device);
-
-	if (!ec)
-		return -EINVAL;
-
-	ret = ec_install_handlers(ec);
-
-	/* EC is fully operational, allow queries */
-	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-	return ret;
-}
-
 static int acpi_ec_stop(struct acpi_device *device, int type)
 {
 	struct acpi_ec *ec;

