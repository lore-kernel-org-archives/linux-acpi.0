From: Len Brown <len.brown@intel.com>
Subject: [PATCH 63/77] ACPI: thinkpad-acpi: add locking to brightness subdriver
Date: Sun, 22 Jul 2007 05:14:48 -0400
Message-ID: <1185095768376-git-send-email-len.brown@intel.com>
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
 <1185095766274-git-send-email-len.brown@intel.com>
 <1185095767879-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45627 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762477AbXGVJQJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:16:09 -0400
In-Reply-To: <1185095767879-git-send-email-len.brown@intel.com>
Message-Id: <f432255e936a892a6896e5032e2b4897423076f2.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The backlight class does all the locking needed for sysfs access, but
offers no API to interface to that locking without an layer violation.

Since we need to mutex-lock procfs access, implement in-driver locking for
brightness.  It will go away the day thinkpad-acpi procfs goes away, or the
backlight class gives us a way to use its locks without a layer violation.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   35 ++++++++++++++++++++++++++++-------
 1 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 01bed93..f15a58f 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -3000,12 +3000,16 @@ static struct backlight_ops ibm_backlight_data = {
         .update_status  = brightness_update_status,
 };
 
+static struct mutex brightness_mutex;
+
 static int __init brightness_init(struct ibm_init_struct *iibm)
 {
 	int b;
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing brightness subdriver\n");
 
+	mutex_init(&brightness_mutex);
+
 	if (!brightness_mode) {
 		if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO)
 			brightness_mode = 2;
@@ -3092,27 +3096,44 @@ static int brightness_get(struct backlight_device *bd)
 
 static int brightness_set(int value)
 {
-	int cmos_cmd, inc, i;
-	int current_value = brightness_get(NULL);
+	int cmos_cmd, inc, i, res;
+	int current_value;
 
 	if (value > 7)
 		return -EINVAL;
 
+	res = mutex_lock_interruptible(&brightness_mutex);
+	if (res < 0)
+		return res;
+
+	current_value = brightness_get(NULL);
+	if (current_value < 0) {
+		res = current_value;
+		goto errout;
+	}
+
 	cmos_cmd = value > current_value ?
 			TP_CMOS_BRIGHTNESS_UP :
 			TP_CMOS_BRIGHTNESS_DOWN;
 	inc = value > current_value ? 1 : -1;
 
+	res = 0;
 	for (i = current_value; i != value; i += inc) {
 		if ((brightness_mode & 2) &&
-		    issue_thinkpad_cmos_command(cmos_cmd))
-			return -EIO;
+		    issue_thinkpad_cmos_command(cmos_cmd)) {
+			res = -EIO;
+			goto errout;
+		}
 		if ((brightness_mode & 1) &&
-		    !acpi_ec_write(brightness_offset, i + inc))
-			return -EIO;
+		    !acpi_ec_write(brightness_offset, i + inc)) {
+			res = -EIO;
+			goto errout;;
+		}
 	}
 
-	return 0;
+errout:
+	mutex_unlock(&brightness_mutex);
+	return res;
 }
 
 static int brightness_read(char *p)
-- 
1.5.3.rc2.22.g69a9b
