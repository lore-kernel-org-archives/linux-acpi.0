From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] i2c_ec: Fix a broken kfree
Date: Tue, 1 Aug 2006 16:37:22 +0200
Message-ID: <20060801163722.e602872f.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:43022 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1161007AbWHAOhT
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Aug 2006 10:37:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Fix an obviously broken kfree() in acpi/i2c_ec device initialization
error path.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
This function would benefit from some improvements (single error path,
kzalloc) but let's fix that obvious bug first. This would preferably go
to Linus before 2.6.18.

 drivers/acpi/i2c_ec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18-rc3.orig/drivers/acpi/i2c_ec.c	2006-07-26 23:03:57.000000000 +0200
+++ linux-2.6.18-rc3/drivers/acpi/i2c_ec.c	2006-08-01 16:22:45.000000000 +0200
@@ -330,7 +330,7 @@
 	status = acpi_evaluate_integer(ec_hc->handle, "_EC", NULL, &val);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Error obtaining _EC\n"));
-		kfree(ec_hc->smbus);
+		kfree(ec_hc);
 		kfree(smbus);
 		return -EIO;
 	}


-- 
Jean Delvare
