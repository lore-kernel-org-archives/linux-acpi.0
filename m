From: Len Brown <len.brown@intel.com>
Subject: [PATCH 10/13] ACPI: consolidate two motherboard drivers into one
Date: Fri, 24 Nov 2006 00:17:38 -0500
Message-ID: <11643454732506-git-send-email-len.brown@intel.com>
References: <11643454612902-git-send-email-len.brown@intel.com> <1164345463205-git-send-email-len.brown@intel.com> <11643454641312-git-send-email-len.brown@intel.com> <11643454642611-git-send-email-len.brown@intel.com> <11643454652241-git-send-email-len.brown@intel.com> <11643454662740-git-send-email-len.brown@intel.com> <1164345468324-git-send-email-len.brown@intel.com> <11643454703489-git-send-email-len.brown@intel.com> <11643454711040-git-send-email-len.brown@intel.com> <11643454722679-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51583 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934289AbWKXFOE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 00:14:04 -0500
In-Reply-To: <11643454722679-git-send-email-len.brown@intel.com>
Message-Id: <46d1ee2fc5b8924aa5bb56c34f2205e6fc329b1b.1164343921.git.len.brown@intel.com>
In-Reply-To: <bd119392c453771fdb994728a2568c2e3f17705d.1164343921.git.len.brown@intel.com>
References: <bd119392c453771fdb994728a2568c2e3f17705d.1164343921.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Li Shaohua <shaohua.li@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Li Shaohua <shaohua.li@intel.com>

Consolidate motherboard1 and motherboard2 drivers into one
so that driver core doesn't complain that two drivers have
the same name.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/motherboard.c |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/motherboard.c b/drivers/acpi/motherboard.c
index 2e17ec7..bedb511 100644
--- a/drivers/acpi/motherboard.c
+++ b/drivers/acpi/motherboard.c
@@ -33,8 +33,7 @@
 ACPI_MODULE_NAME("acpi_motherboard")
 
 /* Dell use PNP0C01 instead of PNP0C02 */
-#define ACPI_MB_HID1			"PNP0C01"
-#define ACPI_MB_HID2			"PNP0C02"
+#define ACPI_MB_HID			"PNP0C01,PNP0C02"
 /**
  * Doesn't care about legacy IO ports, only IO ports beyond 0x1000 are reserved
  * Doesn't care about the failure of 'request_region', since other may reserve
@@ -110,19 +109,10 @@ static int acpi_motherboard_add(struct a
 	return 0;
 }
 
-static struct acpi_driver acpi_motherboard_driver1 = {
+static struct acpi_driver acpi_motherboard_driver = {
 	.name = "motherboard",
 	.class = "",
-	.ids = ACPI_MB_HID1,
-	.ops = {
-		.add = acpi_motherboard_add,
-		},
-};
-
-static struct acpi_driver acpi_motherboard_driver2 = {
-	.name = "motherboard",
-	.class = "",
-	.ids = ACPI_MB_HID2,
+	.ids = ACPI_MB_HID,
 	.ops = {
 		.add = acpi_motherboard_add,
 		},
@@ -173,8 +163,7 @@ static void __init acpi_reserve_resource
 
 static int __init acpi_motherboard_init(void)
 {
-	acpi_bus_register_driver(&acpi_motherboard_driver1);
-	acpi_bus_register_driver(&acpi_motherboard_driver2);
+	acpi_bus_register_driver(&acpi_motherboard_driver);
 	/*
 	 * Guarantee motherboard IO reservation first
 	 * This module must run after scan.c
-- 
1.4.4.g59427
