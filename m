From: Corentin CHARY <corentincj@iksaif.net>
Subject: [patch 3/7] asus-laptop: add bluetooth and wlan support
Date: Thu, 25 Jan 2007 12:54:46 +0100
Message-ID: <200701251254.46132.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:35192 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932846AbXAYLyx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Jan 2007 06:54:53 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

WLED and BLED are not handled like other leds (MLED, etc ..), because sometime
they also control the wlan/bluetooth device.
If the method for wireless_status is found, it's used to get the status, otherwise hotk->status
is used.
We also use the HWRS method, which tell if the bluetooth/wlan device is present or not.
This patch show why we need a ASUS_SET_DEVICE_ATTR macro : if there is a bluetooth device,
/sys/dev.../asus-laptop/bluetooth is usable, else it's not but it's clean.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
 asus-laptop.c |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 1 deletion(-)
---

diff -Naur a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
--- a/drivers/misc/asus-laptop.c	2007-01-21 15:29:27.000000000 +0100
+++ b/drivers/misc/asus-laptop.c	2007-01-21 15:29:02.000000000 +0100
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
@@ -84,6 +93,14 @@
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
@@ -181,9 +198,26 @@
 	return (status == AE_OK) && (out_obj.type == ACPI_TYPE_INTEGER);
 }
 
+static int read_wireless_status(int ledmask) {
+	int led_status;
+
+	if (read_acpi_int(wireless_status_handle, NULL, &led_status, NULL)) {
+		return (led_status & ledmask) ? 1 : 0;
+	} else
+		printk(ASUS_WARNING "Error reading Wireless status\n");
+
+	return (hotk->status & ledmask) ? 1 : 0;
+}
+
 /* Generic LED functions */
 static int read_led(int ledmask)
 {
+	/* There is a special method for both wireless devices */
+	if ((ledmask == BT_ON || ledmask == WL_ON) &&
+	    wireless_status_handle) {
+		return read_wireless_status(ledmask);
+	}
+
 	return (hotk->status & ledmask) ? 1 : 0;
 }
 
@@ -293,6 +327,51 @@
 	return count;
 }
 
+static ssize_t store_led(const char *buf, size_t count,
+			 acpi_handle led_handle, int ledmask, int invert)
+{
+	int rv, value;
+	int led_out = 0;
+
+	rv = parse_arg(buf, count, &value);
+	if (rv > 0)
+		led_out = value ? 1 : 0;
+
+	write_led(led_handle, led_out, ledmask, invert);
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
+	return sprintf(buf, "%d\n", read_led(WL_ON));
+}
+
+static ssize_t store_wlan(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	return store_led(buf, count, wl_switch_handle, WL_ON, 0);
+}
+
+/*
+ * Bluetooth
+ */
+static ssize_t show_bluetooth(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", read_led(BT_ON));
+}
+
+static ssize_t store_bluetooth(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	return store_led(buf, count, bt_switch_handle, BT_ON, 0);
+}
+
 static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
 	/* TODO Find a better way to handle events count. */
@@ -323,9 +402,13 @@
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
 
@@ -346,6 +429,13 @@
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
@@ -378,7 +468,7 @@
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_buffer dsdt = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *model = NULL;
-	int bsts_result;
+	int bsts_result, hwrs_result;
 	char *string = NULL;
 	acpi_status status;
 
@@ -441,6 +531,22 @@
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
+	if(hwrs_result | WL_HWRS)
+		ASUS_HANDLE_INIT(wl_switch);
+	if(hwrs_result | BT_HWRS)
+		ASUS_HANDLE_INIT(bt_switch);
+
+	ASUS_HANDLE_INIT(wireless_status);
+
 	kfree(model);
 
 	return AE_OK;
@@ -505,6 +611,15 @@
 
 	asus_hotk_found = 1;
 
+	/* WLED and BLED are on by  default */
+	hotk->status |= WL_ON | BT_ON;
+
+	if(wl_switch_handle)
+		write_acpi_int(wl_switch_handle, NULL, 1, NULL);
+
+	if(bt_switch_handle)
+		write_acpi_int(bt_switch_handle, NULL, 1, NULL);
+
       end:
 	if (result) {
 		kfree(hotk->name);

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
