From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: ACPI: cleanup scan.c whitespace & coding style
Date: Wed, 27 Jul 2005 16:30:58 -0600
Message-ID: <200507271630.58757.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Make whitespace/coding style consistent.  No functional change (produces
object code identical to pre-patch version).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

Index: work/drivers/acpi/scan.c
===================================================================
--- work.orig/drivers/acpi/scan.c	2005-07-26 15:12:40.000000000 -0600
+++ work/drivers/acpi/scan.c	2005-07-26 15:13:56.000000000 -0600
@@ -27,11 +27,10 @@
 DEFINE_SPINLOCK(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 
-static int
-acpi_bus_trim(struct acpi_device	*start,
-		int rmdevice);
+static int acpi_bus_trim(struct acpi_device *start, int rmdevice);
 
-static void acpi_device_release(struct kobject * kobj)
+static void acpi_device_release (
+	struct kobject	*kobj)
 {
 	struct acpi_device * dev = container_of(kobj,struct acpi_device,kobj);
 	if (dev->pnp.cid_list)
@@ -85,13 +84,17 @@
 	.release	= acpi_device_release,
 };
 
-static int namespace_hotplug(struct kset *kset, struct kobject *kobj,
-			     char **envp, int num_envp, char *buffer,
-			     int buffer_size)
-{
-	struct acpi_device *dev = to_acpi_device(kobj);
-	int i = 0;
-	int len = 0;
+static int namespace_hotplug (
+	struct kset		*kset,
+	struct kobject		*kobj,
+	char			**envp,
+	int			num_envp,
+	char			*buffer,
+	int			buffer_size)
+{
+	struct acpi_device	*dev = to_acpi_device(kobj);
+	int			i = 0;
+	int			len = 0;
 
 	if (!dev->driver)
 		return 0;
@@ -110,7 +113,7 @@
 };
 
 static struct kset acpi_namespace_kset = {
-	.kobj		= { 
+	.kobj		= {
 		.name = "namespace",
 	},
 	.subsys = &acpi_subsys,
@@ -119,7 +122,9 @@
 };
 
 
-static void acpi_device_register(struct acpi_device * device, struct acpi_device * parent)
+static void acpi_device_register (
+	struct acpi_device	*device,
+	struct acpi_device	*parent)
 {
 	/*
 	 * Linkage
@@ -152,7 +157,7 @@
 
 static int
 acpi_device_unregister (
-	struct acpi_device	*device, 
+	struct acpi_device	*device,
 	int			type)
 {
 	spin_lock(&acpi_device_lock);
@@ -277,7 +282,7 @@
 	struct acpi_device	*device,
 	union acpi_object	*package)
 {
-	int 	 i = 0;
+	int			i = 0;
 	union acpi_object	*element = NULL;
 
 	if (!device || !package || (package->package.count < 2))
@@ -293,9 +298,9 @@
 			return AE_BAD_DATA;
 		device->wakeup.gpe_device = element->package.elements[0].reference.handle;
 		device->wakeup.gpe_number = (u32)element->package.elements[1].integer.value;
-	}else if (element->type == ACPI_TYPE_INTEGER) {
+	} else if (element->type == ACPI_TYPE_INTEGER) {
 		device->wakeup.gpe_number = element->integer.value;
-	}else
+	} else
 		return AE_BAD_DATA;
 
 	element = &(package->package.elements[1]);
@@ -308,7 +313,7 @@
 		return AE_NO_MEMORY;
 	}
 	device->wakeup.resources.count = package->package.count - 2;
-	for (i=0; i < device->wakeup.resources.count; i++) {
+	for (i = 0; i < device->wakeup.resources.count; i++) {
 		element = &(package->package.elements[i + 2]);
 		if (element->type != ACPI_TYPE_ANY ) {
 			return AE_BAD_DATA;
@@ -324,7 +329,7 @@
 acpi_bus_get_wakeup_device_flags (
 	struct acpi_device	*device)
 {
-	acpi_status	status = 0;
+	acpi_status		status = 0;
 	struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object	*package = NULL;
 
@@ -360,7 +365,7 @@
 /* --------------------------------------------------------------------------
 		ACPI hotplug sysfs device file support
    -------------------------------------------------------------------------- */
-static ssize_t acpi_eject_store(struct acpi_device *device, 
+static ssize_t acpi_eject_store(struct acpi_device *device,
 		const char *buf, size_t count);
 
 #define ACPI_DEVICE_ATTR(_name,_mode,_show,_store) \
@@ -376,7 +381,7 @@
  */
 static void
 setup_sys_fs_device_files (
-	struct acpi_device *dev,
+	struct acpi_device	*dev,
 	acpi_device_sysfs_files *func)
 {
 	acpi_status		status;
@@ -392,11 +397,13 @@
 }
 
 static int
-acpi_eject_operation(acpi_handle handle, int lockable)
+acpi_eject_operation (
+	acpi_handle		handle,
+	int			lockable)
 {
 	struct acpi_object_list arg_list;
-	union acpi_object arg;
-	acpi_status status = AE_OK;
+	union acpi_object	arg;
+	acpi_status		status = AE_OK;
 
 	/*
 	 * TBD: evaluate _PS3?
@@ -427,15 +434,17 @@
 	return(0);
 }
 
-
 static ssize_t
-acpi_eject_store(struct acpi_device *device, const char *buf, size_t count)
+acpi_eject_store (
+	struct acpi_device	*device,
+	const char		*buf,
+	size_t			count)
 {
-	int	result;
-	int	ret = count;
-	int	islockable;
-	acpi_status	status;
-	acpi_handle	handle;
+	int			result;
+	int			ret = count;
+	int			islockable;
+	acpi_status		status;
+	acpi_handle		handle;
 	acpi_object_type	type = 0;
 
 	if ((!count) || (buf[0] != '1')) {
@@ -492,9 +501,8 @@
 static LIST_HEAD(acpi_bus_drivers);
 static DECLARE_MUTEX(acpi_bus_drivers_lock);
 
-
 /**
- * acpi_bus_match 
+ * acpi_bus_match
  * --------------
  * Checks the device's hardware (_HID) or compatible (_CID) ids to see if it
  * matches the specified driver's criteria.
@@ -509,16 +517,15 @@
 	return acpi_match_ids(device, driver->ids);
 }
 
-
 /**
- * acpi_bus_driver_init 
+ * acpi_bus_driver_init
  * --------------------
- * Used to initialize a device via its device driver.  Called whenever a 
+ * Used to initialize a device via its device driver.  Called whenever a
  * driver is bound to a device.  Invokes the driver's add() and start() ops.
  */
 static int
 acpi_bus_driver_init (
-	struct acpi_device	*device, 
+	struct acpi_device	*device,
 	struct acpi_driver	*driver)
 {
 	int			result = 0;
@@ -551,10 +558,10 @@
 
 int
 acpi_start_single_object (
-		struct acpi_device *device)
+	struct acpi_device	*device)
 {
-	int result = 0;
-	struct acpi_driver *driver;
+	int			result = 0;
+	struct acpi_driver	*driver;
 
 	ACPI_FUNCTION_TRACE("acpi_start_single_object");
 
@@ -570,9 +577,10 @@
 	return_VALUE(result);
 }
 
-static void acpi_driver_attach(struct acpi_driver * drv)
+static void acpi_driver_attach (
+	struct acpi_driver	*drv)
 {
-	struct list_head * node, * next;
+	struct list_head	*node, *next;
 
 	ACPI_FUNCTION_TRACE("acpi_driver_attach");
 
@@ -597,9 +605,10 @@
 	spin_unlock(&acpi_device_lock);
 }
 
-static int acpi_driver_detach(struct acpi_driver * drv)
+static int acpi_driver_detach (
+	struct acpi_driver	*drv)
 {
-	struct list_head * node, * next;
+	struct list_head	*node, *next;
 
 	ACPI_FUNCTION_TRACE("acpi_driver_detach");
 
@@ -622,8 +631,8 @@
 }
 
 /**
- * acpi_bus_register_driver 
- * ------------------------ 
+ * acpi_bus_register_driver
+ * ------------------------
  * Registers a driver with the ACPI bus.  Searches the namespace for all
  * devices that match the driver's criteria and binds.  Returns zero for
  * success or a negative error status for failure.
@@ -649,9 +658,8 @@
 }
 EXPORT_SYMBOL(acpi_bus_register_driver);
 
-
 /**
- * acpi_bus_unregister_driver 
+ * acpi_bus_unregister_driver
  * --------------------------
  * Unregisters a driver with the ACPI bus.  Searches the namespace for all
  * devices that match the driver's criteria and unbinds.
@@ -677,7 +685,7 @@
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
 
 /**
- * acpi_bus_find_driver 
+ * acpi_bus_find_driver
  * --------------------
  * Parses the list of registered drivers looking for a driver applicable for
  * the specified device.
@@ -716,7 +724,7 @@
                                  Device Enumeration
    -------------------------------------------------------------------------- */
 
-static int 
+static int
 acpi_bus_get_flags (
 	struct acpi_device	*device)
 {
@@ -772,7 +780,10 @@
 	return_VALUE(0);
 }
 
-static void acpi_device_get_busid(struct acpi_device * device, acpi_handle handle, int type)
+static void acpi_device_get_busid (
+	struct acpi_device	*device,
+	acpi_handle		handle,
+	int			type)
 {
 	char			bus_id[5] = {'?',0};
 	struct acpi_buffer	buffer = {sizeof(bus_id), bus_id};
@@ -808,8 +819,11 @@
 	}
 }
 
-static void acpi_device_set_id(struct acpi_device * device, struct acpi_device * parent,
-			       acpi_handle handle, int type)
+static void acpi_device_set_id (
+	struct acpi_device	*device,
+	struct acpi_device	*parent,
+	acpi_handle		handle,
+	int			type)
 {
 	struct acpi_device_info	*info;
 	struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
@@ -858,7 +872,7 @@
 		break;
 	}
 
-	/* 
+	/*
 	 * \_SB
 	 * ----
 	 * Fix for the system root bus device -- the only root-level device.
@@ -888,10 +902,13 @@
 	acpi_os_free(buffer.pointer);
 }
 
-static int acpi_device_set_context(struct acpi_device * device, int type)
+static int acpi_device_set_context (
+	struct acpi_device	*device,
+	int			type)
 {
-	acpi_status status = AE_OK;
-	int result = 0;
+	acpi_status		status = AE_OK;
+	int			result = 0;
+
 	/*
 	 * Context
 	 * -------
@@ -900,7 +917,7 @@
 	 * to be careful with fixed-feature devices as they all attach to the
 	 * root object.
 	 */
-	if (type != ACPI_BUS_TYPE_POWER_BUTTON && 
+	if (type != ACPI_BUS_TYPE_POWER_BUTTON &&
 	    type != ACPI_BUS_TYPE_SLEEP_BUTTON) {
 		status = acpi_attach_data(device->handle,
 			acpi_bus_data_handler, device);
@@ -913,11 +930,14 @@
 	return result;
 }
 
-static void acpi_device_get_debug_info(struct acpi_device * device, acpi_handle handle, int type)
+static void acpi_device_get_debug_info (
+	struct acpi_device	*device,
+	acpi_handle		handle,
+	int			type)
 {
 #ifdef CONFIG_ACPI_DEBUG_OUTPUT
-	char		*type_string = NULL;
-	char		name[80] = {'?','\0'};
+	char			*type_string = NULL;
+	char			name[80] = {'?','\0'};
 	struct acpi_buffer	buffer = {sizeof(name), name};
 
 	switch (type) {
@@ -955,15 +975,14 @@
 #endif /*CONFIG_ACPI_DEBUG_OUTPUT*/
 }
 
-
 static int
 acpi_bus_remove (
-	struct acpi_device *dev,
-	int rmdevice)
+	struct acpi_device	*dev,
+	int			rmdevice)
 {
 	int 			result = 0;
 	struct acpi_driver	*driver;
-	
+
 	ACPI_FUNCTION_TRACE("acpi_bus_remove");
 
 	if (!dev)
@@ -996,13 +1015,12 @@
 		if ((dev->parent) && (dev->parent->ops.unbind))
 			dev->parent->ops.unbind(dev);
 	}
-	
+
 	acpi_device_unregister(dev, ACPI_BUS_REMOVAL_EJECT);
 
 	return_VALUE(0);
 }
 
-
 static int
 acpi_add_single_object (
 	struct acpi_device	**child,
@@ -1118,7 +1136,7 @@
 	/*
 	 * Bind _ADR-Based Devices
 	 * -----------------------
-	 * If there's a a bus address (_ADR) then we utilize the parent's 
+	 * If there's a a bus address (_ADR) then we utilize the parent's
 	 * 'bind' function (if exists) to bind the ACPI- and natively-
 	 * enumerated device representations.
 	 */
@@ -1150,9 +1168,9 @@
 	return_VALUE(result);
 }
 
-
-static int acpi_bus_scan (struct acpi_device	*start,
-		struct acpi_bus_ops *ops)
+static int acpi_bus_scan (
+	struct acpi_device	*start,
+	struct acpi_bus_ops	*ops)
 {
 	acpi_status		status = AE_OK;
 	struct acpi_device	*parent = NULL;
@@ -1169,7 +1187,7 @@
 
 	parent = start;
 	phandle = start->handle;
-	
+
 	/*
 	 * Parse through the ACPI namespace, identify all 'devices', and
 	 * create a new 'struct acpi_device' for each.
@@ -1272,8 +1290,8 @@
 	acpi_handle		handle,
 	int			type)
 {
-	int result;
-	struct acpi_bus_ops ops;
+	int			result;
+	struct acpi_bus_ops	ops;
 
 	ACPI_FUNCTION_TRACE("acpi_bus_add");
 
@@ -1289,10 +1307,10 @@
 
 int
 acpi_bus_start (
-	struct acpi_device *device)
+	struct acpi_device	*device)
 {
-	int result;
-	struct acpi_bus_ops ops;
+	int			result;
+	struct acpi_bus_ops	ops;
 
 	ACPI_FUNCTION_TRACE("acpi_bus_start");
 
@@ -1310,8 +1328,9 @@
 EXPORT_SYMBOL(acpi_bus_start);
 
 static int
-acpi_bus_trim(struct acpi_device	*start,
-		int rmdevice)
+acpi_bus_trim (
+	struct acpi_device	*start,
+	int			rmdevice)
 {
 	acpi_status		status;
 	struct acpi_device	*parent, *child;
@@ -1397,11 +1416,10 @@
 	return_VALUE(result);
 }
 
-
 static int __init acpi_scan_init(void)
 {
-	int result;
-	struct acpi_bus_ops ops;
+	int			result;
+	struct acpi_bus_ops	ops;
 
 	ACPI_FUNCTION_TRACE("acpi_scan_init");
 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
