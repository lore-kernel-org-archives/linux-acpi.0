From: Len Brown <len.brown@intel.com>
Subject: [PATCH 058/105] ACPI: thinkpad-acpi: prepare for device model conversion
Date: Sun, 29 Apr 2007 00:50:58 -0400
Message-ID: <11778223593048-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
 <11778223562656-git-send-email-len.brown@intel.com>
 <11778223571390-git-send-email-len.brown@intel.com>
 <11778223581484-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9417 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756134AbXD2Ewl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:41 -0400
In-Reply-To: <11778223581484-git-send-email-len.brown@intel.com>
Message-Id: <8d376cd6543d57ef10799be02ba5f19aa6678032.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Prepare the thinkpad-acpi driver for the conversion to the device
model, by renaming variables and doing other glue work that shall
make the later patches much cleaner.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |  231 +++++++++++++++++++++++-------------------
 drivers/misc/thinkpad_acpi.h |   40 +++++---
 2 files changed, 153 insertions(+), 118 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index e2a1b63..809ec84 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -277,7 +277,7 @@ static int _sta(acpi_handle handle)
  * ACPI device model
  */
 
-static void ibm_handle_init(char *name,
+static void drv_acpi_handle_init(char *name,
 			   acpi_handle *handle, acpi_handle parent,
 			   char **paths, int num_paths, char **path)
 {
@@ -295,40 +295,42 @@ static void ibm_handle_init(char *name,
 	*handle = NULL;
 }
 
-static void dispatch_notify(acpi_handle handle, u32 event, void *data)
+static void dispatch_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct ibm_struct *ibm = data;
 
-	if (!ibm || !ibm->notify)
+	if (!ibm || !ibm->acpi || !ibm->acpi->notify)
 		return;
 
-	ibm->notify(ibm, event);
+	ibm->acpi->notify(ibm, event);
 }
 
-static int __init setup_notify(struct ibm_struct *ibm)
+static int __init setup_acpi_notify(struct ibm_struct *ibm)
 {
 	acpi_status status;
 	int ret;
 
-	if (!*ibm->handle)
+	BUG_ON(!ibm->acpi);
+
+	if (!*ibm->acpi->handle)
 		return 0;
 
 	dbg_printk(TPACPI_DBG_INIT,
 		"setting up ACPI notify for %s\n", ibm->name);
 
-	ret = acpi_bus_get_device(*ibm->handle, &ibm->device);
+	ret = acpi_bus_get_device(*ibm->acpi->handle, &ibm->acpi->device);
 	if (ret < 0) {
 		printk(IBM_ERR "%s device not present\n", ibm->name);
 		return -ENODEV;
 	}
 
-	acpi_driver_data(ibm->device) = ibm;
-	sprintf(acpi_device_class(ibm->device), "%s/%s",
+	acpi_driver_data(ibm->acpi->device) = ibm;
+	sprintf(acpi_device_class(ibm->acpi->device), "%s/%s",
 		IBM_ACPI_EVENT_PREFIX,
 		ibm->name);
 
-	status = acpi_install_notify_handler(*ibm->handle, ibm->type,
-					     dispatch_notify, ibm);
+	status = acpi_install_notify_handler(*ibm->acpi->handle,
+			ibm->acpi->type, dispatch_acpi_notify, ibm);
 	if (ACPI_FAILURE(status)) {
 		if (status == AE_ALREADY_EXISTS) {
 			printk(IBM_NOTICE "another device driver is already handling %s events\n",
@@ -339,11 +341,11 @@ static int __init setup_notify(struct ibm_struct *ibm)
 		}
 		return -ENODEV;
 	}
-	ibm->flags.notify_installed = 1;
+	ibm->flags.acpi_notify_installed = 1;
 	return 0;
 }
 
-static int __init ibm_device_add(struct acpi_device *device)
+static int __init tpacpi_device_add(struct acpi_device *device)
 {
 	return 0;
 }
@@ -355,24 +357,26 @@ static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 	dbg_printk(TPACPI_DBG_INIT,
 		"registering %s as an ACPI driver\n", ibm->name);
 
-	ibm->driver = kzalloc(sizeof(struct acpi_driver), GFP_KERNEL);
-	if (!ibm->driver) {
+	BUG_ON(!ibm->acpi);
+
+	ibm->acpi->driver = kzalloc(sizeof(struct acpi_driver), GFP_KERNEL);
+	if (!ibm->acpi->driver) {
 		printk(IBM_ERR "kzalloc(ibm->driver) failed\n");
 		return -ENOMEM;
 	}
 
-	sprintf(ibm->driver->name, "%s_%s", IBM_NAME, ibm->name);
-	ibm->driver->ids = ibm->hid;
-	ibm->driver->ops.add = &ibm_device_add;
+	sprintf(ibm->acpi->driver->name, "%s_%s", IBM_NAME, ibm->name);
+	ibm->acpi->driver->ids = ibm->acpi->hid;
+	ibm->acpi->driver->ops.add = &tpacpi_device_add;
 
-	ret = acpi_bus_register_driver(ibm->driver);
+	ret = acpi_bus_register_driver(ibm->acpi->driver);
 	if (ret < 0) {
 		printk(IBM_ERR "acpi_bus_register_driver(%s) failed: %d\n",
-		       ibm->hid, ret);
-		kfree(ibm->driver);
-		ibm->driver = NULL;
+		       ibm->acpi->hid, ret);
+		kfree(ibm->acpi->driver);
+		ibm->acpi->driver = NULL;
 	} else if (!ret)
-		ibm->flags.driver_registered = 1;
+		ibm->flags.acpi_driver_registered = 1;
 
 	return ret;
 }
@@ -386,8 +390,8 @@ static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
  ****************************************************************************
  ****************************************************************************/
 
-static int dispatch_read(char *page, char **start, off_t off, int count,
-			 int *eof, void *data)
+static int dispatch_procfs_read(char *page, char **start, off_t off,
+			int count, int *eof, void *data)
 {
 	struct ibm_struct *ibm = data;
 	int len;
@@ -411,8 +415,9 @@ static int dispatch_read(char *page, char **start, off_t off, int count,
 	return len;
 }
 
-static int dispatch_write(struct file *file, const char __user * userbuf,
-			  unsigned long count, void *data)
+static int dispatch_procfs_write(struct file *file,
+			const char __user * userbuf,
+			unsigned long count, void *data)
 {
 	struct ibm_struct *ibm = data;
 	char *kernbuf;
@@ -508,7 +513,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing hotkey subdriver\n");
 
-	IBM_HANDLE_INIT(hkey);
+	IBM_ACPIHANDLE_INIT(hkey);
 
 	/* hotkey not supported on 570 */
 	tp_features.hotkey = hkey_handle != NULL;
@@ -545,10 +550,10 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 	int hkey;
 
 	if (acpi_evalf(hkey_handle, &hkey, "MHKP", "d"))
-		acpi_bus_generate_event(ibm->device, event, hkey);
+		acpi_bus_generate_event(ibm->acpi->device, event, hkey);
 	else {
 		printk(IBM_ERR "unknown hotkey event %d\n", event);
-		acpi_bus_generate_event(ibm->device, event, 0);
+		acpi_bus_generate_event(ibm->acpi->device, event, 0);
 	}
 }
 
@@ -643,15 +648,19 @@ static int hotkey_write(char *buf)
 	return 0;
 }
 
+static struct tp_acpi_drv_struct ibm_hotkey_acpidriver = {
+	.hid = IBM_HKEY_HID,
+	.notify = hotkey_notify,
+	.handle = &hkey_handle,
+	.type = ACPI_DEVICE_NOTIFY,
+};
+
 static struct ibm_struct hotkey_driver_data = {
 	.name = "hotkey",
-	.hid = IBM_HKEY_HID,
 	.read = hotkey_read,
 	.write = hotkey_write,
 	.exit = hotkey_exit,
-	.notify = hotkey_notify,
-	.handle = &hkey_handle,
-	.type = ACPI_DEVICE_NOTIFY,
+	.acpi = &ibm_hotkey_acpidriver,
 };
 
 /*************************************************************************
@@ -662,7 +671,7 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing bluetooth subdriver\n");
 
-	IBM_HANDLE_INIT(hkey);
+	IBM_ACPIHANDLE_INIT(hkey);
 
 	/* bluetooth not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
 	   G4x, R30, R31, R40e, R50e, T20-22, X20-21 */
@@ -742,7 +751,7 @@ static int __init wan_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing wan subdriver\n");
 
-	IBM_HANDLE_INIT(hkey);
+	IBM_ACPIHANDLE_INIT(hkey);
 
 	tp_features.wan = hkey_handle &&
 			  acpi_evalf(hkey_handle, NULL, "GWAN", "qv");
@@ -835,8 +844,8 @@ static int __init video_init(struct ibm_init_struct *iibm)
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing video subdriver\n");
 
-	IBM_HANDLE_INIT(vid);
-	IBM_HANDLE_INIT(vid2);
+	IBM_ACPIHANDLE_INIT(vid);
+	IBM_ACPIHANDLE_INIT(vid2);
 
 	if (vid2_handle && acpi_evalf(NULL, &ivga, "\\IVGA", "d") && ivga)
 		/* G41, assume IVGA doesn't change */
@@ -1053,9 +1062,9 @@ static int __init light_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing light subdriver\n");
 
-	IBM_HANDLE_INIT(ledb);
-	IBM_HANDLE_INIT(lght);
-	IBM_HANDLE_INIT(cmos);
+	IBM_ACPIHANDLE_INIT(ledb);
+	IBM_ACPIHANDLE_INIT(lght);
+	IBM_ACPIHANDLE_INIT(cmos);
 
 	/* light not supported on 570, 600e/x, 770e, 770x, G4x, R30, R31 */
 	tp_features.light = (cmos_handle || lght_handle) && !ledb_handle;
@@ -1148,8 +1157,8 @@ static int __init dock_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing dock subdriver\n");
 
-	IBM_HANDLE_INIT(dock);
-	IBM_HANDLE_INIT(pci);
+	IBM_ACPIHANDLE_INIT(dock);
+	IBM_ACPIHANDLE_INIT(pci);
 
 	vdbg_printk(TPACPI_DBG_INIT, "dock is %s\n",
 		str_supported(dock_handle != NULL));
@@ -1160,22 +1169,22 @@ static int __init dock_init(struct ibm_init_struct *iibm)
 static void dock_notify(struct ibm_struct *ibm, u32 event)
 {
 	int docked = dock_docked();
-	int pci = ibm->hid && strstr(ibm->hid, IBM_PCI_HID);
+	int pci = ibm->acpi->hid && strstr(ibm->acpi->hid, IBM_PCI_HID);
 
 	if (event == 1 && !pci)	/* 570 */
-		acpi_bus_generate_event(ibm->device, event, 1);	/* button */
+		acpi_bus_generate_event(ibm->acpi->device, event, 1);	/* button */
 	else if (event == 1 && pci)	/* 570 */
-		acpi_bus_generate_event(ibm->device, event, 3);	/* dock */
+		acpi_bus_generate_event(ibm->acpi->device, event, 3);	/* dock */
 	else if (event == 3 && docked)
-		acpi_bus_generate_event(ibm->device, event, 1);	/* button */
+		acpi_bus_generate_event(ibm->acpi->device, event, 1);	/* button */
 	else if (event == 3 && !docked)
-		acpi_bus_generate_event(ibm->device, event, 2);	/* undock */
+		acpi_bus_generate_event(ibm->acpi->device, event, 2);	/* undock */
 	else if (event == 0 && docked)
-		acpi_bus_generate_event(ibm->device, event, 3);	/* dock */
+		acpi_bus_generate_event(ibm->acpi->device, event, 3);	/* dock */
 	else {
 		printk(IBM_ERR "unknown dock event %d, status %d\n",
 		       event, _sta(dock_handle));
-		acpi_bus_generate_event(ibm->device, event, 0);	/* unknown */
+		acpi_bus_generate_event(ibm->acpi->device, event, 0);	/* unknown */
 	}
 }
 
@@ -1218,17 +1227,13 @@ static int dock_write(char *buf)
 	return 0;
 }
 
-static struct ibm_struct dock_driver_data[2] = {
+static struct tp_acpi_drv_struct ibm_dock_acpidriver[2] = {
 	{
-	 .name = "dock",
-	 .read = dock_read,
-	 .write = dock_write,
 	 .notify = dock_notify,
 	 .handle = &dock_handle,
 	 .type = ACPI_SYSTEM_NOTIFY,
 	},
 	{
-	 .name = "dock",
 	 .hid = IBM_PCI_HID,
 	 .notify = dock_notify,
 	 .handle = &pci_handle,
@@ -1236,6 +1241,19 @@ static struct ibm_struct dock_driver_data[2] = {
 	},
 };
 
+static struct ibm_struct dock_driver_data[2] = {
+	{
+	 .name = "dock",
+	 .read = dock_read,
+	 .write = dock_write,
+	 .acpi = &ibm_dock_acpidriver[0],
+	},
+	{
+	 .name = "dock",
+	 .acpi = &ibm_dock_acpidriver[1],
+	},
+};
+
 #endif /* CONFIG_THINKPAD_ACPI_DOCK */
 
 /*************************************************************************
@@ -1262,12 +1280,12 @@ static int __init bay_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing bay subdriver\n");
 
-	IBM_HANDLE_INIT(bay);
+	IBM_ACPIHANDLE_INIT(bay);
 	if (bay_handle)
-		IBM_HANDLE_INIT(bay_ej);
-	IBM_HANDLE_INIT(bay2);
+		IBM_ACPIHANDLE_INIT(bay_ej);
+	IBM_ACPIHANDLE_INIT(bay2);
 	if (bay2_handle)
-		IBM_HANDLE_INIT(bay2_ej);
+		IBM_ACPIHANDLE_INIT(bay2_ej);
 
 	tp_features.bay_status = bay_handle &&
 		acpi_evalf(bay_handle, NULL, "_STA", "qv");
@@ -1292,7 +1310,7 @@ static int __init bay_init(struct ibm_init_struct *iibm)
 
 static void bay_notify(struct ibm_struct *ibm, u32 event)
 {
-	acpi_bus_generate_event(ibm->device, event, 0);
+	acpi_bus_generate_event(ibm->acpi->device, event, 0);
 }
 
 #define bay_occupied(b) (_sta(b##_handle) & 1)
@@ -1347,13 +1365,17 @@ static int bay_write(char *buf)
 	return 0;
 }
 
+static struct tp_acpi_drv_struct ibm_bay_acpidriver = {
+	.notify = bay_notify,
+	.handle = &bay_handle,
+	.type = ACPI_SYSTEM_NOTIFY,
+};
+
 static struct ibm_struct bay_driver_data = {
 	.name = "bay",
 	.read = bay_read,
 	.write = bay_write,
-	.notify = bay_notify,
-	.handle = &bay_handle,
-	.type = ACPI_SYSTEM_NOTIFY,
+	.acpi = &ibm_bay_acpidriver,
 };
 
 #endif /* CONFIG_THINKPAD_ACPI_BAY */
@@ -1367,7 +1389,7 @@ static int __init cmos_init(struct ibm_init_struct *iibm)
 	vdbg_printk(TPACPI_DBG_INIT,
 		"initializing cmos commands subdriver\n");
 
-	IBM_HANDLE_INIT(cmos);
+	IBM_ACPIHANDLE_INIT(cmos);
 
 	vdbg_printk(TPACPI_DBG_INIT, "cmos commands are %s\n",
 		str_supported(cmos_handle != NULL));
@@ -1441,7 +1463,7 @@ static int __init led_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing LED subdriver\n");
 
-	IBM_HANDLE_INIT(led);
+	IBM_ACPIHANDLE_INIT(led);
 
 	if (!led_handle)
 		/* led not supported on R30, R31 */
@@ -1566,7 +1588,7 @@ static int __init beep_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing beep subdriver\n");
 
-	IBM_HANDLE_INIT(beep);
+	IBM_ACPIHANDLE_INIT(beep);
 
 	vdbg_printk(TPACPI_DBG_INIT, "beep is %s\n",
 		str_supported(beep_handle != NULL));
@@ -2200,9 +2222,9 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 	fan_watchdog_maxinterval = 0;
 	tp_features.fan_ctrl_status_undef = 0;
 
-	IBM_HANDLE_INIT(fans);
-	IBM_HANDLE_INIT(gfan);
-	IBM_HANDLE_INIT(sfan);
+	IBM_ACPIHANDLE_INIT(fans);
+	IBM_ACPIHANDLE_INIT(gfan);
+	IBM_ACPIHANDLE_INIT(sfan);
 
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
@@ -2728,22 +2750,24 @@ static int __init ibm_init(struct ibm_init_struct *iibm)
 		ibm->flags.init_called = 1;
 	}
 
-	if (ibm->hid) {
-		ret = register_tpacpi_subdriver(ibm);
-		if (ret)
-			goto err_out;
-	}
+	if (ibm->acpi) {
+		if (ibm->acpi->hid) {
+			ret = register_tpacpi_subdriver(ibm);
+			if (ret)
+				goto err_out;
+		}
 
-	if (ibm->notify) {
-		ret = setup_notify(ibm);
-		if (ret == -ENODEV) {
-			printk(IBM_NOTICE "disabling subdriver %s\n",
-				ibm->name);
-			ret = 0;
-			goto err_out;
+		if (ibm->acpi->notify) {
+			ret = setup_acpi_notify(ibm);
+			if (ret == -ENODEV) {
+				printk(IBM_NOTICE "disabling subdriver %s\n",
+					ibm->name);
+				ret = 0;
+				goto err_out;
+			}
+			if (ret < 0)
+				goto err_out;
 		}
-		if (ret < 0)
-			goto err_out;
 	}
 
 	dbg_printk(TPACPI_DBG_INIT,
@@ -2761,9 +2785,9 @@ static int __init ibm_init(struct ibm_init_struct *iibm)
 		}
 		entry->owner = THIS_MODULE;
 		entry->data = ibm;
-		entry->read_proc = &dispatch_read;
+		entry->read_proc = &dispatch_procfs_read;
 		if (ibm->write)
-			entry->write_proc = &dispatch_write;
+			entry->write_proc = &dispatch_procfs_write;
 		ibm->flags.proc_created = 1;
 	}
 
@@ -2786,12 +2810,15 @@ static void ibm_exit(struct ibm_struct *ibm)
 
 	list_del_init(&ibm->all_drivers);
 
-	if (ibm->flags.notify_installed) {
+	if (ibm->flags.acpi_notify_installed) {
 		dbg_printk(TPACPI_DBG_EXIT,
 			"%s: acpi_remove_notify_handler\n", ibm->name);
-		acpi_remove_notify_handler(*ibm->handle, ibm->type,
-					   dispatch_notify);
-		ibm->flags.notify_installed = 0;
+		BUG_ON(!ibm->acpi);
+		acpi_remove_notify_handler(*ibm->acpi->handle,
+					   ibm->acpi->type,
+					   dispatch_acpi_notify);
+		ibm->flags.acpi_notify_installed = 0;
+		ibm->flags.acpi_notify_installed = 0;
 	}
 
 	if (ibm->flags.proc_created) {
@@ -2801,13 +2828,14 @@ static void ibm_exit(struct ibm_struct *ibm)
 		ibm->flags.proc_created = 0;
 	}
 
-	if (ibm->flags.driver_registered) {
+	if (ibm->flags.acpi_driver_registered) {
 		dbg_printk(TPACPI_DBG_EXIT,
 			"%s: acpi_bus_unregister_driver\n", ibm->name);
-		acpi_bus_unregister_driver(ibm->driver);
-		kfree(ibm->driver);
-		ibm->driver = NULL;
-		ibm->flags.driver_registered = 0;
+		BUG_ON(!ibm->acpi);
+		acpi_bus_unregister_driver(ibm->acpi->driver);
+		kfree(ibm->acpi->driver);
+		ibm->acpi->driver = NULL;
+		ibm->flags.acpi_driver_registered = 0;
 	}
 
 	if (ibm->flags.init_called && ibm->exit) {
@@ -2860,7 +2888,7 @@ static int __init probe_for_thinkpad(void)
 	is_thinkpad = dmi_name_in_vendors("ThinkPad");
 
 	/* ec is required because many other handles are relative to it */
-	IBM_HANDLE_INIT(ec);
+	IBM_ACPIHANDLE_INIT(ec);
 	if (!ec_handle) {
 		if (is_thinkpad)
 			printk(IBM_ERR
@@ -3016,12 +3044,12 @@ static int __init thinkpad_acpi_module_init(void)
 		return ret;
 
 	ibm_thinkpad_ec_found = check_dmi_for_ec();
-	IBM_HANDLE_INIT(ecrd);
-	IBM_HANDLE_INIT(ecwr);
+	IBM_ACPIHANDLE_INIT(ecrd);
+	IBM_ACPIHANDLE_INIT(ecwr);
 
-	proc_dir = proc_mkdir(IBM_DIR, acpi_root_dir);
+	proc_dir = proc_mkdir(IBM_PROC_DIR, acpi_root_dir);
 	if (!proc_dir) {
-		printk(IBM_ERR "unable to create proc dir %s", IBM_DIR);
+		printk(IBM_ERR "unable to create proc dir " IBM_PROC_DIR);
 		thinkpad_acpi_module_exit();
 		return -ENODEV;
 	}
@@ -3053,10 +3081,9 @@ static void thinkpad_acpi_module_exit(void)
 	dbg_printk(TPACPI_DBG_INIT, "finished subdriver exit path...\n");
 
 	if (proc_dir)
-		remove_proc_entry(IBM_DIR, acpi_root_dir);
+		remove_proc_entry(IBM_PROC_DIR, acpi_root_dir);
 
-	if (ibm_thinkpad_ec_found)
-		kfree(ibm_thinkpad_ec_found);
+	kfree(ibm_thinkpad_ec_found);
 }
 
 module_init(thinkpad_acpi_module_init);
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 4d3ab40..529528c 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -52,8 +52,9 @@
 #define IBM_DESC "ThinkPad ACPI Extras"
 #define IBM_FILE "thinkpad_acpi"
 #define IBM_URL "http://ibm-acpi.sf.net/"
+#define IBM_MAIL "ibm-acpi-devel@lists.sourceforge.net"
 
-#define IBM_DIR "ibm"
+#define IBM_PROC_DIR "ibm"
 #define IBM_ACPI_EVENT_PREFIX "ibm"
 
 #define IBM_LOG IBM_FILE ": "
@@ -108,20 +109,21 @@ static acpi_handle ec_handle;			/* EC */
 static acpi_handle ecrd_handle, ecwr_handle;	/* 570 EC access */
 static acpi_handle cmos_handle, hkey_handle;	/* basic thinkpad handles */
 
-static void ibm_handle_init(char *name,
+static void drv_acpi_handle_init(char *name,
 		   acpi_handle *handle, acpi_handle parent,
 		   char **paths, int num_paths, char **path);
-#define IBM_HANDLE_INIT(object)						\
-	ibm_handle_init(#object, &object##_handle, *object##_parent,	\
+#define IBM_ACPIHANDLE_INIT(object)						\
+	drv_acpi_handle_init(#object, &object##_handle, *object##_parent,	\
 		object##_paths, ARRAY_SIZE(object##_paths), &object##_path)
 
 /* procfs support */
 static struct proc_dir_entry *proc_dir;
 
 /* procfs helpers */
-static int dispatch_read(char *page, char **start, off_t off, int count,
-		int *eof, void *data);
-static int dispatch_write(struct file *file, const char __user * userbuf,
+static int dispatch_procfs_read(char *page, char **start, off_t off,
+		int count, int *eof, void *data);
+static int dispatch_procfs_write(struct file *file,
+		const char __user * userbuf,
 		unsigned long count, void *data);
 static char *next_cmd(char **cmds);
 
@@ -140,28 +142,34 @@ static void thinkpad_acpi_module_exit(void);
  * Subdrivers
  */
 
-struct ibm_struct {
-	char *name;
+struct ibm_struct;
 
+struct tp_acpi_drv_struct {
 	char *hid;
 	struct acpi_driver *driver;
 
-	int (*read) (char *);
-	int (*write) (char *);
-	void (*exit) (void);
-
 	void (*notify) (struct ibm_struct *, u32);
 	acpi_handle *handle;
-	int type;
+	u32 type;
 	struct acpi_device *device;
+};
+
+struct ibm_struct {
+	char *name;
+
+	int (*read) (char *);
+	int (*write) (char *);
+	void (*exit) (void);
 
 	struct list_head all_drivers;
 
+	struct tp_acpi_drv_struct *acpi;
+
 	struct {
-		u8 driver_registered:1;
+		u8 acpi_driver_registered:1;
+		u8 acpi_notify_installed:1;
 		u8 proc_created:1;
 		u8 init_called:1;
-		u8 notify_installed:1;
 		u8 experimental:1;
 	} flags;
 };
-- 
1.5.2.rc0.34.gda94
