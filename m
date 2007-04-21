From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 09/20] ACPI: thinkpad-acpi: uncouple subdriver init from ibms struct
Date: Sat, 21 Apr 2007 11:08:33 -0300
Message-ID: <11771645271352-git-send-email-hmh@hmh.eng.br>
References: <11771645253042-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48908 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031168AbXDUOI6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Apr 2007 10:08:58 -0400
In-Reply-To: <11771645253042-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@debian.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

From: Henrique de Moraes Holschuh <hmh@debian.org>

Move the .init method from ibms struct to another struct, and use a list
head to control which subdrivers have been activated.

This allows us to have the subdriver init methods marked __init, saving
quite a lot of .text size, and even a bit of .data size as some data can
now be made __initdata.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |  402 ++++++++++++++++++++++++++----------------
 drivers/misc/thinkpad_acpi.h |   51 +++---
 2 files changed, 278 insertions(+), 175 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index e8fc8da..5611268 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -470,7 +470,7 @@ static char *next_cmd(char **cmds)
  * thinkpad-acpi init subdriver
  */
 
-static int thinkpad_acpi_driver_init(void)
+static int __init thinkpad_acpi_driver_init(struct ibm_init_struct *iibm)
 {
 	printk(IBM_INFO "%s v%s\n", IBM_DESC, IBM_VERSION);
 	printk(IBM_INFO "%s\n", IBM_URL);
@@ -492,6 +492,11 @@ static int thinkpad_acpi_driver_read(char *p)
 	return len;
 }
 
+static struct ibm_struct thinkpad_acpi_driver_data = {
+	.name = "driver",
+	.read = thinkpad_acpi_driver_read,
+};
+
 /*************************************************************************
  * Hotkey subdriver
  */
@@ -501,7 +506,7 @@ static int hotkey_mask_supported;
 static int hotkey_orig_status;
 static int hotkey_orig_mask;
 
-static int hotkey_init(void)
+static int __init hotkey_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing hotkey subdriver\n");
 
@@ -640,13 +645,24 @@ static int hotkey_write(char *buf)
 	return 0;
 }
 
+static struct ibm_struct hotkey_driver_data = {
+	.name = "hotkey",
+	.hid = IBM_HKEY_HID,
+	.read = hotkey_read,
+	.write = hotkey_write,
+	.exit = hotkey_exit,
+	.notify = hotkey_notify,
+	.handle = &hkey_handle,
+	.type = ACPI_DEVICE_NOTIFY,
+};
+
 /*************************************************************************
  * Bluetooth subdriver
  */
 
 static int bluetooth_supported;
 
-static int bluetooth_init(void)
+static int __init bluetooth_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing bluetooth subdriver\n");
 
@@ -716,13 +732,19 @@ static int bluetooth_write(char *buf)
 	return 0;
 }
 
+static struct ibm_struct bluetooth_driver_data = {
+	.name = "bluetooth",
+	.read = bluetooth_read,
+	.write = bluetooth_write,
+};
+
 /*************************************************************************
  * Wan subdriver
  */
 
 static int wan_supported;
 
-static int wan_init(void)
+static int __init wan_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing wan subdriver\n");
 
@@ -789,6 +811,13 @@ static int wan_write(char *buf)
 	return 0;
 }
 
+static struct ibm_struct wan_driver_data = {
+	.name = "wan",
+	.read = wan_read,
+	.write = wan_write,
+	.experimental = 1,
+};
+
 /*************************************************************************
  * Video subdriver
  */
@@ -805,7 +834,7 @@ IBM_HANDLE(vid, root, "\\_SB.PCI.AGP.VGA",	/* 570 */
 
 IBM_HANDLE(vid2, root, "\\_SB.PCI0.AGPB.VID");	/* G41 */
 
-static int video_init(void)
+static int __init video_init(struct ibm_init_struct *iibm)
 {
 	int ivga;
 
@@ -1011,6 +1040,13 @@ static int video_write(char *buf)
 	return 0;
 }
 
+static struct ibm_struct video_driver_data = {
+	.name = "video",
+	.read = video_read,
+	.write = video_write,
+	.exit = video_exit,
+};
+
 /*************************************************************************
  * Light (thinklight) subdriver
  */
@@ -1021,7 +1057,7 @@ static int light_status_supported;
 IBM_HANDLE(lght, root, "\\LGHT");	/* A21e, A2xm/p, T20-22, X20-21 */
 IBM_HANDLE(ledb, ec, "LEDB");		/* G4x */
 
-static int light_init(void)
+static int __init light_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing light subdriver\n");
 
@@ -1093,6 +1129,12 @@ static int light_write(char *buf)
 	return 0;
 }
 
+static struct ibm_struct light_driver_data = {
+	.name = "light",
+	.read = light_read,
+	.write = light_write,
+};
+
 /*************************************************************************
  * Dock subdriver
  */
@@ -1110,7 +1152,7 @@ IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
 
 #define dock_docked() (_sta(dock_handle) & 1)
 
-static int dock_init(void)
+static int __init dock_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing dock subdriver\n");
 
@@ -1184,6 +1226,24 @@ static int dock_write(char *buf)
 	return 0;
 }
 
+static struct ibm_struct dock_driver_data[2] = {
+	{
+	 .name = "dock",
+	 .read = dock_read,
+	 .write = dock_write,
+	 .notify = dock_notify,
+	 .handle = &dock_handle,
+	 .type = ACPI_SYSTEM_NOTIFY,
+	},
+	{
+	 .name = "dock",
+	 .hid = IBM_PCI_HID,
+	 .notify = dock_notify,
+	 .handle = &pci_handle,
+	 .type = ACPI_SYSTEM_NOTIFY,
+	},
+};
+
 #endif /* CONFIG_THINKPAD_ACPI_DOCK */
 
 /*************************************************************************
@@ -1211,7 +1271,7 @@ IBM_HANDLE(bay2_ej, bay2, "_EJ3",	/* 600e/x, 770e, A3x */
 	   "_EJ0",			/* 770x */
 	   );				/* all others */
 
-static int bay_init(void)
+static int __init bay_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing bay subdriver\n");
 
@@ -1298,13 +1358,23 @@ static int bay_write(char *buf)
 
 	return 0;
 }
+
+static struct ibm_struct bay_driver_data = {
+	.name = "bay",
+	.read = bay_read,
+	.write = bay_write,
+	.notify = bay_notify,
+	.handle = &bay_handle,
+	.type = ACPI_SYSTEM_NOTIFY,
+};
+
 #endif /* CONFIG_THINKPAD_ACPI_BAY */
 
 /*************************************************************************
  * CMOS subdriver
  */
 
-static int cmos_init(void)
+static int __init cmos_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT,
 		"initializing cmos commands subdriver\n");
@@ -1362,6 +1432,11 @@ static int cmos_write(char *buf)
 	return 0;
 }
 
+static struct ibm_struct cmos_driver_data = {
+	.name = "cmos",
+	.read = cmos_read,
+	.write = cmos_write,
+};
 
 /*************************************************************************
  * LED subdriver
@@ -1374,7 +1449,7 @@ IBM_HANDLE(led, ec, "SLED",	/* 570 */
 	   "LED",		/* all others */
 	   );			/* R30, R31 */
 
-static int led_init(void)
+static int __init led_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing LED subdriver\n");
 
@@ -1487,13 +1562,19 @@ static int led_write(char *buf)
 	return 0;
 }
 
+static struct ibm_struct led_driver_data = {
+	.name = "led",
+	.read = led_read,
+	.write = led_write,
+};
+
 /*************************************************************************
  * Beep subdriver
  */
 
 IBM_HANDLE(beep, ec, "BEEP");	/* all except R30, R31 */
 
-static int beep_init(void)
+static int __init beep_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing beep subdriver\n");
 
@@ -1540,13 +1621,19 @@ static int beep_write(char *buf)
 	return 0;
 }
 
+static struct ibm_struct beep_driver_data = {
+	.name = "beep",
+	.read = beep_read,
+	.write = beep_write,
+};
+
 /*************************************************************************
  * Thermal subdriver
  */
 
 static enum thermal_access_mode thermal_read_mode;
 
-static int thermal_init(void)
+static int __init thermal_init(struct ibm_init_struct *iibm)
 {
 	u8 t, ta1, ta2;
 	int i;
@@ -1692,6 +1779,11 @@ static int thermal_read(char *p)
 	return len;
 }
 
+static struct ibm_struct thermal_driver_data = {
+	.name = "thermal",
+	.read = thermal_read,
+};
+
 /*************************************************************************
  * EC Dump subdriver
  */
@@ -1755,6 +1847,13 @@ static int ecdump_write(char *buf)
 	return 0;
 }
 
+static struct ibm_struct ecdump_driver_data = {
+	.name = "ecdump",
+	.read = ecdump_read,
+	.write = ecdump_write,
+	.experimental = 1,
+};
+
 /*************************************************************************
  * Backlight/brightness subdriver
  */
@@ -1766,7 +1865,7 @@ static struct backlight_ops ibm_backlight_data = {
         .update_status  = brightness_update_status,
 };
 
-static int brightness_init(void)
+static int __init brightness_init(struct ibm_init_struct *iibm)
 {
 	int b;
 
@@ -1883,6 +1982,13 @@ static int brightness_write(char *buf)
 	return 0;
 }
 
+static struct ibm_struct brightness_driver_data = {
+	.name = "brightness",
+	.read = brightness_read,
+	.write = brightness_write,
+	.exit = brightness_exit,
+};
+
 /*************************************************************************
  * Volume subdriver
  */
@@ -1967,6 +2073,11 @@ static int volume_write(char *buf)
 	return 0;
 }
 
+static struct ibm_struct volume_driver_data = {
+	.name = "volume",
+	.read = volume_read,
+	.write = volume_write,
+};
 
 /*************************************************************************
  * Fan subdriver
@@ -2092,7 +2203,7 @@ IBM_HANDLE(sfan, ec, "SFAN",	/* 570 */
 	   "JFNS",		/* 770x-JL */
 	   );			/* all others */
 
-static int fan_init(void)
+static int __init fan_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing fan subdriver\n");
 
@@ -2568,6 +2679,14 @@ static int fan_write(char *buf)
 	return rc;
 }
 
+static struct ibm_struct fan_driver_data = {
+	.name = "fan",
+	.read = fan_read,
+	.write = fan_write,
+	.exit = fan_exit,
+	.experimental = 1,
+};
+
 /****************************************************************************
  ****************************************************************************
  *
@@ -2580,159 +2699,45 @@ static int fan_write(char *buf)
 static struct proc_dir_entry *proc_dir = NULL;
 
 /* Subdriver registry */
-static struct ibm_struct ibms[] = {
-	{
-	 .name = "driver",
-	 .init = thinkpad_acpi_driver_init,
-	 .read = thinkpad_acpi_driver_read,
-	 },
-	{
-	 .name = "hotkey",
-	 .hid = IBM_HKEY_HID,
-	 .init = hotkey_init,
-	 .read = hotkey_read,
-	 .write = hotkey_write,
-	 .exit = hotkey_exit,
-	 .notify = hotkey_notify,
-	 .handle = &hkey_handle,
-	 .type = ACPI_DEVICE_NOTIFY,
-	 },
-	{
-	 .name = "bluetooth",
-	 .init = bluetooth_init,
-	 .read = bluetooth_read,
-	 .write = bluetooth_write,
-	 },
-	{
-	 .name = "wan",
-	 .init = wan_init,
-	 .read = wan_read,
-	 .write = wan_write,
-	 .experimental = 1,
-	 },
-	{
-	 .name = "video",
-	 .init = video_init,
-	 .read = video_read,
-	 .write = video_write,
-	 .exit = video_exit,
-	 },
-	{
-	 .name = "light",
-	 .init = light_init,
-	 .read = light_read,
-	 .write = light_write,
-	 },
-#ifdef CONFIG_THINKPAD_ACPI_DOCK
-	{
-	 .name = "dock",
-	 .init = dock_init,
-	 .read = dock_read,
-	 .write = dock_write,
-	 .notify = dock_notify,
-	 .handle = &dock_handle,
-	 .type = ACPI_SYSTEM_NOTIFY,
-	 },
-	{
-	 .name = "dock",
-	 .hid = IBM_PCI_HID,
-	 .notify = dock_notify,
-	 .handle = &pci_handle,
-	 .type = ACPI_SYSTEM_NOTIFY,
-	 },
-#endif
-#ifdef CONFIG_THINKPAD_ACPI_BAY
-	{
-	 .name = "bay",
-	 .init = bay_init,
-	 .read = bay_read,
-	 .write = bay_write,
-	 .notify = bay_notify,
-	 .handle = &bay_handle,
-	 .type = ACPI_SYSTEM_NOTIFY,
-	 },
-#endif /* CONFIG_THINKPAD_ACPI_BAY */
-	{
-	 .name = "cmos",
-	 .init = cmos_init,
-	 .read = cmos_read,
-	 .write = cmos_write,
-	 },
-	{
-	 .name = "led",
-	 .init = led_init,
-	 .read = led_read,
-	 .write = led_write,
-	 },
-	{
-	 .name = "beep",
-	 .init = beep_init,
-	 .read = beep_read,
-	 .write = beep_write,
-	 },
-	{
-	 .name = "thermal",
-	 .init = thermal_init,
-	 .read = thermal_read,
-	 },
-	{
-	 .name = "ecdump",
-	 .read = ecdump_read,
-	 .write = ecdump_write,
-	 .experimental = 1,
-	 },
-	{
-	 .name = "brightness",
-	 .read = brightness_read,
-	 .write = brightness_write,
-	 .init = brightness_init,
-	 .exit = brightness_exit,
-	 },
-	{
-	 .name = "volume",
-	 .read = volume_read,
-	 .write = volume_write,
-	 },
-	{
-	 .name = "fan",
-	 .read = fan_read,
-	 .write = fan_write,
-	 .init = fan_init,
-	 .exit = fan_exit,
-	 .experimental = 1,
-	 },
-};
+static LIST_HEAD(tpacpi_all_drivers);
+
 
 /*
  * Module and infrastructure proble, init and exit handling
  */
 
 #ifdef CONFIG_THINKPAD_ACPI_DEBUG
-static const char * str_supported(int is_supported)
+static const char * __init str_supported(int is_supported)
 {
-	static const char * const text_unsupported = "not supported";
+	static char text_unsupported[] __initdata = "not supported";
 
-	return (is_supported)? text_unsupported + 4 : text_unsupported;
+	return (is_supported)? &text_unsupported[4] : &text_unsupported[0];
 }
 #endif /* CONFIG_THINKPAD_ACPI_DEBUG */
 
-static int __init ibm_init(struct ibm_struct *ibm)
+static int __init ibm_init(struct ibm_init_struct *iibm)
 {
 	int ret;
+	struct ibm_struct *ibm = iibm->data;
 	struct proc_dir_entry *entry;
 
+	BUG_ON(ibm == NULL);
+
+	INIT_LIST_HEAD(&ibm->all_drivers);
+
 	if (ibm->experimental && !experimental)
 		return 0;
 
 	dbg_printk(TPACPI_DBG_INIT,
 		"probing for %s\n", ibm->name);
 
-	if (ibm->init) {
-		ret = ibm->init();
+	if (iibm->init) {
+		ret = iibm->init(iibm);
 		if (ret > 0)
 			return 0;	/* probe failed */
 		if (ret)
 			return ret;
+
 		ibm->init_called = 1;
 	}
 
@@ -2775,6 +2780,8 @@ static int __init ibm_init(struct ibm_struct *ibm)
 		ibm->proc_created = 1;
 	}
 
+	list_add_tail(&ibm->all_drivers, &tpacpi_all_drivers);
+
 	return 0;
 
 err_out:
@@ -2789,6 +2796,9 @@ err_out:
 static void ibm_exit(struct ibm_struct *ibm)
 {
 	dbg_printk(TPACPI_DBG_EXIT, "removing %s\n", ibm->name);
+
+	list_del_init(&ibm->all_drivers);
+
 	if (ibm->notify_installed) {
 		dbg_printk(TPACPI_DBG_EXIT,
 			"%s: acpi_remove_notify_handler\n", ibm->name);
@@ -2817,6 +2827,8 @@ static void ibm_exit(struct ibm_struct *ibm)
 		ibm->exit();
 		ibm->init_called = 0;
 	}
+
+	dbg_printk(TPACPI_DBG_INIT, "finished removing %s\n", ibm->name);
 }
 
 /* Probing */
@@ -2875,18 +2887,95 @@ static int __init probe_for_thinkpad(void)
 
 /* Module init, exit, parameters */
 
+static struct ibm_init_struct ibms_init[] __initdata = {
+	{
+		.init = thinkpad_acpi_driver_init,
+		.data = &thinkpad_acpi_driver_data,
+	},
+	{
+		.init = hotkey_init,
+		.data = &hotkey_driver_data,
+	},
+	{
+		.init = bluetooth_init,
+		.data = &bluetooth_driver_data,
+	},
+	{
+		.init = wan_init,
+		.data = &wan_driver_data,
+	},
+	{
+		.init = video_init,
+		.data = &video_driver_data,
+	},
+	{
+		.init = light_init,
+		.data = &light_driver_data,
+	},
+#ifdef CONFIG_THINKPAD_ACPI_DOCK
+	{
+		.init = dock_init,
+		.data = &dock_driver_data[0],
+	},
+	{
+		.data = &dock_driver_data[1],
+	},
+#endif
+#ifdef CONFIG_THINKPAD_ACPI_BAY
+	{
+		.init = bay_init,
+		.data = &bay_driver_data,
+	},
+#endif
+	{
+		.init = cmos_init,
+		.data = &cmos_driver_data,
+	},
+	{
+		.init = led_init,
+		.data = &led_driver_data,
+	},
+	{
+		.init = beep_init,
+		.data = &beep_driver_data,
+	},
+	{
+		.init = thermal_init,
+		.data = &thermal_driver_data,
+	},
+	{
+		.data = &ecdump_driver_data,
+	},
+	{
+		.init = brightness_init,
+		.data = &brightness_driver_data,
+	},
+	{
+		.data = &volume_driver_data,
+	},
+	{
+		.init = fan_init,
+		.data = &fan_driver_data,
+	},
+};
+
 static int __init set_ibm_param(const char *val, struct kernel_param *kp)
 {
 	unsigned int i;
+	struct ibm_struct *ibm;
 
-	for (i = 0; i < ARRAY_SIZE(ibms); i++)
-		if (strcmp(ibms[i].name, kp->name) == 0 && ibms[i].write) {
-			if (strlen(val) > sizeof(ibms[i].param) - 2)
+	for (i = 0; i < ARRAY_SIZE(ibms_init); i++) {
+		ibm = ibms_init[i].data;
+		BUG_ON(ibm == NULL);
+
+		if (strcmp(ibm->name, kp->name) == 0 && ibm->write) {
+			if (strlen(val) > sizeof(ibms_init[i].param) - 2)
 				return -ENOSPC;
-			strcpy(ibms[i].param, val);
-			strcat(ibms[i].param, ",");
+			strcpy(ibms_init[i].param, val);
+			strcat(ibms_init[i].param, ",");
 			return 0;
 		}
+	}
 
 	return -EINVAL;
 }
@@ -2938,10 +3027,10 @@ static int __init thinkpad_acpi_module_init(void)
 	}
 	proc_dir->owner = THIS_MODULE;
 
-	for (i = 0; i < ARRAY_SIZE(ibms); i++) {
-		ret = ibm_init(&ibms[i]);
-		if (ret >= 0 && *ibms[i].param)
-			ret = ibms[i].write(ibms[i].param);
+	for (i = 0; i < ARRAY_SIZE(ibms_init); i++) {
+		ret = ibm_init(&ibms_init[i]);
+		if (ret >= 0 && *ibms_init[i].param)
+			ret = ibms_init[i].data->write(ibms_init[i].param);
 		if (ret < 0) {
 			thinkpad_acpi_module_exit();
 			return ret;
@@ -2953,10 +3042,15 @@ static int __init thinkpad_acpi_module_init(void)
 
 static void thinkpad_acpi_module_exit(void)
 {
-	int i;
+	struct ibm_struct *ibm, *itmp;
+
+	list_for_each_entry_safe_reverse(ibm, itmp,
+					 &tpacpi_all_drivers,
+					 all_drivers) {
+		ibm_exit(ibm);
+	}
 
-	for (i = ARRAY_SIZE(ibms) - 1; i >= 0; i--)
-		ibm_exit(&ibms[i]);
+	dbg_printk(TPACPI_DBG_INIT, "finished subdriver exit path...\n");
 
 	if (proc_dir)
 		remove_proc_entry(IBM_DIR, acpi_root_dir);
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index beb1447..97467b7 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/string.h>
+#include <linux/list.h>
 
 #include <linux/proc_fs.h>
 #include <linux/backlight.h>
@@ -116,8 +117,6 @@ static void ibm_handle_init(char *name,
 
 /* procfs support */
 static struct proc_dir_entry *proc_dir;
-static int thinkpad_acpi_driver_init(void);
-static int thinkpad_acpi_driver_read(char *p);
 
 /* procfs helpers */
 static int dispatch_read(char *page, char **start, off_t off, int count,
@@ -142,12 +141,10 @@ static void thinkpad_acpi_module_exit(void);
 
 struct ibm_struct {
 	char *name;
-	char param[32];
 
 	char *hid;
 	struct acpi_driver *driver;
 
-	int (*init) (void);
 	int (*read) (char *);
 	int (*write) (char *);
 	void (*exit) (void);
@@ -157,6 +154,8 @@ struct ibm_struct {
 	int type;
 	struct acpi_device *device;
 
+	struct list_head all_drivers;
+
 	int driver_registered;
 	int proc_created;
 	int init_called;
@@ -165,16 +164,26 @@ struct ibm_struct {
 	int experimental;
 };
 
-static struct ibm_struct ibms[];
+struct ibm_init_struct {
+	char param[32];
+
+	int (*init) (struct ibm_init_struct *);
+	struct ibm_struct *data;
+};
+
+static struct list_head tpacpi_all_drivers;
+
+static struct ibm_init_struct ibms_init[];
 static int set_ibm_param(const char *val, struct kernel_param *kp);
-static int ibm_init(struct ibm_struct *ibm);
+static int ibm_init(struct ibm_init_struct *iibm);
 static void ibm_exit(struct ibm_struct *ibm);
 
-/* ACPI devices */
-static void dispatch_notify(acpi_handle handle, u32 event, void *data);
-static int setup_notify(struct ibm_struct *ibm);
-static int ibm_device_add(struct acpi_device *device);
-static int register_tpacpi_subdriver(struct ibm_struct *ibm);
+
+/*
+ * procfs master subdriver
+ */
+static int thinkpad_acpi_driver_init(struct ibm_init_struct *iibm);
+static int thinkpad_acpi_driver_read(char *p);
 
 
 /*
@@ -188,7 +197,7 @@ static int bay_status2_supported, bay_eject2_supported;
 static acpi_handle bay_handle, bay_ej_handle;
 static acpi_handle bay2_handle, bay2_ej_handle;
 
-static int bay_init(void);
+static int bay_init(struct ibm_init_struct *iibm);
 static void bay_notify(struct ibm_struct *ibm, u32 event);
 static int bay_read(char *p);
 static int bay_write(char *buf);
@@ -211,7 +220,7 @@ static int beep_write(char *buf);
 
 static int bluetooth_supported;
 
-static int bluetooth_init(void);
+static int bluetooth_init(struct ibm_init_struct *iibm);
 static int bluetooth_status(void);
 static int bluetooth_read(char *p);
 static int bluetooth_write(char *buf);
@@ -224,7 +233,7 @@ static int bluetooth_write(char *buf);
 static struct backlight_device *ibm_backlight_device;
 static int brightness_offset = 0x31;
 
-static int brightness_init(void);
+static int brightness_init(struct ibm_init_struct *iibm);
 static void brightness_exit(void);
 static int brightness_get(struct backlight_device *bd);
 static int brightness_set(int value);
@@ -306,7 +315,7 @@ static int fan_watchdog_maxinterval;
 
 static acpi_handle fans_handle, gfan_handle, sfan_handle;
 
-static int fan_init(void);
+static int fan_init(struct ibm_init_struct *iibm);
 static void fan_exit(void);
 static int fan_get_status(u8 *status);
 static int fan_get_speed(unsigned int *speed);
@@ -334,7 +343,7 @@ static int hotkey_mask_supported;
 static int hotkey_orig_status;
 static int hotkey_orig_mask;
 
-static int hotkey_init(void);
+static int hotkey_init(struct ibm_init_struct *iibm);
 static void hotkey_exit(void);
 static int hotkey_get(int *status, int *mask);
 static int hotkey_set(int status, int mask);
@@ -363,7 +372,7 @@ enum {	/* For TPACPI_LED_OLD */
 static enum led_access_mode led_supported;
 static acpi_handle led_handle;
 
-static int led_init(void);
+static int led_init(struct ibm_init_struct *iibm);
 static int led_read(char *p);
 static int led_write(char *buf);
 
@@ -375,7 +384,7 @@ static int light_supported;
 static int light_status_supported;
 static acpi_handle lght_handle, ledb_handle;
 
-static int light_init(void);
+static int light_init(struct ibm_init_struct *iibm);
 static int light_read(char *p);
 static int light_write(char *buf);
 
@@ -397,7 +406,7 @@ struct ibm_thermal_sensors_struct {
 	s32 temp[TPACPI_MAX_THERMAL_SENSORS];
 };
 
-static int thermal_init(void);
+static int thermal_init(struct ibm_init_struct *iibm);
 static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s);
 static int thermal_read(char *p);
 
@@ -417,7 +426,7 @@ static enum video_access_mode video_supported;
 static int video_orig_autosw;
 static acpi_handle vid_handle, vid2_handle;
 
-static int video_init(void);
+static int video_init(struct ibm_init_struct *iibm);
 static void video_exit(void);
 static int video_status(void);
 static int video_autosw(void);
@@ -444,7 +453,7 @@ static int volume_write(char *buf);
 
 static int wan_supported;
 
-static int wan_init(void);
+static int wan_init(struct ibm_init_struct *iibm);
 static int wan_status(void);
 static int wan_read(char *p);
 static int wan_write(char *buf);
-- 
1.5.1

