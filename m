From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] ACPI / scan: do not scan fixed hardware on HW-reduced platform
Date: Mon, 28 Apr 2014 10:38:04 +0800
Message-ID: <535DBF0C.7080409@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56639 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbaD1ChO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Apr 2014 22:37:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

Fixed hardware does not exist on HW-reduced ACPI platform since the
programming interface for them is not implemented on those platforms,
so no need to scan them.
This patch avoids creating the fixed power button ACPI device and
eliminates a probe error message from ACPI button driver on ASUS T100.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/scan.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7efe546a8c42..db5fc6f9628e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2259,12 +2259,16 @@ int __init acpi_scan_init(void)
 	if (result)
 		goto out;
 
-	result = acpi_bus_scan_fixed();
-	if (result) {
-		acpi_detach_data(acpi_root->handle, acpi_scan_drop_device);
-		acpi_device_del(acpi_root);
-		put_device(&acpi_root->dev);
-		goto out;
+	/* Fixed feature devices do not exist on HW-reduced platform */
+	if (!acpi_gbl_reduced_hardware) {
+		result = acpi_bus_scan_fixed();
+		if (result) {
+			acpi_detach_data(acpi_root->handle,
+					 acpi_scan_drop_device);
+			acpi_device_del(acpi_root);
+			put_device(&acpi_root->dev);
+			goto out;
+		}
 	}
 
 	acpi_update_all_gpes();
-- 
1.9.0

