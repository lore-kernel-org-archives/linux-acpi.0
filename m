From: KAMEZAWA Hiroyuki <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [Lhms-devel] [PATCH 1/1]  patch to fix acpi_memhotplug.c
Date: Wed, 16 Nov 2005 12:26:34 +0900
Message-ID: <437AA6EA.905@jp.fujitsu.com>
References: <1131399845.6313.73.camel@knk>  <1131677135.20603.22.camel@knk>	 <1131771825.20603.44.camel@knk> <1132033003.3798.21.camel@knk>	 <4379AA86.5040901@jp.fujitsu.com> <1132109343.3798.62.camel@knk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1132109343.3798.62.camel@knk>
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
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, external hotplug mem list <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

keith wrote:
> Kame this patch will not apply to 2.6.14-mm1 or 2.6.15-rc1.  Is this
> patch ment to be used with other patches?
> 
Hmm, I created this on 2.6.14-mm1 .. but I'll re-check my tree. sorry.



>>  static int
>>  acpi_memory_get_device_resources(struct acpi_memory_device *mem_device)
>>  {
>>@@ -112,18 +130,14 @@ acpi_memory_get_device_resources(struct
>>
>>  static int
>>  acpi_memory_get_device(acpi_handle handle,
>>-		       struct acpi_memory_device **mem_device)
>>+		       struct acpi_device **device)
here. **device. *device is filled by this func.

>>-	/*
>>-	 * Now add the notified device.  This creates the acpi_device
>>-	 * and invokes .add function
>>-	 */
>>-	status = acpi_bus_add(&device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);
>>+	status = acpi_bus_add(device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);
> 
> 
> At this point the device is a null pointer?  Where is the device created
> you pass to acpi_bus_add?

*device is null at this point.

See:
acpi_bus_add()
     -> acpi_bus_scan()(ops.acpi_op_add = 1;)
	-> acpi_add_single_object()
	   (*)device = kmalloc(sizeof(struct acpi_device), GFP_KERNEL);
	    -> acpi_bus_find_driver()
		-> acpi_bus_driver_init()
		   here driver->ops.add = acpi_memory_device_add,
		    -> acpi_memory_device_add()
		       (*) mem_device = kmalloc(sizeof(struct acpi_memory_device), GFP_KERNEL);

All necessary kmalloc is done under acpi_bus_add().
And pointer to device is returned in the first argment(struct acpi_device **).
This is the same manner as acpi_processor/acpi_container.

> 
> 
>>  	if (ACPI_FAILURE(status)) {
>>  		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error in acpi_bus_add\n"));
>>  		return_VALUE(-EINVAL);
>>  	}
>>
>>-      end:
>>-	*mem_device = acpi_driver_data(device);
>>-	if (!(*mem_device)) {
>>-		printk(KERN_ERR "\n driver data not found");
>>-		return_VALUE(-ENODEV);
>>-	}
>>-
>>  	return_VALUE(0);
>>  }
> 
> 
> Where does acpi_memory_get_device return the device via the device
> pointer?  I don't see anywhere it is assigned....  
> 
1                 status = acpi_bus_get_device(handle, &device);
2                 if (ACPI_FAILURE(status) || !device) {
3                         if (present) {
4                                 status = acpi_memory_get_device(handle, &device);
5                                 if (ACPI_FAILURE(status) || !device) {
6                                         ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
7                                           "Error in finding driver data\n"));
8                                         return_VOID;
9                                 }
10                        } else {
11                                ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
12                                        "notified handle seems not present"));
13                                return_VOID;
14                        }
15                }

in line 4 above.


> I am not having _STA confusion.  acpi_memory_get_device just dosen't
> return a device.  I would still fall into "Error in finding driver"
> path. 
> 
Hmm, I'll look into more.
BTW, could you confirm following ?
(1) CONFIG_ACPI_HOTPLUG_MEMORY=y
(2) Does your memory device has type PNP0C80 ?


Thanks,
-- Kame



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
