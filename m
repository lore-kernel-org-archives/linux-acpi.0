From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] make acpi_bus_register_driver() consistent with pci_register_driver() (again)
Date: Fri, 29 Oct 2004 14:04:15 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200410291404.15482.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/IqgBILTvay48DD"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, linux-input-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_/IqgBILTvay48DD
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Change acpi_bus_register_driver() to return zero on success, negative
error on failure, like pci_register_driver() now does.

Also fix the asus_acpi and thinkpad_acpi drivers, which had screwed up
register/unregister behavior.  (The driver should remain registered as
long as it is loaded, regardless of whether devices were claimed at
acpi_bus_register_driver()-time).

Finally, the floppy and i8042 ACPI hooks need tweaking because they
relied on the "number of devices claimed" return value.  These are
exceptions to the general rule in that they register/unregister
immediately because all they need is presence and resource information
and there's no hope of them dealing with hot-plug.

--Boundary-00=_/IqgBILTvay48DD
Content-Type: text/x-diff;
  charset="us-ascii";
  name="acpi_bus_register_driver-return.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acpi_bus_register_driver-return.patch"

Change acpi_bus_register_driver() to return zero on success, negative
error on failure, like pci_register_driver() now does.

Also fix the asus_acpi and thinkpad_acpi drivers, which had screwed up
register/unregister behavior.  (The driver should remain registered as
long as it is loaded, regardless of whether devices were claimed at
acpi_bus_register_driver()-time).

Finally, the floppy and i8042 ACPI hooks need tweaking because they
relied on the "number of devices claimed" return value.  These are
exceptions to the general rule in that they register/unregister
immediately because all they need is presence and resource information
and there's no hope of them dealing with hot-plug.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

diff -u -ur 2.6.10-rc1-mm2/drivers/acpi/asus_acpi.c acpi-register2/drivers/acpi/asus_acpi.c
--- 2.6.10-rc1-mm2/drivers/acpi/asus_acpi.c	2004-10-29 12:56:32.577452441 -0600
+++ acpi-register2/drivers/acpi/asus_acpi.c	2004-10-29 13:02:00.475885924 -0600
@@ -1212,8 +1212,7 @@
 	asus_proc_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&asus_hotk_driver);
-	if (result < 1) {
-		acpi_bus_unregister_driver(&asus_hotk_driver);
+	if (result < 0) {
 		remove_proc_entry(PROC_ASUS, acpi_root_dir);
 		return -ENODEV;
 	}
diff -u -ur 2.6.10-rc1-mm2/drivers/acpi/scan.c acpi-register2/drivers/acpi/scan.c
--- 2.6.10-rc1-mm2/drivers/acpi/scan.c	2004-10-29 12:56:32.621397752 -0600
+++ acpi-register2/drivers/acpi/scan.c	2004-10-29 13:02:00.476862486 -0600
@@ -533,10 +533,9 @@
 	return_VALUE(0);
 }
 
-static int acpi_driver_attach(struct acpi_driver * drv)
+static void acpi_driver_attach(struct acpi_driver * drv)
 {
 	struct list_head * node, * next;
-	int count = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_driver_attach");
 
@@ -551,7 +550,6 @@
 		if (!acpi_bus_match(dev, drv)) {
 			if (!acpi_bus_driver_init(dev, drv)) {
 				atomic_inc(&drv->references);
-				count++;
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found driver [%s] for device [%s]\n",
 						  drv->name, dev->pnp.bus_id));
 			}
@@ -559,7 +557,6 @@
 		spin_lock(&acpi_device_lock);
 	}
 	spin_unlock(&acpi_device_lock);
-	return_VALUE(count);
 }
 
 static int acpi_driver_detach(struct acpi_driver * drv)
@@ -590,16 +587,13 @@
  * acpi_bus_register_driver 
  * ------------------------ 
  * Registers a driver with the ACPI bus.  Searches the namespace for all
- * devices that match the driver's criteria and binds.  Returns the
- * number of devices that were claimed by the driver, or a negative
- * error status for failure.
+ * devices that match the driver's criteria and binds.  Returns zero for
+ * success or a negative error status for failure.
  */
 int
 acpi_bus_register_driver (
 	struct acpi_driver	*driver)
 {
-	int count;
-
 	ACPI_FUNCTION_TRACE("acpi_bus_register_driver");
 
 	if (acpi_disabled)
@@ -611,9 +605,9 @@
 	spin_lock(&acpi_device_lock);
 	list_add_tail(&driver->node, &acpi_bus_drivers);
 	spin_unlock(&acpi_device_lock);
-	count = acpi_driver_attach(driver);
+	acpi_driver_attach(driver);
 
-	return_VALUE(count);
+	return_VALUE(0);
 }
 
 
@@ -627,21 +621,19 @@
 acpi_bus_unregister_driver (
 	struct acpi_driver	*driver)
 {
-	int error = 0;
-
 	ACPI_FUNCTION_TRACE("acpi_bus_unregister_driver");
 
-	if (driver) {
-		acpi_driver_detach(driver);
+	if (!driver)
+		return_VALUE(-EINVAL);
 
-		if (!atomic_read(&driver->references)) {
-			spin_lock(&acpi_device_lock);
-			list_del_init(&driver->node);
-			spin_unlock(&acpi_device_lock);
-		} 
-	} else 
-		error = -EINVAL;
-	return_VALUE(error);
+	acpi_driver_detach(driver);
+
+	if (!atomic_read(&driver->references)) {
+		spin_lock(&acpi_device_lock);
+		list_del_init(&driver->node);
+		spin_unlock(&acpi_device_lock);
+	} 
+	return_VALUE(0);
 }
 
 /**
diff -u -ur 2.6.10-rc1-mm2/drivers/acpi/thinkpad_acpi.c acpi-register2/drivers/acpi/thinkpad_acpi.c
--- 2.6.10-rc1-mm2/drivers/acpi/thinkpad_acpi.c	2004-10-29 12:56:32.625304002 -0600
+++ acpi-register2/drivers/acpi/thinkpad_acpi.c	2004-10-29 13:02:00.476862486 -0600
@@ -247,7 +247,7 @@
 		return -ENODEV;
 
 	result = acpi_bus_register_driver(&acpi_thinkpad_driver);
-	if (result != 1)
+	if (result < 0)
 		return -ENODEV;
 
 	printk(KERN_INFO LOGPREFIX "ACPI IBM Thinkpad Fn+Fx key driver version %s\n", DRIVER_VERSION);
diff -u -ur 2.6.10-rc1-mm2/drivers/block/floppy.c acpi-register2/drivers/block/floppy.c
--- 2.6.10-rc1-mm2/drivers/block/floppy.c	2004-10-29 12:56:32.669249314 -0600
+++ acpi-register2/drivers/block/floppy.c	2004-10-29 13:02:00.480768736 -0600
@@ -4248,7 +4248,7 @@
 	unsigned int dma_channel;
 };
 
-static acpi_status acpi_floppy_resource(struct acpi_resource *res, void *data)
+static acpi_status __init acpi_floppy_resource(struct acpi_resource *res, void *data)
 {
 	struct floppy_resources *fd = (struct floppy_resources *) data;
 	struct acpi_resource_io *io;
@@ -4289,7 +4289,7 @@
 	return AE_OK;
 }
 
-static int acpi_floppy_add(struct acpi_device *device)
+static int __init acpi_floppy_add(struct acpi_device *device)
 {
 	struct floppy_resources fd;
 	acpi_status status;
@@ -4303,7 +4303,7 @@
 
 	strncpy(acpi_device_name(device), "Floppy Controller",
 		sizeof(acpi_device_name(device)));
-	printk("ACPI: %s [%s] at I/O 0x%x-0x%x",
+	printk(KERN_INFO "ACPI: %s [%s] at I/O 0x%x-0x%x",
 		acpi_device_name(device), acpi_device_bid(device),
 		fd.io_region[0].base,
 		fd.io_region[0].base + fd.io_region[0].size - 1);
@@ -4362,7 +4362,7 @@
 	return 0;
 }
 
-static struct acpi_driver acpi_floppy_driver = {
+static struct acpi_driver acpi_floppy_driver __initdata = {
 	.name	= "floppy",
 	.ids	= "PNP0700",
 	.ops	= {
@@ -4370,30 +4370,32 @@
 	},
 };
 
-static int acpi_floppy_init(void)
+/*
+ * Return -ENODEV if ACPI claims no floppy controllers exist.  Otherwise,
+ * return zero after possibly updating the default I/O port and IRQ resources.
+ */
+static int __init acpi_floppy_init(void)
 {
 	int err;
 
 	if (no_acpi_floppy) {
-		printk("%s: ACPI detection disabled\n", DEVICE_NAME);
-		return -ENODEV;
+		printk(KERN_INFO "%s: ACPI detection disabled\n", DEVICE_NAME);
+		return 0;
 	}
 	err = acpi_bus_register_driver(&acpi_floppy_driver);
-	if (err >= 0)
-		acpi_floppy_registered = 1;
-	return err;
-}
+	if (err < 0)
+		return 0;	/* can't tell anything from ACPI */
 
-static void acpi_floppy_exit(void)
-{
-	if (acpi_floppy_registered) {
-		acpi_bus_unregister_driver(&acpi_floppy_driver);
-		acpi_floppy_registered = 0;
-	}
+	/*
+	 * All we needed was the number of floppy controllers and their
+	 * resources, and we can't deal with any sort of hotplug, so might as
+	 * well unregister now.
+	 */
+	acpi_bus_unregister_driver(&acpi_floppy_driver);
+	if (acpi_floppies == 0)
+		return -ENODEV;	/* ACPI says "no floppies here" */
+	return 0;
 }
-#else
-static inline int  acpi_floppy_init(void) { return -ENODEV; }
-static inline void acpi_floppy_exit(void) { }
 #endif
 
 int __init floppy_init(void)
@@ -4401,10 +4403,11 @@
 	int i, unit, drive;
 	int err, dr;
 
-	if (acpi_floppy_init() == 0) {
-		err = -ENODEV;
-		goto out_put_acpi;
-	}
+#ifdef CONFIG_ACPI
+	err = acpi_floppy_init();
+	if (err < 0)
+		return err;
+#endif
 
 	raw_cmd = NULL;
 
@@ -4590,8 +4593,6 @@
 		del_timer(&motor_off_timer[dr]);
 		put_disk(disks[dr]);
 	}
-out_put_acpi:
-	acpi_floppy_exit();
 	return err;
 }
 
@@ -4808,8 +4809,6 @@
 	/* eject disk, if any */
 	fd_eject(0);
 
-	acpi_floppy_exit();
-
 	wait_for_completion(&device_release);
 }
 
diff -u -ur 2.6.10-rc1-mm2/drivers/input/serio/i8042-x86ia64io.h acpi-register2/drivers/input/serio/i8042-x86ia64io.h
--- 2.6.10-rc1-mm2/drivers/input/serio/i8042-x86ia64io.h	2004-10-29 12:56:32.843077437 -0600
+++ acpi-register2/drivers/input/serio/i8042-x86ia64io.h	2004-10-29 13:02:00.481745299 -0600
@@ -98,9 +98,6 @@
 	unsigned int irq;
 };
 
-static int i8042_acpi_kbd_registered;
-static int i8042_acpi_aux_registered;
-
 static acpi_status i8042_acpi_parse_resource(struct acpi_resource *res, void *data)
 {
 	struct i8042_acpi_resources *i8042_res = data;
@@ -151,6 +148,8 @@
 	return AE_OK;
 }
 
+static int i8042_acpi_kbd_found;
+
 static int i8042_acpi_kbd_add(struct acpi_device *device)
 {
 	struct i8042_acpi_resources kbd_res;
@@ -182,13 +181,16 @@
 
 	strncpy(acpi_device_name(device), "PS/2 Keyboard Controller",
 		sizeof(acpi_device_name(device)));
-	printk("ACPI: %s [%s] at I/O 0x%x, 0x%x, irq %d\n",
+	printk(KERN_INFO "ACPI: %s [%s] at I/O 0x%x, 0x%x, irq %d\n",
 		acpi_device_name(device), acpi_device_bid(device),
 		i8042_data_reg, i8042_command_reg, i8042_kbd_irq);
+	i8042_acpi_kbd_found = 1;
 
 	return 0;
 }
 
+static int i8042_acpi_aux_found;
+
 static int i8042_acpi_aux_add(struct acpi_device *device)
 {
 	struct i8042_acpi_resources aux_res;
@@ -208,8 +210,9 @@
 
 	strncpy(acpi_device_name(device), "PS/2 Mouse Controller",
 		sizeof(acpi_device_name(device)));
-	printk("ACPI: %s [%s] at irq %d\n",
-		acpi_device_name(device), acpi_device_bid(device), i8042_aux_irq);
+	printk(KERN_INFO "ACPI: %s [%s] at irq %d\n", acpi_device_name(device),
+		acpi_device_bid(device), i8042_aux_irq);
+	i8042_acpi_aux_found = 1;
 
 	return 0;
 }
@@ -230,41 +233,42 @@
 	},
 };
 
+/*
+ * Return -ENODEV if ACPI claims no i8042 controllers exist.  Otherwise,
+ * return zero after possibly updating the default I/O port and IRQ resources.
+ */
 static int i8042_acpi_init(void)
 {
 	int result;
 
-	if (acpi_disabled || i8042_noacpi) {
-		printk("i8042: ACPI detection disabled\n");
+	if (i8042_noacpi) {
+		printk(KERN_INFO "i8042: ACPI detection disabled\n");
 		return 0;
 	}
 
 	result = acpi_bus_register_driver(&i8042_acpi_kbd_driver);
 	if (result < 0)
-		return result;
+		return 0;	/* can't tell from ACPI */
 
-	if (result == 0) {
-		acpi_bus_unregister_driver(&i8042_acpi_kbd_driver);
-		return -ENODEV;
-	}
-	i8042_acpi_kbd_registered = 1;
+	/*
+	 * All we needed was whether an i8042 is present and the resources,
+	 * and we can't deal with any sort of hotplug, so might as well
+	 * unregister now.
+	 */
+	acpi_bus_unregister_driver(&i8042_acpi_kbd_driver);
+	if (i8042_acpi_kbd_found == 0)
+		return -ENODEV;	/* ACPI says "no i8042 here" */
 
+	i8042_noaux = 1;
 	result = acpi_bus_register_driver(&i8042_acpi_aux_driver);
-	if (result >= 0)
-		i8042_acpi_aux_registered = 1;
-	if (result == 0)
-		i8042_noaux = 1;
-
-	return 0;
-}
+	if (result < 0)
+		return 0;
 
-static void i8042_acpi_exit(void)
-{
-	if (i8042_acpi_kbd_registered)
-		acpi_bus_unregister_driver(&i8042_acpi_kbd_driver);
+	acpi_bus_unregister_driver(&i8042_acpi_aux_driver);
+	if (i8042_acpi_aux_found)
+		i8042_noaux = 0;
 
-	if (i8042_acpi_aux_registered)
-		acpi_bus_unregister_driver(&i8042_acpi_aux_driver);
+	return 0;
 }
 #endif
 
@@ -282,7 +286,7 @@
 	i8042_aux_irq = I8042_MAP_IRQ(12);
 
 #ifdef CONFIG_ACPI
-	if (i8042_acpi_init())
+	if (i8042_acpi_init() < 0)
 		return -1;
 #endif
 
@@ -300,9 +304,6 @@
 
 static inline void i8042_platform_exit(void)
 {
-#ifdef CONFIG_ACPI
-	i8042_acpi_exit();
-#endif
 }
 
 #endif /* _I8042_X86IA64IO_H */

--Boundary-00=_/IqgBILTvay48DD--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
