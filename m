From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 19/33] eeepc-laptop: simplify how the hwmon device reads values from the EC
Date: Thu,  3 Dec 2009 08:45:03 +0100
Message-ID: <1259826317-18809-20-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-6-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-7-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-8-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-9-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-10-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-11-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-12-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-13-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-14-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-15-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-16-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-17-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-18-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-19-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44223 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754291AbZLCHof (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:35 -0500
In-Reply-To: <1259826317-18809-19-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

The hwmon device uses ec_write() to write values to the EC.  So for
consistency it should use ec_read() to read values.  The extra layers
of indirection used did not add any value.

This may mean we no longer take the ACPI global lock for such reads
(if the EC operation region requires the lock and the EC does not).
But there is no point locking each one-byte read individually, when
write operations do not use the lock at all.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
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
1.6.5.3

