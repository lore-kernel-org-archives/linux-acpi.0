From: Lv Zheng <lv.zheng@intel.com>
Subject: [UPDATE RFC PATCH v2] ACPI / EC: Fix an order issue in ec_remove_handlers()
Date: Thu,  7 Jul 2016 12:37:10 +0800
Message-ID: <e48b77b7af1e8269b0ff3fac6cbf37eb480ab722.1467866123.git.lv.zheng@intel.com>
References: <20160706141410.GA1430@tetsubishi>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13220 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbcGGEik (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Jul 2016 00:38:40 -0400
In-Reply-To: <20160706141410.GA1430@tetsubishi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Nicholas <nkudriavtsev@gmail.com>

(Updated to add v2 indicator)

There is an order issue in ec_remove_handlers() that the functions invoked
in it are not invoked in the reversed order of their appearance in
ec_install_handlers(). This existing issue has been triggered by the
following commit:
  Commit: dcf15cbded656a12335bc4151f3f75f10080a375
  Subject: ACPI / EC: Fix a boot EC regresion by restoring boot EC
The commit invokes ec_remove_handlers() during runtime, thus uncovers this
issue. This patch fixes this regression.

Fixes: dcf15cbded65 ("ACPI / EC: Fix a boot EC regresion by restoring boot EC")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=102421
Reported-by: Wolfram Sang <wsa@the-dreams.de>
Reported-by: Nicholas <nkudriavtsev@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Nicholas <nkudriavtsev@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index b1050a0..d513208 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1331,8 +1331,6 @@ static int ec_install_handlers(struct acpi_ec *ec)
 
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
-	acpi_ec_stop(ec, false);
-
 	if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
 		if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 					ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
@@ -1340,6 +1338,17 @@ static void ec_remove_handlers(struct acpi_ec *ec)
 		clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
 	}
 
+	/*
+	 * Disabling EC (transactions) after removing the operation region
+	 * handler. This order is required because _REG(DISCONNECT) may
+	 * access the EmbeddedControl operation regions.
+	 *
+	 * Flushing transactions before removing the GPE handler. This is
+	 * required by the current ACPICA GPE design. ACPICA GPE will block
+	 * a GPE if there is no way to handle it.
+	 */
+	acpi_ec_stop(ec, false);
+
 	if (test_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags)) {
 		if (ACPI_FAILURE(acpi_remove_gpe_handler(NULL, ec->gpe,
 					&acpi_ec_gpe_handler)))
-- 
1.7.10

