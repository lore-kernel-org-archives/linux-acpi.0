From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [resend PATCH] driver core: property: support for generic property
Date: Thu, 12 Mar 2015 02:41:32 +0100
Message-ID: <2095371.SrUNK6JsDO@vostro.rjw.lan>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50035 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752215AbbCLBRs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Mar 2015 21:17:48 -0400
In-Reply-To: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Monday, January 26, 2015 03:17:40 PM Heikki Krogerus wrote:
> This extends the unified device property interface by adding
> "Generic Property" to it for cases where device tree or ACPI
> are not being used.
> 
> That makes the unified device property interface cover also
> most of the cases where information is extracted from custom
> platform_data in the drivers. So if before we had to check
> separately is there custom platform_data for a driver:
> 
> 	if (pdata)
> 		bar = pdata->bar;
> 	else
> 		device_property_read_u32(dev, "foo", &bar);
> 
> we can now drop that check and simply always use the unified
> device property interface.
> 
> That makes it possible to drop a lot of boiler plate from
> the drivers, plus quite a few header files under
> include/linux/ describing those driver specific platform
> data structures can be removed.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/property.c  | 135 ++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/device.h   |   3 ++
>  include/linux/property.h |  17 ++++++
>  3 files changed, 143 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index c458458..4ea6d27 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -15,6 +15,108 @@
>  #include <linux/acpi.h>
>  #include <linux/of.h>
>  
> +static struct dev_gen_prop *dev_prop_get(struct device *dev, const char *name)
> +{
> +	struct dev_gen_prop *prop;
> +
> +	if (!dev->gen_prop)
> +		return NULL;
> +
> +	for (prop = dev->gen_prop; prop->name; prop++)
> +		if (!strcmp(name, prop->name))
> +			return prop;
> +	return NULL;
> +}
> +
> +static int dev_prop_copy_array_u8(u8 *src, u8 *val, size_t nval)
> +{
> +	int i;
> +
> +	for (i = 0; i < nval; i++)
> +		val[i] = src[i];

Use memcpy() perhaps?  And below too?  And then you may not need these
helpers any more.

> +	return 0;
> +}
> +
> +static int dev_prop_copy_array_u16(u16 *src, u16 *val, size_t nval)
> +{
> +	int i;
> +
> +	for (i = 0; i < nval; i++)
> +		val[i] = src[i];
> +	return 0;
> +}
> +
> +static int dev_prop_copy_array_u32(u32 *src, u32 *val, size_t nval)
> +{
> +	int i;
> +
> +	for (i = 0; i < nval; i++)
> +		val[i] = src[i];
> +	return 0;
> +}
> +
> +static int dev_prop_copy_array_u64(u64 *src, u64 *val, size_t nval)
> +{
> +	int i;
> +
> +	for (i = 0; i < nval; i++)
> +		val[i] = src[i];
> +	return 0;
> +}
> +
> +static int dev_prop_copy_array_string(const char **src, const char **val,
> +				      size_t nval)
> +{
> +	int i;
> +
> +	for (i = 0; i < nval; i++)
> +		val[i] = src[i];
> +	return 0;
> +}
> +
> +static int dev_prop_read_array(struct device *dev, const char *name,
> +			       enum dev_prop_type type, void *val, size_t nval)
> +{
> +	struct dev_gen_prop *prop;
> +	int ret = 0;
> +
> +	prop = dev_prop_get(dev, name);
> +	if (!prop)
> +		return -ENODATA;
> +
> +	if (prop->type != type)
> +		return -EPROTO;
> +
> +	if (prop->nval < nval)
> +		return -EOVERFLOW;
> +
> +	switch (prop->type) {
> +	case DEV_PROP_U8:
> +		ret = dev_prop_copy_array_u8((u8 *)prop->num, (u8 *)val,
> +					     nval);
> +		break;
> +	case DEV_PROP_U16:
> +		ret = dev_prop_copy_array_u16((u16 *)prop->num, (u16 *)val,
> +					      nval);
> +		break;
> +	case DEV_PROP_U32:
> +		ret = dev_prop_copy_array_u32((u32 *)prop->num, (u32 *)val,
> +					      nval);
> +		break;
> +	case DEV_PROP_U64:
> +		ret = dev_prop_copy_array_u64(prop->num, (u64 *)val, nval);
> +		break;
> +	case DEV_PROP_STRING:
> +		ret = dev_prop_copy_array_string(prop->str,
> +						 (const char **)val, nval);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	return ret;
> +}
> +
>  /**
>   * device_property_present - check if a property of a device is present
>   * @dev: Device whose property is being checked
> @@ -26,8 +128,9 @@ bool device_property_present(struct device *dev, const char *propname)
>  {
>  	if (IS_ENABLED(CONFIG_OF) && dev->of_node)
>  		return of_property_read_bool(dev->of_node, propname);
> -
> -	return !acpi_dev_prop_get(ACPI_COMPANION(dev), propname, NULL);
> +	if (ACPI_HANDLE(dev))
> +		return !acpi_dev_prop_get(ACPI_COMPANION(dev), propname, NULL);
> +	return !!dev_prop_get(dev, propname);
>  }
>  EXPORT_SYMBOL_GPL(device_property_present);
>  
> @@ -55,8 +158,11 @@ EXPORT_SYMBOL_GPL(fwnode_property_present);
>  	IS_ENABLED(CONFIG_OF) && _dev_->of_node ? \
>  		(OF_DEV_PROP_READ_ARRAY(_dev_->of_node, _propname_, _type_, \
>  					_val_, _nval_)) : \
> -		acpi_dev_prop_read(ACPI_COMPANION(_dev_), _propname_, \
> -				   _proptype_, _val_, _nval_)
> +		ACPI_HANDLE(_dev_) ? \
> +			acpi_dev_prop_read(ACPI_COMPANION(_dev_), _propname_, \
> +					   _proptype_, _val_, _nval_) : \
> +			dev_prop_read_array(_dev_, _propname_, _proptype_, \
> +					   _val_, _nval_)
>  
>  /**
>   * device_property_read_u8_array - return a u8 array property of a device
> @@ -169,10 +275,13 @@ EXPORT_SYMBOL_GPL(device_property_read_u64_array);
>  int device_property_read_string_array(struct device *dev, const char *propname,
>  				      const char **val, size_t nval)
>  {
> -	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> -		of_property_read_string_array(dev->of_node, propname, val, nval) :
> -		acpi_dev_prop_read(ACPI_COMPANION(dev), propname,
> -				   DEV_PROP_STRING, val, nval);
> +	if (IS_ENABLED(CONFIG_OF) && dev->of_node)
> +		return of_property_read_string_array(dev->of_node, propname,
> +						     val, nval);
> +	if (ACPI_HANDLE(dev))
> +		return acpi_dev_prop_read(ACPI_COMPANION(dev), propname,
> +					  DEV_PROP_STRING, val, nval);
> +	return dev_prop_read_array(dev, propname, DEV_PROP_STRING, val, nval);
>  }
>  EXPORT_SYMBOL_GPL(device_property_read_string_array);
>  
> @@ -193,10 +302,12 @@ EXPORT_SYMBOL_GPL(device_property_read_string_array);
>  int device_property_read_string(struct device *dev, const char *propname,
>  				const char **val)
>  {
> -	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> -		of_property_read_string(dev->of_node, propname, val) :
> -		acpi_dev_prop_read(ACPI_COMPANION(dev), propname,
> -				   DEV_PROP_STRING, val, 1);
> +	if (IS_ENABLED(CONFIG_OF) && dev->of_node)
> +		return of_property_read_string(dev->of_node, propname, val);
> +	if (ACPI_HANDLE(dev))
> +		return acpi_dev_prop_read(ACPI_COMPANION(dev), propname,
> +					  DEV_PROP_STRING, val, 1);
> +	return dev_prop_read_array(dev, propname, DEV_PROP_STRING, val, 1);
>  }
>  EXPORT_SYMBOL_GPL(device_property_read_string);
>  
> diff --git a/include/linux/device.h b/include/linux/device.h
> index fb50673..738dc25 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -27,6 +27,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/uidgid.h>
>  #include <linux/gfp.h>
> +#include <linux/property.h>
>  #include <asm/device.h>
>  
>  struct device;
> @@ -704,6 +705,7 @@ struct acpi_dev_node {
>   * @archdata:	For arch-specific additions.
>   * @of_node:	Associated device tree node.
>   * @acpi_node:	Associated ACPI device node.
> + * @gen_prop:	Generic device property
>   * @devt:	For creating the sysfs "dev".
>   * @id:		device instance
>   * @devres_lock: Spinlock to protect the resource of the device.
> @@ -780,6 +782,7 @@ struct device {
>  
>  	struct device_node	*of_node; /* associated device tree node */
>  	struct acpi_dev_node	acpi_node; /* associated ACPI device node */
> +	struct dev_gen_prop	*gen_prop; /* generic device property */

That doesn't seem to go in the right direction to be honest.

Actually, having introduced struct fwnode_handle, we should perhaps try to
replace both of_node and acpi_node with a single struct fwnode_handle pointer
and then add a new fwnode_type for the "pdata" stuff.

If you don't want to deal with of_node, which I can understand easily, it
may be worth trying with acpi_node alone at this point and once you have
the fwnode_handle pointer, you might use it for both ACPI and "pdata"?

Grant, Arnd, I wonder what you think?

>  
>  	dev_t			devt;	/* dev_t, creates the sysfs "dev" */
>  	u32			id;	/* device instance */
> diff --git a/include/linux/property.h b/include/linux/property.h
> index a6a3d98..44e875f 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -26,6 +26,23 @@ enum dev_prop_type {
>  	DEV_PROP_MAX,
>  };
>  
> +/**
> + * struct dev_gen_prop - Generic Device Property
> + * @name: property name
> + * @nval: number of elements in the array
> + * @str: value array of strings
> + * @num: value array of numbers
> + *
> + * Used when of_node and acpi_node are missing.
> + */
> +struct dev_gen_prop {
> +	enum dev_prop_type type;
> +	const char *name;
> +	size_t nval;
> +	const char **str;
> +	u64 *num;
> +};
> +
>  bool device_property_present(struct device *dev, const char *propname);
>  int device_property_read_u8_array(struct device *dev, const char *propname,
>  				  u8 *val, size_t nval);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
