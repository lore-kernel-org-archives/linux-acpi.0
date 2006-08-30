From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [RFC PATCH]: video output sysfs class and acpi video driver
 support
Date: Wed, 30 Aug 2006 08:54:30 -0700
Message-ID: <20060830085430.60e05b4e.rdunlap@xenotime.net>
References: <200608301542.16035.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:46209 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751096AbWH3PvI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Aug 2006 11:51:08 -0400
Received: from midway.site ([71.117.233.155]) by xenotime.net for <linux-acpi@vger.kernel.org>; Wed, 30 Aug 2006 08:51:06 -0700
In-Reply-To: <200608301542.16035.luming.yu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yu Luming <luming.yu@intel.com>
Cc: linux-acpi@vger.kernel.org

On Wed, 30 Aug 2006 15:42:15 +0800 Yu Luming wrote:

> Hi,
> 
> This is a proposal for a unified sysfs interface to control
> video output device switch. The patch includes two parts:
> 1. output sysfs class.  2. acpi video driver support.
> Any comments are appreciated.

Could you be a bit more verbose in the description of the
patch?  (i.e., what it does)  Both here and in the Kconfig
help text....

> Thanks,
> Luming
> 
> diff -BruN 2.6/drivers/acpi/Kconfig edited/drivers/acpi/Kconfig
> --- 2.6/drivers/acpi/Kconfig	2006-08-30 15:10:05.000000000 +0800
> +++ edited/drivers/acpi/Kconfig	2006-08-30 15:19:09.000000000 +0800
> @@ -106,7 +106,7 @@
>  
>  config ACPI_VIDEO
>  	tristate "Video"
> -	depends on X86 && BACKLIGHT_DEVICE
> +	depends on X86 && ( BACKLIGHT_CLASS_DEVICE || VIDEO_OUTPUT_CONTROL)

s/( /(/

>  	help
>  	  This driver implement the ACPI Extensions For Display Adapters

s/implement/implements/
(That entire help section needs help...)

>  	  for integrated graphics devices on motherboard, as specified in
> diff -BruN 2.6/drivers/acpi/video.c edited/drivers/acpi/video.c
> --- 2.6/drivers/acpi/video.c	2006-08-30 15:10:05.000000000 +0800
> +++ edited/drivers/acpi/video.c	2006-08-30 15:19:09.000000000 +0800
> @@ -31,6 +31,7 @@
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/backlight.h>
> +#include <linux/output.h>
>  
>  #include <asm/uaccess.h>
>  
> @@ -163,6 +164,7 @@
>  	struct acpi_video_bus *video;
>  	struct acpi_device *dev;
>  	struct acpi_video_device_brightness *brightness;
> +	struct output_device *output_dev;
>  };
>  
>  /* bus */
> @@ -266,6 +268,10 @@
>  /*backlight device sysfs support*/
>  static int acpi_video_get_brightness(struct backlight_device *bd);
>  static int acpi_video_set_brightness(struct backlight_device *bd);
> +static int acpi_video_output_get(struct output_device *);
> +static int acpi_video_output_set(struct output_device *);
> +static int acpi_video_device_get_state(struct acpi_video_device *, unsigned long *);
> +static int acpi_video_device_set_state(struct acpi_video_device *, int);

Don't put just parameter types, put a meaningful/useful identifier
name with them also.  (See the functions just above the new lines here.)

>  
>  static struct backlight_device *acpi_video_backlight;
>  static struct acpi_video_device *backlight_acpi_device;
> @@ -275,6 +281,10 @@
>  	.get_brightness = acpi_video_get_brightness,
>  	.update_status  = acpi_video_set_brightness,
>  };
> +static struct output_properties acpi_output_properties = {
> +	.set_state = acpi_video_output_set,
> +	.get_status = acpi_video_output_get,
> +};
>  static int acpi_video_get_brightness(struct backlight_device *bd)
>  {
>  	unsigned long cur_level;
> @@ -289,6 +299,20 @@
>  	return 0;
>  }
>  
> +static int acpi_video_output_get(struct output_device *od)
> +{
> +	unsigned long state;
> +	struct acpi_video_device *vd = (struct acpi_video_device *)class_get_devdata(&od->class_dev);
> +	acpi_video_device_get_state(vd, &state);
> +	return (int)state;
> +}
> +
> +static int acpi_video_output_set(struct output_device *od)
> +{
> +	unsigned long state = od->request_state;
> +	struct acpi_video_device *vd = (struct acpi_video_device *)class_get_devdata(&od->class_dev);
> +	return acpi_video_device_set_state(vd, state);
> +}
>  
>  /* --------------------------------------------------------------------------
>                                 Video Management
> @@ -614,6 +638,13 @@
>  		backlight_acpi_device = device;
>  	}
>  
> +	if (device->cap._DCS && device->cap._DSS){

) {

> +		char name[16];
> +		strcat(name, acpi_device_bid(device->dev->parent));
> +		strcat(name, "_");
> +		strcpy(name, acpi_device_bid(device->dev));

I would feel safer with some length-safe str* functions being
used there.

> +		device->output_dev = video_output_register(name, device, &acpi_output_properties);
> +	}
>  	return;
>  }
>  
> @@ -1617,6 +1648,8 @@
>  	if (device == backlight_acpi_device)
>  		backlight_device_unregister(acpi_video_backlight);
>  
> +	video_output_unregister(device->output_dev);
> +
>  	return 0;
>  }
>  
> diff -BruN 2.6/drivers/video/Kconfig edited/drivers/video/Kconfig
> --- 2.6/drivers/video/Kconfig	2006-08-28 11:41:48.000000000 +0800
> +++ edited/drivers/video/Kconfig	2006-08-30 15:19:09.000000000 +0800
> @@ -1616,5 +1616,13 @@
>  	source "drivers/video/backlight/Kconfig"
>  endif
>  
> +
> +config VIDEO_OUTPUT_CONTROL
> +	tristate "video output device switch control"
> +	depends on SYSFS
> +	---help---
> +	  sysfs support for video output device switching.

This is only useful if someone already knows what it does.
It doesn't help someone who is uninformed about it.

> +
> +
>  endmenu
>  
> diff -BruN 2.6/drivers/video/Makefile edited/drivers/video/Makefile
> --- 2.6/drivers/video/Makefile	2006-08-28 11:41:48.000000000 +0800
> +++ edited/drivers/video/Makefile	2006-08-30 15:19:09.000000000 +0800
> @@ -12,7 +12,7 @@
>  
>  obj-$(CONFIG_VT)		  += console/
>  obj-$(CONFIG_LOGO)		  += logo/
> -obj-$(CONFIG_SYSFS)		  += backlight/
> +obj-$(CONFIG_SYSFS)		  += backlight/ 

Don't add whitespace at end of line (as above).

>  
>  obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
>  obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
> @@ -107,3 +107,4 @@
>  
>  # the test framebuffer is last
>  obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
> +obj-$(CONFIG_VIDEO_OUTPUT_CONTROL) += output.o
> diff -BruN 2.6/drivers/video/output.c edited/drivers/video/output.c
> --- 2.6/drivers/video/output.c	1970-01-01 08:00:00.000000000 +0800
> +++ edited/drivers/video/output.c	2006-08-30 15:20:04.000000000 +0800
> @@ -0,0 +1,109 @@
> +/*
> + * Video output switch support
> + */
> +
> +#include <linux/module.h>
> +#include <linux/output.h>
> +#include <linux/err.h>
> +#include <linux/ctype.h>
> +
> +
> +MODULE_DESCRIPTION("Backlight Lowlevel Control Abstraction");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Luming Yu <luming.yu@intel.com>");
> +
> +static ssize_t video_output_show_state (struct class_device *dev, char *buf)

func_name(...)  // no space between func_name and '('

> +{
> +	ssize_t ret_size = 0;
> +	struct output_device *od = to_output_device(dev);
> +	
> +	if(od->props)

if (

> +		ret_size = sprintf(buf, "%.8x\n", od->props->get_status(od));	
> +
> +	return ret_size;
> +}
> +
> +static ssize_t video_output_store_state (struct class_device *dev, const char *buf, size_t count)

no space after function name

> +{
> +	char *endp;
> +	struct output_device *od = to_output_device(dev);
> +	int request_state = simple_strtoul(buf, &endp, 0);
> +	size_t size = endp -buf;
> +	
> +	printk("in video_output_store_state %.8x\n", request_state);
> +        if (*endp && isspace(*endp))
> +                size++;
> +        if (size != count)
> +                return -EINVAL;

There seems to be some off whitespace/tabs there.

> +
> +	if(od->props){

if (

> +		od->request_state = request_state;
> +		od->props->set_state(od);
> +	}
> +	return count;
> +} 
> +
> +static void video_output_class_release(struct class_device *dev)
> +{
> +        struct output_device *od = to_output_device(dev);
> +        kfree(od);
> +}
> +
> +static struct class_device_attribute video_output_attributes[] = {
> +	__ATTR(state, 0644, video_output_show_state, video_output_store_state),
> +	__ATTR_NULL,
> +};
> +
> +static struct class video_output_class = {
> +	.name = "video_output",
> +	.release = video_output_class_release,
> +	.class_dev_attrs = video_output_attributes,
> +};
> +
> +
> +struct output_device *video_output_register(const char *name, void *devdata, struct output_properties *op)
> +{
> +	struct output_device *new_dev;
> +	int	ret_code = 0;
> +
> +	new_dev = (struct output_device *) kzalloc( sizeof(struct output_device), GFP_KERNEL);

kzalloc(sizeof(...

> +	if (!new_dev) {
> +		ret_code = -ENOMEM;
> +		goto error_return;
> +	}
> +	new_dev->props = op;
> +	new_dev->class_dev.class = &video_output_class;
> +	strlcpy(new_dev->class_dev.class_id, name, KOBJ_NAME_LEN);
> +	class_set_devdata(&new_dev->class_dev, devdata);
> +	ret_code = class_device_register(&new_dev->class_dev); 
> +	if (ret_code){

) {

> +		kfree (new_dev);

		kfree(new_dev);

> +		goto error_return;
> +	}
> +	return new_dev;
> +
> +error_return:
> +	return ERR_PTR(ret_code);
> +}
> +EXPORT_SYMBOL(video_output_register);
> +
> +void video_output_unregister(struct output_device *dev)
> +{
> +	if (!dev)
> +		return;
> +	class_device_unregister(&dev->class_dev);
> +}
> +EXPORT_SYMBOL(video_output_unregister);
> +
> +static void __exit video_output_class_exit(void)
> +{
> +	class_unregister(&video_output_class);
> +}
> +
> +static int __init video_output_class_init(void)
> +{
> +	return class_register(&video_output_class);
> +}
> +
> +postcore_initcall(video_output_class_init);
> +module_exit(video_output_class_exit);
> diff -BruN 2.6/include/linux/output.h edited/include/linux/output.h
> --- 2.6/include/linux/output.h	1970-01-01 08:00:00.000000000 +0800
> +++ edited/include/linux/output.h	2006-08-30 15:19:38.000000000 +0800
> @@ -0,0 +1,23 @@
> +#ifndef _LINUX_OUTPUT_H
> +#define _LINUX_OUTPUT_H
> +
> +#include <linux/device.h>
> +
> +struct output_device;
> +
> +struct output_properties {
> +	int (*set_state)(struct output_device *);
> +	int (*get_status)(struct output_device *);
> +};
> +
> +struct output_device {
> +	int request_state;
> +	struct output_properties *props;
> +	struct class_device class_dev;
> +};
> +
> +#define to_output_device(obj) container_of(obj, struct output_device, class_dev)
> +
> +struct output_device *video_output_register(const char *, void *, struct output_properties *);
> +void video_output_unregister(struct output_device *);
> +#endif


---
~Randy
