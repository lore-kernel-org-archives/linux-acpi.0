From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: ACPI: Fix resource_lock dead lock in acpi_power_on_device
Date: Mon, 9 Jul 2012 10:40:55 +0800
Message-ID: <CAF1ivSafWrR46RV+pEEZk8cDhiGaFaoqathORJkD6Y-G7HxUUg@mail.gmail.com>
References: <1340600942.3328.37.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:45312 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab2GICk4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Jul 2012 22:40:56 -0400
Received: by vcbf11 with SMTP id f11so7038010vcb.19
        for <linux-acpi@vger.kernel.org>; Sun, 08 Jul 2012 19:40:55 -0700 (PDT)
In-Reply-To: <1340600942.3328.37.camel@minggr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Lan, Tianyu" <tianyu.lan@intel.com>

On Mon, Jun 25, 2012 at 1:09 PM, Lin Ming <ming.m.lin@intel.com> wrote:
> Commit 0090def("ACPI: Add interface to register/unregister device
> to/from power resources") used resource_lock to protect the devices list
> that relies on power resource. It caused a mutex dead lock, as below
>
> acpi_power_on ---> lock resource_lock
>   __acpi_power_on
>     acpi_power_on_device
>       acpi_power_get_inferred_state
>         acpi_power_get_list_state ---> lock resource_lock
>
> This patch adds a new mutex "devices_lock" to protect the devices list
> and calls acpi_power_on_device in acpi_power_on, instead of
> __acpi_power_on, after the resource_lock is released.

Len,

What do you think of this fix?

Regards,
Lin Ming

>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
>  drivers/acpi/power.c |   29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index eb640874..068349e 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -103,6 +103,7 @@ struct acpi_power_resource {
>
>         /* List of devices relying on this power resource */
>         struct acpi_power_resource_device *devices;
> +       struct mutex devices_lock;
>  };
>
>  static struct list_head acpi_power_resource_list;
> @@ -221,7 +222,6 @@ static void acpi_power_on_device(struct acpi_power_managed_device *device)
>
>  static int __acpi_power_on(struct acpi_power_resource *resource)
>  {
> -       struct acpi_power_resource_device *device_list = resource->devices;
>         acpi_status status = AE_OK;
>
>         status = acpi_evaluate_object(resource->device->handle, "_ON", NULL, NULL);
> @@ -234,12 +234,6 @@ static int __acpi_power_on(struct acpi_power_resource *resource)
>         ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Power resource [%s] turned on\n",
>                           resource->name));
>
> -       while (device_list) {
> -               acpi_power_on_device(device_list->device);
> -
> -               device_list = device_list->next;
> -       }
> -
>         return 0;
>  }
>
> @@ -247,6 +241,7 @@ static int acpi_power_on(acpi_handle handle)
>  {
>         int result = 0;
>         struct acpi_power_resource *resource = NULL;
> +       struct acpi_power_resource_device *device_list;
>
>         result = acpi_power_get_context(handle, &resource);
>         if (result)
> @@ -266,6 +261,17 @@ static int acpi_power_on(acpi_handle handle)
>
>         mutex_unlock(&resource->resource_lock);
>
> +       mutex_lock(&resource->devices_lock);
> +
> +       device_list = resource->devices;
> +       while (device_list) {
> +               acpi_power_on_device(device_list->device);
> +
> +               device_list = device_list->next;
> +       }
> +
> +       mutex_unlock(&resource->devices_lock);
> +
>         return result;
>  }
>
> @@ -351,7 +357,7 @@ static void __acpi_power_resource_unregister_device(struct device *dev,
>         if (acpi_power_get_context(res_handle, &resource))
>                 return;
>
> -       mutex_lock(&resource->resource_lock);
> +       mutex_lock(&resource->devices_lock);
>         prev = NULL;
>         curr = resource->devices;
>         while (curr) {
> @@ -368,7 +374,7 @@ static void __acpi_power_resource_unregister_device(struct device *dev,
>                 prev = curr;
>                 curr = curr->next;
>         }
> -       mutex_unlock(&resource->resource_lock);
> +       mutex_unlock(&resource->devices_lock);
>  }
>
>  /* Unlink dev from all power resources in _PR0 */
> @@ -410,10 +416,10 @@ static int __acpi_power_resource_register_device(
>
>         power_resource_device->device = powered_device;
>
> -       mutex_lock(&resource->resource_lock);
> +       mutex_lock(&resource->devices_lock);
>         power_resource_device->next = resource->devices;
>         resource->devices = power_resource_device;
> -       mutex_unlock(&resource->resource_lock);
> +       mutex_unlock(&resource->devices_lock);
>
>         return 0;
>  }
> @@ -717,6 +723,7 @@ static int acpi_power_add(struct acpi_device *device)
>
>         resource->device = device;
>         mutex_init(&resource->resource_lock);
> +       mutex_init(&resource->devices_lock);
>         strcpy(resource->name, device->pnp.bus_id);
>         strcpy(acpi_device_name(device), ACPI_POWER_DEVICE_NAME);
>         strcpy(acpi_device_class(device), ACPI_POWER_CLASS);
> --
> 1.7.10
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
