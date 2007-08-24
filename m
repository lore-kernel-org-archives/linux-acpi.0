From: Len Brown <len.brown@intel.com>
Subject: [PATCH 02/25] ACPI: thermal: create "thermal.crt=C" bootparam
Date: Fri, 24 Aug 2007 03:20:49 -0400
Message-ID: <11879400782033-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19079 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783AbXHXHVT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:19 -0400
In-Reply-To: <11879400762710-git-send-email-len.brown@intel.com>
Message-Id: <c52a7419af18594426bc601d1ea346dbbcf71e28.1187939442.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

Some hardware will malfunction at a temperature below
the BIOS provided critical shutdown threshold.

This hook allows moving the critical trip points down
to a temperature which provokes a graceful shutdown
before the hardware malfunction.

http://bugzilla.kernel.org/show_bug.cgi?id=8884

WARNING: A trip-point override will not get noticed
until the system delivers a temperature change event,
or unless thermal zone polling is enabled.
eg. "thermal.tzp=10"

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    4 ++++
 drivers/acpi/thermal.c              |   18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 975f029..18dcfdd 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1826,6 +1826,10 @@ and is between 256 and 4096 characters. It is defined in the file
 			-1: disable all active trip points in all thermal zones
 			<degrees C>: override all lowest active trip points
 
+	thermal.crt=	[HW,ACPI]
+			-1: disable all critical trip points in all thermal zones
+			<degrees C>: lower all critical trip points
+
 	thermal.nocrt=	[HW,ACPI]
 			Set to disable actions on ACPI thermal zone
 			critical and hot trip points.
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 9b31f36..4c420fe 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -79,6 +79,10 @@ static int act;
 module_param(act, int, 0644);
 MODULE_PARM_DESC(act, "Disable or override all lowest active trip points.");
 
+static int crt;
+module_param(crt, int, 0644);
+MODULE_PARM_DESC(crt, "Disable or lower all critical trip points.");
+
 static int tzp;
 module_param(tzp, int, 0444);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.");
@@ -340,6 +344,20 @@ static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 				  tz->trips.critical.temperature));
 	}
 
+	if (tz->trips.critical.flags.valid == 1) {
+		if (crt == -1) {
+			tz->trips.critical.flags.valid = 0;
+		} else if (crt > 0) {
+			unsigned long crt_k = CELSIUS_TO_KELVIN(crt);
+
+			/*
+			 * Allow override to lower critical threshold
+			 */
+			if (crt_k < tz->trips.critical.temperature)
+				tz->trips.critical.temperature = crt_k;
+		}
+	}
+
 	/* Critical Sleep (optional) */
 
 	status =
-- 
1.5.3.rc6.17.g1911
