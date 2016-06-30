From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 5/5] acpi: battery_common: battery present status for INT3407
Date: Wed, 29 Jun 2016 17:00:19 -0700
Message-ID: <1467244819-19046-6-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1467244819-19046-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51184 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751590AbcF2X64 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jun 2016 19:58:56 -0400
In-Reply-To: <1467244819-19046-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

acpi_battery_get_status() will be called often to check if the battery is
present. This call sets status.battery_present field to return the status.
But When enumerated via DPTF power (INT3407), since this field will not be
set as this is not a battery but it will still set the status.present
field. So a check is added when hid is INT3407 check for the presence and
set the status.battery_present flag, so that the rest of the driver calls
don't fail looking for status.battery_present flag.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/battery_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/battery_common.c b/drivers/acpi/battery_common.c
index aaf32ab..89966c4 100644
--- a/drivers/acpi/battery_common.c
+++ b/drivers/acpi/battery_common.c
@@ -387,6 +387,11 @@ static int acpi_battery_get_status(struct acpi_battery *battery)
 		return -ENODEV;
 	}
 
+	if (!strcmp(acpi_device_hid(battery->device), "INT3407")) {
+		if (battery->device->status.present)
+			battery->device->status.battery_present = 1;
+	}
+
 	return 0;
 }
 
-- 
2.5.0

