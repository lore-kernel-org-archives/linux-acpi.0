From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI/EC: Fix an issue that ec_remove_handlers() is invoked unexpectedly.
Date: Mon, 15 Dec 2014 08:47:52 +0800
Message-ID: <1418604472-1764-1-git-send-email-lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2817 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbaLOAsT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 Dec 2014 19:48:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The ec_remove_handlers() is invoked without checking
EC_FLAGS_HANDLERS_INSTALLED, this patch enhances this check to avoid issues
that acpi_disable_gpe() is invoked unexpectedly to reduce the GPE runtime
count. This may happen when the EC handler installation failed on some
platforms.

Reported-by: Venkat Raghavulu <venkat.raghavulu@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 5f9b74b..1b5853f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -844,6 +844,8 @@ static int ec_install_handlers(struct acpi_ec *ec)
 
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
+	if (!test_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags))
+		return;
 	acpi_disable_gpe(NULL, ec->gpe);
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
-- 
1.7.10

