From: Thomas Renninger <trenn@suse.de>
Subject: Autoload acpi modules via uevent and pnpacpi
Date: Thu, 03 Aug 2006 17:25:19 +0200
Message-ID: <1154618720.4302.542.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ffm3pNViaG1qois4beD+"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:47570 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964775AbWHCPVr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2006 11:21:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, thermal@o2.pl


--=-ffm3pNViaG1qois4beD+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I tried out the patch Bjorn sent some days ago to autoload ACPI modules
via udev. The attached patch is based on latest test tree and includes
Bjorn's code. This works, but is not nice.

I had to tweak pnp to:
  - also register ACPI devices which have no _CRS func
  - allow (one byte longer) ACPIXXXX _HIDs to be used as PNP ids.

Now I got the following modules autoloaded (without the need of any
userspace adjustments):
  battery, asus_acpi, button, ac (tested)
  
  fan, ibm_acpi, acpi_memhotplug, container, sbs,..
  (should also work, but untested)

I also wanted to use the suspend/resume stuff from there to point to the
acpi_driver->suspend/resume funcs, but this does not work as
pnp_driver->suspend/resume is used there, no idea whether this could be
mapped somehow, I didn't see an easy way.

Another problem is that e.g. thermal_zones do not have a PNP id.
We could add a dummy _HID like ACPI9999 for that one?

Is it intended to pass all ACPI devices to pnpacpi in future?
Not sure whether this is such a good idea.

IMO it's better to let the stuff stay or be added to drivers/acpi.
There already is suspend/resume for acpi devices there now, the uevent
stuff should also go there?

Comments?

    Thomas

 drivers/acpi/ac.c               |    2 +
 drivers/acpi/acpi_memhotplug.c  |    2 +
 drivers/acpi/asus_acpi.c        |    2 +
 drivers/acpi/battery.c          |    2 +
 drivers/acpi/button.c           |    4 ++
 drivers/acpi/fan.c              |    2 +
 drivers/acpi/ibm_acpi.c         |    3 ++
 drivers/acpi/sbs.c              |    2 +
 drivers/acpi/scan.c             |   15 ++++++++++
 drivers/pnp/driver.c            |   56 ++++++++++++++++++++++++++++++++++++++++
 drivers/pnp/pnpacpi/core.c      |   48 ++++++++++++++++++++++------------
 include/acpi/acpi_bus.h         |   30 +++++++++++----------
 include/linux/mod_devicetable.h |    4 +-
 13 files changed, 140 insertions(+), 32 deletions(-)

Index: linux-acpi-2.6.git_i386/drivers/acpi/ac.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/ac.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/ac.c
@@ -50,6 +50,8 @@ ACPI_MODULE_NAME("acpi_ac")
 MODULE_DESCRIPTION(ACPI_AC_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dACPI0003");
+
 extern struct proc_dir_entry *acpi_lock_ac_dir(void);
 extern void *acpi_unlock_ac_dir(struct proc_dir_entry *acpi_ac_dir);
 
Index: linux-acpi-2.6.git_i386/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/acpi_memhotplug.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/acpi_memhotplug.c
@@ -45,6 +45,8 @@ ACPI_MODULE_NAME("acpi_memory")
 MODULE_DESCRIPTION(ACPI_MEMORY_DEVICE_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dPNP0c80");
+
 /* ACPI _STA method values */
 #define ACPI_MEMORY_STA_PRESENT		(0x00000001UL)
 #define ACPI_MEMORY_STA_ENABLED		(0x00000002UL)
Index: linux-acpi-2.6.git_i386/drivers/acpi/asus_acpi.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/asus_acpi.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/asus_acpi.c
@@ -75,6 +75,8 @@ MODULE_AUTHOR("Julien Lerouge, Karol Koz
 MODULE_DESCRIPTION(ACPI_HOTK_NAME);
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dATK0100");
+
 static uid_t asus_uid;
 static gid_t asus_gid;
 module_param(asus_uid, uint, 0);
Index: linux-acpi-2.6.git_i386/drivers/acpi/battery.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/battery.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/battery.c
@@ -59,6 +59,8 @@ ACPI_MODULE_NAME("acpi_battery")
 MODULE_DESCRIPTION(ACPI_BATTERY_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dPNP0c0a");
+
 extern struct proc_dir_entry *acpi_lock_battery_dir(void);
 extern void *acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
 
Index: linux-acpi-2.6.git_i386/drivers/acpi/button.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/button.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/button.c
@@ -66,6 +66,10 @@ ACPI_MODULE_NAME("acpi_button")
 MODULE_DESCRIPTION(ACPI_BUTTON_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dPNP0c0c");
+MODULE_ALIAS("pnp:dPNP0c0d");
+MODULE_ALIAS("pnp:dPNP0c0e");
+
 static int acpi_button_add(struct acpi_device *device);
 static int acpi_button_remove(struct acpi_device *device, int type);
 static int acpi_button_info_open_fs(struct inode *inode, struct file *file);
Index: linux-acpi-2.6.git_i386/drivers/acpi/fan.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/fan.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/fan.c
@@ -46,6 +46,8 @@ ACPI_MODULE_NAME("acpi_fan")
 MODULE_DESCRIPTION(ACPI_FAN_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dPNP0c0b");
+
 static int acpi_fan_add(struct acpi_device *device);
 static int acpi_fan_remove(struct acpi_device *device, int type);
 static int acpi_fan_suspend(struct acpi_device *device, int state);
Index: linux-acpi-2.6.git_i386/drivers/acpi/ibm_acpi.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/ibm_acpi.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/ibm_acpi.c
@@ -93,6 +93,9 @@ MODULE_DESCRIPTION(IBM_DESC);
 MODULE_VERSION(IBM_VERSION);
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dIBM0068");
+MODULE_ALIAS("pnp:dIBM0068");
+
 #define IBM_DIR IBM_NAME
 
 #define IBM_LOG IBM_FILE ": "
Index: linux-acpi-2.6.git_i386/drivers/acpi/sbs.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/sbs.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/sbs.c
@@ -84,6 +84,8 @@ MODULE_AUTHOR("Rich Townsend");
 MODULE_DESCRIPTION("Smart Battery System ACPI interface driver");
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dACPI0001");
+
 static struct semaphore sbs_sem;
 
 #define	UPDATE_MODE		QUEUE_UPDATE_MODE
Index: linux-acpi-2.6.git_i386/drivers/acpi/scan.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/scan.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/scan.c
@@ -707,6 +707,21 @@ static int acpi_bus_get_flags(struct acp
 	if (ACPI_SUCCESS(status))
 		device->flags.removable = 1;
 
+	/* Presence of _DIS indicates 'suprise_removal_ok' */
+	status = acpi_get_handle(device->handle, "_DIS", &temp);
+	if (ACPI_SUCCESS(status))
+		device->flags.suprise_removal_ok = 1;
+
+	/* Presence of _DIS indicates 'suprise_removal_ok' */
+	status = acpi_get_handle(device->handle, "_SRS", &temp);
+	if (ACPI_SUCCESS(status))
+		device->flags.set_resourses = 1;
+
+	/* Presence of _DIS indicates 'suprise_removal_ok' */
+	status = acpi_get_handle(device->handle, "_CRS", &temp);
+	if (ACPI_SUCCESS(status))
+		device->flags.current_resourses = 1;
+
 	/* Presence of _EJD|_EJ0 indicates 'ejectable' */
 	status = acpi_get_handle(device->handle, "_EJD", &temp);
 	if (ACPI_SUCCESS(status))
Index: linux-acpi-2.6.git_i386/drivers/pnp/pnpacpi/core.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/pnp/pnpacpi/core.c
+++ linux-acpi-2.6.git_i386/drivers/pnp/pnpacpi/core.c
@@ -53,6 +53,20 @@ static inline int is_exclusive_device(st
 #define TEST_ALPHA(c) \
 	if (!('@' <= (c) || (c) <= 'Z')) \
 		return 0
+
+static int __init isacpiid(char *id)
+{
+	if (strncmp(id, "ACPI", 4))
+	    return 0;
+	TEST_HEX(id[4]);
+	TEST_HEX(id[5]);
+	TEST_HEX(id[6]);
+	TEST_HEX(id[7]);
+	if (id[8] != '\0')
+		return 0;
+	return 1;
+}
+
 static int __init ispnpidacpi(char *id)
 {
 	TEST_ALPHA(id[0]);
@@ -69,14 +83,18 @@ static int __init ispnpidacpi(char *id)
 
 static void __init pnpidacpi_to_pnpid(char *id, char *str)
 {
-	str[0] = id[0];
-	str[1] = id[1];
-	str[2] = id[2];
-	str[3] = tolower(id[3]);
-	str[4] = tolower(id[4]);
-	str[5] = tolower(id[5]);
-	str[6] = tolower(id[6]);
-	str[7] = '\0';
+	if (!strncmp(id, "ACPI", 4))
+		memcpy(str, id, 8);
+	else{
+		str[0] = id[0];
+		str[1] = id[1];
+		str[2] = id[2];
+		str[3] = tolower(id[3]);
+		str[4] = tolower(id[4]);
+		str[5] = tolower(id[5]);
+		str[6] = tolower(id[6]);
+		str[7] = '\0';
+	}
 }
 
 static int pnpacpi_get_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
@@ -128,14 +146,13 @@ static struct pnp_protocol pnpacpi_proto
 
 static int __init pnpacpi_add_device(struct acpi_device *device)
 {
-	acpi_handle temp = NULL;
 	acpi_status status;
 	struct pnp_id *dev_id;
 	struct pnp_dev *dev;
 
-	status = acpi_get_handle(device->handle, "_CRS", &temp);
-	if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
-		is_exclusive_device(device))
+	if ((!ispnpidacpi(acpi_device_hid(device)) &&
+	     !isacpiid(acpi_device_hid(device))) ||
+	    is_exclusive_device(device))
 		return 0;
 
 	pnp_dbg("ACPI device : hid %s", acpi_device_hid(device));
@@ -145,18 +162,17 @@ static int __init pnpacpi_add_device(str
 		return -ENOMEM;
 	}
 	dev->data = device->handle;
+
 	/* .enabled means if the device can decode the resources */
 	dev->active = device->status.enabled;
-	status = acpi_get_handle(device->handle, "_SRS", &temp);
-	if (ACPI_SUCCESS(status))
+	if (device->flags.set_resourses)
 		dev->capabilities |= PNP_CONFIGURABLE;
 	dev->capabilities |= PNP_READ;
 	if (device->flags.dynamic_status)
 		dev->capabilities |= PNP_WRITE;
 	if (device->flags.removable)
 		dev->capabilities |= PNP_REMOVABLE;
-	status = acpi_get_handle(device->handle, "_DIS", &temp);
-	if (ACPI_SUCCESS(status))
+	if (device->flags.suprise_removal_ok)
 		dev->capabilities |= PNP_DISABLE;
 
 	dev->protocol = &pnpacpi_protocol;
Index: linux-acpi-2.6.git_i386/include/acpi/acpi_bus.h
===================================================================
--- linux-acpi-2.6.git_i386.orig/include/acpi/acpi_bus.h
+++ linux-acpi-2.6.git_i386/include/acpi/acpi_bus.h
@@ -157,20 +157,22 @@ struct acpi_device_status {
 /* Flags */
 
 struct acpi_device_flags {
-	u32 dynamic_status:1;
-	u32 hardware_id:1;
-	u32 compatible_ids:1;
-	u32 bus_address:1;
-	u32 unique_id:1;
-	u32 removable:1;
-	u32 ejectable:1;
-	u32 lockable:1;
-	u32 suprise_removal_ok:1;
-	u32 power_manageable:1;
-	u32 performance_manageable:1;
-	u32 wake_capable:1;	/* Wakeup(_PRW) supported? */
-	u32 force_power_state:1;
-	u32 reserved:19;
+	u32 dynamic_status:1;		/* _STA */
+	u32 hardware_id:1;		/* _HID */
+	u32 compatible_ids:1;		/* _CID */
+	u32 bus_address:1;		/* _ADR */
+	u32 unique_id:1;		/* _UID */
+	u32 removable:1;		/* _RMV */
+	u32 ejectable:1;		/* _EJD/_EJ0 */
+	u32 lockable:1;			/* _LCK */
+	u32 suprise_removal_ok:1;	/* _DIS */
+	u32 power_manageable:1;		/* _PS0/_PR0 */
+	u32 performance_manageable:1;   /* not defined yet */
+	u32 wake_capable:1;		/* _PRW */
+	u32 force_power_state:1;	/* all fans */
+	u32 set_resourses:1;		/* _SRS */
+	u32 current_resourses:1;	/* _CRS */
+	u32 reserved:17;
 };
 
 /* File System */
Index: linux-acpi-2.6.git_i386/include/linux/mod_devicetable.h
===================================================================
--- linux-acpi-2.6.git_i386.orig/include/linux/mod_devicetable.h
+++ linux-acpi-2.6.git_i386/include/linux/mod_devicetable.h
@@ -149,8 +149,8 @@ struct ccw_device_id {
 #define CCW_DEVICE_ID_MATCH_DEVICE_MODEL	0x08
 
 
-#define PNP_ID_LEN	8
-#define PNP_MAX_DEVICES	8
+#define PNP_ID_LEN	9
+#define PNP_MAX_DEVICES	32
 
 struct pnp_device_id {
 	__u8 id[PNP_ID_LEN];
Index: linux-acpi-2.6.git_i386/drivers/pnp/driver.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/pnp/driver.c
+++ linux-acpi-2.6.git_i386/drivers/pnp/driver.c
@@ -191,9 +191,65 @@ static int pnp_bus_resume(struct device 
 	return 0;
 }
 
+static int pnp_uevent(struct device *dev, char **envp, int num_envp,
+                     char *buffer, int buffer_size)
+{
+	struct pnp_dev *pdev;
+	struct pnp_id *pos;
+	int i = 0;
+	int length = 0;
+	int ids = 0;
+	char *id_buffer, *p;
+	
+	if (!dev)
+		return -ENODEV;
+	
+	pdev = to_pnp_dev(dev);
+	if (!pdev)
+		return -ENODEV;
+
+	for (pos = pdev->id; pos; pos = pos->next)
+		ids++;
+	
+	id_buffer = kmalloc(ids * 9, GFP_KERNEL);
+	if (!id_buffer)
+		return -ENOMEM;
+	
+	p = id_buffer;
+	for (pos = pdev->id; pos; pos = pos->next)
+		p += scnprintf(p, 9, "%s%c", pos->id, pos->next ? ':' : '\0');
+	
+	printk (KERN_INFO "Throwing pnp event for: %s\n", id_buffer);
+	printk (KERN_INFO "MODALIAS=pnp:d%s", id_buffer);
+
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "PNP_ID=%s", id_buffer)) {
+		kfree(id_buffer);
+		return -ENOMEM;
+	}
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "MODALIAS=pnp:d%s", id_buffer)) {
+		kfree(id_buffer);
+		return -ENOMEM;
+	}
+	
+	kfree(id_buffer);
+	
+	if (add_uevent_var(envp, num_envp, &i,
+                          buffer, buffer_size, &length,
+			   "PNP_DEVICE_NODE=%s", dev->bus_id))
+		return -ENOMEM;
+	
+	envp[i] = NULL;
+	return 0;
+}
+
 struct bus_type pnp_bus_type = {
 	.name	= "pnp",
 	.match	= pnp_bus_match,
+        .uevent = pnp_uevent,
 	.probe	= pnp_device_probe,
 	.remove	= pnp_device_remove,
 	.suspend = pnp_bus_suspend,


--=-ffm3pNViaG1qois4beD+
Content-Disposition: attachment; filename=acpi_pnp_uevent.patch
Content-Type: text/x-patch; name=acpi_pnp_uevent.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

 drivers/acpi/ac.c               |    2 +
 drivers/acpi/acpi_memhotplug.c  |    2 +
 drivers/acpi/asus_acpi.c        |    2 +
 drivers/acpi/battery.c          |    2 +
 drivers/acpi/button.c           |    4 ++
 drivers/acpi/fan.c              |    2 +
 drivers/acpi/ibm_acpi.c         |    3 ++
 drivers/acpi/sbs.c              |    2 +
 drivers/acpi/scan.c             |   15 ++++++++++
 drivers/pnp/driver.c            |   56 ++++++++++++++++++++++++++++++++++++++++
 drivers/pnp/pnpacpi/core.c      |   48 ++++++++++++++++++++++------------
 include/acpi/acpi_bus.h         |   30 +++++++++++----------
 include/linux/mod_devicetable.h |    4 +-
 13 files changed, 140 insertions(+), 32 deletions(-)

Index: linux-acpi-2.6.git_i386/drivers/acpi/ac.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/ac.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/ac.c
@@ -50,6 +50,8 @@ ACPI_MODULE_NAME("acpi_ac")
 MODULE_DESCRIPTION(ACPI_AC_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dACPI0003");
+
 extern struct proc_dir_entry *acpi_lock_ac_dir(void);
 extern void *acpi_unlock_ac_dir(struct proc_dir_entry *acpi_ac_dir);
 
Index: linux-acpi-2.6.git_i386/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/acpi_memhotplug.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/acpi_memhotplug.c
@@ -45,6 +45,8 @@ ACPI_MODULE_NAME("acpi_memory")
 MODULE_DESCRIPTION(ACPI_MEMORY_DEVICE_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dPNP0c80");
+
 /* ACPI _STA method values */
 #define ACPI_MEMORY_STA_PRESENT		(0x00000001UL)
 #define ACPI_MEMORY_STA_ENABLED		(0x00000002UL)
Index: linux-acpi-2.6.git_i386/drivers/acpi/asus_acpi.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/asus_acpi.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/asus_acpi.c
@@ -75,6 +75,8 @@ MODULE_AUTHOR("Julien Lerouge, Karol Koz
 MODULE_DESCRIPTION(ACPI_HOTK_NAME);
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dATK0100");
+
 static uid_t asus_uid;
 static gid_t asus_gid;
 module_param(asus_uid, uint, 0);
Index: linux-acpi-2.6.git_i386/drivers/acpi/battery.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/battery.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/battery.c
@@ -59,6 +59,8 @@ ACPI_MODULE_NAME("acpi_battery")
 MODULE_DESCRIPTION(ACPI_BATTERY_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dPNP0c0a");
+
 extern struct proc_dir_entry *acpi_lock_battery_dir(void);
 extern void *acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
 
Index: linux-acpi-2.6.git_i386/drivers/acpi/button.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/button.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/button.c
@@ -66,6 +66,10 @@ ACPI_MODULE_NAME("acpi_button")
 MODULE_DESCRIPTION(ACPI_BUTTON_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dPNP0c0c");
+MODULE_ALIAS("pnp:dPNP0c0d");
+MODULE_ALIAS("pnp:dPNP0c0e");
+
 static int acpi_button_add(struct acpi_device *device);
 static int acpi_button_remove(struct acpi_device *device, int type);
 static int acpi_button_info_open_fs(struct inode *inode, struct file *file);
Index: linux-acpi-2.6.git_i386/drivers/acpi/fan.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/fan.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/fan.c
@@ -46,6 +46,8 @@ ACPI_MODULE_NAME("acpi_fan")
 MODULE_DESCRIPTION(ACPI_FAN_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dPNP0c0b");
+
 static int acpi_fan_add(struct acpi_device *device);
 static int acpi_fan_remove(struct acpi_device *device, int type);
 static int acpi_fan_suspend(struct acpi_device *device, int state);
Index: linux-acpi-2.6.git_i386/drivers/acpi/ibm_acpi.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/ibm_acpi.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/ibm_acpi.c
@@ -93,6 +93,9 @@ MODULE_DESCRIPTION(IBM_DESC);
 MODULE_VERSION(IBM_VERSION);
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dIBM0068");
+MODULE_ALIAS("pnp:dIBM0068");
+
 #define IBM_DIR IBM_NAME
 
 #define IBM_LOG IBM_FILE ": "
Index: linux-acpi-2.6.git_i386/drivers/acpi/sbs.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/sbs.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/sbs.c
@@ -84,6 +84,8 @@ MODULE_AUTHOR("Rich Townsend");
 MODULE_DESCRIPTION("Smart Battery System ACPI interface driver");
 MODULE_LICENSE("GPL");
 
+MODULE_ALIAS("pnp:dACPI0001");
+
 static struct semaphore sbs_sem;
 
 #define	UPDATE_MODE		QUEUE_UPDATE_MODE
Index: linux-acpi-2.6.git_i386/drivers/acpi/scan.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/acpi/scan.c
+++ linux-acpi-2.6.git_i386/drivers/acpi/scan.c
@@ -707,6 +707,21 @@ static int acpi_bus_get_flags(struct acp
 	if (ACPI_SUCCESS(status))
 		device->flags.removable = 1;
 
+	/* Presence of _DIS indicates 'suprise_removal_ok' */
+	status = acpi_get_handle(device->handle, "_DIS", &temp);
+	if (ACPI_SUCCESS(status))
+		device->flags.suprise_removal_ok = 1;
+
+	/* Presence of _DIS indicates 'suprise_removal_ok' */
+	status = acpi_get_handle(device->handle, "_SRS", &temp);
+	if (ACPI_SUCCESS(status))
+		device->flags.set_resourses = 1;
+
+	/* Presence of _DIS indicates 'suprise_removal_ok' */
+	status = acpi_get_handle(device->handle, "_CRS", &temp);
+	if (ACPI_SUCCESS(status))
+		device->flags.current_resourses = 1;
+
 	/* Presence of _EJD|_EJ0 indicates 'ejectable' */
 	status = acpi_get_handle(device->handle, "_EJD", &temp);
 	if (ACPI_SUCCESS(status))
Index: linux-acpi-2.6.git_i386/drivers/pnp/pnpacpi/core.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/pnp/pnpacpi/core.c
+++ linux-acpi-2.6.git_i386/drivers/pnp/pnpacpi/core.c
@@ -53,6 +53,20 @@ static inline int is_exclusive_device(st
 #define TEST_ALPHA(c) \
 	if (!('@' <= (c) || (c) <= 'Z')) \
 		return 0
+
+static int __init isacpiid(char *id)
+{
+	if (strncmp(id, "ACPI", 4))
+	    return 0;
+	TEST_HEX(id[4]);
+	TEST_HEX(id[5]);
+	TEST_HEX(id[6]);
+	TEST_HEX(id[7]);
+	if (id[8] != '\0')
+		return 0;
+	return 1;
+}
+
 static int __init ispnpidacpi(char *id)
 {
 	TEST_ALPHA(id[0]);
@@ -69,14 +83,18 @@ static int __init ispnpidacpi(char *id)
 
 static void __init pnpidacpi_to_pnpid(char *id, char *str)
 {
-	str[0] = id[0];
-	str[1] = id[1];
-	str[2] = id[2];
-	str[3] = tolower(id[3]);
-	str[4] = tolower(id[4]);
-	str[5] = tolower(id[5]);
-	str[6] = tolower(id[6]);
-	str[7] = '\0';
+	if (!strncmp(id, "ACPI", 4))
+		memcpy(str, id, 8);
+	else{
+		str[0] = id[0];
+		str[1] = id[1];
+		str[2] = id[2];
+		str[3] = tolower(id[3]);
+		str[4] = tolower(id[4]);
+		str[5] = tolower(id[5]);
+		str[6] = tolower(id[6]);
+		str[7] = '\0';
+	}
 }
 
 static int pnpacpi_get_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
@@ -128,14 +146,13 @@ static struct pnp_protocol pnpacpi_proto
 
 static int __init pnpacpi_add_device(struct acpi_device *device)
 {
-	acpi_handle temp = NULL;
 	acpi_status status;
 	struct pnp_id *dev_id;
 	struct pnp_dev *dev;
 
-	status = acpi_get_handle(device->handle, "_CRS", &temp);
-	if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
-		is_exclusive_device(device))
+	if ((!ispnpidacpi(acpi_device_hid(device)) &&
+	     !isacpiid(acpi_device_hid(device))) ||
+	    is_exclusive_device(device))
 		return 0;
 
 	pnp_dbg("ACPI device : hid %s", acpi_device_hid(device));
@@ -145,18 +162,17 @@ static int __init pnpacpi_add_device(str
 		return -ENOMEM;
 	}
 	dev->data = device->handle;
+
 	/* .enabled means if the device can decode the resources */
 	dev->active = device->status.enabled;
-	status = acpi_get_handle(device->handle, "_SRS", &temp);
-	if (ACPI_SUCCESS(status))
+	if (device->flags.set_resourses)
 		dev->capabilities |= PNP_CONFIGURABLE;
 	dev->capabilities |= PNP_READ;
 	if (device->flags.dynamic_status)
 		dev->capabilities |= PNP_WRITE;
 	if (device->flags.removable)
 		dev->capabilities |= PNP_REMOVABLE;
-	status = acpi_get_handle(device->handle, "_DIS", &temp);
-	if (ACPI_SUCCESS(status))
+	if (device->flags.suprise_removal_ok)
 		dev->capabilities |= PNP_DISABLE;
 
 	dev->protocol = &pnpacpi_protocol;
Index: linux-acpi-2.6.git_i386/include/acpi/acpi_bus.h
===================================================================
--- linux-acpi-2.6.git_i386.orig/include/acpi/acpi_bus.h
+++ linux-acpi-2.6.git_i386/include/acpi/acpi_bus.h
@@ -157,20 +157,22 @@ struct acpi_device_status {
 /* Flags */
 
 struct acpi_device_flags {
-	u32 dynamic_status:1;
-	u32 hardware_id:1;
-	u32 compatible_ids:1;
-	u32 bus_address:1;
-	u32 unique_id:1;
-	u32 removable:1;
-	u32 ejectable:1;
-	u32 lockable:1;
-	u32 suprise_removal_ok:1;
-	u32 power_manageable:1;
-	u32 performance_manageable:1;
-	u32 wake_capable:1;	/* Wakeup(_PRW) supported? */
-	u32 force_power_state:1;
-	u32 reserved:19;
+	u32 dynamic_status:1;		/* _STA */
+	u32 hardware_id:1;		/* _HID */
+	u32 compatible_ids:1;		/* _CID */
+	u32 bus_address:1;		/* _ADR */
+	u32 unique_id:1;		/* _UID */
+	u32 removable:1;		/* _RMV */
+	u32 ejectable:1;		/* _EJD/_EJ0 */
+	u32 lockable:1;			/* _LCK */
+	u32 suprise_removal_ok:1;	/* _DIS */
+	u32 power_manageable:1;		/* _PS0/_PR0 */
+	u32 performance_manageable:1;   /* not defined yet */
+	u32 wake_capable:1;		/* _PRW */
+	u32 force_power_state:1;	/* all fans */
+	u32 set_resourses:1;		/* _SRS */
+	u32 current_resourses:1;	/* _CRS */
+	u32 reserved:17;
 };
 
 /* File System */
Index: linux-acpi-2.6.git_i386/include/linux/mod_devicetable.h
===================================================================
--- linux-acpi-2.6.git_i386.orig/include/linux/mod_devicetable.h
+++ linux-acpi-2.6.git_i386/include/linux/mod_devicetable.h
@@ -149,8 +149,8 @@ struct ccw_device_id {
 #define CCW_DEVICE_ID_MATCH_DEVICE_MODEL	0x08
 
 
-#define PNP_ID_LEN	8
-#define PNP_MAX_DEVICES	8
+#define PNP_ID_LEN	9
+#define PNP_MAX_DEVICES	32
 
 struct pnp_device_id {
 	__u8 id[PNP_ID_LEN];
Index: linux-acpi-2.6.git_i386/drivers/pnp/driver.c
===================================================================
--- linux-acpi-2.6.git_i386.orig/drivers/pnp/driver.c
+++ linux-acpi-2.6.git_i386/drivers/pnp/driver.c
@@ -191,9 +191,65 @@ static int pnp_bus_resume(struct device 
 	return 0;
 }
 
+static int pnp_uevent(struct device *dev, char **envp, int num_envp,
+                     char *buffer, int buffer_size)
+{
+	struct pnp_dev *pdev;
+	struct pnp_id *pos;
+	int i = 0;
+	int length = 0;
+	int ids = 0;
+	char *id_buffer, *p;
+	
+	if (!dev)
+		return -ENODEV;
+	
+	pdev = to_pnp_dev(dev);
+	if (!pdev)
+		return -ENODEV;
+
+	for (pos = pdev->id; pos; pos = pos->next)
+		ids++;
+	
+	id_buffer = kmalloc(ids * 9, GFP_KERNEL);
+	if (!id_buffer)
+		return -ENOMEM;
+	
+	p = id_buffer;
+	for (pos = pdev->id; pos; pos = pos->next)
+		p += scnprintf(p, 9, "%s%c", pos->id, pos->next ? ':' : '\0');
+	
+	printk (KERN_INFO "Throwing pnp event for: %s\n", id_buffer);
+	printk (KERN_INFO "MODALIAS=pnp:d%s", id_buffer);
+
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "PNP_ID=%s", id_buffer)) {
+		kfree(id_buffer);
+		return -ENOMEM;
+	}
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "MODALIAS=pnp:d%s", id_buffer)) {
+		kfree(id_buffer);
+		return -ENOMEM;
+	}
+	
+	kfree(id_buffer);
+	
+	if (add_uevent_var(envp, num_envp, &i,
+                          buffer, buffer_size, &length,
+			   "PNP_DEVICE_NODE=%s", dev->bus_id))
+		return -ENOMEM;
+	
+	envp[i] = NULL;
+	return 0;
+}
+
 struct bus_type pnp_bus_type = {
 	.name	= "pnp",
 	.match	= pnp_bus_match,
+        .uevent = pnp_uevent,
 	.probe	= pnp_device_probe,
 	.remove	= pnp_device_remove,
 	.suspend = pnp_bus_suspend,

--=-ffm3pNViaG1qois4beD+--

