From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH] ACPI based Memory Hotplug Driver Patch
Date: Fri, 10 Sep 2004 23:02:00 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040910230200.73eb0374.tokunaga.keiich@jp.fujitsu.com>
References: <FEB6C4E97F6CAF41978FB2059D5454180F37E8@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <FEB6C4E97F6CAF41978FB2059D5454180F37E8-OkeUvhg1trkFyVwBAnZdSLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 09 Sep 2004 16:24:46 +0530 S, Naveen B wrote:
> Attached is an ACPI based hot plug driver patch to support physical
> memory hotplug. This driver supports physical hotplug operation on
> memory, fields notifications from firmware and notifies the VM of the
> affected memory ranges.  The following patch is against kernel
> 2.6.8.1-mm3, and works with the current memory hotplug VM patches
> posted at: http://sprucegoose.sr71.net/patches.  This patch has been
> tested on real prototype hardware in the hot-add memory case. Hot
> remove feature is tested in an emulated environment (by overriding
> ACPI DSDT). 
> 
> Please review and consider for inclusion. 

I would like to add a feature into drivers/acpi/memory.c.

Please see the patch below.  This patch is for the kernel applying
your patch.

This patch generates procfs entry 'info' for each memory ACPI
object to expose memory device information.  This information
is needed to determine which logical memory ID(s) (memsection ID)
belongs which memory ACPI object (e.g. memsection5 --> MEM0).
Memsection IDs could be fingured out from min_address_range
and max_address_range that 'info' file shows.

Actually, container hotplug is assuming to use the information,
because 'container.agent', which lives in the userland, needs
to search memsection entires related with a certain ACPI memory
object name (e.g. MEM0) to invoke generic memory hotplug function.

The 'info' file shows the following information.

kei%cat /proc/acpi/memory/MEM0/info
resource_type:               0x0
producer_consumer:           0x0
decode:                      0x0
min_address:                 0x0
max_address:                 0x0
granularity:                 0x0
min_address_range:           0x0
max_address_range:           0x80000000
address_translation_offset:  0x0
address_length:              0x80000000

Thanks,
Keiichiro Tokunaga


Signed-off-by: Keiichiro Tokunaga (tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org)
---

 linux-2.6.8.1-mm3-mem-kei/drivers/acpi/memory.c |  155 ++++++++++++++++++++++--
 1 files changed, 148 insertions(+), 7 deletions(-)

diff -puN drivers/acpi/memory.c~proc_memory drivers/acpi/memory.c
--- linux-2.6.8.1-mm3-mem/drivers/acpi/memory.c~proc_memory	2004-09-10 14:01:21.000000000 +0900
+++ linux-2.6.8.1-mm3-mem-kei/drivers/acpi/memory.c	2004-09-10 17:37:54.000000000 +0900
@@ -29,6 +29,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/memory_hotplug.h>
 #include <acpi/acpi_drivers.h>
 
@@ -38,6 +40,8 @@
 #define ACPI_MEMORY_DEVICE_HID			"PNP0C80"
 #define ACPI_MEMORY_DEVICE_DRIVER_NAME		"Hotplug Mem Driver"
 #define ACPI_MEMORY_DEVICE_NAME			"Hotplug Mem Device"
+#define ACPI_MEMORY_DEVICE_FILE_INFO		"info"
+
 
 #define _COMPONENT		ACPI_MEMORY_DEVICE_COMPONENT
 
@@ -61,6 +65,7 @@ MODULE_LICENSE("GPL");
 static int acpi_memory_device_add (struct acpi_device *device);
 static int acpi_memory_device_remove (struct acpi_device *device, int type);
 void acpi_memory_device_notify(acpi_handle handle, u32 event, void *data);
+static int acpi_memory_info_open_fs(struct inode *inode, struct file *file);
 
 static struct acpi_driver acpi_memory_device_driver = {
 	.name =		ACPI_MEMORY_DEVICE_DRIVER_NAME,
@@ -79,11 +84,124 @@ struct acpi_memory_device {
 	unsigned short read_write_attribute;/* memory read/write attribute */
 	u64 start_addr;	/* Memory Range start physical addr */
 	u64 end_addr;	/* Memory Range end physical addr */
+	struct acpi_resource	resource;
 };
 
 #define to_memory_device(sys_device) container_of(sys_device, \
 					struct acpi_memory_device, sysdev)
 
+static struct file_operations acpi_memory_device_info_fops = {
+	.open 		= acpi_memory_info_open_fs,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+struct proc_dir_entry		*acpi_memory_device_dir = NULL;
+
+static int acpi_memory_info_seq_show(struct seq_file *seq, void *offset)
+{
+	struct acpi_memory_device *mem_device = (struct acpi_memory_device *)seq->private;
+	struct acpi_resource		*resource;
+	struct acpi_resource_address64	address64;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_info_seq_show");
+
+	if (!mem_device)
+		goto end;
+
+	resource = &mem_device->resource;
+
+	/*
+	 * Even if the resource is an address16 or address32, or address64,
+	 * copy it to the adddress64 return buffer.
+	 */
+	acpi_resource_to_address64(resource, &address64);
+
+	if (address64.resource_type != ACPI_MEMORY_RANGE) {
+		goto end;
+	}
+
+	seq_printf(seq,
+		   "resource_type:               0x%x\n"
+		   "producer_consumer:           0x%x\n"
+		   "decode:                      0x%x\n"
+		   "min_address:                 0x%x\n"
+		   "max_address:                 0x%x\n"
+		   "granularity:                 0x%lx\n"
+		   "min_address_range:           0x%lx\n"
+		   "max_address_range:           0x%lx\n"
+		   "address_translation_offset:  0x%lx\n"
+		   "address_length:              0x%lx\n",
+		   address64.resource_type,
+		   address64.producer_consumer,
+		   address64.decode,
+		   address64.min_address_fixed,
+		   address64.max_address_fixed,
+		   address64.granularity,
+		   address64.min_address_range,
+		   address64.max_address_range,
+		   address64.address_translation_offset,
+		   address64.address_length);
+end:
+	return 0;
+}
+
+static int acpi_memory_info_open_fs(struct inode *inode, struct file *file)
+{
+	return single_open(file, acpi_memory_info_seq_show,
+			   PDE(inode)->data);
+}
+
+static int
+acpi_memory_add_fs (
+	struct acpi_device      *device)
+{
+	struct proc_dir_entry   *entry = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_add_fs");
+
+	if (!acpi_device_dir(device)) {
+		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
+						     acpi_memory_device_dir);
+		if (!acpi_device_dir(device))
+			return_VALUE(-ENODEV);
+	}
+	acpi_device_dir(device)->owner = THIS_MODULE;
+
+	/* 'info' [R] */
+	entry = create_proc_entry(ACPI_MEMORY_DEVICE_FILE_INFO,
+				  S_IRUGO, acpi_device_dir(device));
+	if (!entry)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Unable to create '%s' fs entry\n",
+				  ACPI_MEMORY_DEVICE_FILE_INFO));
+	else {
+		entry->proc_fops = &acpi_memory_device_info_fops;
+		entry->data = acpi_driver_data(device);
+		entry->owner = THIS_MODULE;
+	}
+
+	return_VALUE(0);
+}
+
+static int
+acpi_memory_remove_fs (
+	struct acpi_device      *device)
+{
+	ACPI_FUNCTION_TRACE("acpi_memory_remove_fs");
+
+	if (acpi_device_dir(device)) {
+		remove_proc_entry(ACPI_MEMORY_DEVICE_FILE_INFO,
+				  acpi_device_dir(device));
+		remove_proc_entry(acpi_device_bid(device),
+				  acpi_memory_device_dir);
+		acpi_device_dir(device) = NULL;
+	}
+
+	return_VALUE(0);
+}
+
 static int 
 acpi_memory_get_device_resources(struct acpi_memory_device *mem_device) 
 {
@@ -102,6 +220,7 @@ acpi_memory_get_device_resources(struct 
 		return_VALUE(-EINVAL);
 
 	resource = (struct acpi_resource *) buffer.pointer;
+	mem_device->resource = *resource;
 		
 	switch (resource->id) {
 	case ACPI_RSTYPE_ADDRESS16:
@@ -409,16 +528,19 @@ acpi_memory_device_add(struct acpi_devic
 
 	/* Get the range from the _CRS */
 	result = acpi_memory_get_device_resources(mem_device);
-	if (result) {
-		kfree(mem_device);
-		return_VALUE(result);
-	}
+	if (result)
+		goto end;
 		
 	/* Set the device state */
 	mem_device->state = MEMORY_POWER_ON_STATE;
 
 	printk(KERN_INFO "%s \n", acpi_device_name(device));
 
+	/* procfs */
+	result = acpi_memory_add_fs(device);
+	if (result)
+		goto end;
+
 	status = acpi_install_notify_handler(mem_device->handle,
 		ACPI_SYSTEM_NOTIFY, acpi_memory_device_notify, mem_device);
 	if (ACPI_FAILURE(status)) {
@@ -428,6 +550,12 @@ acpi_memory_device_add(struct acpi_devic
 		kfree(mem_device);
 	}
 	
+end:
+	if (result) {
+		acpi_memory_remove_fs(device);
+		kfree(mem_device);
+	}
+
 	return_VALUE(result);
 }
 
@@ -442,6 +570,9 @@ acpi_memory_device_remove (struct acpi_d
 		return_VALUE(-EINVAL);
 	
 	mem_device = (struct acpi_memory_device *) acpi_driver_data(device);
+
+	acpi_memory_remove_fs(device);
+
 	kfree(mem_device);
 
 	return_VALUE(0);
@@ -531,11 +662,18 @@ acpi_memory_device_init (void)
 
 	ACPI_FUNCTION_TRACE("acpi_memory_device_init");
 
-	result = acpi_bus_register_driver(&acpi_memory_device_driver);
+	acpi_memory_device_dir = proc_mkdir(ACPI_MEMORY_DEVICE_CLASS,
+					    acpi_root_dir);
+	if (!acpi_memory_device_dir)
+		return_VALUE(-ENODEV);
+	acpi_memory_device_dir->owner = THIS_MODULE;
 
-	if (result < 0) 
+	result = acpi_bus_register_driver(&acpi_memory_device_driver);
+	if (result < 0) {
+		remove_proc_entry(ACPI_MEMORY_DEVICE_CLASS, acpi_root_dir);
 		return_VALUE(-ENODEV);
-	
+	}
+
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, 
 				ACPI_UINT32_MAX,
 				acpi_memory_register_notify_handler, 
@@ -543,6 +681,7 @@ acpi_memory_device_init (void)
 
 	if (ACPI_FAILURE (status)) {
 		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "walk_namespace failed\n"));
+		remove_proc_entry(ACPI_MEMORY_DEVICE_CLASS, acpi_root_dir);
 		acpi_bus_unregister_driver(&acpi_memory_device_driver);
 		return_VALUE(-ENODEV);
         }
@@ -571,6 +710,8 @@ acpi_memory_device_exit (void)
 
 	acpi_bus_unregister_driver(&acpi_memory_device_driver);
 
+	remove_proc_entry(ACPI_MEMORY_DEVICE_CLASS, acpi_root_dir);
+
 	return_VOID;
 }
 

_


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
