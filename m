From: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/6]ACPI based Physical CPU hotplug
Date: Wed, 8 Sep 2004 18:41:52 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040908184152.D7384@unix-os.sc.intel.com>
References: <44BDAFB888F59F408FAE3CC35AB47041B17999@orsmsx409>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <44BDAFB888F59F408FAE3CC35AB47041B17999@orsmsx409>; from anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Wed, Sep 08, 2004 at 06:10:50PM -0700
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developer <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, LHNS list <lhns-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



---
Name:container_drv.patch
Status: Tested on 2.6.9-rc1-mm2
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Depends:	
Version: applies on 2.6.9-rc1-mm2
Description:
This is the very early version on the Container driver which supports
hotplug notifications on ACPI004, PNP0A05 and PNP0A06 devices.
---

 linux-2.6.9-rc1-mm2-askeshav/drivers/acpi/Kconfig     |   10 
 linux-2.6.9-rc1-mm2-askeshav/drivers/acpi/Makefile    |    1 
 linux-2.6.9-rc1-mm2-askeshav/drivers/acpi/container.c |  341 ++++++++++++++++++
 linux-2.6.9-rc1-mm2-askeshav/include/acpi/container.h |   13 
 4 files changed, 364 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/Kconfig~container_drv drivers/acpi/Kconfig
--- linux-2.6.9-rc1-mm2/drivers/acpi/Kconfig~container_drv	2004-09-08 16:42:29.741133406 -0700
+++ linux-2.6.9-rc1-mm2-askeshav/drivers/acpi/Kconfig	2004-09-08 16:42:29.832930280 -0700
@@ -100,6 +100,7 @@ config ACPI_HOTPLUG_CPU
 	bool "Processor Hotplug (EXPERIMENTAL)"
 	depends on ACPI_PROCESSOR && HOTPLUG_CPU
 	depends on !IA64_SGI_SN
+	select ACPI_CONTAINER
 	default n
 	 ---help---
 	 Select this option if your platform support physical CPU hotplug.
@@ -224,5 +225,12 @@ config X86_PM_TIMER
 	  kernel logs, and/or you are using this on a notebook which
 	  does not yet have an HPET, you should say "Y" here.
 
-endmenu
+config ACPI_CONTAINER
+	tristate "ACPI004,PNP0A05 and PNP0A06 Container Driver"
+	depends on (ACPI)
+	default (ACPI_HOTPLUG_MEMORY || ACPI_HOTPLUG_CPU || ACPI_HOTPLUG_IO)
+	 ---help---
+	 	This is the ACPI generic container driver which supports
+		ACPI004, PNP0A05 and PNP0A06 devices
 
+endmenu
diff -puN drivers/acpi/Makefile~container_drv drivers/acpi/Makefile
--- linux-2.6.9-rc1-mm2/drivers/acpi/Makefile~container_drv	2004-09-08 16:42:29.745039656 -0700
+++ linux-2.6.9-rc1-mm2-askeshav/drivers/acpi/Makefile	2004-09-08 16:42:29.832930280 -0700
@@ -41,6 +41,7 @@ obj-$(CONFIG_ACPI_FAN)		+= fan.o
 obj-$(CONFIG_ACPI_PCI)		+= pci_root.o pci_link.o pci_irq.o pci_bind.o
 obj-y				+= power.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
+obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-$(CONFIG_ACPI_DEBUG)	+= system.o
 obj-y				+= event.o
diff -puN /dev/null include/acpi/container.h
--- /dev/null	2004-06-30 13:03:36.000000000 -0700
+++ linux-2.6.9-rc1-mm2-askeshav/include/acpi/container.h	2004-09-08 16:42:29.833906843 -0700
@@ -0,0 +1,13 @@
+#ifndef __ACPI_CONTAINER_H
+#define __ACPI_CONTAINER_H
+
+#include <linux/kernel.h>
+
+struct acpi_container {
+	acpi_handle handle;
+	unsigned long sun;
+	int state;
+};
+
+#endif /* __ACPI_CONTAINER_H */
+
diff -puN /dev/null drivers/acpi/container.c
--- /dev/null	2004-06-30 13:03:36.000000000 -0700
+++ linux-2.6.9-rc1-mm2-askeshav/drivers/acpi/container.c	2004-09-08 16:42:29.835859968 -0700
@@ -0,0 +1,341 @@
+/*
+ * acpi_container.c  - ACPI Generic Container Driver
+ * ($Revision: )
+ *
+ * Copyright (C) 2004 Anil S Keshavamurthy (anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org)
+ * Copyright (C) 2004 Keiichiro Tokunaga (tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org)
+ * Copyright (C) 2004 Motoyuki Ito (motoyuki-tPnzhWqfZ96MLkP6nYsO9A@public.gmane.org)
+ * Copyright (C) 2004 Intel Corp.
+ * Copyright (C) 2004 FUJITSU LIMITED
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/container.h>
+
+#define ACPI_CONTAINER_DRIVER_NAME	"ACPI container driver"
+#define ACPI_CONTAINER_DEVICE_NAME	"ACPI container device"
+#define ACPI_CONTAINER_CLASS		"container"
+
+#define INSTALL_NOTIFY_HANDLER		1
+#define UNINSTALL_NOTIFY_HANDLER	2
+
+#define ACPI_CONTAINER_COMPONENT	0x01000000
+#define _COMPONENT			ACPI_CONTAINER_COMPONENT
+ACPI_MODULE_NAME			("acpi_container")
+
+MODULE_AUTHOR("Anil S Keshavamurthy");
+MODULE_DESCRIPTION(ACPI_CONTAINER_DRIVER_NAME);
+MODULE_LICENSE("GPL");
+
+#define ACPI_STA_PRESENT		(0x00000001)
+
+static int acpi_container_add(struct acpi_device *device);
+static int acpi_container_remove(struct acpi_device *device, int type);
+
+static struct acpi_driver acpi_container_driver = {
+	.name =		ACPI_CONTAINER_DRIVER_NAME,
+	.class =	ACPI_CONTAINER_CLASS,
+	.ids =		"ACPI004,PNP0A05,PNP0A06",
+	.ops =		{
+				.add =		acpi_container_add,
+				.remove =	acpi_container_remove,
+			},
+};
+
+
+/*******************************************************************/
+
+static int
+is_device_present(acpi_handle handle)
+{
+	acpi_handle		temp;
+	acpi_status		status;
+	unsigned long	sta;
+
+	ACPI_FUNCTION_TRACE("is_device_present");
+
+	status = acpi_get_handle(handle, "_STA", &temp);
+	if (ACPI_FAILURE(status))
+		return_VALUE(1); /* _STA not found, assmue device present */
+
+	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
+	if (ACPI_FAILURE(status))
+		return_VALUE(0); /* Firmware error */
+
+	return_VALUE((sta & ACPI_STA_PRESENT) == ACPI_STA_PRESENT);
+}
+
+/*******************************************************************/
+static int
+acpi_container_add(struct acpi_device *device)
+{
+	struct acpi_container *container;
+
+	ACPI_FUNCTION_TRACE("acpi_container_add");
+
+	if (!device) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "device is NULL\n"));
+		return_VALUE(-EINVAL);
+	}
+
+	container = kmalloc(sizeof(struct acpi_container), GFP_KERNEL);
+	if(!container)
+		return_VALUE(-ENOMEM);
+	
+	memset(container, 0, sizeof(struct acpi_container));
+	container->handle = device->handle;
+	strcpy(acpi_device_name(device), ACPI_CONTAINER_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_CONTAINER_CLASS);
+	acpi_driver_data(device) = container;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device <%s> bid <%s>\n",	\
+		acpi_device_name(device), acpi_device_bid(device)));
+
+
+	return_VALUE(0);
+}
+
+static int
+acpi_container_remove(struct acpi_device *device, int type)
+{
+	acpi_status		status = AE_OK;
+	struct acpi_container	*pc = NULL;
+	pc = (struct acpi_container*) acpi_driver_data(device);
+
+	if (pc)
+		kfree(pc);
+
+	return status;
+}
+
+
+static int
+container_run_sbin_hotplug(struct acpi_device *device, char *action)
+{
+	char *argv[3], *envp[6], action_str[32];
+	int i, ret;
+	int len;
+	char pathname[ACPI_PATHNAME_MAX] = {0};
+	acpi_status status;
+	char *container_str;
+	struct acpi_buffer buffer = {ACPI_PATHNAME_MAX, pathname};
+
+	ACPI_FUNCTION_TRACE("container_run_sbin_hotplug");
+
+
+	status = acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
+	if (ACPI_FAILURE(status)) {
+		return(-ENODEV);
+	}
+
+	len = strlen("CONTAINER=") + strlen(pathname) + 1;
+	container_str = kmalloc(len, GFP_KERNEL);
+	if (!container_str)
+		return(-ENOMEM);
+
+	sprintf(container_str, "CONTAINER=%s",pathname);
+	sprintf(action_str, "ACTION=%s", action);
+
+	i = 0;
+	argv[i++] = hotplug_path;
+	argv[i++] = "container";
+	argv[i] = NULL;
+
+	i = 0;
+	envp[i++] = "HOME=/";
+	envp[i++] = "PATH=/sbin;/bin;/usr/sbin;/usr/bin";
+	envp[i++] = action_str;
+	envp[i++] = container_str;
+	envp[i++] = "PLATFORM=ACPI";
+	envp[i] = NULL;
+
+	ret = call_usermodehelper(argv[0], argv, envp, 0);
+
+	kfree(container_str);
+	return_VALUE(ret);
+}
+
+static int
+container_device_add(struct acpi_device **device, acpi_handle handle)
+{
+	acpi_handle phandle;
+	struct acpi_device *pdev;
+	int result;
+
+	ACPI_FUNCTION_TRACE("container_device_add");
+
+	if (acpi_get_parent(handle, &phandle)) {
+		return_VALUE(-ENODEV);
+	}
+
+	if (acpi_bus_get_device(phandle, &pdev)) {
+		return_VALUE(-ENODEV);
+	}
+
+	if (acpi_bus_add(device, pdev, handle, ACPI_BUS_TYPE_DEVICE)) {
+		return_VALUE(-ENODEV);
+	}
+
+	result = acpi_bus_scan(*device);
+
+	return_VALUE(result);
+}
+
+static void
+container_notify_cb(acpi_handle handle, u32 type, void *context)
+{
+	struct acpi_device		*device = NULL;
+	int result;
+	int present;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE("container_notify_cb");
+
+	present = is_device_present(handle);
+	
+	switch (type) {
+	case ACPI_NOTIFY_BUS_CHECK:
+		/* Fall through */
+	case ACPI_NOTIFY_DEVICE_CHECK:
+		if (present) {
+			status = acpi_bus_get_device(handle, &device);
+			if (ACPI_FAILURE(status) || !device) {
+				result = container_device_add(&device, handle);
+				if (!result)
+					container_run_sbin_hotplug(device, "add");
+			} else {
+				/* device exist and this is a remove request */
+				container_run_sbin_hotplug(device, "remove");
+			}
+		}
+		break;
+	case ACPI_NOTIFY_EJECT_REQUEST:
+		if (!acpi_bus_get_device(handle, &device) && device) {
+			container_run_sbin_hotplug(device, "remove");
+		}
+		break;
+	default:
+		break;
+	}
+	return_VOID;
+}
+
+static acpi_status
+container_walk_namespace_cb(acpi_handle handle,
+	u32 lvl,
+	void *context,
+	void **rv)
+{
+	char 				*hid = NULL;
+	struct acpi_buffer 		buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_device_info 	*info;
+	acpi_status 			status;
+	int 				*action = context;
+
+	ACPI_FUNCTION_TRACE("container_walk_namespace_cb");
+
+	status = acpi_get_object_info(handle, &buffer);
+	if (ACPI_FAILURE(status) || !buffer.pointer) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	info = buffer.pointer;
+	if (info->valid & ACPI_VALID_HID)
+		hid = info->hardware_id.value;
+
+	if (hid == NULL) {
+		goto end;
+	}
+
+	if (strcmp(hid, "ACPI004") && strcmp(hid, "PNP0A05") &&
+			strcmp(hid, "PNP0A06")) {
+		goto end;
+	}
+
+	switch(*action) {
+	case INSTALL_NOTIFY_HANDLER:
+		acpi_install_notify_handler(handle,
+			ACPI_SYSTEM_NOTIFY,
+			container_notify_cb,
+			NULL);
+		break;
+	case UNINSTALL_NOTIFY_HANDLER:
+		acpi_remove_notify_handler(handle,
+			ACPI_SYSTEM_NOTIFY,
+			container_notify_cb);
+		break;
+	default:
+		break;
+	}
+
+end:
+	acpi_os_free(buffer.pointer);
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+
+int __init
+acpi_container_init(void)
+{
+	int	result = 0;
+	int	action = INSTALL_NOTIFY_HANDLER;
+
+	result = acpi_bus_register_driver(&acpi_container_driver);
+	if (result < 0) {
+		return(result);
+	}
+
+	/* register notify handler to every container device */
+	acpi_walk_namespace(ACPI_TYPE_DEVICE,
+				     ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX,
+				     container_walk_namespace_cb,
+				     &action, NULL);
+
+	return(0);
+}
+
+void __exit
+acpi_container_exit(void)
+{
+	int			action = UNINSTALL_NOTIFY_HANDLER;
+
+	ACPI_FUNCTION_TRACE("acpi_container_exit");
+
+	acpi_walk_namespace(ACPI_TYPE_DEVICE,
+				     ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX,
+				     container_walk_namespace_cb,
+				     &action, NULL);
+
+	acpi_bus_unregister_driver(&acpi_container_driver);
+
+	return_VOID;
+}
+
+module_init(acpi_container_init);
+module_exit(acpi_container_exit);
_


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
