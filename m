From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ACPI / EC: Add missing destroy_workqueue() on error in acpi_ec_init()
Date: Fri, 29 Jul 2016 15:53:24 +0000
Message-ID: <1469807604-32204-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35163 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbcG2Pxc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jul 2016 11:53:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id h186so5640132pfg.2
        for <linux-acpi@vger.kernel.org>; Fri, 29 Jul 2016 08:53:32 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-acpi@vger.kernel.org

Add the missing destroy_workqueue() before return from
acpi_ec_init() in the error handling case.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/acpi/ec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9267554..853a55d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1676,8 +1676,10 @@ int __init acpi_ec_init(void)
 
 	/* Now register the driver for the EC */
 	result = acpi_bus_register_driver(&acpi_ec_driver);
-	if (result < 0)
+	if (result < 0) {
+		destroy_workqueue(ec_query_wq);
 		return -ENODEV;
+	}
 
 	return result;
 }



