From: Corentin CHARY <corentincj@iksaif.net>
Subject: [patch 7/7] asus-laptop: add  light sensor support
Date: Thu, 25 Jan 2007 12:54:59 +0100
Message-ID: <200701251254.59337.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:35246 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109AbXAYLzF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Jan 2007 06:55:05 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

/proc/acpi/asus/lslvl is now /sys/.../asus-laptop/ls_level
/proc/acpi/asus/lssw is now /sys/.../asus-laptop/ls_switch
nothing else ..

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
 asus-laptop.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 4 deletions(-)
---

diff -Naur a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
--- a/drivers/misc/asus-laptop.c	2007-01-21 15:39:24.000000000 +0100
+++ b/drivers/misc/asus-laptop.c	2007-01-21 15:44:54.000000000 +0100
@@ -145,6 +145,9 @@
 	    "\\INFB", /* A2H D1 L2D L3D L3H L2E L5D L5C M1A M2E L4L W3V */
 	    "\\SSTE"); /* A3F A6F A3N A3L M6N W3N W6A */
 
+ASUS_HANDLE(ls_switch, ASUS_HOTK_PREFIX "ALSC"); /* Z71A Z71V */
+ASUS_HANDLE(ls_level, ASUS_HOTK_PREFIX "ALSL"); /* Z71A Z71V */
+
 /*
  * This is the main structure, we can use it to store anything interesting
  * about the hotk device
@@ -155,6 +158,8 @@
 	acpi_handle handle;	//the handle of the hotk device
 	char status;		//status of the hotk, for LEDs, ...
 	u32 ledd_status;	//status of the LED display
+	u8 light_level;    //light sensor level
+	u8 light_switch;    //light sensor switch value
 	u16 event_count[128];	//count for each event TODO make this better
 };
 
@@ -588,6 +593,62 @@
 	return rv;
 }
 
+/*
+ * Light Sens
+ */
+static void set_light_sens_switch(int value)
+{
+	if (!write_acpi_int(ls_switch_handle, NULL, value, NULL))
+		printk(ASUS_WARNING "Error setting light sensor switch\n");
+	hotk->light_switch = value;
+}
+
+static ssize_t show_lssw(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", hotk->light_switch);
+}
+
+static ssize_t store_lssw(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	int rv, value;
+
+	rv = parse_arg(buf, count, &value);
+	if (rv > 0)
+		set_light_sens_switch(value ? 1 : 0);
+
+	return rv;
+}
+
+static void set_light_sens_level(int value)
+{
+	if (!write_acpi_int(ls_level_handle, NULL, value, NULL))
+		printk(ASUS_WARNING "Error setting light sensor level\n");
+	hotk->light_level = value;
+}
+
+static ssize_t show_lslvl(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", hotk->light_level);
+}
+
+static ssize_t store_lslvl(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	int rv, value;
+
+	rv = parse_arg(buf, count, &value);
+	if (rv > 0) {
+		value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
+		/* 0 <= value <= 15 */
+		set_light_sens_level(value);
+	}
+
+	return rv;
+}
+
 static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
 	/* TODO Find a better way to handle events count. */
@@ -634,6 +695,8 @@
 static ASUS_CREATE_DEVICE_ATTR(bluetooth);
 static ASUS_CREATE_DEVICE_ATTR(display);
 static ASUS_CREATE_DEVICE_ATTR(ledd);
+static ASUS_CREATE_DEVICE_ATTR(ls_switch);
+static ASUS_CREATE_DEVICE_ATTR(ls_level);
 
 static struct attribute *asuspf_attributes[] = {
         &dev_attr_infos.attr,
@@ -641,6 +704,8 @@
         &dev_attr_bluetooth.attr,
         &dev_attr_display.attr,
         &dev_attr_ledd.attr,
+        &dev_attr_ls_switch.attr,
+        &dev_attr_ls_level.attr,
         NULL
 };
 
@@ -677,6 +742,10 @@
 	if (ledd_set_handle)
 		ASUS_SET_DEVICE_ATTR(ledd, 0644, show_ledd, store_ledd);
 
+	if (ls_switch_handle && ls_level_handle) {
+		ASUS_SET_DEVICE_ATTR(ls_level, 0644, show_lslvl, store_lslvl);
+		ASUS_SET_DEVICE_ATTR(ls_switch, 0644, show_lssw, store_lssw);
+	}
 }
 
 static int asus_handle_init(char *name, acpi_handle *handle,
@@ -798,6 +867,11 @@
 	ASUS_HANDLE_INIT(display_set);
 	ASUS_HANDLE_INIT(display_get);
 
+	/* There is a lot of models with "ALSL", but a few get
+	   a real light sens, so we need to check it. */
+	if(ASUS_HANDLE_INIT(ls_switch))
+		ASUS_HANDLE_INIT(ls_level);
+
 	kfree(model);
 
 	return AE_OK;
@@ -865,17 +939,27 @@
 	/* WLED and BLED are on by default */
 	hotk->status |= WL_ON | BT_ON;
 
+	if(wl_switch_handle)
+		write_acpi_int(wl_switch_handle, NULL, 1, NULL);
+
+	if(bt_switch_handle)
+		write_acpi_int(bt_switch_handle, NULL, 1, NULL);
+
 	/* LCD Backlight is on by default */
 	hotk->status |= LCD_ON;
 
 	/* LED display is off by default */
 	hotk->ledd_status = 0xFFF;
 
-	if(wl_switch_handle)
-		write_acpi_int(wl_switch_handle, NULL, 1, NULL);
+	/* Set initial values of light sensor and level */
+	hotk->light_switch = 1; /* Default to light sensor disabled */
+	hotk->light_level = 0; /* level 5 for sensor sensitivity */
 
-	if(bt_switch_handle)
-		write_acpi_int(bt_switch_handle, NULL, 1, NULL);
+	if (ls_switch_handle)
+		set_light_sens_switch(hotk->light_switch);
+
+	if (ls_level_handle)
+		set_light_sens_level(hotk->light_level);
 
       end:
 	if (result) {

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
