From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [patch 7/7] asus-laptop: add  light sensor support
Date: Fri, 26 Jan 2007 14:04:58 +0100
Message-ID: <200701261404.58597.corentincj@iksaif.net>
References: <200701251254.59337.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:36665 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965650AbXAZNFA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Jan 2007 08:05:00 -0500
In-Reply-To: <200701251254.59337.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

From: Corentin Chary <corentincj@iksaif.net>

/proc/acpi/asus/lslvl is now /sys/.../asus-laptop/ls_level
/proc/acpi/asus/lssw is now /sys/.../asus-laptop/ls_switch nothing
else ..

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/misc/asus-laptop.c |   84 +++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff -Naur a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
--- a/drivers/misc/asus-laptop.c	2007-01-26 13:05:53.000000000 +0100
+++ b/drivers/misc/asus-laptop.c	2007-01-26 13:04:54.000000000 +0100
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
 
@@ -590,6 +595,62 @@
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
@@ -636,6 +697,8 @@
 static ASUS_CREATE_DEVICE_ATTR(bluetooth);
 static ASUS_CREATE_DEVICE_ATTR(display);
 static ASUS_CREATE_DEVICE_ATTR(ledd);
+static ASUS_CREATE_DEVICE_ATTR(ls_switch);
+static ASUS_CREATE_DEVICE_ATTR(ls_level);
 
 static struct attribute *asuspf_attributes[] = {
         &dev_attr_infos.attr,
@@ -643,6 +706,8 @@
         &dev_attr_bluetooth.attr,
         &dev_attr_display.attr,
         &dev_attr_ledd.attr,
+        &dev_attr_ls_switch.attr,
+        &dev_attr_ls_level.attr,
         NULL
 };
 
@@ -679,6 +744,10 @@
 	if (ledd_set_handle)
 		ASUS_SET_DEVICE_ATTR(ledd, 0644, show_ledd, store_ledd);
 
+	if (ls_switch_handle && ls_level_handle) {
+		ASUS_SET_DEVICE_ATTR(ls_level, 0644, show_lslvl, store_lslvl);
+		ASUS_SET_DEVICE_ATTR(ls_switch, 0644, show_lssw, store_lssw);
+	}
 }
 
 static int asus_handle_init(char *name, acpi_handle *handle,
@@ -800,6 +869,11 @@
 	ASUS_HANDLE_INIT(display_set);
 	ASUS_HANDLE_INIT(display_get);
 
+	/* There is a lot of models with "ALSL", but a few get
+	   a real light sens, so we need to check it. */
+	if(ASUS_HANDLE_INIT(ls_switch))
+		ASUS_HANDLE_INIT(ls_level);
+
 	kfree(model);
 
 	return AE_OK;
@@ -874,6 +948,16 @@
  	/* LED display is off by default */
  	hotk->ledd_status = 0xFFF;
 
+ 	/* Set initial values of light sensor and level */
+ 	hotk->light_switch = 1; /* Default to light sensor disabled */
+ 	hotk->light_level = 0; /* level 5 for sensor sensitivity */
+
+ 	if (ls_switch_handle)
+ 		set_light_sens_switch(hotk->light_switch);
+
+ 	if (ls_level_handle)
+ 		set_light_sens_level(hotk->light_level);
+
       end:
 	if (result) {
 		kfree(hotk->name);
