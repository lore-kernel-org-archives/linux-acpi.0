From: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [Lhms-devel] [PATCH 1/1]  patch to fix acpi_memhotplug.c
Date: Tue, 15 Nov 2005 19:20:48 +0900
Message-ID: <20051115171221.7E99.Y-GOTO@jp.fujitsu.com>
References: <1131771825.20603.44.camel@knk> <1132033003.3798.21.camel@knk>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1132033003.3798.21.camel@knk>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, external hotplug mem list <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello, Keith-san.

>   I am submitting this patch for inclusion in the acpi development tree.
> I have not received any feedback of my beta patch or emails over the
> past week.  I cleaned my previous patch up and made the error handling
> match the rest of the driver.  I need this patch to support my hardware
> (IBM x460/x366/x445) acpi hot-add memory events.   
> 
>   In general acpi_bus_get_device fails for my event. 
> acpi_bus-0072 [04] bus_get_device        : No context for object [ffff81007ff397f0] 
>   The current driver relies on acpi_bus_get_device to create the acpi
> memory_device but these call fails for my hardware.  
>   
>   My event is a single notify with a memory range passed along as data.
> The current driver is expecting some other event or series of events (As
> I have posted before I am a little confused on how the current driver
> works at all).  My code provides a way for the data that is passed along
> during the event to be converted directly to the memory_device without
> reliance on acpi_bus_get_device.  My code in no way breaks the current
> implementation and seems a reasonable addition for increased
> flexibility. 

Hmm.
I have a bit similar (but contrastive) problem on our making box.
In my case, physical hotplug unit is a node. So, notification of event
will reach "container driver". And container driver just call 
struct acpi_driver ops.add via acpi_bus_scan(). And it will also call
ops.start if start method is exist.

Howerver, there is no ops.start method in acpi_memhotplug.c.
So, when bus is scaned by container driver add event,
add_memory is not called.
Following patch is to add start method for it.



BTW, I recommend that you should add ACPI_FUNCTION_TRACE() at
acpi_memory_get_current_resource() for debugging like other acpi
functions.


Thanks.


Signed-off-by: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

--
Index: test_acpi/drivers/acpi/acpi_memhotplug.c
===================================================================
--- test_acpi.orig/drivers/acpi/acpi_memhotplug.c	2005-11-15 18:55:27.000000000 +0900
+++ test_acpi/drivers/acpi/acpi_memhotplug.c	2005-11-15 18:55:39.000000000 +0900
@@ -57,6 +57,7 @@ MODULE_LICENSE("GPL");
 
 static int acpi_memory_device_add(struct acpi_device *device);
 static int acpi_memory_device_remove(struct acpi_device *device, int type);
+static int acpi_memory_device_start (struct acpi_device *device);
 
 static struct acpi_driver acpi_memory_device_driver = {
 	.name = ACPI_MEMORY_DEVICE_DRIVER_NAME,
@@ -65,6 +66,7 @@ static struct acpi_driver acpi_memory_de
 	.ops = {
 		.add = acpi_memory_device_add,
 		.remove = acpi_memory_device_remove,
+		.start = acpi_memory_device_start,
 		},
 };
 
@@ -422,6 +424,26 @@ static int acpi_memory_device_remove(str
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
+	return_VALUE(result);
+}
+
 /*
  * Helper function to check for memory device
  */

-- 
Yasunori Goto 




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
