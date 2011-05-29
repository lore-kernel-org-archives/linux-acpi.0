From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/18] ACPI EC: remove dead code
Date: Sun, 29 May 2011 05:44:00 -0400
Message-ID: <1cb7b1e0de6a1f8f071f4a146e3d10f3a662f707.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:35439 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036Ab1E2JoV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:44:21 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY00DX1B1W40B2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:44:21 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
In-reply-to: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

static void acpi_ec_gpe_query(void *ec_cxt);
-> The function is right above this declaration -> not needed.

poll_force is also not used, cleaned up in ec.c and its users:
compal-laptop and msi-laptop.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c                    |    6 +-----
 drivers/platform/x86/compal-laptop.c |   12 ++++++------
 drivers/platform/x86/msi-laptop.c    |   12 ++++++------
 include/linux/acpi.h                 |    3 +--
 4 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index fa848c4..b3f1d6f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -69,7 +69,6 @@ enum ec_command {
 
 #define ACPI_EC_DELAY		500	/* Wait 500ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
-#define ACPI_EC_CDELAY		10	/* Wait 10us before polling EC */
 #define ACPI_EC_MSI_UDELAY	550	/* Wait 550us for MSI EC */
 
 #define ACPI_EC_STORM_THRESHOLD 8	/* number of false interrupts
@@ -433,8 +432,7 @@ EXPORT_SYMBOL(ec_write);
 
 int ec_transaction(u8 command,
 		   const u8 * wdata, unsigned wdata_len,
-		   u8 * rdata, unsigned rdata_len,
-		   int force_poll)
+		   u8 * rdata, unsigned rdata_len)
 {
 	struct transaction t = {.command = command,
 				.wdata = wdata, .rdata = rdata,
@@ -592,8 +590,6 @@ static void acpi_ec_gpe_query(void *ec_cxt)
 	mutex_unlock(&ec->lock);
 }
 
-static void acpi_ec_gpe_query(void *ec_cxt);
-
 static int ec_check_sci(struct acpi_ec *ec, u8 state)
 {
 	if (state & ACPI_EC_FLAG_SCI) {
diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/compal-laptop.c
index 034572b..f4f43e6 100644
--- a/drivers/platform/x86/compal-laptop.c
+++ b/drivers/platform/x86/compal-laptop.c
@@ -200,7 +200,7 @@ static bool extra_features;
  * watching the output of address 0x4F (do an ec_transaction writing 0x33
  * into 0x4F and read a few bytes from the output, like so:
  *	u8 writeData = 0x33;
- *	ec_transaction(0x4F, &writeData, 1, buffer, 32, 0);
+ *	ec_transaction(0x4F, &writeData, 1, buffer, 32);
  * That address is labled "fan1 table information" in the service manual.
  * It should be clear which value in 'buffer' changes). This seems to be
  * related to fan speed. It isn't a proper 'realtime' fan speed value
@@ -286,7 +286,7 @@ static int get_backlight_level(void)
 static void set_backlight_state(bool on)
 {
 	u8 data = on ? BACKLIGHT_STATE_ON_DATA : BACKLIGHT_STATE_OFF_DATA;
-	ec_transaction(BACKLIGHT_STATE_ADDR, &data, 1, NULL, 0, 0);
+	ec_transaction(BACKLIGHT_STATE_ADDR, &data, 1, NULL, 0);
 }
 
 
@@ -294,24 +294,24 @@ static void set_backlight_state(bool on)
 static void pwm_enable_control(void)
 {
 	unsigned char writeData = PWM_ENABLE_DATA;
-	ec_transaction(PWM_ENABLE_ADDR, &writeData, 1, NULL, 0, 0);
+	ec_transaction(PWM_ENABLE_ADDR, &writeData, 1, NULL, 0);
 }
 
 static void pwm_disable_control(void)
 {
 	unsigned char writeData = PWM_DISABLE_DATA;
-	ec_transaction(PWM_DISABLE_ADDR, &writeData, 1, NULL, 0, 0);
+	ec_transaction(PWM_DISABLE_ADDR, &writeData, 1, NULL, 0);
 }
 
 static void set_pwm(int pwm)
 {
-	ec_transaction(PWM_ADDRESS, &pwm_lookup_table[pwm], 1, NULL, 0, 0);
+	ec_transaction(PWM_ADDRESS, &pwm_lookup_table[pwm], 1, NULL, 0);
 }
 
 static int get_fan_rpm(void)
 {
 	u8 value, data = FAN_DATA;
-	ec_transaction(FAN_ADDRESS, &data, 1, &value, 1, 0);
+	ec_transaction(FAN_ADDRESS, &data, 1, &value, 1);
 	return 100 * (int)value;
 }
 
diff --git a/drivers/platform/x86/msi-laptop.c b/drivers/platform/x86/msi-laptop.c
index 7e9bb6d..918a65d 100644
--- a/drivers/platform/x86/msi-laptop.c
+++ b/drivers/platform/x86/msi-laptop.c
@@ -120,7 +120,7 @@ static int set_lcd_level(int level)
 	buf[1] = (u8) (level*31);
 
 	return ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, buf, sizeof(buf),
-			      NULL, 0, 1);
+			      NULL, 0);
 }
 
 static int get_lcd_level(void)
@@ -129,7 +129,7 @@ static int get_lcd_level(void)
 	int result;
 
 	result = ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, &wdata, 1,
-				&rdata, 1, 1);
+				&rdata, 1);
 	if (result < 0)
 		return result;
 
@@ -142,7 +142,7 @@ static int get_auto_brightness(void)
 	int result;
 
 	result = ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, &wdata, 1,
-				&rdata, 1, 1);
+				&rdata, 1);
 	if (result < 0)
 		return result;
 
@@ -157,7 +157,7 @@ static int set_auto_brightness(int enable)
 	wdata[0] = 4;
 
 	result = ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, wdata, 1,
-				&rdata, 1, 1);
+				&rdata, 1);
 	if (result < 0)
 		return result;
 
@@ -165,7 +165,7 @@ static int set_auto_brightness(int enable)
 	wdata[1] = (rdata & 0xF7) | (enable ? 8 : 0);
 
 	return ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, wdata, 2,
-			      NULL, 0, 1);
+			      NULL, 0);
 }
 
 static ssize_t set_device_state(const char *buf, size_t count, u8 mask)
@@ -202,7 +202,7 @@ static int get_wireless_state(int *wlan, int *bluetooth)
 	u8 wdata = 0, rdata;
 	int result;
 
-	result = ec_transaction(MSI_EC_COMMAND_WIRELESS, &wdata, 1, &rdata, 1, 1);
+	result = ec_transaction(MSI_EC_COMMAND_WIRELESS, &wdata, 1, &rdata, 1);
 	if (result < 0)
 		return -1;
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a2e910e..1deb2a7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -150,8 +150,7 @@ extern int ec_read(u8 addr, u8 *val);
 extern int ec_write(u8 addr, u8 val);
 extern int ec_transaction(u8 command,
                           const u8 *wdata, unsigned wdata_len,
-                          u8 *rdata, unsigned rdata_len,
-			  int force_poll);
+                          u8 *rdata, unsigned rdata_len);
 
 #if defined(CONFIG_ACPI_WMI) || defined(CONFIG_ACPI_WMI_MODULE)
 
-- 
1.7.5.3.367.ga9930.dirty

