From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v2 2/2] ACPI / utils: Add acpi_dev_present()
Date: Mon, 30 Nov 2015 16:27:23 +0800
Message-ID: <565C086B.4000000@huawei.com>
References: <cover.1448480385.git.lukas@wunner.de> <e6b4c58be0bc78dbc9ca8b14acf0448eda6b325c.1448480385.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:21948 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbbK3I2p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2015 03:28:45 -0500
In-Reply-To: <e6b4c58be0bc78dbc9ca8b14acf0448eda6b325c.1448480385.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: devel@acpica.org, Robert Moore <robert.moore@intel.com>, Mark Brown <broonie@kernel.org>, Hui Wang <hui.wang@canonical.com>, Darren Hart <dvhart@infradead.org>

On 2015/11/26 4:19, Lukas Wunner wrote:
> There's an idiom in use by 7 Linux drivers to detect the presence of a
> particular ACPI HID by walking the namespace with acpi_get_devices().
> The callback passed to acpi_get_devices() is mostly identical across
> the drivers, leading to lots of duplicate code.
>
> Add acpi_dev_present(), the ACPI equivalent to pci_dev_present(),
> allowing us to deduplicate all that boilerplate in the drivers.
>
> v2: * Instead of walking the namespace, iterate over acpi_bus_id_list
>       which has all HIDs cached (Hanjun Guo, Robert Moore).
>     * Move to utils.c (Rafael J. Wysocki). This necessitates non-static
>       declaration of acpi_bus_id_list.
>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/acpi/internal.h |  8 ++++++++
>  drivers/acpi/scan.c     |  8 +-------
>  drivers/acpi/utils.c    | 31 +++++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h |  2 ++
>  4 files changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 11d87bf..60bda0d 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -86,6 +86,14 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent);
>  #define ACPI_STA_DEFAULT (ACPI_STA_DEVICE_PRESENT | ACPI_STA_DEVICE_ENABLED | \
>  			  ACPI_STA_DEVICE_UI | ACPI_STA_DEVICE_FUNCTIONING)
>  
> +extern struct list_head acpi_bus_id_list;
> +
> +struct acpi_device_bus_id{
> +	char bus_id[15];
> +	unsigned int instance_no;
> +	struct list_head node;
> +};
> +
>  int acpi_device_add(struct acpi_device *device,
>  		    void (*release)(struct device *));
>  void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a0e942b..4be2179 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -39,7 +39,7 @@ static const char *dummy_hid = "device";
>  
>  static LIST_HEAD(acpi_dep_list);
>  static DEFINE_MUTEX(acpi_dep_list_lock);
> -static LIST_HEAD(acpi_bus_id_list);
> +LIST_HEAD(acpi_bus_id_list);
>  static DEFINE_MUTEX(acpi_scan_lock);
>  static LIST_HEAD(acpi_scan_handlers_list);
>  DEFINE_MUTEX(acpi_device_lock);
> @@ -52,12 +52,6 @@ struct acpi_dep_data {
>  	acpi_handle slave;
>  };
>  
> -struct acpi_device_bus_id{
> -	char bus_id[15];
> -	unsigned int instance_no;
> -	struct list_head node;
> -};
> -
>  void acpi_scan_lock_acquire(void)
>  {
>  	mutex_lock(&acpi_scan_lock);
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 475c907..f2f9873 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -29,6 +29,7 @@
>  #include <linux/dynamic_debug.h>
>  
>  #include "internal.h"
> +#include "sleep.h"
>  
>  #define _COMPONENT		ACPI_BUS_COMPONENT
>  ACPI_MODULE_NAME("utils");
> @@ -709,6 +710,36 @@ bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, int rev, u64 funcs)
>  }
>  EXPORT_SYMBOL(acpi_check_dsm);
>  
> +/**
> + * acpi_dev_present - Detect presence of a given ACPI device in the system.
> + * @hid: Hardware ID of the device.
> + *
> + * Return %true if the device was present at the moment of invocation.
> + * Note that if the device is pluggable, it may since have disappeared.
> + *
> + * For this function to work, acpi_bus_scan() must have been executed
> + * which happens in the subsys_initcall() subsection. Hence, do not
> + * call from a subsys_initcall() or earlier (use acpi_get_devices()
> + * instead). Calling from module_init() is fine (which is synonymous
> + * with device_initcall()).
> + */
> +bool acpi_dev_present(const char *hid)

If the driver can't pass the "dev" as the argument form acpi device or platform
device, this is the way to match HIDs.

But if we get the pointer to acpi device or platform device structure before calling
this function, I think acpi_match_device_ids() can match what you need, and we don't
need to invent another function.

Thanks
Hanjun

