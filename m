From: Len Brown <lenb@kernel.org>
Subject: [PATCH 099/171] ACPI: update thermal temperature
Date: Tue, 29 Apr 2008 04:44:19 -0400
Message-ID: <76ecb4f2d7ea5c3aac8970b9529775316507c6d2.1209457070.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:1417 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760750AbYD2Ip1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:27 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang, Rui <rui.zhang@intel.com>

Fix the problem that thermal_get_temp returns the cached value,
which causes the temperature in generic thermal never updates.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 5e9641c..782c225 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -884,10 +884,15 @@ static void acpi_thermal_check(void *data)
 static int thermal_get_temp(struct thermal_zone_device *thermal, char *buf)
 {
 	struct acpi_thermal *tz = thermal->devdata;
+	int result;
 
 	if (!tz)
 		return -EINVAL;
 
+	result = acpi_thermal_get_temperature(tz);
+	if (result)
+		return result;
+
 	return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(tz->temperature));
 }
 
-- 
1.5.5.1.99.gf0ec4

