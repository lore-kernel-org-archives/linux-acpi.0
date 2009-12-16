From: Len Brown <lenb@kernel.org>
Subject: [PATCH 036/103] eeepc-laptop: simplify how the hwmon device reads
 values from the EC
Date: Wed, 16 Dec 2009 03:35:47 -0500
Message-ID: <463b4e474ed0905ffc27ee347648739dbfb03acc.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41516 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761479AbZLPKGJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:06:09 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:58 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

The hwmon device uses ec_write() to write values to the EC.  So for
consistency it should use ec_read() to read values.  The extra layers
of indirection used did not add any value.

This may mean we no longer take the ACPI global lock for such reads
(if the EC operation region requires the lock and the EC does not).
But there is no point locking each one-byte read individually, when
write operations do not use the lock at all.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   43 +++++++++++++++++------------------
 1 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 50ceaaf..04a59d3 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -118,14 +118,14 @@ static const char *cm_setv[] = {
 	NULL, NULL, "PBPS", "TPDS"
 };
 
-#define EEEPC_EC	"\\_SB.PCI0.SBRG.EC0."
+#define EEEPC_EC_SC00      0x61
+#define EEEPC_EC_FAN_PWM   (EEEPC_EC_SC00 + 2) /* Fan PWM duty cycle (%) */
+#define EEEPC_EC_FAN_HRPM  (EEEPC_EC_SC00 + 5) /* High byte, fan speed (RPM) */
+#define EEEPC_EC_FAN_LRPM  (EEEPC_EC_SC00 + 6) /* Low byte, fan speed (RPM) */
+
+#define EEEPC_EC_SFB0      0xD0
+#define EEEPC_EC_FAN_CTRL  (EEEPC_EC_SFB0 + 3) /* Byte containing SF25  */
 
-#define EEEPC_EC_FAN_PWM	EEEPC_EC "SC02" /* Fan PWM duty cycle (%) */
-#define EEEPC_EC_SC02		0x63
-#define EEEPC_EC_FAN_HRPM	EEEPC_EC "SC05" /* High byte, fan speed (RPM) */
-#define EEEPC_EC_FAN_LRPM	EEEPC_EC "SC06" /* Low byte, fan speed (RPM) */
-#define EEEPC_EC_FAN_CTRL	EEEPC_EC "SFB3" /* Byte containing SF25  */
-#define EEEPC_EC_SFB3		0xD3
 
 /*
  * This is the main structure, we can use it to store useful information
@@ -903,35 +903,34 @@ static int eeepc_hotk_restore(struct device *device)
  */
 static int eeepc_get_fan_pwm(void)
 {
-	int value = 0;
+	u8 value = 0;
 
-	read_acpi_int(NULL, EEEPC_EC_FAN_PWM, &value);
-	value = value * 255 / 100;
-	return (value);
+	ec_read(EEEPC_EC_FAN_PWM, &value);
+	return value * 255 / 100;
 }
 
 static void eeepc_set_fan_pwm(int value)
 {
 	value = SENSORS_LIMIT(value, 0, 255);
 	value = value * 100 / 255;
-	ec_write(EEEPC_EC_SC02, value);
+	ec_write(EEEPC_EC_FAN_PWM, value);
 }
 
 static int eeepc_get_fan_rpm(void)
 {
-	int high = 0;
-	int low = 0;
+	u8 high = 0;
+	u8 low = 0;
 
-	read_acpi_int(NULL, EEEPC_EC_FAN_HRPM, &high);
-	read_acpi_int(NULL, EEEPC_EC_FAN_LRPM, &low);
-	return (high << 8 | low);
+	ec_read(EEEPC_EC_FAN_HRPM, &high);
+	ec_read(EEEPC_EC_FAN_LRPM, &low);
+	return high << 8 | low;
 }
 
 static int eeepc_get_fan_ctrl(void)
 {
-	int value = 0;
+	u8 value = 0;
 
-	read_acpi_int(NULL, EEEPC_EC_FAN_CTRL, &value);
+	ec_read(EEEPC_EC_FAN_CTRL, &value);
 	if (value & 0x02)
 		return 1; /* manual */
 	else
@@ -940,14 +939,14 @@ static int eeepc_get_fan_ctrl(void)
 
 static void eeepc_set_fan_ctrl(int manual)
 {
-	int value = 0;
+	u8 value = 0;
 
-	read_acpi_int(NULL, EEEPC_EC_FAN_CTRL, &value);
+	ec_read(EEEPC_EC_FAN_CTRL, &value);
 	if (manual == 1)
 		value |= 0x02;
 	else
 		value &= ~0x02;
-	ec_write(EEEPC_EC_SFB3, value);
+	ec_write(EEEPC_EC_FAN_CTRL, value);
 }
 
 static ssize_t store_sys_hwmon(void (*set)(int), const char *buf, size_t count)
-- 
1.6.0.6

