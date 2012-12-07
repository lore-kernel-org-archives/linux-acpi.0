From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] ACPI: add Haswell LPSS devices to acpi_platform_device_ids list
Date: Fri,  7 Dec 2012 12:08:02 +0200
Message-ID: <1354874882-1162-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5819 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932320Ab2LGKEq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Dec 2012 05:04:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

All devices behind Haswell LPSS (Low Power Subsystem) should be represented
as platform devices so add them to the acpi_platform_device_ids list.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/scan.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 67a7fa6..8ee379e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -37,6 +37,16 @@ static const struct acpi_device_id acpi_platform_device_ids[] = {
 
 	{ "PNP0D40" },
 
+	/* Haswell LPSS devices */
+	{ "INT33C0", 0 },
+	{ "INT33C1", 0 },
+	{ "INT33C2", 0 },
+	{ "INT33C3", 0 },
+	{ "INT33C4", 0 },
+	{ "INT33C5", 0 },
+	{ "INT33C6", 0 },
+	{ "INT33C7", 0 },
+
 	{ }
 };
 
-- 
1.7.10.4

