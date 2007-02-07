From: Len Brown <lenb@kernel.org>
Subject: [PATCH 36/140] asus-laptop: add light sensor support
Date: Wed,  7 Feb 2007 13:50:50 -0500
Message-ID: <1170874422581-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:32267 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422757AbXBGSxy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:54 -0500
In-Reply-To: <1170874421658-git-send-email-lenb@kernel.org>
Message-Id: <8b857353237c144113b9bbbf9e0236b3f0e7d315.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

/proc/acpi/asus/lslvl is now /sys/.../asus-laptop/ls_level
/proc/acpi/asus/lssw is now /sys/.../asus-laptop/ls_switch nothing
else ..

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |   84 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index bd963c6..6f72cd5 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -145,6 +145,9 @@ ASUS_HANDLE(display_get,
 	    "\\INFB", /* A2H D1 L2D L3D L3H L2E L5D L5C M1A M2E L4L W3V */
 	    "\\SSTE"); /* A3F A6F A3N A3L M6N W3N W6A */
 
+ASUS_HANDLE(ls_switch, ASUS_HOTK_PREFIX "ALSC"); /* Z71A Z71V */
+ASUS_HANDLE(ls_level, ASUS_HOTK_PREFIX "ALSL"); /* Z71A Z71V */
+
 /*
  * This is the main structure, we can use it to store anything interesting
  * about the hotk device
@@ -155,6 +158,8 @@ struct asus_hotk {
 	acpi_handle handle;	//the handle of the hotk device
 	char status;		//status of the hotk, for LEDs, ...
 	u32 ledd_status;	//status of the LED display
+	u8 light_level;    //light sensor level
+	u8 light_switch;    //light sensor switch value
 	u16 event_count[128];	//count for each event TODO make this better
 };
 
@@ -590,6 +595,62 @@ static ssize_t store_disp(struct device *dev, struct device_attribute *attr,
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
@@ -636,6 +697,8 @@ static ASUS_CREATE_DEVICE_ATTR(wlan);
 static ASUS_CREATE_DEVICE_ATTR(bluetooth);
 static ASUS_CREATE_DEVICE_ATTR(display);
 static ASUS_CREATE_DEVICE_ATTR(ledd);
+static ASUS_CREATE_DEVICE_ATTR(ls_switch);
+static ASUS_CREATE_DEVICE_ATTR(ls_level);
 
 static struct attribute *asuspf_attributes[] = {
         &dev_attr_infos.attr,
@@ -643,6 +706,8 @@ static struct attribute *asuspf_attributes[] = {
         &dev_attr_bluetooth.attr,
         &dev_attr_display.attr,
         &dev_attr_ledd.attr,
+        &dev_attr_ls_switch.attr,
+        &dev_attr_ls_level.attr,
         NULL
 };
 
@@ -679,6 +744,10 @@ static void asus_hotk_add_fs(void)
 	if (ledd_set_handle)
 		ASUS_SET_DEVICE_ATTR(ledd, 0644, show_ledd, store_ledd);
 
+	if (ls_switch_handle && ls_level_handle) {
+		ASUS_SET_DEVICE_ATTR(ls_level, 0644, show_lslvl, store_lslvl);
+		ASUS_SET_DEVICE_ATTR(ls_switch, 0644, show_lssw, store_lssw);
+	}
 }
 
 static int asus_handle_init(char *name, acpi_handle *handle,
@@ -800,6 +869,11 @@ static int asus_hotk_get_info(void)
 	ASUS_HANDLE_INIT(display_set);
 	ASUS_HANDLE_INIT(display_get);
 
+	/* There is a lot of models with "ALSL", but a few get
+	   a real light sens, so we need to check it. */
+	if(ASUS_HANDLE_INIT(ls_switch))
+		ASUS_HANDLE_INIT(ls_level);
+
 	kfree(model);
 
 	return AE_OK;
@@ -874,6 +948,16 @@ static int asus_hotk_add(struct acpi_device *device)
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
-- 
1.5.0.rc3.39.gec804
