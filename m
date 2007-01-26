From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [patch 6/7] asus-laptop: add ledd support
Date: Fri, 26 Jan 2007 14:04:55 +0100
Message-ID: <200701261404.55363.corentincj@iksaif.net>
References: <200701251254.52843.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:36663 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965649AbXAZNFA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Jan 2007 08:05:00 -0500
In-Reply-To: <200701251254.52843.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

From: Corentin Chary <corentincj@iksaif.net>

Ledd is a special led ... /sys/.../asus-laptop/ledd works like
/proc/acpi/asus/ledd

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/misc/asus-laptop.c |   38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff -Naur a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
--- a/drivers/misc/asus-laptop.c	2007-01-26 13:02:37.000000000 +0100
+++ b/drivers/misc/asus-laptop.c	2007-01-26 13:03:15.000000000 +0100
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
 
@@ -479,6 +483,30 @@
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
@@ -607,12 +635,14 @@
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
 
@@ -646,6 +676,9 @@
 	else if(display_set_handle)
 		ASUS_SET_DEVICE_ATTR(display, 0200, NULL, store_disp);
 
+	if (ledd_set_handle)
+		ASUS_SET_DEVICE_ATTR(ledd, 0644, show_ledd, store_ledd);
+
 }
 
 static int asus_handle_init(char *name, acpi_handle *handle,
@@ -741,6 +774,8 @@
 	ASUS_HANDLE_INIT(rled_set);
 	ASUS_HANDLE_INIT(pled_set);
 
+	ASUS_HANDLE_INIT(ledd_set);
+
 	/*
 	 * The HWRS method return informations about the hardware.
 	 * 0x80 bit is for WLAN, 0x100 for Bluetooth.
@@ -836,6 +871,9 @@
 	/* LCD Backlight is on by default */
 	write_status(NULL, 1, LCD_ON, 0);
 
+ 	/* LED display is off by default */
+ 	hotk->ledd_status = 0xFFF;
+
       end:
 	if (result) {
 		kfree(hotk->name);
