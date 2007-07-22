From: Len Brown <len.brown@intel.com>
Subject: [PATCH 61/77] ACPI: thinkpad-acpi: make EC-based thermal readings non-experimental
Date: Sun, 22 Jul 2007 05:14:46 -0400
Message-ID: <1185095766274-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
 <1185095751279-git-send-email-len.brown@intel.com>
 <11850957522609-git-send-email-len.brown@intel.com>
 <11850957531914-git-send-email-len.brown@intel.com>
 <11850957541879-git-send-email-len.brown@intel.com>
 <11850957552824-git-send-email-len.brown@intel.com>
 <11850957561003-git-send-email-len.brown@intel.com>
 <11850957571080-git-send-email-len.brown@intel.com>
 <11850957591101-git-send-email-len.brown@intel.com>
 <11850957601664-git-send-email-len.brown@intel.com>
 <1185095761326-git-send-email-len.brown@intel.com>
 <11850957621605-git-send-email-len.brown@intel.com>
 <11850957633613-git-send-email-len.brown@intel.com>
 <11850957641697-git-send-email-len.brown@intel.com>
 <11850957651127-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6024 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764307AbXGVJQI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:16:08 -0400
In-Reply-To: <11850957651127-git-send-email-len.brown@intel.com>
Message-Id: <3d6f99ca00ccf861305fd8630a21f2e696886708.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Reading the 16 thermal sensors directly from the EC has been stable for
about one year, in all supported ThinkPad models.  Remove its
"experimental" label.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |   18 +++++-------------
 drivers/misc/thinkpad_acpi.c    |    2 +-
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 5d827de..3eb949e 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -710,23 +710,15 @@ Temperature sensors
 procfs: /proc/acpi/ibm/thermal
 sysfs device attributes: (hwmon) temp*_input
 
-Most ThinkPads include six or more separate temperature sensors but
-only expose the CPU temperature through the standard ACPI methods.
-This feature shows readings from up to eight different sensors on older
-ThinkPads, and it has experimental support for up to sixteen different
-sensors on newer ThinkPads.
-
-EXPERIMENTAL: The 16-sensors feature is marked EXPERIMENTAL because the
-implementation directly accesses hardware registers and may not work as
-expected. USE WITH CAUTION! To use this feature, you need to supply the
-experimental=1 parameter when loading the module.  When EXPERIMENTAL
-mode is enabled, reading the first 8 sensors on newer ThinkPads will
-also use an new experimental thermal sensor access mode.
+Most ThinkPads include six or more separate temperature sensors but only
+expose the CPU temperature through the standard ACPI methods.  This
+feature shows readings from up to eight different sensors on older
+ThinkPads, and up to sixteen different sensors on newer ThinkPads.
 
 For example, on the X40, a typical output may be:
 temperatures:   42 42 45 41 36 -128 33 -128
 
-EXPERIMENTAL: On the T43/p, a typical output may be:
+On the T43/p, a typical output may be:
 temperatures:   48 48 36 52 38 -128 31 -128 48 52 48 -128 -128 -128 -128 -128
 
 The mapping of thermal sensors to physical locations varies depending on
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index f74d7d6..84a1000 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2709,7 +2709,7 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
 
 	acpi_tmp7 = acpi_evalf(ec_handle, NULL, "TMP7", "qv");
 
-	if (thinkpad_id.ec_model && experimental) {
+	if (thinkpad_id.ec_model) {
 		/*
 		 * Direct EC access mode: sensors at registers
 		 * 0x78-0x7F, 0xC0-0xC7.  Registers return 0x00 for
-- 
1.5.3.rc2.22.g69a9b
