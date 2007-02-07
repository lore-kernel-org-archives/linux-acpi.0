From: Len Brown <lenb@kernel.org>
Subject: [PATCH 32/140] asus-laptop: add bluetooth and wlan support
Date: Wed,  7 Feb 2007 13:50:46 -0500
Message-ID: <1170874418134-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:45778 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422752AbXBGSxk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:40 -0500
In-Reply-To: <1170874417392-git-send-email-lenb@kernel.org>
Message-Id: <4564de172dcdce641c0d6c689e79e95b5f6bee2c.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

WLED and BLED are not handled like other leds (MLED, etc ..),
because sometime they also control the wlan/bluetooth device.
If the method for wireless_status is found, it's used to get the
status, otherwise hotk->status is used.  We also use the HWRS
method, which tell if the bluetooth/wlan device is present or not.
This patch show why we need a ASUS_SET_DEVICE_ATTR macro : if
there is a bluetooth device, /sys/dev.../asus-laptop/bluetooth
is usable, else it's not but it's clean.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |  115 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index d0d5ee9..222d4fb 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -56,8 +56,17 @@
 #define ASUS_HOTK_PREFIX        "\\_SB.ATKD."
 
 /*
+ * Known bits returned by \_SB.ATKD.HWRS
+ */
+#define WL_HWRS     0x80
+#define BT_HWRS     0x100
+
+/*
  * Flags for hotk status
+ * WL_ON and BT_ON are also used for wireless_status()
  */
+#define WL_ON       0x01	//internal Wifi
+#define BT_ON       0x02	//internal Bluetooth
 #define MLED_ON     0x04	//mail LED
 #define TLED_ON     0x08	//touchpad LED
 #define RLED_ON     0x10        //Record LED
@@ -84,6 +93,14 @@ ASUS_HANDLE(tled_set, ASUS_HOTK_PREFIX "TLED");
 ASUS_HANDLE(rled_set, ASUS_HOTK_PREFIX "RLED"); /* W1JC */
 ASUS_HANDLE(pled_set, ASUS_HOTK_PREFIX "PLED"); /* A7J */
 
+/* Bluetooth and WLAN
+ * WLED and BLED are not handled like other XLED, because in some dsdt
+ * they also control the WLAN/Bluetooth device.
+ */
+ASUS_HANDLE(wl_switch, ASUS_HOTK_PREFIX "WLED");
+ASUS_HANDLE(bt_switch, ASUS_HOTK_PREFIX "BLED");
+ASUS_HANDLE(wireless_status, ASUS_HOTK_PREFIX "RSTS"); /* All new models */
+
 /*
  * This is the main structure, we can use it to store anything interesting
  * about the hotk device
@@ -181,14 +198,32 @@ static int read_acpi_int(acpi_handle handle, const char *method, int *val,
 	return (status == AE_OK) && (out_obj.type == ACPI_TYPE_INTEGER);
 }
 
+static int read_wireless_status(int mask) {
+	int status;
+
+	if (!wireless_status_handle)
+		return (hotk->status & mask) ? 1 : 0;
+
+	if (read_acpi_int(wireless_status_handle, NULL, &status, NULL)) {
+		return (status & mask) ? 1 : 0;
+	} else
+		printk(ASUS_WARNING "Error reading Wireless status\n");
+
+	return (hotk->status & mask) ? 1 : 0;
+}
+
 /* Generic LED functions */
 static int read_status(int mask)
 {
+	/* There is a special method for both wireless devices */
+	if (mask == BT_ON || mask == WL_ON)
+		return read_wireless_status(mask);
+
 	return (hotk->status & mask) ? 1 : 0;
 }
 
 static void write_status(acpi_handle handle, int out, int mask,
-		      int invert)
+			 int invert)
 {
 	hotk->status = (out) ? (hotk->status | mask) : (hotk->status & ~mask);
 
@@ -292,6 +327,51 @@ static int parse_arg(const char *buf, unsigned long count, int *val)
 	return count;
 }
 
+static ssize_t store_status(const char *buf, size_t count,
+			    acpi_handle handle, int mask, int invert)
+{
+	int rv, value;
+	int out = 0;
+
+	rv = parse_arg(buf, count, &value);
+	if (rv > 0)
+		out = value ? 1 : 0;
+
+	write_status(handle, out, mask, invert);
+
+	return rv;
+}
+
+/*
+ * WLAN
+ */
+static ssize_t show_wlan(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", read_status(WL_ON));
+}
+
+static ssize_t store_wlan(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	return store_status(buf, count, wl_switch_handle, WL_ON, 0);
+}
+
+/*
+ * Bluetooth
+ */
+static ssize_t show_bluetooth(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", read_status(BT_ON));
+}
+
+static ssize_t store_bluetooth(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	return store_status(buf, count, bt_switch_handle, BT_ON, 0);
+}
+
 static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
 	/* TODO Find a better way to handle events count. */
@@ -322,9 +402,13 @@ static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 	} while(0)
 
 static ASUS_CREATE_DEVICE_ATTR(infos);
+static ASUS_CREATE_DEVICE_ATTR(wlan);
+static ASUS_CREATE_DEVICE_ATTR(bluetooth);
 
 static struct attribute *asuspf_attributes[] = {
         &dev_attr_infos.attr,
+        &dev_attr_wlan.attr,
+        &dev_attr_bluetooth.attr,
         NULL
 };
 
@@ -345,6 +429,13 @@ static struct platform_device *asuspf_device;
 static void asus_hotk_add_fs(void)
 {
 	ASUS_SET_DEVICE_ATTR(infos, 0444, show_infos, NULL);
+
+	if (wl_switch_handle)
+		ASUS_SET_DEVICE_ATTR(wlan, 0644, show_wlan, store_wlan);
+
+	if (bt_switch_handle)
+		ASUS_SET_DEVICE_ATTR(bluetooth, 0644,
+				     show_bluetooth, store_bluetooth);
 }
 
 static int asus_handle_init(char *name, acpi_handle *handle,
@@ -377,7 +468,7 @@ static int asus_hotk_get_info(void)
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_buffer dsdt = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *model = NULL;
-	int bsts_result;
+	int bsts_result, hwrs_result;
 	char *string = NULL;
 	acpi_status status;
 
@@ -440,6 +531,22 @@ static int asus_hotk_get_info(void)
 	ASUS_HANDLE_INIT(rled_set);
 	ASUS_HANDLE_INIT(pled_set);
 
+	/*
+	 * The HWRS method return informations about the hardware.
+	 * 0x80 bit is for WLAN, 0x100 for Bluetooth.
+	 * The significance of others is yet to be found.
+	 * If we don't find the method, we assume the device are present.
+	 */
+	if (!read_acpi_int(hotk->handle, "HRWS", &hwrs_result, NULL))
+		hwrs_result = WL_HWRS | BT_HWRS;
+
+	if(hwrs_result & WL_HWRS)
+		ASUS_HANDLE_INIT(wl_switch);
+	if(hwrs_result & BT_HWRS)
+		ASUS_HANDLE_INIT(bt_switch);
+
+	ASUS_HANDLE_INIT(wireless_status);
+
 	kfree(model);
 
 	return AE_OK;
@@ -504,6 +611,10 @@ static int asus_hotk_add(struct acpi_device *device)
 
 	asus_hotk_found = 1;
 
+	/* WLED and BLED are on by  default */
+	write_status(bt_switch_handle, 1, BT_ON, 0);
+	write_status(wl_switch_handle, 1, WL_ON, 0);
+
       end:
 	if (result) {
 		kfree(hotk->name);
-- 
1.5.0.rc3.39.gec804
