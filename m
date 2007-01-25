From: Corentin CHARY <corentincj@iksaif.net>
Subject: [patch 6/7] asus-laptop: add ledd support
Date: Thu, 25 Jan 2007 12:54:52 +0100
Message-ID: <200701251254.52843.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:35243 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092AbXAYLzD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Jan 2007 06:55:03 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

Ledd is a special led ... /sys/.../asus-laptop/ledd works like /proc/acpi/asus/ledd

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
 asus-laptop.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
---

diff -Naur a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
--- a/drivers/misc/asus-laptop.c	2007-01-21 15:35:37.000000000 +0100
+++ b/drivers/misc/asus-laptop.c	2007-01-21 15:38:44.000000000 +0100
@@ -104,6 +104,9 @@
 ASUS_HANDLE(rled_set, ASUS_HOTK_PREFIX "RLED"); /* W1JC */
 ASUS_HANDLE(pled_set, ASUS_HOTK_PREFIX "PLED"); /* A7J */
 
+/* LEDD */
+ASUS_HANDLE(ledd_set, ASUS_HOTK_PREFIX "SLCM");
+
 /* Bluetooth and WLAN
  * WLED and BLED are not handled like other XLED, because in some dsdt
  * they also control the WLAN/Bluetooth device.
@@ -151,6 +154,7 @@
 	struct acpi_device *device;	//the device we are in
 	acpi_handle handle;	//the handle of the hotk device
 	char status;		//status of the hotk, for LEDs, ...
+	u32 ledd_status;	//status of the LED display
 	u16 event_count[128];	//count for each event TODO make this better
 };
 
@@ -477,6 +481,30 @@
 }
 
 /*
+ * LEDD display
+ */
+static ssize_t show_ledd(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%08x\n", hotk->ledd_status);
+}
+
+static ssize_t store_ledd(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	int rv, value;
+
+	rv = parse_arg(buf, count, &value);
+	if (rv > 0) {
+		if (!write_acpi_int(ledd_set_handle, NULL, value, NULL))
+			printk(ASUS_WARNING "LED display write failed\n");
+		else
+			hotk->ledd_status = (u32) value;
+	}
+	return rv;
+}
+
+/*
  * WLAN
  */
 static ssize_t show_wlan(struct device *dev,
@@ -605,12 +633,14 @@
 static ASUS_CREATE_DEVICE_ATTR(wlan);
 static ASUS_CREATE_DEVICE_ATTR(bluetooth);
 static ASUS_CREATE_DEVICE_ATTR(display);
+static ASUS_CREATE_DEVICE_ATTR(ledd);
 
 static struct attribute *asuspf_attributes[] = {
         &dev_attr_infos.attr,
         &dev_attr_wlan.attr,
         &dev_attr_bluetooth.attr,
         &dev_attr_display.attr,
+        &dev_attr_ledd.attr,
         NULL
 };
 
@@ -644,6 +674,9 @@
 	else if(display_set_handle)
 		ASUS_SET_DEVICE_ATTR(display, 0200, NULL, store_disp);
 
+	if (ledd_set_handle)
+		ASUS_SET_DEVICE_ATTR(ledd, 0644, show_ledd, store_ledd);
+
 }
 
 static int asus_handle_init(char *name, acpi_handle *handle,
@@ -739,6 +772,8 @@
 	ASUS_HANDLE_INIT(rled_set);
 	ASUS_HANDLE_INIT(pled_set);
 
+	ASUS_HANDLE_INIT(ledd_set);
+
 	/*
 	 * The HWRS method return informations about the hardware.
 	 * 0x80 bit is for WLAN, 0x100 for Bluetooth.
@@ -833,6 +868,9 @@
 	/* LCD Backlight is on by default */
 	hotk->status |= LCD_ON;
 
+	/* LED display is off by default */
+	hotk->ledd_status = 0xFFF;
+
 	if(wl_switch_handle)
 		write_acpi_int(wl_switch_handle, NULL, 1, NULL);
 

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
