From: keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Lhms-devel] [PATCH 1/1]  patch to fix acpi_memhotplug.c
Date: Wed, 16 Nov 2005 20:18:27 -0800
Message-ID: <1132201107.3798.81.camel@knk>
References: <1131771825.20603.44.camel@knk> <1132033003.3798.21.camel@knk>
	 <20051115171221.7E99.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-gydD2GKEGKfOnk4I3IzZ"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051115171221.7E99.Y-GOTO-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, external hotplug mem list <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-gydD2GKEGKfOnk4I3IzZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-11-15 at 19:20 +0900, Yasunori Goto wrote:
> Hello, Keith-san.
> 
> >   I am submitting this patch for inclusion in the acpi development tree.
> > I have not received any feedback of my beta patch or emails over the
> > past week.  I cleaned my previous patch up and made the error handling
> > match the rest of the driver.  I need this patch to support my hardware
> > (IBM x460/x366/x445) acpi hot-add memory events.   
> > 
> >   In general acpi_bus_get_device fails for my event. 
> > acpi_bus-0072 [04] bus_get_device        : No context for object [ffff81007ff397f0] 
> >   The current driver relies on acpi_bus_get_device to create the acpi
> > memory_device but these call fails for my hardware.  
> >   
> >   My event is a single notify with a memory range passed along as data.
> > The current driver is expecting some other event or series of events (As
> > I have posted before I am a little confused on how the current driver
> > works at all).  My code provides a way for the data that is passed along
> > during the event to be converted directly to the memory_device without
> > reliance on acpi_bus_get_device.  My code in no way breaks the current
> > implementation and seems a reasonable addition for increased
> > flexibility. 
> 
> Hmm.
> I have a bit similar (but contrastive) problem on our making box.
> In my case, physical hotplug unit is a node. So, notification of event
> will reach "container driver". And container driver just call 
> struct acpi_driver ops.add via acpi_bus_scan(). And it will also call
> ops.start if start method is exist.
> 
> Howerver, there is no ops.start method in acpi_memhotplug.c.
> So, when bus is scaned by container driver add event,
> add_memory is not called.
> Following patch is to add start method for it.

My add event is called with my patch.  The notify event is triggering
and falling into the right path. 

I tried your patch but my device is not making and add event.  I really
looks to just be a notify with the memory range attached.  I really
think my patch is the right way to go for my hardware. 

> 
> BTW, I recommend that you should add  at
> acpi_memory_get_current_resource() for debugging like other acpi
> functions.

Thanks.  I missed that. See the updated patch.  


Thanks,
  Keith Mannthey 
  LTC xSeries 

--=-gydD2GKEGKfOnk4I3IzZ
Content-Disposition: attachment; filename=acpi_mem_fixv3.patch
Content-Type: text/x-patch; name=acpi_mem_fixv3.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.15-rc1-orig/drivers/acpi/acpi_memhotplug.c	2005-11-14 10:56:13.000000000 -0800
+++ linux-2.6.15-rc1/drivers/acpi/acpi_memhotplug.c	2005-11-16 20:06:47.000000000 -0800
@@ -110,6 +110,32 @@
 	return_VALUE(0);
 }
 
+static int 
+acpi_memory_get_current_resource(acpi_handle handle, struct acpi_memory_device **return_device) {
+	
+	int result;
+	struct acpi_memory_device *mem_device;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_get_current_resource");
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
@@ -118,6 +144,7 @@
 	acpi_handle phandle;
 	struct acpi_device *device = NULL;
 	struct acpi_device *pdevice = NULL;
+	int result;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_get_device");
 
@@ -147,14 +174,17 @@
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
 

--=-gydD2GKEGKfOnk4I3IzZ--



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
