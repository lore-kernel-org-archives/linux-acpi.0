From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] ACPI: Fix resource_lock dead lock in acpi_power_on_device
Date: Fri, 14 Sep 2012 00:26:35 +0200
Message-ID: <201209140026.35993.rjw@sisk.pl>
References: <1347440853-12540-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:53100 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754861Ab2IMWUN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Sep 2012 18:20:13 -0400
In-Reply-To: <1347440853-12540-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Leb Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On Wednesday, September 12, 2012, Aaron Lu wrote:
> Commit 0090def("ACPI: Add interface to register/unregister device
> to/from power resources") used resource_lock to protect the devices list
> that relies on power resource. It caused a mutex dead lock, as below
> 
>     acpi_power_on ---> lock resource_lock
>       __acpi_power_on
>         acpi_power_on_device
>           acpi_power_get_inferred_state
>             acpi_power_get_list_state ---> lock resource_lock
> 
> This patch adds a new mutex "devices_lock" to protect the devices list
> and calls acpi_power_on_device in acpi_power_on, instead of
> __acpi_power_on, after the resource_lock is released.
> 
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Good catch, thanks.

I hope Len won't mind if I take it for v3.6.

> ---
> v2:
> If power resource is already on, no need to check if device needs
> to be resumed.
> v1:
> By Lin Ming.
> 
>  drivers/acpi/power.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 215ecd0..3582a26 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -105,6 +105,7 @@ struct acpi_power_resource {
>  
>  	/* List of devices relying on this power resource */
>  	struct acpi_power_resource_device *devices;
> +	struct mutex devices_lock;
>  };
>  
>  static struct list_head acpi_power_resource_list;
> @@ -223,7 +224,6 @@ static void acpi_power_on_device(struct acpi_power_managed_device *device)
>  
>  static int __acpi_power_on(struct acpi_power_resource *resource)
>  {
> -	struct acpi_power_resource_device *device_list = resource->devices;
>  	acpi_status status = AE_OK;
>  
>  	status = acpi_evaluate_object(resource->device->handle, "_ON", NULL, NULL);
> @@ -236,19 +236,14 @@ static int __acpi_power_on(struct acpi_power_resource *resource)
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Power resource [%s] turned on\n",
>  			  resource->name));
>  
> -	while (device_list) {
> -		acpi_power_on_device(device_list->device);
> -
> -		device_list = device_list->next;
> -	}
> -
>  	return 0;
>  }
>  
>  static int acpi_power_on(acpi_handle handle)
>  {
> -	int result = 0;
> +	int result = 0, resume_device = 0;

I'll change the data type of resume_device to bool when applying the patch.

>  	struct acpi_power_resource *resource = NULL;
> +	struct acpi_power_resource_device *device_list;
>  
>  	result = acpi_power_get_context(handle, &resource);
>  	if (result)
> @@ -264,10 +259,26 @@ static int acpi_power_on(acpi_handle handle)
>  		result = __acpi_power_on(resource);
>  		if (result)
>  			resource->ref_count--;
> +		else
> +			resume_device = 1;
>  	}
>  
>  	mutex_unlock(&resource->resource_lock);
>  
> +	if (!resume_device)
> +		return result;
> +
> +	mutex_lock(&resource->devices_lock);
> +
> +	device_list = resource->devices;
> +	while (device_list) {
> +		acpi_power_on_device(device_list->device);
> +
> +		device_list = device_list->next;
> +	}
> +
> +	mutex_unlock(&resource->devices_lock);
> +
>  	return result;
>  }
>  
> @@ -353,7 +364,7 @@ static void __acpi_power_resource_unregister_device(struct device *dev,
>  	if (acpi_power_get_context(res_handle, &resource))
>  		return;
>  
> -	mutex_lock(&resource->resource_lock);
> +	mutex_lock(&resource->devices_lock);
>  	prev = NULL;
>  	curr = resource->devices;
>  	while (curr) {
> @@ -370,7 +381,7 @@ static void __acpi_power_resource_unregister_device(struct device *dev,
>  		prev = curr;
>  		curr = curr->next;
>  	}
> -	mutex_unlock(&resource->resource_lock);
> +	mutex_unlock(&resource->devices_lock);
>  }
>  
>  /* Unlink dev from all power resources in _PR0 */
> @@ -412,10 +423,10 @@ static int __acpi_power_resource_register_device(
>  
>  	power_resource_device->device = powered_device;
>  
> -	mutex_lock(&resource->resource_lock);
> +	mutex_lock(&resource->devices_lock);
>  	power_resource_device->next = resource->devices;
>  	resource->devices = power_resource_device;
> -	mutex_unlock(&resource->resource_lock);
> +	mutex_unlock(&resource->devices_lock);
>  
>  	return 0;
>  }
> @@ -719,6 +730,7 @@ static int acpi_power_add(struct acpi_device *device)
>  
>  	resource->device = device;
>  	mutex_init(&resource->resource_lock);
> +	mutex_init(&resource->devices_lock);
>  	strcpy(resource->name, device->pnp.bus_id);
>  	strcpy(acpi_device_name(device), ACPI_POWER_DEVICE_NAME);
>  	strcpy(acpi_device_class(device), ACPI_POWER_CLASS);
> 

Thanks,
Rafael
