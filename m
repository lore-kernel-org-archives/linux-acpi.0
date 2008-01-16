From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 2/2] asus-laptop add kill switch support
Date: Wed, 16 Jan 2008 16:57:50 +0100
Message-ID: <200801161657.50967.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:49144 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974AbYAPQAN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2008 11:00:13 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org
Cc: Fabien Crespel <fabien@crespel.net>

From: Corentin CHARY <corentincj@iksaif.net>

Note: All this work have been done by Fabien Crespel and the original
      patch was from him. Thks again ;).

The latest asus-laptop driver (version 0.42 from kernel version
2.6.22.13) is missing support for the "Kill Switch" of some laptops.
When you turn the Kill Switch ON, the LEDs are still on, while they should 
turn off and come back only when I turn the switch OFF again.

Basically:
- there is now a killswitch file in /sys/devices/platform/asus-laptop/
to report the KS status (read from HWRS)
- when the KS is turned ON, the LEDs are turned OFF, when it's turned
OFF, the previous status is restored
- when the KS is ON, the WLAN and BT status is read from and written to
the INTERNAL driver status (hotk->status) only, to avoid re-enabling the
LEDs. This is also useful to read the "previous status" of WLAN and BT,
and possibly to change it before disabling the Kill Switch. For example,
if WLAN is ON when I turn the KS ON, I can decide to turn it OFF and
enable BT only by writing into the corresponding sysfs files. Then I
turn the KS OFF, and only BT turns on :p
- during driver initialization, instead of always turning WLAN and BT
ON, the current status is read with read_wireless_status and written
immediately. This means that for the first initialization, the previous
status is restored (for example if I had WLAN ON / BT OFF in Windows, it
will be restored when Linux boots).

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus-laptop.c |  212 ++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 176 insertions(+), 36 deletions(-)

--- a/drivers/misc/asus-laptop.c	2008-01-15 23:22:19.000000000 +0100
+++ b/drivers/misc/asus-laptop.c	2008-01-15 23:23:00.000000000 +0100
@@ -31,6 +31,7 @@
  *  Josh Green     - Light Sens support
  *  Thomas Tuttle  - His first patch for led support was very helpfull
  *  Sam Lin        - GPS support
+ *  Fabien Crespel - Kill Switch support
  */
 
 #include <linux/autoconf.h>
@@ -59,16 +60,25 @@
 /*
  * Some events we use, same for all Asus
  */
-#define ATKD_BR_UP       0x10
-#define ATKD_BR_DOWN     0x20
-#define ATKD_LCD_ON      0x33
-#define ATKD_LCD_OFF     0x34
+#define ATKD_BR_UP       0x10	// Brightness Up base value
+#define ATKD_BR_DOWN     0x20	// Brightness Down base value
+#define ATKD_LCD_ON      0x33	// LCD Display ON
+#define ATKD_LCD_OFF     0x34	// LCD Display OFF
+#define ATKD_WL_TOGGLE   0x5D	// WLAN Toggle
+#define ATKD_WL_ON       0x5E	// WLAN ON notification
+#define ATKD_WL_OFF      0x5F	// WLAN OFF notification
+#define ATKD_BT_ON       0x7D	// Bluetooth ON notification
+#define ATKD_BT_OFF      0x7E	// Bluetooth OFF notification
+#define ATKD_KS_ON       0x81	// Kill Switch ON
+#define ATKD_KS_OFF      0x80	// Kill Switch OFF
 
 /*
  * Known bits returned by \_SB.ATKD.HWRS
  */
-#define WL_HWRS     0x80
-#define BT_HWRS     0x100
+#define RF_HWRS     0x01	// Radio Frequency enabled
+#define KS_HWRS     0x02	// Kill Switch present
+#define WL_HWRS     0x80	// Wifi adapter present
+#define BT_HWRS     0x100	// Bluetooth adapter present
 
 /*
  * Flags for hotk status
@@ -95,14 +105,23 @@
 MODULE_DESCRIPTION(ASUS_HOTK_NAME);
 MODULE_LICENSE("GPL");
 
-/* WAPF defines the behavior of the Fn+Fx wlan key
- * The significance of values is yet to be found, but
- * most of the time:
- * 0x0 will do nothing
+/* WAPF defines the behavior of the Fn+Fx wireless switch key.
+ * The significance of values is yet to be found, but most of the time:
+ *
+ * 0x0 will do nothing or give all control to hardware.
+ *
  * 0x1 will allow to control the device with Fn+Fx key.
+ *     When a Kill Switch is used, hardware will handle the Bluetooth device.
+ *     For both, software intervention might be needed to handle WLAN correctly.
+ *
  * 0x4 will send an ACPI event (0x88) while pressing the Fn+Fx key
- * 0x5 like 0x1 or 0x4
+ *     and when the Kill Switch is toggled (0x80 and 0x81).
+ *     This is a software-only mode, this driver only handles the Kill Switch.
+ * 
+ * 0x5 like 0x1 or 0x4, but on most models 0x4 has the priority.
+ *
  * So, if something doesn't work as you want, just try other values =)
+ * Note that some models (like F3JC) are only meant to be used with 0x4.
  */
 static uint wapf = 1;
 module_param(wapf, uint, 0644);
@@ -129,6 +148,7 @@
 ASUS_HANDLE(wl_switch, ASUS_HOTK_PREFIX "WLED");
 ASUS_HANDLE(bt_switch, ASUS_HOTK_PREFIX "BLED");
 ASUS_HANDLE(wireless_status, ASUS_HOTK_PREFIX "RSTS");	/* All new models */
+ASUS_HANDLE(hwrs, ASUS_HOTK_PREFIX "HWRS"); /* Hardware information */
 
 /* Brightness */
 ASUS_HANDLE(brightness_set, ASUS_HOTK_PREFIX "SPLV");
@@ -176,7 +196,7 @@
 	char *name;		//laptop name
 	struct acpi_device *device;	//the device we are in
 	acpi_handle handle;	//the handle of the hotk device
-	char status;		//status of the hotk, for LEDs, ...
+	u16 status;		//status of the hotk, for LEDs, ...
 	u32 ledd_status;	//status of the LED display
 	u8 light_level;		//light sensor level
 	u8 light_switch;	//light sensor switch value
@@ -310,14 +330,47 @@
 	return (hotk->status & GPS_ON) ? 1 : 0;
 }
 
-/* Generic LED functions */
+/*
+ * The HWRS method returns information about the hardware.
+ * 0x80 bit is for WLAN, 0x100 for Bluetooth.
+ * 0x02 means there is a physical Kill Switch on the laptop.
+ * When it is present, 0x01 means Radio Frequency is ON (i.e. KS is OFF)
+ * The significance of others is yet to be found.
+ * If we don't find the method, we assume WLAN and BT are present.
+ * -- Note: 0x400 seems to always come with 0x02 ..?
+ */
+static int read_hwrs(void)
+{
+	ulong status;
+	acpi_status rv = AE_OK;
+	
+	if (!hwrs_handle)
+		return WL_HWRS | BT_HWRS;
+
+	rv = acpi_evaluate_integer(hwrs_handle, NULL, NULL, &status);
+	if (ACPI_FAILURE(rv)) {
+		printk(ASUS_WARNING "Error reading HWRS\n");
+		return WL_HWRS | BT_HWRS;
+	}
+	
+	return status;
+}
+
+static int read_killswitch_status(void)
+{
+	ulong status = read_hwrs();
+	return (status & KS_HWRS && !(status & RF_HWRS));
+}
+
+/* Generic status handling functions (for LEDs and other features) */
 static int read_status(int mask)
 {
-	/* There is a special method for both wireless devices */
-	if (mask == BT_ON || mask == WL_ON)
-		return read_wireless_status(mask);
-	else if (mask == GPS_ON)
-		return read_gps_status();
+	/* There is a special method for both wireless devices + GPS */
+	/* When a Kill Switch is ON, read internal value (= previous status) */
+	if ((mask == BT_ON || mask == WL_ON) && !read_killswitch_status())
+ 		return read_wireless_status(mask);
+ 	else if (mask == GPS_ON)
+ 		return read_gps_status();
 
 	return (hotk->status & mask) ? 1 : 0;
 }
@@ -327,6 +380,11 @@
 	hotk->status = (out) ? (hotk->status | mask) : (hotk->status & ~mask);
 
 	switch (mask) {
+	case WL_ON:
+	case BT_ON:
+		/* Don't change the LED if the Kill Switch is ON */
+		if (handle && read_killswitch_status()) return;
+		break;
 	case MLED_ON:
 		out = !out & 0x1;
 		break;
@@ -719,7 +777,19 @@
 {
 	return store_status(buf, count, NULL, GPS_ON);
 }
+ 
+/*
+ * Kill Switch
+ */
+static ssize_t show_killswitch(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", read_killswitch_status());
+}
 
+/*
+ * Notify Handler
+ */
 static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
 	/* TODO Find a better way to handle events count. */
@@ -737,9 +807,78 @@
 		write_status(NULL, 0, LCD_ON);
 		lcd_blank(FB_BLANK_POWERDOWN);
 	}
+	
+	/*
+	 * Kill Switch ON/OFF events
+	 *
+	 * Enable/disable WLAN and BT depending on Kill Switch status.
+	 * Only works with models that send 0x80 and 0x81 when KS is changed.
+	 * Some models only send this event with WAPF = 0x04.
+	 */
+	if (event == ATKD_KS_ON) {
+
+		if (write_acpi_int(wl_switch_handle, NULL, 0, NULL))
+			printk(ASUS_WARNING "KS ON: failed to disable WLAN\n");
+
+		if (write_acpi_int(bt_switch_handle, NULL, 0, NULL))
+			printk(ASUS_WARNING "KS ON: failed to disable BT\n");
+
+	} else if (event == ATKD_KS_OFF) {
+		int status;
 
+		status = hotk->status & WL_ON ? 1 : 0;
+		if (write_acpi_int(wl_switch_handle, NULL, status, NULL))
+			printk(ASUS_WARNING "KS OFF: failed to restore WLAN\n");
+
+		status = hotk->status & BT_ON ? 1 : 0;
+		if (write_acpi_int(bt_switch_handle, NULL, status, NULL))
+			printk(ASUS_WARNING "KS OFF: failed to restore BT\n");
+	}
+	
+	/*
+	 * WLAN Toggle event
+	 *
+	 * Toggle the WLAN status & LED.
+	 * This may be sent by the Fn+Fx key, or by the Kill Switch.
+	 * It must ALWAYS set the LED, even if the KS is ON.
+	 * Should only happen with WAPF = 0x01
+	 */
+	if (event == ATKD_WL_TOGGLE && wl_switch_handle) {
+		int status;
+		int mask = 0;
+
+		status = read_wireless_status(WL_ON) ? 0 : 1;
+		if (!read_killswitch_status())
+			mask = WL_ON;
+		/* 
+		 * If KS is ON, only toggle the LED
+		 * else Toggle both the LED and internal status
+		 */
+		write_status(wl_switch_handle, status, mask);
+	}
+	
+	/*
+	 * WLAN and BT status events
+	 *
+	 * These events are only sent for notification and information purposes.
+	 * The hardware should have updated the LEDs on its own.
+	 * Here we use them to update the internal status, so that we always
+	 * have an accurate 'previous status' to report through sysfs files
+	 * when the Kill Switch is ON.
+	 * Should only happen with WAPF = 0x01 or 0x00
+	 */
+	if (!read_killswitch_status()) {
+		if (event == ATKD_WL_ON)
+			write_status(NULL, 1, WL_ON);
+		else if (event == ATKD_WL_OFF)
+			write_status(NULL, 0, WL_ON);
+		else if (event == ATKD_BT_ON)
+			write_status(NULL, 1, BT_ON);
+		else if (event == ATKD_BT_OFF)
+			write_status(NULL, 0, BT_ON);
+	}
 	acpi_bus_generate_proc_event(hotk->device, event,
-				hotk->event_count[event % 128]++);
+				     hotk->event_count[event % 128]++);
 
 	return;
 }
@@ -768,6 +907,7 @@
 static ASUS_CREATE_DEVICE_ATTR(ls_switch);
 static ASUS_CREATE_DEVICE_ATTR(ls_level);
 static ASUS_CREATE_DEVICE_ATTR(gps);
+static ASUS_CREATE_DEVICE_ATTR(killswitch);
 
 static struct attribute *asuspf_attributes[] = {
 	&dev_attr_infos.attr,
@@ -778,6 +918,7 @@
 	&dev_attr_ls_switch.attr,
 	&dev_attr_ls_level.attr,
 	&dev_attr_gps.attr,
+ 	&dev_attr_killswitch.attr,
 	NULL
 };
 
@@ -820,6 +961,9 @@
 
 	if (gps_status_handle && gps_on_handle && gps_off_handle)
 		ASUS_SET_DEVICE_ATTR(gps, 0644, show_gps, store_gps);
+
+	if (read_hwrs() & KS_HWRS)
+		ASUS_SET_DEVICE_ATTR(killswitch, 0444, show_killswitch, NULL);
 }
 
 static int asus_handle_init(char *name, acpi_handle * handle,
@@ -919,16 +1063,8 @@
 
 	ASUS_HANDLE_INIT(ledd_set);
 
-	/*
-	 * The HWRS method return informations about the hardware.
-	 * 0x80 bit is for WLAN, 0x100 for Bluetooth.
-	 * The significance of others is yet to be found.
-	 * If we don't find the method, we assume the device are present.
-	 */
-	status =
-	    acpi_evaluate_integer(hotk->handle, "HRWS", NULL, &hwrs_result);
-	if (ACPI_FAILURE(status))
-		hwrs_result = WL_HWRS | BT_HWRS;
+	ASUS_HANDLE_INIT(hwrs);
+	hwrs_result = read_hwrs();
 
 	if (hwrs_result & WL_HWRS)
 		ASUS_HANDLE_INIT(wl_switch);
@@ -1017,13 +1153,17 @@
 
 	asus_hotk_found = 1;
 
-	/* WLED and BLED are on by default */
-	write_status(bt_switch_handle, 1, BT_ON);
-	write_status(wl_switch_handle, 1, WL_ON);
-
-	/* If the h/w switch is off, we need to check the real status */
-	write_status(NULL, read_status(BT_ON), BT_ON);
-	write_status(NULL, read_status(WL_ON), WL_ON);
+	/* Initialize WLAN and Bluetooth with current hardware value */
+	write_status(bt_switch_handle, read_wireless_status(BT_ON), BT_ON);
+	write_status(wl_switch_handle, read_wireless_status(WL_ON), WL_ON);
+	
+	/* Make sure to turn off the LEDs if Kill Switch is ON */
+	if (read_killswitch_status()) {
+		if (write_acpi_int(wl_switch_handle, NULL, 0, NULL))
+			printk(ASUS_WARNING "KS ON: failed to disable WLAN\n");
+		if (write_acpi_int(bt_switch_handle, NULL, 0, NULL))
+			printk(ASUS_WARNING "KS ON: failed to disable BT\n");
+	}
 
 	/* LCD Backlight is on by default */
 	write_status(NULL, 1, LCD_ON);
