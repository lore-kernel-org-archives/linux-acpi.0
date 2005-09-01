From: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: [RFC:PATCH] ACPI code for memory hot-add when node is added [2/2]
Date: Thu, 01 Sep 2005 15:18:57 +0900
Message-ID: <20050901151301.4A16.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-ML <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Linux Hotplug Memory Support <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


This patch is to get ACPI handle of its memory block 
from physical memory address. 
Its handle is used to get node id from physical address.

This patch still return pxm number as a node id directly.
It should map new node id to pxm_to_nid_map[].

However I'm worried about alternative idea which is removing this map.
Current kernel implementation might be able to 
accept discontigous node id, because all of old "for" loop of
node id was changed to for_each_node() or for_each_online_node().
But I'm not sure...

Signed-off-by: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

Index: acpi_add_new/drivers/acpi/acpi_memhotplug.c
===================================================================
--- acpi_add_new.orig/drivers/acpi/acpi_memhotplug.c	2005-08-31 16:20:37.000000000 +0900
+++ acpi_add_new/drivers/acpi/acpi_memhotplug.c	2005-08-31 16:20:39.000000000 +0900
@@ -501,6 +501,94 @@ acpi_memory_deregister_notify_handler (a
 	return_ACPI_STATUS(status);
 }
 
+static int
+acpi_find_node_id(acpi_handle *handle, int *nid)
+{
+	int pxm;
+
+	ACPI_FUNCTION_TRACE("acpi_find_node_id");
+
+	pxm = acpi_get_pxm(handle);
+	if (pxm < 0)
+		return_VALUE(-ENODEV);
+
+	*nid = pxm; /* XXX: Direct map from pxm to nid. */
+
+	return_VALUE(0);
+}
+
+struct find_memdevice_arg{
+	u64 start_addr;
+	u64 size;
+};
+
+acpi_status
+acpi_memory_match_paddr_to_memdevice(acpi_handle handle, u32 lvl, void *context, void **retv)
+{
+	acpi_status status;
+	struct acpi_device *device = NULL;
+	struct find_memdevice_arg *arg = context;
+	struct acpi_memory_device *mem_device = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_match_paddr_to_memdevice\n");
+
+	status = is_memory_device(handle);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(AE_OK);       /* Not memory device. continue */
+
+	if (acpi_bus_get_device(handle, &device) || !device)
+		return_ACPI_STATUS(AE_OK);       /* Device is not attached. continue */
+
+	mem_device = acpi_driver_data(device);
+	if ((status = acpi_memory_check_device(mem_device)) < 0)
+		return_ACPI_STATUS(AE_OK);       /* Not online. continue */
+
+	if (mem_device->start_addr > arg->start_addr ||
+	    mem_device->end_addr + 1 < arg->start_addr + arg->size)
+		return_ACPI_STATUS(AE_OK);      /* Not match. continue */
+
+	*retv = (void *)mem_device;
+
+	return_ACPI_STATUS(AE_CTRL_TERMINATE);
+}
+
+static int
+acpi_memory_find_memdevice(u64 start_addr, u64 size,
+			struct acpi_memory_device **mem_device)
+{
+	acpi_status status;
+	struct find_memdevice_arg arg;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_find_memdevice\n");
+
+	arg.start_addr = start_addr;
+	arg.size = size;
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX,
+				     acpi_memory_match_paddr_to_memdevice,
+				     (void *)&arg, (void **)mem_device);
+
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "walk_namespace_failed at acpi_memory_fine_memdevice\n"));
+		return_VALUE(-ENODEV);
+	}
+	return_VALUE(0);
+}
+
+int
+acpi_search_node_id(u64 start_addr, u64 size)
+{
+	struct acpi_memory_device *mem_device;
+	int nid = -1;
+	ACPI_FUNCTION_TRACE("acpi_search_node_id\n");
+
+	if (!acpi_memory_find_memdevice(start_addr, size, &mem_device))
+		acpi_find_node_id(mem_device->handle, &nid);
+
+	return_VALUE(nid);
+}
+
 static int __init
 acpi_memory_device_init (void)
 {

-- 
Yasunori Goto 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
