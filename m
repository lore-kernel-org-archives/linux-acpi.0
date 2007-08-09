From: Len Brown <len.brown@intel.com>
Subject: [PATCH 4/6] ACPI: thermal: create "thermal.nocrt" bootparam
Date: Thu,  9 Aug 2007 01:58:54 -0400
Message-ID: <11866391393475-git-send-email-len.brown@intel.com>
References: 11866388361593-git-send-email-len.brown@intel.com
 <11866391363162-git-send-email-len.brown@intel.com>
 <11866391373567-git-send-email-len.brown@intel.com>
 <11866391381018-git-send-email-len.brown@intel.com>
 <11866391391260-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23487 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757691AbXHIF7A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2007 01:59:00 -0400
In-Reply-To: <11866391391260-git-send-email-len.brown@intel.com>
Message-Id: <b3f523f99b705457d55f79ce20d960a6f94cbf86.1186638234.git.len.brown@intel.com>
In-Reply-To: <c405f58ecf5ebf0ba3752cb24a7cd0cc5075646d.1186638234.git.len.brown@intel.com>
References: <c405f58ecf5ebf0ba3752cb24a7cd0cc5075646d.1186638234.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

thermal.nocrt=1 disables actions on _CRT and _HOT
ACPI thermal zone trip-points.  They will be marked
as <disabled> in /proc/acpi/thermal_zone/*/trip_points.

There are two cases where this option is used:

1. Debugging a hot system crossing valid trip point.

   If your system fan is spinning at full speed,
   be sure that the vent is not clogged with dust.
   Many laptops have very fine thermal fins that are easily blocked.

   Check that the processor fan-sink is properly seated,
   has the proper thermal grease, and is really spinning.

   Check for fan related options in BIOS SETUP.
   Sometimes there is a performance vs quiet option.
   Defaults are generally the most conservative.

   If your fan is not spinning, yet /proc/acpi/fan/
   has files in it, please file a Linux/ACPI bug.

   WARNING: you risk shortening the lifetime of your
   hardware if you use this parameter on a hot system.
   Note that this refers to all system components,
   including the disk drive.

2. Working around a cool system crossing critical
   trip point due to erroneous temperature reading.

   Try again with CONFIG_HWMON=n
   There is known potential for conflict between the
   the hwmon sub-system and the ACPI BIOS.
   If this fixes it, notify lm-sensors@lm-sensors.org
   and linux-acpi@vger.kernel.org

   Otherwise, file a Linux/ACPI bug, or notify
   just linux-acpi@vger.kernel.org.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    4 ++++
 drivers/acpi/thermal.c              |   18 ++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 9118fc6..897bb63 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1820,6 +1820,10 @@ and is between 256 and 4096 characters. It is defined in the file
 	thash_entries=	[KNL,NET]
 			Set number of hash buckets for TCP connection
 
+	thermal.nocrt=	[HW,ACPI]
+			Set to disable actions on ACPI thermal zone
+			critical and hot trip points.
+
 	thermal.off=	[HW,ACPI]
 			1: disable ACPI thermal control
 
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 9d7453c..1642980 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -78,6 +78,10 @@ static int tzp;
 module_param(tzp, int, 0444);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.\n");
 
+static int nocrt;
+module_param(nocrt, int, 0);
+MODULE_PARM_DESC(nocrt, "Set to disable action on ACPI thermal zone critical and hot trips.\n");
+
 static int off;
 module_param(off, int, 0);
 MODULE_PARM_DESC(off, "Set to disable ACPI thermal support.\n");
@@ -442,7 +446,7 @@ static int acpi_thermal_get_devices(struct acpi_thermal *tz)
 
 static int acpi_thermal_critical(struct acpi_thermal *tz)
 {
-	if (!tz || !tz->trips.critical.flags.valid)
+	if (!tz || !tz->trips.critical.flags.valid || nocrt)
 		return -EINVAL;
 
 	if (tz->temperature >= tz->trips.critical.temperature) {
@@ -464,7 +468,7 @@ static int acpi_thermal_critical(struct acpi_thermal *tz)
 
 static int acpi_thermal_hot(struct acpi_thermal *tz)
 {
-	if (!tz || !tz->trips.hot.flags.valid)
+	if (!tz || !tz->trips.hot.flags.valid || nocrt)
 		return -EINVAL;
 
 	if (tz->temperature >= tz->trips.hot.temperature) {
@@ -839,12 +843,14 @@ static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
 		goto end;
 
 	if (tz->trips.critical.flags.valid)
-		seq_printf(seq, "critical (S5):           %ld C\n",
-			   KELVIN_TO_CELSIUS(tz->trips.critical.temperature));
+		seq_printf(seq, "critical (S5):           %ld C%s",
+			   KELVIN_TO_CELSIUS(tz->trips.critical.temperature),
+			   nocrt ? " <disabled>\n" : "\n");
 
 	if (tz->trips.hot.flags.valid)
-		seq_printf(seq, "hot (S4):                %ld C\n",
-			   KELVIN_TO_CELSIUS(tz->trips.hot.temperature));
+		seq_printf(seq, "hot (S4):                %ld C%s",
+			   KELVIN_TO_CELSIUS(tz->trips.hot.temperature),
+			   nocrt ? " <disabled>\n" : "\n");
 
 	if (tz->trips.passive.flags.valid) {
 		seq_printf(seq,
-- 
1.5.3.rc4.29.g74276
