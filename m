From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI: Adds sysfs "ddn" attribute of the ACPI device objects to export its _DDN object.
Date: Thu, 06 Mar 2014 14:17:09 +0100
Message-ID: <60613889.YO9Qifkoq6@vostro.rjw.lan>
References: <663e3209957959e78611238a9679af3a2af0a600.1393549042.git.lv.zheng@intel.com> <84bd79a1bc330c840d3ccb2b1b10db5cf5de242f.1394068491.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64794 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751095AbaCFNB6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Mar 2014 08:01:58 -0500
In-Reply-To: <84bd79a1bc330c840d3ccb2b1b10db5cf5de242f.1394068491.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>

On Thursday, March 06, 2014 09:16:15 AM Lv Zheng wrote:
> The information contained in _DDN (Dos Device Name) might be useful
> for userspace utilities, this patch thus exports such information
> using "ddn" attribute.
> Note that the "ddn" attribute will be created as long as the _DDN
> identifying object exists, whatever its evaluation succeeds or not.
> 
> This patch must modify the code which is using "struct acpi_buffer"
> as the buffer.length must be reset to ACPI_ALLOCATE_BUFFER before
> reusing it to invoke acpi_evaluate_object() again.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Cc: Arjan van de Ven <arjan@linux.intel.com>

Queued up for 3.15, thanks!

> ---
>  Documentation/ABI/testing/sysfs-bus-acpi |    7 +++++
>  drivers/acpi/scan.c                      |   44 +++++++++++++++++++++++++++++-
>  include/acpi/acpi_bus.h                  |    1 +
>  3 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
> index 7fa9cbc..db376b8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-acpi
> +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> @@ -49,6 +49,13 @@ Description:
>  		This attribute contains the output of the device object's
>  		_UID control method, if present.
>  
> +What:		/sys/bus/acpi/devices/.../ddn
> +Date:		February 2014
> +Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
> +Description:
> +		This attribute contains the output of the device object's
> +		_DDN control method, if present.
> +
>  What:		/sys/bus/acpi/devices/.../eject
>  Date:		December 2006
>  Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 7efe546..604b3bc 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -660,6 +660,16 @@ static ssize_t description_show(struct device *dev,
>  }
>  static DEVICE_ATTR(description, 0444, description_show, NULL);
>  
> +/* sysfs file that shows DOS device name text from the ACPI _DDN method */
> +static ssize_t ddn_show(struct device *dev, struct device_attribute *attr,
> +			char *buf) {
> +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> +
> +	return acpi_dev->pnp.ddn ?
> +	       snprintf(buf, PAGE_SIZE, "%s\n", acpi_dev->pnp.ddn) : 0;
> +}
> +static DEVICE_ATTR(ddn, 0444, ddn_show, NULL);
> +
>  static ssize_t
>  acpi_device_sun_show(struct device *dev, struct device_attribute *attr,
>  		     char *buf) {
> @@ -685,10 +695,11 @@ static DEVICE_ATTR_RO(status);
>  
>  static int acpi_device_setup_files(struct acpi_device *dev)
>  {
> -	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +	struct acpi_buffer buffer;
>  	acpi_status status;
>  	unsigned long long sun;
>  	int result = 0;
> +	union acpi_object *object;
>  
>  	/*
>  	 * Devices gotten from FADT don't have a "path" attribute
> @@ -713,6 +724,8 @@ static int acpi_device_setup_files(struct acpi_device *dev)
>  	 * If device has _STR, 'description' file is created
>  	 */
>  	if (acpi_has_method(dev->handle, "_STR")) {
> +		buffer.length = ACPI_ALLOCATE_BUFFER;
> +		buffer.pointer = NULL;
>  		status = acpi_evaluate_object(dev->handle, "_STR",
>  					NULL, &buffer);
>  		if (ACPI_FAILURE(status))
> @@ -723,6 +736,28 @@ static int acpi_device_setup_files(struct acpi_device *dev)
>  			goto end;
>  	}
>  
> +	/*
> +	 * If device has _DDN, 'ddn' file is created
> +	 */
> +	if (acpi_has_method(dev->handle, "_DDN")) {
> +		buffer.length = ACPI_ALLOCATE_BUFFER;
> +		buffer.pointer = NULL;
> +		status = acpi_evaluate_object_typed(dev->handle, "_DDN",
> +						    NULL, &buffer,
> +						    ACPI_TYPE_STRING);
> +		if (ACPI_FAILURE(status))
> +			buffer.pointer = NULL;
> +		object = buffer.pointer;
> +		if (object) {
> +			dev->pnp.ddn = kstrdup(object->string.pointer,
> +					       GFP_KERNEL);
> +			kfree(object);
> +		}
> +		result = device_create_file(&dev->dev, &dev_attr_ddn);
> +		if (result)
> +			goto end;
> +	}
> +
>  	if (dev->pnp.type.bus_address)
>  		result = device_create_file(&dev->dev, &dev_attr_adr);
>  	if (dev->pnp.unique_id)
> @@ -785,6 +820,13 @@ static void acpi_device_remove_files(struct acpi_device *dev)
>  		device_remove_file(&dev->dev, &dev_attr_description);
>  	}
>  	/*
> +	 * If device has _DDN, remove 'ddn' file
> +	 */
> +	if (acpi_has_method(dev->handle, "_DDN")) {
> +		device_remove_file(&dev->dev, &dev_attr_ddn);
> +		kfree(dev->pnp.ddn);
> +	}
> +	/*
>  	 * If device has _EJ0, remove 'eject' file.
>  	 */
>  	if (acpi_has_method(dev->handle, "_EJ0"))
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 84a2e29..7bc77d9 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -244,6 +244,7 @@ struct acpi_device_pnp {
>  	acpi_device_name device_name;	/* Driver-determined */
>  	acpi_device_class device_class;	/*        "          */
>  	union acpi_object *str_obj;	/* unicode string for _STR method */
> +	char *ddn;			/* _DDN */
>  	unsigned long sun;		/* _SUN */
>  };
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
