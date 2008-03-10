From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: [PATCH] ACPI: thermal fixup for broken BIOS which has invalid trip
	points
Date: Mon, 10 Mar 2008 09:53:51 +0800
Message-ID: <1205114031.10256.193.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12380 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755138AbYCJCFI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Mar 2008 22:05:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

thermal fixup for broken BIOS which has invalid trip points.
http://bugzilla.kernel.org/show_bug.cgi?id=8544
http://marc.info/?l=linux-kernel&m=120496222629983&w=2

Signed-off-by: Zhang Rui<rui.zhang@intel.com>
---
 drivers/acpi/thermal.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -326,7 +326,9 @@ static int acpi_thermal_set_cooling_mode
 #define ACPI_TRIPS_ACTIVE	0x08
 #define ACPI_TRIPS_DEVICES	0x10
 
-#define ACPI_TRIPS_REFRESH_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
+#define ACPI_TRIPS_REFRESH_THRESHOLDS	(ACPI_TRIPS_PASSIVE |	\
+					 ACPI_TRIPS_ACTIVE |	\
+					 ACPI_TRIPS_DEVICES)
 #define ACPI_TRIPS_REFRESH_DEVICES	ACPI_TRIPS_DEVICES
 
 #define ACPI_TRIPS_INIT      (ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT |	\


