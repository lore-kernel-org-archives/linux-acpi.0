From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/2] thinkpad-acpi: remove dock and bay subdrivers
Date: Tue,  7 Jul 2009 20:09:50 -0300
Message-ID: <1247008190-29419-3-git-send-email-hmh@hmh.eng.br>
References: <1247008190-29419-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58886 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755194AbZGGXJ7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jul 2009 19:09:59 -0400
In-Reply-To: <1247008190-29419-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The standard ACPI dock driver can handle the hotplug bays and docks of
the ThinkPads just fine (including batteries) as of 2.6.27, and the
code in thinkpad-acpi for the dock and bay subdrivers is currently
broken anyway...

Userspace needs some love to support the two-stage ejection nicely,
but it is simple enough to do through udev rules (you don't even need
HAL) so this wouldn't justify fixing the dock and bay subdrivers,
either.

That leaves warm-swap bays (_EJ3) support for thinkpad-acpi, as well
as support for the weird dock of the model 570, but since such support
has never left the "experimental" stage, it is also not a strong
enough reason to find a way to fix this code.

Users of ThinkPads with warm-swap bays are urged to request that _EJ3
support be added to the regular ACPI dock driver, if such feature is
indeed useful for them.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |  127 ------------
 drivers/platform/x86/Kconfig            |   27 ---
 drivers/platform/x86/thinkpad_acpi.c    |  327 -------------------------------
 3 files changed, 0 insertions(+), 481 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index f2296ec..e2ddcde 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -36,8 +36,6 @@ detailed description):
 	- Bluetooth enable and disable
 	- video output switching, expansion control
 	- ThinkLight on and off
-	- limited docking and undocking
-	- UltraBay eject
 	- CMOS/UCMS control
 	- LED control
 	- ACPI sounds
@@ -729,131 +727,6 @@ cannot be read or if it is unknown, thinkpad-acpi will report it as "off".
 It is impossible to know if the status returned through sysfs is valid.
 
 
-Docking / undocking -- /proc/acpi/ibm/dock
-------------------------------------------
-
-Docking and undocking (e.g. with the X4 UltraBase) requires some
-actions to be taken by the operating system to safely make or break
-the electrical connections with the dock.
-
-The docking feature of this driver generates the following ACPI events:
-
-	ibm/dock GDCK 00000003 00000001 -- eject request
-	ibm/dock GDCK 00000003 00000002 -- undocked
-	ibm/dock GDCK 00000000 00000003 -- docked
-
-NOTE: These events will only be generated if the laptop was docked
-when originally booted. This is due to the current lack of support for
-hot plugging of devices in the Linux ACPI framework. If the laptop was
-booted while not in the dock, the following message is shown in the
-logs:
-
-	Mar 17 01:42:34 aero kernel: thinkpad_acpi: dock device not present
-
-In this case, no dock-related events are generated but the dock and
-undock commands described below still work. They can be executed
-manually or triggered by Fn key combinations (see the example acpid
-configuration files included in the driver tarball package available
-on the web site).
-
-When the eject request button on the dock is pressed, the first event
-above is generated. The handler for this event should issue the
-following command:
-
-	echo undock > /proc/acpi/ibm/dock
-
-After the LED on the dock goes off, it is safe to eject the laptop.
-Note: if you pressed this key by mistake, go ahead and eject the
-laptop, then dock it back in. Otherwise, the dock may not function as
-expected.
-
-When the laptop is docked, the third event above is generated. The
-handler for this event should issue the following command to fully
-enable the dock:
-
-	echo dock > /proc/acpi/ibm/dock
-
-The contents of the /proc/acpi/ibm/dock file shows the current status
-of the dock, as provided by the ACPI framework.
-
-The docking support in this driver does not take care of enabling or
-disabling any other devices you may have attached to the dock. For
-example, a CD drive plugged into the UltraBase needs to be disabled or
-enabled separately. See the provided example acpid configuration files
-for how this can be accomplished.
-
-There is no support yet for PCI devices that may be attached to a
-docking station, e.g. in the ThinkPad Dock II. The driver currently
-does not recognize, enable or disable such devices. This means that
-the only docking stations currently supported are the X-series
-UltraBase docks and "dumb" port replicators like the Mini Dock (the
-latter don't need any ACPI support, actually).
-
-
-UltraBay eject -- /proc/acpi/ibm/bay
-------------------------------------
-
-Inserting or ejecting an UltraBay device requires some actions to be
-taken by the operating system to safely make or break the electrical
-connections with the device.
-
-This feature generates the following ACPI events:
-
-	ibm/bay MSTR 00000003 00000000 -- eject request
-	ibm/bay MSTR 00000001 00000000 -- eject lever inserted
-
-NOTE: These events will only be generated if the UltraBay was present
-when the laptop was originally booted (on the X series, the UltraBay
-is in the dock, so it may not be present if the laptop was undocked).
-This is due to the current lack of support for hot plugging of devices
-in the Linux ACPI framework. If the laptop was booted without the
-UltraBay, the following message is shown in the logs:
-
-	Mar 17 01:42:34 aero kernel: thinkpad_acpi: bay device not present
-
-In this case, no bay-related events are generated but the eject
-command described below still works. It can be executed manually or
-triggered by a hot key combination.
-
-Sliding the eject lever generates the first event shown above. The
-handler for this event should take whatever actions are necessary to
-shut down the device in the UltraBay (e.g. call idectl), then issue
-the following command:
-
-	echo eject > /proc/acpi/ibm/bay
-
-After the LED on the UltraBay goes off, it is safe to pull out the
-device.
-
-When the eject lever is inserted, the second event above is
-generated. The handler for this event should take whatever actions are
-necessary to enable the UltraBay device (e.g. call idectl).
-
-The contents of the /proc/acpi/ibm/bay file shows the current status
-of the UltraBay, as provided by the ACPI framework.
-
-EXPERIMENTAL warm eject support on the 600e/x, A22p and A3x (To use
-this feature, you need to supply the experimental=1 parameter when
-loading the module):
-
-These models do not have a button near the UltraBay device to request
-a hot eject but rather require the laptop to be put to sleep
-(suspend-to-ram) before the bay device is ejected or inserted).
-The sequence of steps to eject the device is as follows:
-
-	echo eject > /proc/acpi/ibm/bay
-	put the ThinkPad to sleep
-	remove the drive
-	resume from sleep
-	cat /proc/acpi/ibm/bay should show that the drive was removed
-
-On the A3x, both the UltraBay 2000 and UltraBay Plus devices are
-supported. Use "eject2" instead of "eject" for the second bay.
-
-Note: the UltraBay eject support on the 600e/x, A22p and A3x is
-EXPERIMENTAL and may not work as expected. USE WITH CAUTION!
-
-
 CMOS/UCMS control
 -----------------
 
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 6335f63..77c6097 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -277,33 +277,6 @@ config THINKPAD_ACPI_UNSAFE_LEDS
 	  Say N here, unless you are building a kernel for your own
 	  use, and need to control the important firmware LEDs.
 
-config THINKPAD_ACPI_DOCK
-	bool "Legacy Docking Station Support"
-	depends on THINKPAD_ACPI
-	depends on ACPI_DOCK=n
-	depends on BROKEN
-	default n
-	---help---
-	  Allows the thinkpad_acpi driver to handle docking station events.
-	  This support was made obsolete by the generic ACPI docking station
-	  support (CONFIG_ACPI_DOCK).  It will allow locking and removing the
-	  laptop from the docking station, but will not properly connect PCI
-	  devices.
-
-	  If you are not sure, say N here.
-
-config THINKPAD_ACPI_BAY
-	bool "Legacy Removable Bay Support"
-	depends on THINKPAD_ACPI
-	depends on BROKEN
-	default n
-	---help---
-	  Allows the thinkpad_acpi driver to handle removable bays.  It will
-	  electrically disable the device in the bay, and also generate
-	  notifications when the bay lever is ejected or inserted.
-
-	  If you are not sure, say Y here.
-
 config THINKPAD_ACPI_VIDEO
 	bool "Video output control support"
 	depends on THINKPAD_ACPI
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a463fd7..27d68e7 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -239,12 +239,6 @@ struct ibm_init_struct {
 };
 
 static struct {
-#ifdef CONFIG_THINKPAD_ACPI_BAY
-	u32 bay_status:1;
-	u32 bay_eject:1;
-	u32 bay_status2:1;
-	u32 bay_eject2:1;
-#endif
 	u32 bluetooth:1;
 	u32 hotkey:1;
 	u32 hotkey_mask:1;
@@ -589,18 +583,6 @@ static int acpi_ec_write(int i, u8 v)
 	return 1;
 }
 
-#if defined(CONFIG_THINKPAD_ACPI_DOCK) || defined(CONFIG_THINKPAD_ACPI_BAY)
-static int _sta(acpi_handle handle)
-{
-	int status;
-
-	if (!handle || !acpi_evalf(handle, &status, "_STA", "d"))
-		status = 0;
-
-	return status;
-}
-#endif
-
 static int issue_thinkpad_cmos_command(int cmos_cmd)
 {
 	if (!cmos_handle)
@@ -4442,293 +4424,6 @@ static struct ibm_struct light_driver_data = {
 };
 
 /*************************************************************************
- * Dock subdriver
- */
-
-#ifdef CONFIG_THINKPAD_ACPI_DOCK
-
-static void dock_notify(struct ibm_struct *ibm, u32 event);
-static int dock_read(char *p);
-static int dock_write(char *buf);
-
-TPACPI_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
-	   "\\_SB.PCI0.DOCK",	/* 600e/x,770e,770x,A2xm/p,T20-22,X20-21 */
-	   "\\_SB.PCI0.PCI1.DOCK",	/* all others */
-	   "\\_SB.PCI.ISA.SLCE",	/* 570 */
-    );				/* A21e,G4x,R30,R31,R32,R40,R40e,R50e */
-
-/* don't list other alternatives as we install a notify handler on the 570 */
-TPACPI_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
-
-static const struct acpi_device_id ibm_pci_device_ids[] = {
-	{PCI_ROOT_HID_STRING, 0},
-	{"", 0},
-};
-
-static struct tp_acpi_drv_struct ibm_dock_acpidriver[2] = {
-	{
-	 .notify = dock_notify,
-	 .handle = &dock_handle,
-	 .type = ACPI_SYSTEM_NOTIFY,
-	},
-	{
-	/* THIS ONE MUST NEVER BE USED FOR DRIVER AUTOLOADING.
-	 * We just use it to get notifications of dock hotplug
-	 * in very old thinkpads */
-	 .hid = ibm_pci_device_ids,
-	 .notify = dock_notify,
-	 .handle = &pci_handle,
-	 .type = ACPI_SYSTEM_NOTIFY,
-	},
-};
-
-static struct ibm_struct dock_driver_data[2] = {
-	{
-	 .name = "dock",
-	 .read = dock_read,
-	 .write = dock_write,
-	 .acpi = &ibm_dock_acpidriver[0],
-	},
-	{
-	 .name = "dock",
-	 .acpi = &ibm_dock_acpidriver[1],
-	},
-};
-
-#define dock_docked() (_sta(dock_handle) & 1)
-
-static int __init dock_init(struct ibm_init_struct *iibm)
-{
-	vdbg_printk(TPACPI_DBG_INIT, "initializing dock subdriver\n");
-
-	TPACPI_ACPIHANDLE_INIT(dock);
-
-	vdbg_printk(TPACPI_DBG_INIT, "dock is %s\n",
-		str_supported(dock_handle != NULL));
-
-	return (dock_handle)? 0 : 1;
-}
-
-static int __init dock_init2(struct ibm_init_struct *iibm)
-{
-	int dock2_needed;
-
-	vdbg_printk(TPACPI_DBG_INIT, "initializing dock subdriver part 2\n");
-
-	if (dock_driver_data[0].flags.acpi_driver_registered &&
-	    dock_driver_data[0].flags.acpi_notify_installed) {
-		TPACPI_ACPIHANDLE_INIT(pci);
-		dock2_needed = (pci_handle != NULL);
-		vdbg_printk(TPACPI_DBG_INIT,
-			    "dock PCI handler for the TP 570 is %s\n",
-			    str_supported(dock2_needed));
-	} else {
-		vdbg_printk(TPACPI_DBG_INIT,
-		"dock subdriver part 2 not required\n");
-		dock2_needed = 0;
-	}
-
-	return (dock2_needed)? 0 : 1;
-}
-
-static void dock_notify(struct ibm_struct *ibm, u32 event)
-{
-	int docked = dock_docked();
-	int pci = ibm->acpi->hid && ibm->acpi->device &&
-		acpi_match_device_ids(ibm->acpi->device, ibm_pci_device_ids);
-	int data;
-
-	if (event == 1 && !pci)	/* 570 */
-		data = 1;	/* button */
-	else if (event == 1 && pci)	/* 570 */
-		data = 3;	/* dock */
-	else if (event == 3 && docked)
-		data = 1;	/* button */
-	else if (event == 3 && !docked)
-		data = 2;	/* undock */
-	else if (event == 0 && docked)
-		data = 3;	/* dock */
-	else {
-		printk(TPACPI_ERR "unknown dock event %d, status %d\n",
-		       event, _sta(dock_handle));
-		data = 0;	/* unknown */
-	}
-	acpi_bus_generate_proc_event(ibm->acpi->device, event, data);
-	acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
-					  dev_name(&ibm->acpi->device->dev),
-					  event, data);
-}
-
-static int dock_read(char *p)
-{
-	int len = 0;
-	int docked = dock_docked();
-
-	if (!dock_handle)
-		len += sprintf(p + len, "status:\t\tnot supported\n");
-	else if (!docked)
-		len += sprintf(p + len, "status:\t\tundocked\n");
-	else {
-		len += sprintf(p + len, "status:\t\tdocked\n");
-		len += sprintf(p + len, "commands:\tdock, undock\n");
-	}
-
-	return len;
-}
-
-static int dock_write(char *buf)
-{
-	char *cmd;
-
-	if (!dock_docked())
-		return -ENODEV;
-
-	while ((cmd = next_cmd(&buf))) {
-		if (strlencmp(cmd, "undock") == 0) {
-			if (!acpi_evalf(dock_handle, NULL, "_DCK", "vd", 0) ||
-			    !acpi_evalf(dock_handle, NULL, "_EJ0", "vd", 1))
-				return -EIO;
-		} else if (strlencmp(cmd, "dock") == 0) {
-			if (!acpi_evalf(dock_handle, NULL, "_DCK", "vd", 1))
-				return -EIO;
-		} else
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
-#endif /* CONFIG_THINKPAD_ACPI_DOCK */
-
-/*************************************************************************
- * Bay subdriver
- */
-
-#ifdef CONFIG_THINKPAD_ACPI_BAY
-
-TPACPI_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
-	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
-	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60 */
-	   "\\_SB.PCI0.IDE0.SCND.MSTR",	/* all others */
-	   );				/* A21e, R30, R31 */
-TPACPI_HANDLE(bay_ej, bay, "_EJ3",	/* 600e/x, A2xm/p, A3x */
-	   "_EJ0",		/* all others */
-	   );			/* 570,A21e,G4x,R30,R31,R32,R40e,R50e */
-TPACPI_HANDLE(bay2, root, "\\_SB.PCI0.IDE0.PRIM.SLAV",	/* A3x, R32 */
-	   "\\_SB.PCI0.IDE0.IDEP.IDPS",	/* 600e/x, 770e, 770x */
-	   );				/* all others */
-TPACPI_HANDLE(bay2_ej, bay2, "_EJ3",	/* 600e/x, 770e, A3x */
-	   "_EJ0",			/* 770x */
-	   );				/* all others */
-
-static int __init bay_init(struct ibm_init_struct *iibm)
-{
-	vdbg_printk(TPACPI_DBG_INIT, "initializing bay subdriver\n");
-
-	TPACPI_ACPIHANDLE_INIT(bay);
-	if (bay_handle)
-		TPACPI_ACPIHANDLE_INIT(bay_ej);
-	TPACPI_ACPIHANDLE_INIT(bay2);
-	if (bay2_handle)
-		TPACPI_ACPIHANDLE_INIT(bay2_ej);
-
-	tp_features.bay_status = bay_handle &&
-		acpi_evalf(bay_handle, NULL, "_STA", "qv");
-	tp_features.bay_status2 = bay2_handle &&
-		acpi_evalf(bay2_handle, NULL, "_STA", "qv");
-
-	tp_features.bay_eject = bay_handle && bay_ej_handle &&
-		(strlencmp(bay_ej_path, "_EJ0") == 0 || experimental);
-	tp_features.bay_eject2 = bay2_handle && bay2_ej_handle &&
-		(strlencmp(bay2_ej_path, "_EJ0") == 0 || experimental);
-
-	vdbg_printk(TPACPI_DBG_INIT,
-		"bay 1: status %s, eject %s; bay 2: status %s, eject %s\n",
-		str_supported(tp_features.bay_status),
-		str_supported(tp_features.bay_eject),
-		str_supported(tp_features.bay_status2),
-		str_supported(tp_features.bay_eject2));
-
-	return (tp_features.bay_status || tp_features.bay_eject ||
-		tp_features.bay_status2 || tp_features.bay_eject2)? 0 : 1;
-}
-
-static void bay_notify(struct ibm_struct *ibm, u32 event)
-{
-	acpi_bus_generate_proc_event(ibm->acpi->device, event, 0);
-	acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
-					  dev_name(&ibm->acpi->device->dev),
-					  event, 0);
-}
-
-#define bay_occupied(b) (_sta(b##_handle) & 1)
-
-static int bay_read(char *p)
-{
-	int len = 0;
-	int occupied = bay_occupied(bay);
-	int occupied2 = bay_occupied(bay2);
-	int eject, eject2;
-
-	len += sprintf(p + len, "status:\t\t%s\n",
-		tp_features.bay_status ?
-			(occupied ? "occupied" : "unoccupied") :
-				"not supported");
-	if (tp_features.bay_status2)
-		len += sprintf(p + len, "status2:\t%s\n", occupied2 ?
-			       "occupied" : "unoccupied");
-
-	eject = tp_features.bay_eject && occupied;
-	eject2 = tp_features.bay_eject2 && occupied2;
-
-	if (eject && eject2)
-		len += sprintf(p + len, "commands:\teject, eject2\n");
-	else if (eject)
-		len += sprintf(p + len, "commands:\teject\n");
-	else if (eject2)
-		len += sprintf(p + len, "commands:\teject2\n");
-
-	return len;
-}
-
-static int bay_write(char *buf)
-{
-	char *cmd;
-
-	if (!tp_features.bay_eject && !tp_features.bay_eject2)
-		return -ENODEV;
-
-	while ((cmd = next_cmd(&buf))) {
-		if (tp_features.bay_eject && strlencmp(cmd, "eject") == 0) {
-			if (!acpi_evalf(bay_ej_handle, NULL, NULL, "vd", 1))
-				return -EIO;
-		} else if (tp_features.bay_eject2 &&
-			   strlencmp(cmd, "eject2") == 0) {
-			if (!acpi_evalf(bay2_ej_handle, NULL, NULL, "vd", 1))
-				return -EIO;
-		} else
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
-static struct tp_acpi_drv_struct ibm_bay_acpidriver = {
-	.notify = bay_notify,
-	.handle = &bay_handle,
-	.type = ACPI_SYSTEM_NOTIFY,
-};
-
-static struct ibm_struct bay_driver_data = {
-	.name = "bay",
-	.read = bay_read,
-	.write = bay_write,
-	.acpi = &ibm_bay_acpidriver,
-};
-
-#endif /* CONFIG_THINKPAD_ACPI_BAY */
-
-/*************************************************************************
  * CMOS subdriver
  */
 
@@ -7854,22 +7549,6 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 		.init = light_init,
 		.data = &light_driver_data,
 	},
-#ifdef CONFIG_THINKPAD_ACPI_DOCK
-	{
-		.init = dock_init,
-		.data = &dock_driver_data[0],
-	},
-	{
-		.init = dock_init2,
-		.data = &dock_driver_data[1],
-	},
-#endif
-#ifdef CONFIG_THINKPAD_ACPI_BAY
-	{
-		.init = bay_init,
-		.data = &bay_driver_data,
-	},
-#endif
 	{
 		.init = cmos_init,
 		.data = &cmos_driver_data,
@@ -7968,12 +7647,6 @@ TPACPI_PARAM(hotkey);
 TPACPI_PARAM(bluetooth);
 TPACPI_PARAM(video);
 TPACPI_PARAM(light);
-#ifdef CONFIG_THINKPAD_ACPI_DOCK
-TPACPI_PARAM(dock);
-#endif
-#ifdef CONFIG_THINKPAD_ACPI_BAY
-TPACPI_PARAM(bay);
-#endif /* CONFIG_THINKPAD_ACPI_BAY */
 TPACPI_PARAM(cmos);
 TPACPI_PARAM(led);
 TPACPI_PARAM(beep);
-- 
1.6.2.4

