From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [RFC] filling in ACPI files in sysfs
Date: Wed, 07 Apr 2004 16:13:43 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081376023.2748.15.camel@patsy.fc.hp.com>
References: <1081373781.23176.30.camel@t40>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1081373781.23176.30.camel-LjAuIDrFwz0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Cc: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-04-07 at 15:36, Paul Ionescu wrote:
> Hi Alex,
> 
> I patch-ed a 2.6.5 kernel, and boot-ed an IBM T30 Thinkpad Laptop.
> It looks nice at first sight, and now I want _Qxx methods in /EC to play
> with :)
> 
> What I found strange is the following behaviour:
> If I boot with my second battery inserted, I have the corresponding
> entries for BAT1 in /proc/acpi/battery and /sys/.../EC/BAT1
> If I boot without my second battery inserted, and I insert it later on,
> I don't have the corresponding BAT1 directory for it in /proc/acpi and
> /sys/.../EC/.
> And this is true for other acpi devices too.
> I think that the problem is that it does not (yet) update the list of
> active devices in real time, but uses the list with devices detected at
> boot time.

   Yeah, we were only filling in devices that the _STA method claimed
were present at boot.  I've fixed that now.

> Anyway, this is a good start, and I am waiting for more patches to test.

   Here you go, a second iteration.  I haven't looked at the _Qxx
methods yet, but we're up to over 30 methods exported now.  I've added
several writable methods so you can do more than query status.  I've
been able to undock my omnibook 500 laptop (electromechanical eject) and
switch between a CRT and LCD using only the sysfs interface.  I thought
about parsing some of the more complicated data structures, but that
turned into way too much code too quickly.  So you'll find there are
several entries that return a binary dump of the data structures.  these
include _CRS, _PRS, _PRT, and _MAT.  Some of the methods look like they
should work, but I don't have a box w/ firmware that exports them, so
let me know if the output is broken.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

===== drivers/acpi/scan.c 1.22 vs edited =====
--- 1.22/drivers/acpi/scan.c	Tue Feb  3 22:29:19 2004
+++ edited/drivers/acpi/scan.c	Wed Apr  7 15:55:17 2004
@@ -7,6 +7,7 @@
 
 #include <acpi/acpi_drivers.h>
 #include <acpi/acinterp.h>	/* for acpi_ex_eisa_id_to_string() */
+#include <acpi/actypes.h>
 
 
 #define _COMPONENT		ACPI_BUS_COMPONENT
@@ -22,9 +23,326 @@
 #define ACPI_BUS_DRIVER_NAME		"ACPI Bus Driver"
 #define ACPI_BUS_DEVICE_NAME		"System Bus"
 
+#define METHOD_NAME__BCL		"_BCL"
+#define METHOD_NAME__BCM		"_BCM"
+#define METHOD_NAME__DCK		"_DCK"
+#define METHOD_NAME__DCS		"_DCS"
+#define METHOD_NAME__DGS		"_DGS"
+#define METHOD_NAME__DDN		"_DDN"
+#define METHOD_NAME__DSS		"_DSS"
+#define METHOD_NAME__DOS		"_DOS"
+#define METHOD_NAME__DOD		"_DOD"
+#define METHOD_NAME__EDL		"_EDL"
+#define METHOD_NAME__EJ0		"_EJ0"
+#define METHOD_NAME__EJD		"_EJD"
+#define METHOD_NAME__FIX		"_FIX"
+#define METHOD_NAME__HPP		"_HPP"
+#define METHOD_NAME__LCK		"_LCK"
+#define METHOD_NAME__LID		"_LID"
+#define METHOD_NAME__MAT		"_MAT"
+#define METHOD_NAME__PXM		"_PXM"
+#define METHOD_NAME__RMV		"_RMV"
+#define METHOD_NAME__STR		"_STR"
+#define METHOD_NAME__SUN		"_SUN"
+
 static LIST_HEAD(acpi_device_list);
 static spinlock_t acpi_device_lock = SPIN_LOCK_UNLOCKED;
 
+struct acpi_handle_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct acpi_device *, char *, char *);
+	ssize_t (*store)(struct acpi_device *, char *, const char *, size_t);
+};
+
+#define EISA_ID_TYPE (1<<0)
+#define UNICODE_TYPE (1<<1)
+
+static ssize_t
+parse_integer(char *buf, u32 value, unsigned int flags) {
+	if (flags & EISA_ID_TYPE) {
+		acpi_ex_eisa_id_to_string(value, buf);
+		buf[8] = '\n';
+		return 9;
+	}
+	return sprintf(buf, "%08x\n", value);
+}
+
+static ssize_t
+parse_string(char *buf, u32 length, char *pointer, unsigned int flags) {
+	snprintf(buf, length, "%s", pointer);
+	buf[length++] = '\n';
+	return length;
+}
+
+static ssize_t
+parse_buffer(char *buf, u32 length, u8 *pointer, unsigned int flags) {
+	ssize_t offset = 0;
+
+	if (flags & UNICODE_TYPE) {
+		for (; length > 0 ; length -= 2) {
+			buf[offset++] = *pointer;
+			pointer += 2;
+		}
+	} else {
+		for (; length > 0 ; length--) {
+			sprintf(buf + offset, "%02x", *pointer);
+			offset += 2;
+			pointer++;
+		}
+	}
+	buf[offset++] = '\n';
+	return offset;
+}
+
+static ssize_t parse_package(char *, union acpi_object *, unsigned int);
+
+static ssize_t
+parse_element(
+	char			*buf,
+	union acpi_object	*element,
+	unsigned int		flags)
+{
+
+	switch (element->type) {
+		case ACPI_TYPE_INTEGER:
+			return parse_integer(buf, element->integer.value, flags);
+		case ACPI_TYPE_STRING:
+			return parse_string(buf, element->string.length,
+			                    element->string.pointer, flags);
+		case ACPI_TYPE_BUFFER:
+			return parse_buffer(buf, element->buffer.length,
+			                   element->buffer.pointer, flags);
+		case ACPI_TYPE_PACKAGE:
+			return parse_package(buf, element, flags);
+		default:
+			return sprintf(buf, "Unknown Type: %d\n", element->type);
+	}
+}
+
+static ssize_t
+parse_package(char *buf, union acpi_object *element, unsigned int flags) {
+	int count = element->package.count;
+	ssize_t tmp, retval = 0;
+
+	element = element->package.elements;
+
+	for (; count > 0 ; count--, element++) {
+		tmp = parse_element(buf, element, flags);
+		buf += tmp;
+		retval += tmp;
+	}
+	return retval;
+}
+
+static ssize_t
+acpi_device_read_file (
+	struct acpi_device	*device,
+	char			*method,
+	char			*buf)
+{
+	acpi_status status;
+	union acpi_object *element;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	ssize_t retval = 0;
+	unsigned int flags = 0;
+
+	if (!strcmp(method, METHOD_NAME__CRS)) {
+		status = acpi_get_current_resources(device->handle, &buffer);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+
+		memcpy(buf, buffer.pointer, buffer.length);
+		retval = buffer.length;
+		acpi_os_free(buffer.pointer);
+	} else if (!strcmp(method, METHOD_NAME__PRS)) {
+		status = acpi_get_possible_resources(device->handle, &buffer);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+
+		memcpy(buf, buffer.pointer, buffer.length);
+		retval = buffer.length;
+		acpi_os_free(buffer.pointer);
+	} else if (!strcmp(method, METHOD_NAME__PRT)) {
+		status = acpi_get_irq_routing_table(device->handle, &buffer);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+
+		memcpy(buf, buffer.pointer, buffer.length);
+		retval = buffer.length;
+		acpi_os_free(buffer.pointer);
+	} else if (!strcmp(method, METHOD_NAME__MAT)) {
+		status = acpi_evaluate_object(device->handle, method,
+		                              NULL, &buffer);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+
+		memcpy(buf, buffer.pointer, buffer.length);
+		retval = buffer.length;
+		acpi_os_free(buffer.pointer);
+	} else {
+		status = acpi_evaluate_object(device->handle, method,
+		                              NULL, &buffer);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+	
+		if (!strcmp(method, METHOD_NAME__HID)
+		    || !strcmp(method, METHOD_NAME__CID)
+		    || !strcmp(method, METHOD_NAME__FIX))
+			flags |= EISA_ID_TYPE;
+
+		if (!strcmp(method, METHOD_NAME__STR))
+			flags |= UNICODE_TYPE;
+
+		element = (union acpi_object *) buffer.pointer;
+		retval = parse_element(buf, element, flags);
+		acpi_os_free(buffer.pointer);
+	}
+	return retval;
+}
+
+static ssize_t
+acpi_device_write_integer (
+	struct acpi_device	*device,
+	char			*method,
+	const char		*buf,
+	size_t			length)
+{
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	int value;
+
+
+	value = simple_strtol(buf, NULL, 0);
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = value;
+
+	if (ACPI_FAILURE(acpi_evaluate_object(device->handle, method, &arg_list, NULL)))
+		return -ENODEV;
+	
+	return length;
+}
+
+#define acpi_handle_attr(method, show_func, store_func) \
+static struct acpi_handle_attribute acpi_handle_attr##method = { \
+	.attr = {.name = METHOD_NAME_##method, .mode = S_IFREG | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP}, \
+	.show = show_func, \
+	.store = store_func, \
+};
+
+acpi_handle_attr(_ADR, acpi_device_read_file, NULL)
+acpi_handle_attr(_BBN, acpi_device_read_file, NULL)
+acpi_handle_attr(_BCL, acpi_device_read_file, NULL)
+acpi_handle_attr(_BCM, NULL, acpi_device_write_integer)
+acpi_handle_attr(_CID, acpi_device_read_file, NULL)
+acpi_handle_attr(_CRS, acpi_device_read_file, NULL)
+acpi_handle_attr(_DCK, NULL, acpi_device_write_integer)
+acpi_handle_attr(_DCS, acpi_device_read_file, NULL)
+acpi_handle_attr(_DGS, acpi_device_read_file, NULL)
+acpi_handle_attr(_DDN, acpi_device_read_file, NULL)
+acpi_handle_attr(_DSS, NULL, acpi_device_write_integer)
+acpi_handle_attr(_DOS, NULL, acpi_device_write_integer)
+acpi_handle_attr(_DOD, acpi_device_read_file, NULL)
+acpi_handle_attr(_EDL, acpi_device_read_file, NULL)
+acpi_handle_attr(_EJ0, NULL, acpi_device_write_integer)
+acpi_handle_attr(_EJD, acpi_device_read_file, NULL)
+acpi_handle_attr(_FIX, acpi_device_read_file, NULL)
+acpi_handle_attr(_HID, acpi_device_read_file, NULL)
+acpi_handle_attr(_HPP, acpi_device_read_file, NULL)
+acpi_handle_attr(_LCK, NULL, acpi_device_write_integer)
+acpi_handle_attr(_LID, acpi_device_read_file, NULL)
+acpi_handle_attr(_MAT, acpi_device_read_file, NULL)
+acpi_handle_attr(_PRS, acpi_device_read_file, NULL)
+acpi_handle_attr(_PRT, acpi_device_read_file, NULL)
+acpi_handle_attr(_PXM, acpi_device_read_file, NULL)
+acpi_handle_attr(_RMV, acpi_device_read_file, NULL)
+acpi_handle_attr(_SEG, acpi_device_read_file, NULL)
+acpi_handle_attr(_STA, acpi_device_read_file, NULL)
+acpi_handle_attr(_STR, acpi_device_read_file, NULL)
+acpi_handle_attr(_SUN, acpi_device_read_file, NULL)
+acpi_handle_attr(_UID, acpi_device_read_file, NULL)
+
+typedef void acpi_device_sysfs_files(struct kobject *,
+                                     const struct attribute *);
+
+static void
+setup_sys_fs_files (
+	struct acpi_device *dev,
+	acpi_device_sysfs_files *func)
+{
+	acpi_handle tmp = NULL;
+
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__ADR, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_ADR.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__BBN, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_BBN.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__BCL, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_BCL.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__BCM, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_BCM.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__CID, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_CID.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__CRS, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_CRS.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__DCK, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_DCK.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__DCS, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_DCS.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__DGS, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_DGS.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__DDN, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_DDN.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__DSS, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_DSS.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__DOS, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_DOS.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__DOD, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_DOD.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__EDL, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_EDL.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__EJ0, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_EJ0.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__EJD, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_EJD.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__FIX, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_FIX.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__HID, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_HID.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__HPP, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_HPP.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__LCK, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_LCK.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__LID, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_LID.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__MAT, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_MAT.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__PRS, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_PRS.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__PRT, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_PRT.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__PXM, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_PXM.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__RMV, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_RMV.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__SEG, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_SEG.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__STA, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_STA.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__STR, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_STR.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__SUN, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_SUN.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__UID, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_UID.attr);
+}
+
+#define create_sysfs_files(dev) \
+	setup_sys_fs_files(dev, (acpi_device_sysfs_files *)&sysfs_create_file)
+#define remove_sysfs_files(dev) \
+	setup_sys_fs_files(dev, &sysfs_remove_file)
+
 static void acpi_device_release(struct kobject * kobj)
 {
 	struct acpi_device * dev = container_of(kobj,struct acpi_device,kobj);
@@ -33,7 +351,32 @@
 	kfree(dev);
 }
 
+#define to_acpi_device(n) container_of(n, struct acpi_device, kobj)
+#define to_handle_attr(n) container_of(n, struct acpi_handle_attribute, attr);
+
+static ssize_t acpi_device_attr_show(struct kobject *kobj,
+                struct attribute *attr, char *buf)
+{
+	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_handle_attribute *attribute = to_handle_attr(attr);
+	return attribute->show ? attribute->show(device, attribute->attr.name, buf) : 0;
+}
+
+static ssize_t acpi_device_attr_store(struct kobject *kobj,
+                struct attribute *attr, const char *buf, size_t len)
+{
+	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_handle_attribute *attribute = to_handle_attr(attr);
+	return attribute->store ? attribute->store(device, attribute->attr.name, buf, len) : len;
+}
+
+static struct sysfs_ops acpi_device_sysfs_ops = {
+	.show = acpi_device_attr_show,
+	.store = acpi_device_attr_store,
+};
+
 static struct kobj_type ktype_acpi_ns = {
+	.sysfs_ops	= &acpi_device_sysfs_ops,
 	.release	= acpi_device_release,
 };
 
@@ -72,6 +415,7 @@
 	device->kobj.ktype = &ktype_acpi_ns;
 	device->kobj.kset = &acpi_namespace_kset;
 	kobject_add(&device->kobj);
+	create_sysfs_files(device);
 }
 
 static int
@@ -79,6 +423,7 @@
 	struct acpi_device	*device, 
 	int			type)
 {
+	remove_sysfs_files(device);
 	kobject_unregister(&device->kobj);
 	return 0;
 }
@@ -706,7 +1051,7 @@
 	switch (type) {
 	case ACPI_BUS_TYPE_DEVICE:
 		result = acpi_bus_get_status(device);
-		if (ACPI_FAILURE(result) || !device->status.present) {
+		if (ACPI_FAILURE(result)) {
 			result = -ENOENT;
 			goto end;
 		}




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
