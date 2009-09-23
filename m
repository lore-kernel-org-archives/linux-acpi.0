From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH v3 13/17] ACPI: identify device tree root by null
	parent pointer, not ACPI_BUS_TYPE
Date: Wed, 23 Sep 2009 11:09:44 +0800
Message-ID: <1253675384.3609.361.camel@localhost.localdomain>
References: <20090921192656.21322.23072.stgit@bob.kio>
	 <20090921192950.21322.63040.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12728 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860AbZIWDJg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Sep 2009 23:09:36 -0400
In-Reply-To: <20090921192950.21322.63040.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-09-22 at 03:29 +0800, Bjorn Helgaas wrote:
> We can identify the root of the ACPI device tree by the fact that it
> has no parent.  This is simpler than passing around ACPI_BUS_TYPE_SYSTEM
> and will help remove special treatment of the device tree root.
> 
> Currently, we add the root by hand with ACPI_BUS_TYPE_SYSTEM.  If we
> traverse the tree treating the root as just another device and use
> acpi_get_type(), the root shows up as ACPI_TYPE_DEVICE.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  drivers/acpi/scan.c     |   20 +++++++++++++-------
>  include/acpi/acpi_bus.h |    1 -
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 27d2dec..0b5aaf0 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -22,6 +22,8 @@ extern struct acpi_device *acpi_root;
>  #define ACPI_BUS_HID			"LNXSYBUS"
>  #define ACPI_BUS_DEVICE_NAME		"System Bus"
>  
> +#define ACPI_IS_ROOT_DEVICE(device)    (!(device)->parent)
the following definition will be better
   #define ACPI_IS_ROOT_DEVICE(device)  \
				(device->handle == ACPI_ROOT_OBJECT)

thanks.
> +
>  static LIST_HEAD(acpi_device_list);
>  static LIST_HEAD(acpi_bus_id_list);
>  DEFINE_MUTEX(acpi_device_lock);
> @@ -955,10 +957,12 @@ static void acpi_device_get_busid(struct acpi_device *device)
>  	 * The device's Bus ID is simply the object name.
>  	 * TBD: Shouldn't this value be unique (within the ACPI namespace)?
>  	 */
> -	switch (device->device_type) {
> -	case ACPI_BUS_TYPE_SYSTEM:
> +	if (ACPI_IS_ROOT_DEVICE(device)) {
>  		strcpy(device->pnp.bus_id, "ACPI");
> -		break;
> +		return;
> +	}
> +
> +	switch (device->device_type) {
>  	case ACPI_BUS_TYPE_POWER_BUTTON:
>  		strcpy(device->pnp.bus_id, "PWRF");
>  		break;
> @@ -1093,6 +1097,11 @@ static void acpi_device_set_id(struct acpi_device *device)
>  
>  	switch (device->device_type) {
>  	case ACPI_BUS_TYPE_DEVICE:
> +		if (ACPI_IS_ROOT_DEVICE(device)) {
> +			hid = ACPI_SYSTEM_HID;
> +			break;
> +		}
> +
>  		status = acpi_get_object_info(device->handle, &info);
>  		if (ACPI_FAILURE(status)) {
>  			printk(KERN_ERR PREFIX "%s: Error reading device info\n", __func__);
> @@ -1129,9 +1138,6 @@ static void acpi_device_set_id(struct acpi_device *device)
>  	case ACPI_BUS_TYPE_PROCESSOR:
>  		hid = ACPI_PROCESSOR_OBJECT_HID;
>  		break;
> -	case ACPI_BUS_TYPE_SYSTEM:
> -		hid = ACPI_SYSTEM_HID;
> -		break;
>  	case ACPI_BUS_TYPE_THERMAL:
>  		hid = ACPI_THERMAL_HID;
>  		break;
> @@ -1643,7 +1649,7 @@ int __init acpi_scan_init(void)
>  	 * Create the root device in the bus's device tree
>  	 */
>  	result = acpi_add_single_object(&acpi_root, ACPI_ROOT_OBJECT,
> -					ACPI_BUS_TYPE_SYSTEM, &ops);
> +					ACPI_BUS_TYPE_DEVICE, &ops);
>  	if (result)
>  		goto Done;
>  
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 8e39b3e..ef1cb23 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -70,7 +70,6 @@ enum acpi_bus_device_type {
>  	ACPI_BUS_TYPE_POWER,
>  	ACPI_BUS_TYPE_PROCESSOR,
>  	ACPI_BUS_TYPE_THERMAL,
> -	ACPI_BUS_TYPE_SYSTEM,
>  	ACPI_BUS_TYPE_POWER_BUTTON,
>  	ACPI_BUS_TYPE_SLEEP_BUTTON,
>  	ACPI_BUS_DEVICE_TYPE_COUNT
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

