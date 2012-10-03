From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: [PATCH 4/4] acpi,memory-hotplug : store the node id in acpi_memory_device
Date: Wed, 3 Oct 2012 19:11:31 +0900
Message-ID: <506C0F53.5030500@jp.fujitsu.com>
References: <506C0AE8.40702@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <506C0AE8.40702@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rientjes@google.com, liuj97@gmail.com, len.brown@intel.com, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com, wency@cn.fujitsu.com
List-Id: linux-acpi@vger.kernel.org

From: Wen Congyang <wency@cn.fujitsu.com>

The memory device has only one node id. Store the node id when
enable the memory device, and we can reuse it when removing the
memory device.

CC: David Rientjes <rientjes@google.com>
CC: Jiang Liu <liuj97@gmail.com>
CC: Len Brown <len.brown@intel.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Christoph Lameter <cl@linux.com>
Cc: Minchan Kim <minchan.kim@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
CC: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
---
 drivers/acpi/acpi_memhotplug.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Index: linux-3.6/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-3.6.orig/drivers/acpi/acpi_memhotplug.c	2012-10-03 19:03:26.818401966 +0900
+++ linux-3.6/drivers/acpi/acpi_memhotplug.c	2012-10-03 19:08:38.804604700 +0900
@@ -83,6 +83,7 @@ struct acpi_memory_info {
 struct acpi_memory_device {
 	struct acpi_device * device;
 	unsigned int state;	/* State of the memory device */
+	int nid;
 	struct list_head res_list;
 };
 
@@ -256,6 +257,9 @@ static int acpi_memory_enable_device(str
 		info->enabled = 1;
 		num_enabled++;
 	}
+
+	mem_device->nid = node;
+
 	if (!num_enabled) {
 		printk(KERN_ERR PREFIX "add_memory failed\n");
 		mem_device->state = MEMORY_INVALID_STATE;
@@ -310,9 +314,7 @@ static int acpi_memory_remove_memory(str
 {
 	int result;
 	struct acpi_memory_info *info, *n;
-	int node;
-
-	node = acpi_get_node(mem_device->device->handle);
+	int node = mem_device->nid;
 
 	list_for_each_entry_safe(info, n, &mem_device->res_list, list) {
 		if (!info->enabled)
@@ -322,9 +324,6 @@ static int acpi_memory_remove_memory(str
 		if (result)
 			return result;
 
-		if (node < 0)
-			node = memory_add_physaddr_to_nid(info->start_addr);
-
 		result = remove_memory(node, info->start_addr, info->length);
 		if (result)
 			return result;
