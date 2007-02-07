From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/140] ACPI: consolidate two motherboard drivers into one
Date: Wed,  7 Feb 2007 13:50:24 -0500
Message-ID: <11708743821259-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:27002 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422712AbXBGSxI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:08 -0500
In-Reply-To: <11708743802558-git-send-email-lenb@kernel.org>
Message-Id: <54a07001b9efb6a3bb9a9d8ac9ddb226e29b5406.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
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
@@ -110,19 +109,10 @@ static int acpi_motherboard_add(struct acpi_device *device)
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
@@ -173,8 +163,7 @@ static void __init acpi_reserve_resources(void)
 
 static int __init acpi_motherboard_init(void)
 {
-	acpi_bus_register_driver(&acpi_motherboard_driver1);
-	acpi_bus_register_driver(&acpi_motherboard_driver2);
+	acpi_bus_register_driver(&acpi_motherboard_driver);
 	/*
 	 * Guarantee motherboard IO reservation first
 	 * This module must run after scan.c
-- 
1.5.0.rc3.39.gec804
