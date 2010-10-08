From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] ACPI: Do not export hid/modalias sysfs file for
 ACPI objects without a HID
Date: Fri, 08 Oct 2010 08:26:21 +0800
Message-ID: <1286497581.2111.3753.camel@rui>
References: <1285923240-31671-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19912 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab0JHA2b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Oct 2010 20:28:31 -0400
In-Reply-To: <1285923240-31671-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "kay.sievers@vrfy.org" <kay.sievers@vrfy.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>

On Fri, 2010-10-01 at 16:53 +0800, Thomas Renninger wrote:
> Boot and compile tested.
> The fact that pnp.ids can now be empty needs testing on some
> further machines, though.
> 
> This should handle a "modprobe is wrongly called by udev" issue:
> https://bugzilla.kernel.org/show_bug.cgi?id=19162
> 
> Modaliase files in
> /sys/devices/LNXSYSTM:00/
> went down from 113 to 71 on my tested system.
> 
> This is a sysfs change, but userspace must already be able to handle it.
> 
> Also do not fill up pnp.ids list with a "struct hid"
> entry. This comment:
>      * This generic ID isn't useful for driver binding, but it provides
>      * the useful property that "every acpi_device has an ID."
> is still half way true:
> Best you never touch pnp.ids list directly or make sure it can be empty,
> instead use:
> char *acpi_device_hid()
> which always returns a value ("device" as a dummy if the object
> has no hid).
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: Zhang Rui <rui.zhang@intel.com>
> CC: kay.sievers@vrfy.org
> CC: <linux-acpi@vger.kernel.org>
> CC: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  drivers/acpi/scan.c |   36 ++++++++++++++++++++----------------
>  1 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index b23825e..d281afb 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -26,6 +26,9 @@ extern struct acpi_device *acpi_root;
>  
>  #define ACPI_IS_ROOT_DEVICE(device)    (!(device)->parent)
>  
> +/* Should be const */
> +static char* dummy_hid = "device";
> +
>  static LIST_HEAD(acpi_device_list);
>  static LIST_HEAD(acpi_bus_id_list);
>  DEFINE_MUTEX(acpi_device_lock);
> @@ -49,6 +52,9 @@ static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
>  	int count;
>  	struct acpi_hardware_id *id;
>  
> +	if (list_empty(&acpi_dev->pnp.ids))
> +		return 0;
> +
>  	len = snprintf(modalias, size, "acpi:");
>  	size -= len;
>  
> @@ -202,13 +208,15 @@ static int acpi_device_setup_files(struct acpi_device *dev)
>  			goto end;
>  	}
>  
> -	result = device_create_file(&dev->dev, &dev_attr_hid);
> -	if (result)
> -		goto end;
> +	if (!list_empty(&dev->pnp.ids)) {
> +		result = device_create_file(&dev->dev, &dev_attr_hid);
> +		if (result)
> +			goto end;
>  
> -	result = device_create_file(&dev->dev, &dev_attr_modalias);
> -	if (result)
> -		goto end;
> +		result = device_create_file(&dev->dev, &dev_attr_modalias);
> +		if (result)
> +			goto end;
> +	}
>  

the "hid" attribute exports the first entry of the device.pnp..ids list,
while "modalias" exports all the entries.
now it seems that the "hid" file is redundant, right?

thanks,
rui


