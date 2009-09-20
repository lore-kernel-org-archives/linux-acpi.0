From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 5/6] thinkpad-acpi: add internal hotkey event API
Date: Sun, 20 Sep 2009 14:09:26 -0300
Message-ID: <1253466567-4285-6-git-send-email-hmh@hmh.eng.br>
References: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44188 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754693AbZITRJ5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Sep 2009 13:09:57 -0400
In-Reply-To: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add an internal API to the driver, to allow subdrivers to request and
receive HKEY 0x1000 events.  This API will be used by the backlight
(brightness up/down) and upcoming ALSA mixer (volume up/down/mute)
subdrivers.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   48 ++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 50aa4c1..ffd584c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2014,6 +2014,9 @@ static u16 *hotkey_keycode_map;
 
 static struct attribute_set *hotkey_dev_attributes;
 
+static void tpacpi_driver_event(const unsigned int hkey_event);
+static void hotkey_driver_event(const unsigned int scancode);
+
 /* HKEY.MHKG() return bits */
 #define TP_HOTKEY_TABLET_MASK (1 << 3)
 
@@ -2168,6 +2171,35 @@ static int hotkey_user_mask_set(const u32 mask)
 	return rc;
 }
 
+/*
+ * Sets the driver hotkey mask.
+ *
+ * Can be called even if the hotkey subdriver is inactive
+ */
+static int tpacpi_hotkey_driver_mask_set(const u32 mask)
+{
+	int rc;
+
+	/* Do the right thing if hotkey_init has not been called yet */
+	if (!tp_features.hotkey) {
+		hotkey_driver_mask = mask;
+		return 0;
+	}
+
+	mutex_lock(&hotkey_mutex);
+
+	HOTKEY_CONFIG_CRITICAL_START
+	hotkey_driver_mask = mask;
+	hotkey_source_mask |= (mask & ~hotkey_all_mask);
+	HOTKEY_CONFIG_CRITICAL_END
+
+	rc = hotkey_mask_set((hotkey_acpi_mask | hotkey_driver_mask) &
+							~hotkey_source_mask);
+	mutex_unlock(&hotkey_mutex);
+
+	return rc;
+}
+
 static int hotkey_status_get(int *status)
 {
 	if (!acpi_evalf(hkey_handle, status, "DHKC", "d"))
@@ -2227,6 +2259,7 @@ static void tpacpi_input_send_key(const unsigned int scancode)
 /* Do NOT call without validating scancode first */
 static void tpacpi_input_send_key_masked(const unsigned int scancode)
 {
+	hotkey_driver_event(scancode);
 	if (hotkey_user_mask & (1 << scancode))
 		tpacpi_input_send_key(scancode);
 }
@@ -7625,6 +7658,21 @@ static struct ibm_struct fan_driver_data = {
  ****************************************************************************
  ****************************************************************************/
 
+/*
+ * HKEY event callout for other subdrivers go here
+ * (yes, it is ugly, but it is quick, safe, and gets the job done
+ */
+static void tpacpi_driver_event(const unsigned int hkey_event)
+{
+}
+
+
+
+static void hotkey_driver_event(const unsigned int scancode)
+{
+	tpacpi_driver_event(0x1001 + scancode);
+}
+
 /* sysfs name ---------------------------------------------------------- */
 static ssize_t thinkpad_acpi_pdev_name_show(struct device *dev,
 			   struct device_attribute *attr,
-- 
1.6.3.3

