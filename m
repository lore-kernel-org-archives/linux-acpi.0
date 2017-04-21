From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Fri, 21 Apr 2017 18:28:24 -0400
Message-ID: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42920 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1042542AbdDUW2d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2017 18:28:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, timur@codeaurora.org
Cc: Sinan Kaya <okaya@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

GED driver is currently set up as a platform driver. On modern operating
systems, most of the drivers are compiled as kernel modules. It is possible
that a GED interrupt event is received and the driver such as GHES/GPIO/I2C
to service it is not available yet. To accommodate this use case, delay
GED driver load to the late init phase.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/evged.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index 46f0603..30e638b 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -151,4 +151,10 @@ static int ged_probe(struct platform_device *pdev)
 		.acpi_match_table = ACPI_PTR(ged_acpi_ids),
 	},
 };
-builtin_platform_driver(ged_driver);
+
+static __init int ged_init(void)
+{
+	return platform_driver_register(&ged_driver);
+}
+
+late_initcall(ged_init);
-- 
1.9.1

