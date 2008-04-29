From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/4] ACPI: Cleanup: Remove unneeded, multiple local dummy variables
Date: Tue, 29 Apr 2008 11:14:24 -0400
Message-ID: <66fb9d120e91050093b8ce4c1daa2e440660152b.1209480940.git.len.brown@intel.com>
References: <1209482064-25440-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6427 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756372AbYD2POb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2008 11:14:31 -0400
In-Reply-To: <1209482064-25440-1-git-send-email-lenb@kernel.org>
In-Reply-To: <78eed028f13b1a0b2612368dff3786e400e6cf8b.1209480940.git.len.brown@intel.com>
References: <78eed028f13b1a0b2612368dff3786e400e6cf8b.1209480940.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e6ce262..6b1999b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -882,10 +882,7 @@ static void acpi_device_get_busid(struct acpi_device *device,
 static int
 acpi_video_bus_match(struct acpi_device *device)
 {
-	acpi_handle h_dummy1;
-	acpi_handle h_dummy2;
-	acpi_handle h_dummy3;
-
+	acpi_handle h_dummy;
 
 	if (!device)
 		return -EINVAL;
@@ -895,18 +892,18 @@ acpi_video_bus_match(struct acpi_device *device)
 	 */
 
 	/* Does this device able to support video switching ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy1)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy2)))
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy)))
 		return 0;
 
 	/* Does this device able to retrieve a video ROM ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_ROM", &h_dummy1)))
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_ROM", &h_dummy)))
 		return 0;
 
 	/* Does this device able to configure which video head to be POSTed ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_VPO", &h_dummy1)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_GPD", &h_dummy2)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_SPD", &h_dummy3)))
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_VPO", &h_dummy)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_GPD", &h_dummy)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_SPD", &h_dummy)))
 		return 0;
 
 	return -ENODEV;
-- 
1.5.5.1.99.gf0ec4

