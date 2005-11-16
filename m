From: keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Lhms-devel] [PATCH 1/1]  patch to fix acpi_memhotplug.c
Date: Tue, 15 Nov 2005 18:49:03 -0800
Message-ID: <1132109343.3798.62.camel@knk>
References: <1131399845.6313.73.camel@knk>  <1131677135.20603.22.camel@knk>
	 <1131771825.20603.44.camel@knk> <1132033003.3798.21.camel@knk>
	 <4379AA86.5040901@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4379AA86.5040901-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, external hotplug mem list <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-11-15 at 18:29 +0900, KAMEZAWA Hiroyuki wrote:
> keith wrote:
> > Hello,
> > 
> >   I am submitting this patch for inclusion in the acpi development tree.
> > I have not received any feedback of my beta patch or emails over the
> > past week.  I cleaned my previous patch up and made the error handling
> > match the rest of the driver.  I need this patch to support my hardware
> > (IBM x460/x366/x445) acpi hot-add memory events.   
> > 
> 
> Sorry, I missed your previous e-mail.
> 
> >   In general acpi_bus_get_device fails for my event. 
> > acpi_bus-0072 [04] bus_get_device        : No context for object [ffff81007ff397f0] 
> >   The current driver relies on acpi_bus_get_device to create the acpi
> > memory_device but these call fails for my hardware.  
> >   
> 
> I think the case in which a device is not onlined at boot time and
> not -scaned- is not correctly managed. Could you try attached patch ?
> 
> -- Kame <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>


Kame this patch will not apply to 2.6.14-mm1 or 2.6.15-rc1.  Is this
patch ment to be used with other patches?

My device is present at boot time (It appears in my ACPI namespace).  I
don't know what you mean by correctly managed. 

I am not sure this patch will work for me.  
Even thought you don't call acpi_bus_get_device you don't created the
acpi_device.  There is no path to kmalloc to create the device. In your
acpi_memory_get_device how is it intended to create the acpi_device or
mem_device.

See comments below...

> ==
> Fix acpi_memory_get_device().
> A case of "memory object is not onlined at boot time but hot-added" is managed.
> 
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
> 
> 
> Index: linux-2.6.14-mm1/drivers/acpi/acpi_memhotplug.c
> ===================================================================
> --- linux-2.6.14-mm1.orig/drivers/acpi/acpi_memhotplug.c
> +++ linux-2.6.14-mm1/drivers/acpi/acpi_memhotplug.c
> @@ -77,6 +77,24 @@ struct acpi_memory_device {
>   	u64 end_addr;		/* Memory Range end physical addr */
>   };
> 
> +/* Maybe the same function in acpi_contaiener.c should be exported ..*/
> +#define ACPI_STA_PRESENT                (0x00000001)
> +static int is_memory_device_present(acpi_handle handle)
> +{
> +	acpi_status status;
> +	unsigned long sta;
> +	acpi_handle temp;
> +	ACPI_FUNCTION_TRACE("is_memory_device_present");
> +	status = acpi_get_handle(handle, "_STA", &temp);
> +	if (ACPI_FAILURE(status))
> +		return_VALUE(1);	/* _STA not found, assume present */
> +	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
> +	if (ACPI_FAILURE(status))
> +		return_VALUE(0);
> +	return_VALUE((sta & ACPI_STA_PRESENT) == ACPI_STA_PRESENT);
> +}
> +
> +
>   static int
>   acpi_memory_get_device_resources(struct acpi_memory_device *mem_device)
>   {
> @@ -112,18 +130,14 @@ acpi_memory_get_device_resources(struct
> 
>   static int
>   acpi_memory_get_device(acpi_handle handle,
> -		       struct acpi_memory_device **mem_device)
> +		       struct acpi_device **device)
>   {
>   	acpi_status status;
>   	acpi_handle phandle;
> -	struct acpi_device *device = NULL;
>   	struct acpi_device *pdevice = NULL;
> 
>   	ACPI_FUNCTION_TRACE("acpi_memory_get_device");
> 
> -	if (!acpi_bus_get_device(handle, &device) && device)
> -		goto end;
> -
>   	status = acpi_get_parent(handle, &phandle);
>   	if (ACPI_FAILURE(status)) {
>   		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error in acpi_get_parent\n"));
> @@ -138,23 +152,12 @@ acpi_memory_get_device(acpi_handle handl
>   		return_VALUE(-EINVAL);
>   	}
> 
> -	/*
> -	 * Now add the notified device.  This creates the acpi_device
> -	 * and invokes .add function
> -	 */
> -	status = acpi_bus_add(&device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);
> +	status = acpi_bus_add(device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);

At this point the device is a null pointer?  Where is the device created
you pass to acpi_bus_add?

>   	if (ACPI_FAILURE(status)) {
>   		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error in acpi_bus_add\n"));
>   		return_VALUE(-EINVAL);
>   	}
> 
> -      end:
> -	*mem_device = acpi_driver_data(device);
> -	if (!(*mem_device)) {
> -		printk(KERN_ERR "\n driver data not found");
> -		return_VALUE(-ENODEV);
> -	}
> -
>   	return_VALUE(0);
>   }

Where does acpi_memory_get_device return the device via the device
pointer?  I don't see anywhere it is assigned....  

> 
> @@ -282,9 +285,11 @@ static void acpi_memory_device_notify(ac
>   {
>   	struct acpi_memory_device *mem_device;
>   	struct acpi_device *device;
> +	acpi_status status;
> +	int present;
> 
>   	ACPI_FUNCTION_TRACE("acpi_memory_device_notify");
> -
> +	present = is_memory_device_present(handle);
>   	switch (event) {
>   	case ACPI_NOTIFY_BUS_CHECK:
>   		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> @@ -294,12 +299,26 @@ static void acpi_memory_device_notify(ac
>   		if (event == ACPI_NOTIFY_DEVICE_CHECK)
>   			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>   					  "\nReceived DEVICE CHECK notification for device\n"));
> -		if (acpi_memory_get_device(handle, &mem_device)) {
> -			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> +		status = acpi_bus_get_device(handle, &device);
> +		if (ACPI_FAILURE(status) || !device) {
> +			if (present) {
> +				status = acpi_memory_get_device(handle, &device);
> +				if (ACPI_FAILURE(status) || !device) {
> +					ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>   					  "Error in finding driver data\n"));
> +					return_VOID;
> +				}
> +			} else {
> +				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> +					"notified handle seems not present"));
> +				return_VOID;
> +			}
> +		}
> +		mem_device = acpi_driver_data(device);

What part of the code is creating the mem_device attached to the generic
acpi_device?  acpi_driver_data is a simple beast that return the data
field in the device.  Who attaches the memory_device to the generic
acpi_device?

I am not having _STA confusion.  acpi_memory_get_device just dosen't
return a device.  I would still fall into "Error in finding driver"
path. 


> +		if (!mem_device) {
> +			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "error acpi_memhotplug: device has no mem_device"));
>   			return_VOID;
>   		}
> -
>   		if (!acpi_memory_check_device(mem_device)) {
>   			if (acpi_memory_enable_device(mem_device))
>   
> 				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,

I don't see who this patch will create of find the correct memory_device
in my situation but if you patch that applies I would me happy to try
out your changes.

Thanks,
keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
