From: tianyu.lan@intel.com
Subject: [PATCH 2/3] ACPI/Thermal: Remove unused macro in the driver/acpi/thermal.c
Date: Wed, 14 Aug 2013 21:00:38 +0800
Message-ID: <1376485239-18312-2-git-send-email-tianyu.lan@intel.com>
References: <1376485239-18312-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51187 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932282Ab3HNNLP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Aug 2013 09:11:15 -0400
In-Reply-To: <1376485239-18312-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, rui.zhang@intel.com

From: Lan Tianyu <tianyu.lan@intel.com>

The ACPI_THERMAL_FILE* macros are not used now and so remove them.

Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/thermal.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 850818d..71ab083 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -50,11 +50,6 @@
 
 #define ACPI_THERMAL_CLASS		"thermal_zone"
 #define ACPI_THERMAL_DEVICE_NAME	"Thermal Zone"
-#define ACPI_THERMAL_FILE_STATE		"state"
-#define ACPI_THERMAL_FILE_TEMPERATURE	"temperature"
-#define ACPI_THERMAL_FILE_TRIP_POINTS	"trip_points"
-#define ACPI_THERMAL_FILE_COOLING_MODE	"cooling_mode"
-#define ACPI_THERMAL_FILE_POLLING_FREQ	"polling_frequency"
 #define ACPI_THERMAL_NOTIFY_TEMPERATURE	0x80
 #define ACPI_THERMAL_NOTIFY_THRESHOLDS	0x81
 #define ACPI_THERMAL_NOTIFY_DEVICES	0x82
-- 
1.8.4.rc0.1.g8f6a3e5.dirty

