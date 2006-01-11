From: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: [Patch 2/2]Memory hotplug from ACPI container driver take 2.(allow -EEXIST.)
Date: Wed, 11 Jan 2006 18:58:51 +0900
Message-ID: <20060111184657.BCB4.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI-ML <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel ML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


When acpi_memory_device_init() is called at boottime to
register struct memory acpi_memory_device. So, 
acpi_bus_add() are called via acpi_driver_attach().
But it also calls ops->start() function.
It is called even if the memory blocks are initialized at
early boottime. In this case add_memory() return -EEXIST, and
the memory blocks becomes INVALID state even if it is normal.

This is patch for it.

Signed-off-by: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>


Index: new_feature_patch/drivers/acpi/acpi_memhotplug.c
===================================================================
--- new_feature_patch.orig/drivers/acpi/acpi_memhotplug.c	2006-01-11 16:03:34.000000000 +0900
+++ new_feature_patch/drivers/acpi/acpi_memhotplug.c	2006-01-11 16:44:18.000000000 +0900
@@ -203,8 +203,19 @@ static int acpi_memory_enable_device(str
 	 */
 	result = add_memory(mem_device->start_addr,
 			    (mem_device->end_addr - mem_device->start_addr) + 1);
-	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "\nadd_memory failed\n"));
+
+	switch(result) {
+	case 0:
+		break;
+	case -EEXIST:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "\nmemory %lu-%lu has already existed\n"
+				  mem_device->start_addr,
+				  mem_device->end_addr));
+		return 0;
+	default:
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "\nadd_memory failed result=%d\n", result));
 		mem_device->state = MEMORY_INVALID_STATE;
 		return result;
 	}

-- 
Yasunori Goto 


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
