From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3] ACPI / EC: Fix an order issue in ec_remove_handlers()
Date: Fri,  8 Jul 2016 09:25:05 +0800
Message-ID: <197d3c522b51e8c07156d0496fd9bb48e580d984.1467940972.git.lv.zheng@intel.com>
References: <20160706141410.GA1430@tetsubishi>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:15686 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753401AbcGHBZT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Jul 2016 21:25:19 -0400
In-Reply-To: <20160706141410.GA1430@tetsubishi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

There is an order issue in ec_remove_handlers() that the functions invoked
in it are not able to handle the current restrictions (see comments below).
If ec_remove_handlers() is invoked during runtime after _REG(CONNECT) is
invoked, this issue will be uncovered.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=102421
Reported-and-tested-by: Wolfram Sang <wsa@the-dreams.de>
Reported-by: Nicholas <nkudriavtsev@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index b1050a0..84073a6 100644
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
@@ -1340,6 +1338,19 @@ static void ec_remove_handlers(struct acpi_ec *ec)
 		clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
 	}
 
+	/*
+	 * Stops handling the EC transactions after removing the operation
+	 * region handler. This is required because _REG(DISCONNECT)
+	 * invoked during the removal can result in new EC transactions.
+	 *
+	 * Flushes the EC requests and thus disables the GPE before
+	 * removing the GPE handler. This is required by the current ACPICA
+	 * GPE core. ACPICA GPE core will automatically disable a GPE when
+	 * it is indicated but there is no way to handle it. So the drivers
+	 * must disable the GPEs prior than removing the GPE handlers.
+	 */
+	acpi_ec_stop(ec, false);
+
 	if (test_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags)) {
 		if (ACPI_FAILURE(acpi_remove_gpe_handler(NULL, ec->gpe,
 					&acpi_ec_gpe_handler)))
-- 
1.7.10

