From: keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/1]  patch to fix acpi_memhotplug.c
Date: Mon, 14 Nov 2005 21:36:42 -0800
Message-ID: <1132033003.3798.21.camel@knk>
References: <1131399845.6313.73.camel@knk>  <1131677135.20603.22.camel@knk>
	 <1131771825.20603.44.camel@knk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-OTT9nVwtqLPyZbIE34PU"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1131771825.20603.44.camel@knk>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, external hotplug mem list <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-OTT9nVwtqLPyZbIE34PU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

  I am submitting this patch for inclusion in the acpi development tree.
I have not received any feedback of my beta patch or emails over the
past week.  I cleaned my previous patch up and made the error handling
match the rest of the driver.  I need this patch to support my hardware
(IBM x460/x366/x445) acpi hot-add memory events.   

  In general acpi_bus_get_device fails for my event. 
acpi_bus-0072 [04] bus_get_device        : No context for object [ffff81007ff397f0] 
  The current driver relies on acpi_bus_get_device to create the acpi
memory_device but these call fails for my hardware.  
  
  My event is a single notify with a memory range passed along as data.
The current driver is expecting some other event or series of events (As
I have posted before I am a little confused on how the current driver
works at all).  My code provides a way for the data that is passed along
during the event to be converted directly to the memory_device without
reliance on acpi_bus_get_device.  My code in no way breaks the current
implementation and seems a reasonable addition for increased
flexibility. 

This patch is against 2.6.15-rc1. 

Signed-off-by:  Keith Mannthey <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>





--=-OTT9nVwtqLPyZbIE34PU
Content-Disposition: attachment; filename=acpi_mem_fixv2.patch
Content-Type: text/x-patch; name=acpi_mem_fixv2.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.15-rc1-orig/drivers/acpi/acpi_memhotplug.c	2005-11-14 10:56:13.000000000 -0800
+++ linux-2.6.15-rc1/drivers/acpi/acpi_memhotplug.c	2005-11-14 21:01:43.000000000 -0800
@@ -110,6 +110,30 @@
 	return_VALUE(0);
 }
 
+static int 
+acpi_memory_get_current_resource(acpi_handle handle, struct acpi_memory_device **return_device) {
+	
+	int result;
+	struct acpi_memory_device *mem_device;
+	
+	mem_device = kmalloc(sizeof(struct acpi_memory_device), GFP_KERNEL);
+	if (!mem_device)
+		return_VALUE(-ENOMEM);
+	memset(mem_device,0, sizeof(struct acpi_memory_device));
+
+	mem_device->handle = handle;
+	result = acpi_memory_get_device_resources(mem_device);
+	if (result) {
+		kfree(mem_device);
+		return_VALUE(result);
+	}
+	mem_device->state = MEMORY_POWER_ON_STATE;
+	*return_device = mem_device;
+	
+	return_VALUE(result);
+}
+
+
 static int
 acpi_memory_get_device(acpi_handle handle,
 		       struct acpi_memory_device **mem_device)
@@ -118,6 +142,7 @@
 	acpi_handle phandle;
 	struct acpi_device *device = NULL;
 	struct acpi_device *pdevice = NULL;
+	int result;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_get_device");
 
@@ -147,14 +172,17 @@
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error in acpi_bus_add\n"));
 		return_VALUE(-EINVAL);
 	}
-
       end:
 	*mem_device = acpi_driver_data(device);
+
 	if (!(*mem_device)) {
-		printk(KERN_ERR "\n driver data not found");
-		return_VALUE(-ENODEV);
+		/* Try and get the memory_device from the current handle */
+		result = acpi_memory_get_current_resource(handle,mem_device);
+		if (result) {
+			printk(KERN_ERR "\nThere is no data for this memory device\n");
+			return_VALUE(-EINVAL);
+		}
 	}
-
 	return_VALUE(0);
 }
 

--=-OTT9nVwtqLPyZbIE34PU--



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
