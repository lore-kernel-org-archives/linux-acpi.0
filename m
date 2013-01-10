From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] acpi thermal: Use mode to enable/disable kernel thermal processing
Date: Thu, 10 Jan 2013 08:11:31 -0800
Message-ID: <1357834291-12943-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52409 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247Ab3AJQJN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Jan 2013 11:09:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

As per documentation, "mode" sysfs interface should be able to
enable/disable thermal processing in kernel, so that user side
is able to take more control.
Currently acpi thermal driver is not following this setting.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 506fbd4..70036c8 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -531,6 +531,10 @@ static void acpi_thermal_check(void *data)
 {
 	struct acpi_thermal *tz = data;
 
+	if (!tz->tz_enabled) {
+		pr_warn("thermal zone is disabled \n");
+		return;
+	}
 	thermal_zone_device_update(tz->thermal_zone);
 }
 
-- 
1.7.11.7

