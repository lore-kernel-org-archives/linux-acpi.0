From: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ACPI based Memory Hotplug Driver Patch Update
Date: Wed, 13 Oct 2004 04:59:46 +0530
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <FEB6C4E97F6CAF41978FB2059D5454180F3910@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

Attaching the updated ACPI Memory Driver Patch along with this mail.
This implements review feedback and is ported to latest kernel
(2.6.9-rc4-mm1). And this is tested on the real hardware with patchset
available in http://sprucegoose.sr71.net/patches

Let me know for any clarifications.

Tokunaga,=20
This does not include your patch yet. Would like to test and consider it
in the subsequent patches once the base driver gets into the kernel.

Len,=20
Can you consider this for inclusion? Please let me know.

Thanks & Regards

Signed-off-by: Naveen B S <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Matt Tolentino <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

 drivers/acpi/Kconfig           |    7=20
 drivers/acpi/Makefile          |    1=20
 drivers/acpi/acpi_ksyms.c      |    1=20
 drivers/acpi/acpi_memhotplug.c |  542
+++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c            |    2=20
 include/acpi/acpi_bus.h        |    2=20
 6 files changed, 554 insertions(+), 1 deletion(-)

diff -Nura linux-2.6.9-rc4-mm1-orig/drivers/acpi/acpi_ksyms.c
linux-2.6.9-rc4-mm1-hpmem/drivers/acpi/acpi_ksyms.c
--- linux-2.6.9-rc4-mm1-orig/drivers/acpi/acpi_ksyms.c	2004-10-12
12:02:48.000000000 -0400
+++ linux-2.6.9-rc4-mm1-hpmem/drivers/acpi/acpi_ksyms.c	2004-10-12
13:58:19.000000000 -0400
@@ -138,6 +138,7 @@
 EXPORT_SYMBOL(acpi_bus_receive_event);
 EXPORT_SYMBOL(acpi_bus_register_driver);
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
+EXPORT_SYMBOL(acpi_bus_add);
=20
 #endif /*CONFIG_ACPI_BUS*/
=20
diff -Nura linux-2.6.9-rc4-mm1-orig/drivers/acpi/acpi_memhotplug.c
linux-2.6.9-rc4-mm1-hpmem/drivers/acpi/acpi_memhotplug.c
--- linux-2.6.9-rc4-mm1-orig/drivers/acpi/acpi_memhotplug.c
1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-rc4-mm1-hpmem/drivers/acpi/acpi_memhotplug.c
2004-10-12 14:08:56.000000000 -0400
@@ -0,0 +1,542 @@
+/*
+ * Copyright (C) 2004 Intel Corporation <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
(at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ * ACPI based HotPlug driver that supports Memory Hotplug=20
+ * This driver fields notifications from firmare for memory add
+ * and remove operations and alerts the VM of the affected memory
+ * ranges. =20
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/memory_hotplug.h>
+#include <acpi/acpi_drivers.h>
+
+
+#define ACPI_MEMORY_DEVICE_COMPONENT		0x08000000UL
+#define ACPI_MEMORY_DEVICE_CLASS		"memory"
+#define ACPI_MEMORY_DEVICE_HID			"PNP0C80"
+#define ACPI_MEMORY_DEVICE_DRIVER_NAME		"Hotplug Mem Driver"
+#define ACPI_MEMORY_DEVICE_NAME			"Hotplug Mem
Device"
+
+#define _COMPONENT		ACPI_MEMORY_DEVICE_COMPONENT
+
+ACPI_MODULE_NAME		("acpi_memory")
+MODULE_AUTHOR("Naveen B S <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION(ACPI_MEMORY_DEVICE_DRIVER_NAME);
+MODULE_LICENSE("GPL");
+
+/* ACPI _STA method values */
+#define ACPI_MEMORY_STA_PRESENT		(0x00000001UL)
+#define ACPI_MEMORY_STA_ENABLED		(0x00000002UL)
+#define ACPI_MEMORY_STA_FUNCTIONAL	(0x00000008UL)
+
+/* Memory Device States */
+#define MEMORY_INVALID_STATE	0
+#define MEMORY_POWER_ON_STATE	1
+#define MEMORY_POWER_OFF_STATE	2
+
+static int acpi_memory_device_add (struct acpi_device *device);
+static int acpi_memory_device_remove (struct acpi_device *device, int
type);
+
+static struct acpi_driver acpi_memory_device_driver =3D {
+	.name =3D		ACPI_MEMORY_DEVICE_DRIVER_NAME,
+	.class =3D	ACPI_MEMORY_DEVICE_CLASS,
+	.ids =3D		ACPI_MEMORY_DEVICE_HID,
+	.ops =3D		{
+				.add =3D		acpi_memory_device_add,
+				.remove =3D
acpi_memory_device_remove,
+			},
+};
+
+struct acpi_memory_device {
+	acpi_handle handle;=09
+	unsigned int state;		/* State of the memory device */
+	unsigned short cache_attribute;	/* memory cache attribute */
+	unsigned short read_write_attribute;/* memory read/write
attribute */
+	u64 start_addr;	/* Memory Range start physical addr */
+	u64 end_addr;	/* Memory Range end physical addr */
+};
+
+
+static int=20
+acpi_memory_get_device_resources(struct acpi_memory_device *mem_device)

+{
+	acpi_status status;
+	struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};=09
+	struct acpi_resource *resource =3D NULL;
+	struct acpi_resource_address64 address64;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_get_device_resources");
+
+	/* Get the range from the _CRS */
+	status =3D acpi_get_current_resources(mem_device->handle,
&buffer);
+	if (ACPI_FAILURE(status))
+		return_VALUE(-EINVAL);
+
+	resource =3D (struct acpi_resource *) buffer.pointer;
+	status =3D acpi_resource_to_address64(resource, &address64);

+	if (ACPI_SUCCESS(status)) {
+		if (address64.resource_type =3D=3D ACPI_MEMORY_RANGE) {
+			/* Populate the structure */
+			mem_device->cache_attribute =3D=20
+
address64.attribute.memory.cache_attribute;
+			mem_device->read_write_attribute =3D=20
+			address64.attribute.memory.read_write_attribute;
+			mem_device->start_addr =3D
address64.min_address_range;
+			mem_device->end_addr =3D
address64.max_address_range;
+		}
+	}
+	=09
+	acpi_os_free(buffer.pointer);
+	return_VALUE(0);
+}
+
+static int=20
+acpi_memory_get_device(acpi_handle handle,
+	struct acpi_memory_device **mem_device)=20
+{
+	acpi_status status;
+	acpi_handle phandle;
+	struct acpi_device *device =3D NULL;
+	struct acpi_device *pdevice =3D NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_get_device");
+
+	if (!acpi_bus_get_device(handle, &device) && device)=20
+		goto end;
+=09
+	status =3D acpi_get_parent(handle, &phandle);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error in acpi_get_parent\n"));
+		return_VALUE(-EINVAL);
+	}
+
+	/* Get the parent device */
+	status =3D acpi_bus_get_device(phandle, &pdevice);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error in acpi_bus_get_device\n"));
+		return_VALUE(-EINVAL);
+	}
+=09
+	/*=20
+	 * Now add the notified device.  This creates the acpi_device=20
+	 * and invokes .add function=20
+	 */
+	status =3D acpi_bus_add(&device, pdevice, handle,
ACPI_BUS_TYPE_DEVICE);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error in acpi_bus_add\n"));
+		return_VALUE(-EINVAL);
+	}
+
+end:
+	*mem_device =3D acpi_driver_data(device);
+	if (!(*mem_device)) {
+		printk(KERN_ERR "\n driver data not found" );
+		return_VALUE(-ENODEV);
+	}
+
+	return_VALUE(0);
+}
+
+static int=20
+acpi_memory_check_device(struct acpi_memory_device *mem_device)
+{
+	unsigned long current_status;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_check_device");
+
+	/* Get device present/absent information from the _STA */
+	if (ACPI_FAILURE(acpi_evaluate_integer(mem_device->handle,
"_STA",=20
+		NULL, &current_status)))
+		return_VALUE(-ENODEV);
+	/*=20
+	 * Check for device status. Device should be=20
+	 * present/enabled/functioning.
+	 */
+	if (!((current_status & ACPI_MEMORY_STA_PRESENT)
+		&& (current_status & ACPI_MEMORY_STA_ENABLED)
+		&& (current_status & ACPI_MEMORY_STA_FUNCTIONAL)))=20
+		return_VALUE(-ENODEV);
+
+	return_VALUE(0);
+}
+
+static int=20
+acpi_memory_enable_device(struct acpi_memory_device *mem_device)
+{
+	int result;
+=09
+	ACPI_FUNCTION_TRACE("acpi_memory_enable_device");
+
+	/* Get the range from the _CRS */
+	result =3D acpi_memory_get_device_resources(mem_device);=20
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,=20
+			"\nget_device_resources failed\n"));
+		mem_device->state =3D MEMORY_INVALID_STATE;	=09
+		return result;
+	}
+
+	/*=20
+	 * Tell the VM there is more memory here...
+	 * Note: Assume that this function returns zero on success=20
+	 */
+	result =3D add_memory(mem_device->start_addr,=20
+			(mem_device->end_addr - mem_device->start_addr)
+ 1,
+			mem_device->read_write_attribute);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,=20
+			"\nadd_memory failed\n"));
+		mem_device->state =3D MEMORY_INVALID_STATE;	=09
+		return result;
+	}
+
+	return result;
+}
+
+static int=20
+acpi_memory_powerdown_device(struct acpi_memory_device *mem_device)
+{
+	acpi_status status;
+	struct acpi_object_list	arg_list;
+	union acpi_object arg;
+	unsigned long current_status;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_powerdown_device");
+
+	/* Issue the _EJ0 command */
+	arg_list.count =3D 1;
+	arg_list.pointer =3D &arg;
+	arg.type =3D ACPI_TYPE_INTEGER;
+	arg.integer.value =3D 1;
+	status =3D acpi_evaluate_object(mem_device->handle,=20
+			"_EJ0", &arg_list, NULL);
+	/* Return on _EJ0 failure */
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,"_EJ0 failed.\n"));
+		return_VALUE(-ENODEV);	=09
+	}
+
+	/* Evalute _STA to check if the device is disabled */
+	status =3D acpi_evaluate_integer(mem_device->handle, "_STA",=20
+		NULL, &current_status);
+	if (ACPI_FAILURE(status))
+		return_VALUE(-ENODEV);
+
+	/* Check for device status.  Device should be disabled */
+	if (current_status & ACPI_MEMORY_STA_ENABLED)=20
+		return_VALUE(-EINVAL);
+
+	return_VALUE(0);
+}
+
+static int=20
+acpi_memory_disable_device(struct acpi_memory_device *mem_device)=20
+{
+	int result;
+	u64 start =3D mem_device->start_addr;
+	u64 len =3D mem_device->end_addr - start + 1;
+	unsigned long attr =3D mem_device->read_write_attribute;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_disable_device");
+
+	/*=20
+	 * Ask the VM to offline this memory range.
+	 * Note: Assume that this function returns zero on success=20
+	 */
+	result =3D remove_memory(start, len, attr);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Hot-Remove
failed.\n"));
+		return_VALUE(result);=09
+	}
+
+	/* Power-off and eject the device */
+	result =3D acpi_memory_powerdown_device(mem_device);=09
+	if (result) {=20
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+					"Device Power Down failed.\n"));
+		/* Set the status of the device to invalid */
+		mem_device->state =3D MEMORY_INVALID_STATE;
+		return result;
+	}
+=09
+	mem_device->state =3D MEMORY_POWER_OFF_STATE;
+	return result;=09
+}
+
+static void
+acpi_memory_device_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_memory_device *mem_device;
+	struct acpi_device *device;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_device_notify");
+
+	switch (event) {
+	case ACPI_NOTIFY_BUS_CHECK:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,=20
+			"\nReceived BUS CHECK notification for
device\n"));
+		/* Fall Through */
+	case ACPI_NOTIFY_DEVICE_CHECK:
+		if (event =3D=3D ACPI_NOTIFY_DEVICE_CHECK)
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,=20
+			"\nReceived DEVICE CHECK notification for
device\n"));
+		if (acpi_memory_get_device(handle, &mem_device)) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Error in finding driver data\n"));
+			return_VOID;
+		}
+	=09
+		if (!acpi_memory_check_device(mem_device)) {
+			if (acpi_memory_enable_device(mem_device))
+				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,=20
+				"Error in
acpi_memory_enable_device\n"));
+		}
+		break;
+	case ACPI_NOTIFY_EJECT_REQUEST:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,=20
+			"\nReceived EJECT REQUEST notification for
device\n"));
+	=09
+		if (acpi_bus_get_device(handle, &device)) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,=20
+					"Device doesn't exist\n"));
+			break;
+		}
+		mem_device =3D acpi_driver_data(device);
+		if (!mem_device) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,=20
+					"Driver Data is NULL\n"));
+			break;
+		}
+=09
+		/*
+		 * Currently disabling memory device from kernel mode
+		 * TBD: Can also be disabled from user mode scripts
+		 * TBD: Can also be disabled by Callback registration=20
+		 * 	with generic sysfs driver
+		 */=09
+		if (acpi_memory_disable_device(mem_device))
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,=20
+				"Error in
acpi_memory_disable_device\n"));
+		/*
+		 * TBD: Invoke acpi_bus_remove to cleanup data
structures
+		 */
+		break;
+	default:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"Unsupported event [0x%x]\n", event));
+		break;
+	}
+
+	return_VOID;
+}
+
+static int
+acpi_memory_device_add(struct acpi_device *device)
+{
+	int result;
+	struct acpi_memory_device *mem_device =3D NULL;
+=09
+	ACPI_FUNCTION_TRACE("acpi_memory_device_add");
+
+	if (!device)
+		return_VALUE(-EINVAL);
+
+	mem_device =3D kmalloc(sizeof(struct acpi_memory_device),
GFP_KERNEL);
+	if (!mem_device)
+		return_VALUE(-ENOMEM);
+	memset(mem_device, 0, sizeof(struct acpi_memory_device));
+
+	mem_device->handle =3D device->handle;
+	sprintf(acpi_device_name(device), "%s",
ACPI_MEMORY_DEVICE_NAME);
+	sprintf(acpi_device_class(device), "%s",
ACPI_MEMORY_DEVICE_CLASS);
+	acpi_driver_data(device) =3D mem_device;
+
+	/* Get the range from the _CRS */
+	result =3D acpi_memory_get_device_resources(mem_device);
+	if (result) {
+		kfree(mem_device);
+		return_VALUE(result);
+	}
+	=09
+	/* Set the device state */
+	mem_device->state =3D MEMORY_POWER_ON_STATE;
+
+	printk(KERN_INFO "%s \n", acpi_device_name(device));
+
+	return_VALUE(result);
+}
+
+static int=20
+acpi_memory_device_remove (struct acpi_device *device, int type)
+{
+	struct acpi_memory_device *mem_device =3D NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_device_remove");
+
+	if (!device || !acpi_driver_data(device))
+		return_VALUE(-EINVAL);
+=09
+	mem_device =3D (struct acpi_memory_device *)
acpi_driver_data(device);
+	kfree(mem_device);
+
+	return_VALUE(0);
+}
+
+/*=20
+ * Helper function to check for memory device=20
+ */
+static acpi_status=20
+is_memory_device(acpi_handle handle)=20
+{
+	char *hardware_id;
+	acpi_status status;
+	struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_device_info *info;
+=09
+	ACPI_FUNCTION_TRACE("is_memory_device");
+
+	status =3D acpi_get_object_info(handle, &buffer);
+	if (ACPI_FAILURE(status))=20
+		return_ACPI_STATUS(AE_ERROR);
+=09
+	info =3D buffer.pointer;
+	if (!(info->valid & ACPI_VALID_HID)) {
+		acpi_os_free(buffer.pointer);
+		return_ACPI_STATUS(AE_ERROR);
+	}
+=09
+	hardware_id =3D info->hardware_id.value;
+	if ((hardware_id =3D=3D NULL) ||=20
+		(strcmp(hardware_id, ACPI_MEMORY_DEVICE_HID)))=20
+		status =3D AE_ERROR;
+=09
+	acpi_os_free(buffer.pointer);
+	return_ACPI_STATUS(status);=09
+}
+
+static acpi_status
+acpi_memory_register_notify_handler (acpi_handle handle,=20
+	u32 level, void *ctxt, void **retv)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_register_notify_handler");
+=09
+	status =3D is_memory_device(handle);
+	if (ACPI_FAILURE(status))=20
+		return_ACPI_STATUS(AE_OK);	/* continue */
+=09
+	status =3D acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,

+			acpi_memory_device_notify, NULL);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error installing notify handler\n"));
+		return_ACPI_STATUS(AE_OK);	/* continue */
+	}
+	=09
+	return_ACPI_STATUS(status);=09
+}
+
+static acpi_status
+acpi_memory_deregister_notify_handler (acpi_handle handle,=20
+			       u32 level, void *ctxt, void **retv)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_deregister_notify_handler");
+=09
+	status =3D is_memory_device(handle);
+	if (ACPI_FAILURE(status))=20
+		return_ACPI_STATUS(AE_OK);	/* continue */
+=09
+	status =3D acpi_remove_notify_handler(handle,
+			ACPI_SYSTEM_NOTIFY, acpi_memory_device_notify);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Error removing notify handler\n"));
+		return_ACPI_STATUS(AE_OK);	/* continue */
+	}
+=09
+	return_ACPI_STATUS(status);=09
+}
+
+static int __init
+acpi_memory_device_init (void)
+{
+	int result;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_device_init");
+
+	result =3D acpi_bus_register_driver(&acpi_memory_device_driver);
+
+	if (result < 0)=20
+		return_VALUE(-ENODEV);
+=09
+	status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,

+				ACPI_UINT32_MAX,
+				acpi_memory_register_notify_handler,=20
+				NULL, NULL);
+
+	if (ACPI_FAILURE (status)) {
+		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "walk_namespace
failed\n"));
+		acpi_bus_unregister_driver(&acpi_memory_device_driver);
+		return_VALUE(-ENODEV);
+        }
+
+	return_VALUE(0);
+}
+
+static void __exit
+acpi_memory_device_exit (void)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_device_exit");
+=09
+	/*=20
+	 * Adding this to un-install notification handlers for all the
device
+	 * handles.=20
+	 */
+	status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,

+			ACPI_UINT32_MAX,
+			acpi_memory_deregister_notify_handler,=20
+			NULL, NULL);
+
+	if (ACPI_FAILURE (status))=20
+		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "walk_namespace
failed\n"));
+
+	acpi_bus_unregister_driver(&acpi_memory_device_driver);
+
+	return_VOID;
+}
+
+module_init(acpi_memory_device_init);
+module_exit(acpi_memory_device_exit);
+
+
diff -Nura linux-2.6.9-rc4-mm1-orig/drivers/acpi/Kconfig
linux-2.6.9-rc4-mm1-hpmem/drivers/acpi/Kconfig
--- linux-2.6.9-rc4-mm1-orig/drivers/acpi/Kconfig	2004-10-12
12:02:48.000000000 -0400
+++ linux-2.6.9-rc4-mm1-hpmem/drivers/acpi/Kconfig	2004-10-12
13:58:19.000000000 -0400
@@ -307,5 +307,12 @@
 	  kernel logs, and/or you are using this on a notebook which
 	  does not yet have an HPET, you should say "Y" here.
=20
+config ACPI_HOTPLUG_MEMORY
+	tristate "Memory Hotplug"
+	depends on ACPI
+	depends on MEMORY_HOTPLUG
+	default m
+	help
+	  This driver adds supports for ACPI Memory Hotplug.
 endmenu
=20
diff -Nura linux-2.6.9-rc4-mm1-orig/drivers/acpi/Makefile
linux-2.6.9-rc4-mm1-hpmem/drivers/acpi/Makefile
--- linux-2.6.9-rc4-mm1-orig/drivers/acpi/Makefile	2004-10-12
12:02:48.000000000 -0400
+++ linux-2.6.9-rc4-mm1-hpmem/drivers/acpi/Makefile	2004-10-12
14:09:28.000000000 -0400
@@ -49,3 +49,4 @@
 obj-$(CONFIG_ACPI_TOSHIBA)	+=3D toshiba_acpi.o
 obj-$(CONFIG_ACPI_THINKPAD)	+=3D thinkpad_acpi.o
 obj-$(CONFIG_ACPI_BUS)		+=3D scan.o motherboard.o
+obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+=3D acpi_memhotplug.o
diff -Nura linux-2.6.9-rc4-mm1-orig/drivers/acpi/scan.c
linux-2.6.9-rc4-mm1-hpmem/drivers/acpi/scan.c
--- linux-2.6.9-rc4-mm1-orig/drivers/acpi/scan.c	2004-10-12
12:01:46.000000000 -0400
+++ linux-2.6.9-rc4-mm1-hpmem/drivers/acpi/scan.c	2004-10-12
13:58:19.000000000 -0400
@@ -760,7 +760,7 @@
 #endif /*CONFIG_ACPI_DEBUG_OUTPUT*/
 }
=20
-static int=20
+int=20
 acpi_bus_add (
 	struct acpi_device	**child,
 	struct acpi_device	*parent,
diff -Nura linux-2.6.9-rc4-mm1-orig/include/acpi/acpi_bus.h
linux-2.6.9-rc4-mm1-hpmem/include/acpi/acpi_bus.h
--- linux-2.6.9-rc4-mm1-orig/include/acpi/acpi_bus.h	2004-10-12
12:01:59.000000000 -0400
+++ linux-2.6.9-rc4-mm1-hpmem/include/acpi/acpi_bus.h	2004-10-12
13:58:19.000000000 -0400
@@ -321,6 +321,8 @@
 int acpi_bus_receive_event (struct acpi_bus_event *event);
 int acpi_bus_register_driver (struct acpi_driver *driver);
 int acpi_bus_unregister_driver (struct acpi_driver *driver);
+int acpi_bus_add (struct acpi_device **child, struct acpi_device
*parent,
+						acpi_handle handle, int
type);
=20
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);





-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
