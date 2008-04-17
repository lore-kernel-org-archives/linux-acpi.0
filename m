From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 2/7] ACPI: Introduce static func: cid_add to add IDs as
	compatible IDs to a device
Date: Thu, 17 Apr 2008 17:02:43 +0800
Message-ID: <1208422963.7844.13.camel@yakui_zhao.sh.intel.com>
References: <1208371949.1784.343.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25401 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762511AbYDQBL0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2008 21:11:26 -0400
In-Reply-To: <1208371949.1784.343.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Corentin CHARY <corentincj@iksaif.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>

On Wed, 2008-04-16 at 20:52 +0200, Thomas Renninger wrote:
> ACPI: Introduce static func: cid_add to add IDs as compatible IDs to a device
> 
> Rip the functionality out of acpi_device_set_id, it is needed elsewhere in
> the code on follow-up patches.
> 
It seems that the cid_add function will be called twice for some
devices. 
For example: VIDEO device
    When the CID object exists, the cid_add function will be called to
add the compatible_list.
    When it is identified as the VIDEO device, the cid_add function will
be called again to add the compatible_list.

In such case the compatible_list pointer will be replaced directly by
new pointer and the memory pointed by compatible_list can't be free.

Best regards.
   Yakui
    
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> 
> ---
>  drivers/acpi/scan.c |   97 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 50 insertions(+), 47 deletions(-)
> 
> Index: linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/scan.c
> ===================================================================
> --- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/acpi/scan.c
> +++ linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/scan.c
> @@ -954,6 +954,52 @@ static int acpi_dock_match(struct acpi_d
>  	return acpi_get_handle(device->handle, "_DCK", &tmp);
>  }
>  
> +/* Add a single Compatible ID or a whole list of CIDs to a device */
> +static void cid_add(struct acpi_device *device, const char *cid_add,
> +		    struct acpi_compatible_id_list *cid_list) {
> +
> +	struct acpi_compatible_id_list *list = NULL;
> +	int size = 0;
> +	int count = 0;
> +
> +	if (!cid_list && !cid_add)
> +		return;
> +
> +	if (cid_list) {
> +		size = cid_list->size;
> +	} else if (cid_add) {
> +		size = sizeof(struct acpi_compatible_id_list);
> +		cid_list = ACPI_ALLOCATE_ZEROED((acpi_size) size);
> +		if (!cid_list) {
> +			printk(KERN_ERR "Memory allocation error\n");
> +			return;
> +		} else {
> +			cid_list->count = 0;
> +			cid_list->size = size;
> +		}
> +	}
> +	if (cid_add)
> +		size += sizeof(struct acpi_compatible_id);
> +	list = kmalloc(size, GFP_KERNEL);
> +
> +	if (list) {
> +		if (cid_list) {
> +			memcpy(list, cid_list, cid_list->size);
> +			count = cid_list->count;
> +		}
> +		if (cid_add) {
> +			strncpy(list->id[count].value, cid_add,
> +				ACPI_MAX_CID_LENGTH);
> +			count++;
> +			device->flags.compatible_ids = 1;
> +		}
> +		list->size = size;
> +		list->count = count;
> +		device->pnp.cid_list = list;
> +	} else
> +		printk(KERN_ERR PREFIX "Memory allocation error\n");
> +}
> +
>  static void acpi_device_set_id(struct acpi_device *device,
>  			       struct acpi_device *parent, acpi_handle handle,
>  			       int type)
> @@ -962,8 +1008,6 @@ static void acpi_device_set_id(struct ac
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  	char *hid = NULL;
>  	char *uid = NULL;
> -	struct acpi_compatible_id_list *cid_list = NULL;
> -	const char *cid_add = NULL;
>  	acpi_status status;
>  
>  	switch (type) {
> @@ -980,7 +1024,7 @@ static void acpi_device_set_id(struct ac
>  		if (info->valid & ACPI_VALID_UID)
>  			uid = info->unique_id.value;
>  		if (info->valid & ACPI_VALID_CID)
> -			cid_list = &info->compatibility_id;
> +			cid_add(device, NULL, &info->compatibility_id);
>  		if (info->valid & ACPI_VALID_ADR) {
>  			device->pnp.bus_address = info->address;
>  			device->flags.bus_address = 1;
> @@ -992,11 +1036,11 @@ static void acpi_device_set_id(struct ac
>  		   against another driver.
>  		*/
>  		if (ACPI_SUCCESS(acpi_video_bus_match(device)))
> -			cid_add = ACPI_VIDEO_HID;
> +			cid_add(device, ACPI_VIDEO_HID, NULL);
>  		else if (ACPI_SUCCESS(acpi_bay_match(device)))
> -			cid_add = ACPI_BAY_HID;
> +			cid_add(device, ACPI_BAY_HID, NULL);
>  		else if (ACPI_SUCCESS(acpi_dock_match(device)))
> -			cid_add = ACPI_DOCK_HID;
> +			cid_add(device, ACPI_DOCK_HID, NULL);;
>  
>  		break;
>  	case ACPI_BUS_TYPE_POWER:
> @@ -1038,47 +1082,6 @@ static void acpi_device_set_id(struct ac
>  		strcpy(device->pnp.unique_id, uid);
>  		device->flags.unique_id = 1;
>  	}
> -	if (cid_list || cid_add) {
> -		struct  acpi_compatible_id_list *list;
> -		int size = 0;
> -		int count = 0;
> -
> -		if (cid_list) {
> -			size = cid_list->size;
> -		} else if (cid_add) {
> -			size = sizeof(struct acpi_compatible_id_list);
> -			cid_list = ACPI_ALLOCATE_ZEROED((acpi_size) size);
> -			if (!cid_list) {
> -				printk(KERN_ERR "Memory allocation error\n");
> -				kfree(buffer.pointer);
> -				return;
> -			} else {
> -				cid_list->count = 0;
> -				cid_list->size = size;
> -			}
> -		}
> -		if (cid_add)
> -			size += sizeof(struct acpi_compatible_id);
> -		list = kmalloc(size, GFP_KERNEL);
> -
> -		if (list) {
> -			if (cid_list) {
> -				memcpy(list, cid_list, cid_list->size);
> -				count = cid_list->count;
> -			}
> -			if (cid_add) {
> -				strncpy(list->id[count].value, cid_add,
> -					ACPI_MAX_CID_LENGTH);
> -				count++;
> -				device->flags.compatible_ids = 1;
> -			}
> -			list->size = size;
> -			list->count = count;
> -			device->pnp.cid_list = list;
> -		} else
> -			printk(KERN_ERR PREFIX "Memory allocation error\n");
> -	}
> -
>  	kfree(buffer.pointer);
>  }
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

