From: Darren Hart <dvhart@infradead.org>,
	Carlos Corbacho <carlos@strangeworlds.co.uk>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] wmi: Set wmi devices' parents
Date: Mon, 23 Nov 2015 11:37:09 -0800
Message-ID: <20151123193709.GZ7413@malice.jf.intel.com>
References: <7c58f0a208e0c903008989aec457230e5e58608e.1448306649.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7c58f0a208e0c903008989aec457230e5e58608e.1448306649.git.luto@kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 23, 2015 at 11:25:30AM -0800, Andy Lutomirski wrote:
> Without this patch, wmi devices are in /sys/virtual/wmi.  They're
> logically children of the ACPI WMI device, so slot them into the
> device hierarchy.  With this change, on my laptop, they end up in
> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:00/wmi and
> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:01/wmi.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

I'd like to hear from some of the main contributors to this driver:

Matthew?
Carlos?
Len?

Any cocnerns on this change?

My initial concern is about changign how we expose this to userspace, but I
believe where it appears in the /sys/devices FS is NOT part of the
kernel-userspace interface commitment (per sysfs-rules.txt).

Greg, is that correct?

> ---
> 
> The WMI driver doesn't really play well with the driver model.  This
> helps a little.
> 
> Depending on how much time I find, I may send some followups to turn
> it into a real bus driver since it really does work like a bus.
> 
> drivers/platform/x86/wmi.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index eb391a281833..e58768787677 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -684,9 +684,11 @@ static struct class wmi_class = {
>  };
>  
>  static int wmi_create_device(const struct guid_block *gblock,
> -			     struct wmi_block *wblock, acpi_handle handle)
> +			     struct wmi_block *wblock,
> +			     struct acpi_device *device)
>  {
>  	wblock->dev.class = &wmi_class;
> +	wblock->dev.parent = &device->dev;
>  
>  	dev_set_name(&wblock->dev, "%pUL", gblock->guid);
>  
> @@ -723,7 +725,7 @@ static bool guid_already_parsed(const char *guid_string)
>  /*
>   * Parse the _WDG method for the GUID data blocks
>   */
> -static int parse_wdg(acpi_handle handle)
> +static int parse_wdg(struct acpi_device *device)
>  {
>  	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
>  	union acpi_object *obj;
> @@ -733,7 +735,7 @@ static int parse_wdg(acpi_handle handle)
>  	int retval;
>  	u32 i, total;
>  
> -	status = acpi_evaluate_object(handle, "_WDG", NULL, &out);
> +	status = acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
>  	if (ACPI_FAILURE(status))
>  		return -ENXIO;
>  
> @@ -757,7 +759,7 @@ static int parse_wdg(acpi_handle handle)
>  		if (!wblock)
>  			return -ENOMEM;
>  
> -		wblock->handle = handle;
> +		wblock->handle = device->handle;
>  		wblock->gblock = gblock[i];
>  
>  		/*
> @@ -767,7 +769,7 @@ static int parse_wdg(acpi_handle handle)
>  		  for device creation.
>  		*/
>  		if (!guid_already_parsed(gblock[i].guid)) {
> -			retval = wmi_create_device(&gblock[i], wblock, handle);
> +			retval = wmi_create_device(&gblock[i], wblock, device);
>  			if (retval) {
>  				wmi_free_devices();
>  				goto out_free_pointer;
> @@ -884,7 +886,7 @@ static int acpi_wmi_add(struct acpi_device *device)
>  		return -ENODEV;
>  	}
>  
> -	error = parse_wdg(device->handle);
> +	error = parse_wdg(device);
>  	if (error) {
>  		acpi_remove_address_space_handler(device->handle,
>  						  ACPI_ADR_SPACE_EC,
> -- 
> 2.5.0
> 
> 

-- 
Darren Hart
Intel Open Source Technology Center
