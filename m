From: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: [RFC:PATCH] ACPI code for memory hot-add when node is added [1/2]
Date: Thu, 01 Sep 2005 15:11:27 +0900
Message-ID: <20050901143206.4A11.Y-GOTO@jp.fujitsu.com>
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


If a notification is delivered a container with memory block like a numa node,
container driver should searches devices which belongs on the container
and adds it.
But current implementation works only when notification comes directly
to memory device, because notify handler for memory device calls
enable_device() directly.
I think acpi_memory_device driver should have .start method to call
acpi_memory_enable_device(). This method is calls from both notification case
memory device and container.

Signed-off-by: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

Index: acpi_add_new/drivers/acpi/acpi_memhotplug.c
===================================================================
--- acpi_add_new.orig/drivers/acpi/acpi_memhotplug.c	2005-08-11 19:34:44.000000000 +0900
+++ acpi_add_new/drivers/acpi/acpi_memhotplug.c	2005-08-11 19:35:07.000000000 +0900
@@ -58,6 +58,7 @@ MODULE_LICENSE("GPL");
 
 static int acpi_memory_device_add (struct acpi_device *device);
 static int acpi_memory_device_remove (struct acpi_device *device, int type);
+static int acpi_memory_device_start (struct acpi_device *device);
 
 static struct acpi_driver acpi_memory_device_driver = {
 	.name =		ACPI_MEMORY_DEVICE_DRIVER_NAME,
@@ -66,6 +67,7 @@ static struct acpi_driver acpi_memory_de
 	.ops =		{
 				.add =		acpi_memory_device_add,
 				.remove =	acpi_memory_device_remove,
+				.start =	acpi_memory_device_start,
 			},
 };
 
@@ -309,12 +311,6 @@ acpi_memory_device_notify(acpi_handle ha
 				"Error in finding driver data\n"));
 			return_VOID;
 		}
-
-		if (!acpi_memory_check_device(mem_device)) {
-			if (acpi_memory_enable_device(mem_device))
-				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				"Error in acpi_memory_enable_device\n"));
-		}
 		break;
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -406,6 +402,27 @@ acpi_memory_device_remove (struct acpi_d
 	return_VALUE(0);
 }
 
+static int
+acpi_memory_device_start (struct acpi_device *device)
+{
+	struct acpi_memory_device *mem_device = NULL;
+	int result = 0;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_device_start");
+
+	mem_device = (struct acpi_memory_device *) acpi_driver_data(device);
+
+	if (!acpi_memory_check_device(mem_device)){
+		/* call add_memory func */
+		result = acpi_memory_enable_device(mem_device);
+		if (result)
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error in acpi_memory_enable_device\n"));
+	}
+
+	return_VALUE(result);
+}
+
 /*
  * Helper function to check for memory device
  */

-- 
Yasunori Goto 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
