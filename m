From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 053/112] the generic thermal sysfs driver
Date: Thu, 7 Feb 2008 08:46:45 -0800
Message-ID: <20080207084645.c6e67aad.randy.dunlap@oracle.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
	<203d3d4aa482339b4816f131f713e1b8ee37f6dd.1202376824.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:46907 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755135AbYBGQsy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 11:48:54 -0500
In-Reply-To: <203d3d4aa482339b4816f131f713e1b8ee37f6dd.1202376824.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

On Thu,  7 Feb 2008 04:34:15 -0500 Len Brown wrote:

> From: Zhang Rui <rui.zhang@intel.com>
> 
> The Generic Thermal sysfs driver for thermal management.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  Documentation/thermal/sysfs-api.txt |  246 ++++++++++++
>  drivers/Kconfig                     |    2 +
>  drivers/Makefile                    |    1 +
>  drivers/thermal/Kconfig             |   15 +
>  drivers/thermal/Makefile            |    5 +
>  drivers/thermal/thermal.c           |  714 +++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h             |   90 +++++
>  7 files changed, 1073 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/thermal/sysfs-api.txt
>  create mode 100644 drivers/thermal/Kconfig
>  create mode 100644 drivers/thermal/Makefile
>  create mode 100644 drivers/thermal/thermal.c
>  create mode 100644 include/linux/thermal.h
> 
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> new file mode 100644
> index 0000000..5776e09
> --- /dev/null
> +++ b/Documentation/thermal/sysfs-api.txt

Nice doc.  Thanks.

> @@ -0,0 +1,246 @@
> +Generic Thermal Sysfs driver How To
> +=========================
> +
> +Written by Sujith Thomas <sujith.thomas@intel.com>, Zhang Rui <rui.zhang@intel.com>
> +
> +Updated: 2 January 2008
> +
> +Copyright (c)  2008 Intel Corporation
> +
> +
> +0. Introduction
> +
> +The generic thermal sysfs provides a set of interfaces for thermal zone devices (sensors)
> +and thermal cooling devices (fan, processor...) to register with the thermal management
> +solution and to be a part of it.
> +
> +This how-to focusses on enabling new thermal zone and cooling devices to participate

s/focusses/focuses/

> +in thermal management.
> +This solution is platform independent and any type of thermal zone devices and
> +cooling devices should be able to make use of the infrastructure.
> +
> +The main task of the thermal sysfs driver is to expose thermal zone attributes as well
> +as cooling device attributes to the user space.
> +An intelligent thermal management application can make decisions based on inputs
> +from thermal zone attributes (the current temperature and trip point temperature)
> +and throttle appropriate devices.
> +
> +[0-*]	denotes any positive number starting from 0
> +[1-*]	denotes any positive number starting from 1
> +
...

> +2. sysfs attributes structure
> +
> +RO	read only value
> +RW	read/write value
> +
> +All thermal sysfs attributes will be represented under /sys/class/thermal
> +/sys/class/thermal/

Is that a duplicated path?  or what?

> +
> +Thermal zone device sys I/F, created once it's registered:
> +|thermal_zone[0-*]:
> +	|-----type:			Type of the thermal zone
> +	|-----temp:			Current temperature
> +	|-----mode:			Working mode of the thermal zone
> +	|-----trip_point_[0-*]_temp:	Trip point temperature
> +	|-----trip_point_[0-*]_type:	Trip point type
> +
> +Thermal cooling device sys I/F, created once it's registered:
> +|cooling_device[0-*]:
> +	|-----type :			Type of the cooling device(processor/fan/...)
> +	|-----max_state:		Maximum cooling state of the cooling device
> +	|-----cur_state:		Current cooling state of the cooling device
> +
> +
> +These two dynamic attributes are created/removed in pairs.
> +They represent the relationship between a thermal zone and its associated cooling device.
> +They are created/removed for each
> +thermal_zone_bind_cooling_device/thermal_zone_unbind_cooling_device successful exection.
> +
> +|thermal_zone[0-*]
> +	|-----cdev[0-*]:		The [0-*]th cooling device in the current thermal zone
> +	|-----cdev[0-*]_trip_point:	Trip point that cdev[0-*] is associated with
> +
> +
> +***************************
> +* Thermal zone attributes *
> +***************************
> +
> +type				Strings which represent the thermal zone type.
> +				This is given by thermal zone driver as part of registration.
> +				Eg: "ACPI thermal zone" indicates it's a ACPI thermal device
> +				RO
> +				Optional
> +
> +temp				Current temperature as reported by thermal zone (sensor)
> +				Unit: degree celsius
> +				RO
> +				Required
> +
> +mode				One of the predifned values in [kernel, user]

                                           predefined

> +				This file gives information about the algorithm
> +				that is currently managing the thermal zone.
> +				It can be either default kernel based algorithm
> +				or user space application.
> +				RW
> +				Optional
> +				kernel	= Thermal management in kernel thermal zone driver.
> +				user	= Preventing kernel thermal zone driver actions upon
> +					  trip points so that user application can take full
> +					  charge of the thermal management.
> +
> +trip_point_[0-*]_temp		The temperature above which trip point will be fired
> +				Unit: degree celsius
> +				RO
> +				Optional
> +
> +trip_point_[0-*]_type 		Strings which indicate the type of the trip point
> +				Eg. it can be one of critical, hot, passive,

                                E.g.

> +				    active[0-*] for ACPI thermal zone.
> +				RO
> +				Optional
> +
> +cdev[0-*]			Sysfs link to the thermal cooling device node where the sys I/F
> +				for cooling device throttling control represents.
> +				RO
> +				Optional
> +
> +cdev[0-*]_trip_point		The trip point with which cdev[0-*] is assocated in this thermal zone
> +				-1 means the cooling device is not associated with any trip point.
> +				RO
> +				Optional
> +
> +******************************
> +* Cooling device  attributes *
> +******************************
> +
> +type				String which represents the type of device
> +				eg: For generic ACPI: this should be "Fan",
> +				"Processor" or "LCD"
> +				eg. For memory controller device on intel_menlow platform:
> +				this should be "Memory controller"
> +				RO
> +				Optional
> +
> +max_state			The maximum permissible cooling state of this cooling device.
> +				RO
> +				Required
> +
> +cur_state			The current cooling state of this cooling device.
> +				the value can any integer numbers between 0 and max_state,
> +				cur_state == 0 means no cooling
> +				cur_state == max_state means the maximum cooling.
> +				RW
> +				Required
> +
> +3. A simple implementation
> +
> +ACPI thermal zone may support multiple trip points like critical/hot/passive/active.
> +If an ACPI thermal zone supports critical, passive, active[0] and active[1] at the same time,
> +it may register itself as a thermale_zone_device (thermal_zone1) with 4 trip points in all.

                               thermale ?

> +It has one processor and one fan, which are both registered as thermal_cooling_device.
> +If the processor is listed in _PSL method, and the fan is listed in _AL0 method,
> +the sys I/F structure will be built like this:
> +
> +/sys/class/thermal:
> +
> +|thermal_zone1:
> +	|-----type:			ACPI thermal zone
> +	|-----temp:			37
> +	|-----mode:			kernel
> +	|-----trip_point_0_temp:	100
> +	|-----trip_point_0_type:	critical
> +	|-----trip_point_1_temp:	80
> +	|-----trip_point_1_type:	passive
> +	|-----trip_point_2_temp:	70
> +	|-----trip_point_2_type:	active[0]
> +	|-----trip_point_3_temp:	60
> +	|-----trip_point_3_type:	active[1]
> +	|-----cdev0:			--->/sys/class/thermal/cooling_device0
> +	|-----cdev0_trip_point:		1	/* cdev0 can be used for passive */
> +	|-----cdev1:			--->/sys/class/thermal/cooling_device3
> +	|-----cdev1_trip_point:		2	/* cdev1 can be used for active[0]*/
> +
> +|cooling_device0:
> +	|-----type:			Processor
> +	|-----max_state:		8
> +	|-----cur_state:		0
> +
> +|cooling_device3:
> +	|-----type:			Fan
> +	|-----max_state:		2
> +	|-----cur_state:		0

> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> new file mode 100644
> index 0000000..9b3f612
> --- /dev/null
> +++ b/drivers/thermal/Kconfig
> @@ -0,0 +1,15 @@
> +#
> +# Generic thermal sysfs drivers configuration
> +#
> +
> +menuconfig THERMAL
> +	bool "Generic Thermal sysfs driver"
> +	default y
> +	help
> +	  Generic Thermal Sysfs driver offers a generic mechanism for
> +	  thermal management. Usually it's made up of one or more thermal
> +	  zone and cooling device.
> +	  each thermal zone contains its own temperature, trip points,

          Each

> +	  cooling devices.
> +	  All platforms with ACPI thermal support can use this driver.
> +	  If you want this support, you should say Y here

                                                     here.

> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> new file mode 100644
> index 0000000..8ef1232
> --- /dev/null
> +++ b/drivers/thermal/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for sensor chip drivers.
> +#
> +
> +obj-$(CONFIG_THERMAL)		+= thermal.o
> diff --git a/drivers/thermal/thermal.c b/drivers/thermal/thermal.c
> new file mode 100644
> index 0000000..3273e34
> --- /dev/null
> +++ b/drivers/thermal/thermal.c
> @@ -0,0 +1,714 @@
> +/*
> + *  thermal.c - Generic Thermal Management Sysfs support.
> + *
> + *  Copyright (C) 2008 Intel Corp
> + *  Copyright (C) 2008 Zhang Rui <rui.zhang@intel.com>
> + *  Copyright (C) 2008 Sujith Thomas <sujith.thomas@intel.com>
> + *
> + *  
> + */
> +
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kdev_t.h>
> +#include <linux/idr.h>
> +#include <linux/thermal.h>
> +#include <linux/spinlock.h>
> +
> +MODULE_AUTHOR("Zhang Rui")
> +MODULE_DESCRIPTION("Generic thermal management sysfs support");
> +MODULE_LICENSE("GPL");
> +
> +#define PREFIX "Thermal: "
> +
> +struct thermal_cooling_device_instance {
> +	int id;
> +	char name[THERMAL_NAME_LENGTH];
> +	struct thermal_zone_device *tz;
> +	struct thermal_cooling_device *cdev;
> +	int trip;
> +	char attr_name[THERMAL_NAME_LENGTH];
> +	struct device_attribute attr;
> +	struct list_head node;
> +};
> +
> +static DEFINE_IDR(thermal_tz_idr);
> +static DEFINE_IDR(thermal_cdev_idr);
> +static DEFINE_MUTEX(thermal_idr_lock);
> +
> +static LIST_HEAD(thermal_tz_list);
> +static LIST_HEAD(thermal_cdev_list);
> +static DEFINE_MUTEX(thermal_list_lock);
> +
> +static int get_idr(struct idr *idr, struct mutex *lock, int *id)
> +{
> +	int err;
> +
> +      again:

Don't indent labels so much (just 0 or 1 spaces).  When they are
indented so much, it's difficult to see them (they are close to
hidden).


> +	if (unlikely(idr_pre_get(idr, GFP_KERNEL) == 0))
> +		return -ENOMEM;
> +
> +	if (lock)
> +		mutex_lock(lock);
> +	err = idr_get_new(idr, NULL, id);
> +	if (lock)
> +		mutex_unlock(lock);
> +	if (unlikely(err == -EAGAIN))
> +		goto again;
> +	else if (unlikely(err))
> +		return err;
> +
> +	*id = *id & MAX_ID_MASK;
> +	return 0;
> +}
> +
> +/* Device management */
> +
> +/**
> + * thermal_zone_bind_cooling_device - bind a cooling device to a thermal zone
> + * this function is usually called in the thermal zone device .bind callback.
> + * @tz:		thermal zone device
> + * @trip:	indicates which trip point the cooling devices is
> + *		associated with in this thermal zone.
> + * @cdev:	thermal cooling device
> + */

Please see Documentation/kernel-doc-nano-HOWTO.txt for info on
kernel-doc format.  The second line above ("this function...")
is out of place.  It should be moved to follow the function
parameters and separated from them by one "blank" (actually
" *") line.

> +int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
> +				     int trip,
> +				     struct thermal_cooling_device *cdev)
> +{
> +	struct thermal_cooling_device_instance *dev;
> +	struct thermal_cooling_device_instance *pos;
> +	int result;
> +
> +	if (trip >= tz->trips ||
> +	    (trip < 0 && trip != THERMAL_TRIPS_NONE))
> +		return -EINVAL;
> +
> +	if (!tz || !cdev)
> +		return -EINVAL;
> +
> +	dev =
> +	    kzalloc(sizeof(struct thermal_cooling_device_instance), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +	dev->tz = tz;
> +	dev->cdev = cdev;
> +	dev->trip = trip;
> +	result = get_idr(&tz->idr, &tz->lock, &dev->id);
> +	if (result)
> +		goto free_mem;
> +
> +	sprintf(dev->name, "cdev%d", dev->id);
> +	result =
> +	    sysfs_create_link(&tz->device.kobj, &cdev->device.kobj, dev->name);
> +	if (result)
> +		goto release_idr;
> +
> +	sprintf(dev->attr_name, "cdev%d_trip_point", dev->id);
> +	dev->attr.attr.name = dev->attr_name;
> +	dev->attr.attr.mode = 0444;
> +	dev->attr.show = thermal_cooling_device_trip_point_show;
> +	result = device_create_file(&tz->device, &dev->attr);
> +	if (result)
> +		goto remove_symbol_link;
> +
> +	mutex_lock(&tz->lock);
> +	list_for_each_entry(pos, &tz->cooling_devices, node)
> +	    if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
> +		result = -EEXIST;
> +		break;
> +	}
> +	if (!result)
> +		list_add_tail(&dev->node, &tz->cooling_devices);
> +	mutex_unlock(&tz->lock);
> +
> +	if (!result)
> +		return 0;
> +
> +	device_remove_file(&tz->device, &dev->attr);
> +      remove_symbol_link:
> +	sysfs_remove_link(&tz->device.kobj, dev->name);
> +      release_idr:
> +	release_idr(&tz->idr, &tz->lock, dev->id);
> +      free_mem:
> +	kfree(dev);
> +	return result;
> +}
> +EXPORT_SYMBOL(thermal_zone_bind_cooling_device);
> +
> +/**
> + * thermal_zone_unbind_cooling_device - unbind a cooling device from a thermal zone
> + * this function is usually called in the thermal zone device .unbind callback.
> + * @tz:		thermal zone device
> + * @trip:	indicates which trip point the cooling devices is
> + *		associated with in this thermal zone.
> + * @cdev:	thermal cooling device
> + */

Ditto.

> +int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
> +				       int trip,
> +				       struct thermal_cooling_device *cdev)
> +{
> +	struct thermal_cooling_device_instance *pos, *next;
> +
> +	mutex_lock(&tz->lock);
> +	list_for_each_entry_safe(pos, next, &tz->cooling_devices, node) {
> +		if (pos->tz == tz && pos->trip == trip
> +		    && pos->cdev == cdev) {
> +			list_del(&pos->node);
> +			mutex_unlock(&tz->lock);
> +			goto unbind;
> +		}
> +	}
> +	mutex_unlock(&tz->lock);
> +
> +	return -ENODEV;
> +
> +      unbind:
> +	device_remove_file(&tz->device, &pos->attr);
> +	sysfs_remove_link(&tz->device.kobj, pos->name);
> +	release_idr(&tz->idr, &tz->lock, pos->id);
> +	kfree(pos);
> +	return 0;
> +}
> +EXPORT_SYMBOL(thermal_zone_unbind_cooling_device);
> +
> +/**
> + * thermal_cooling_device_register - register a new thermal cooling device
> + * @type:	the thermal cooling device type.
> + * @devdata:	device private data.
> + * @ops:		standard thermal cooling devices callbacks.
> + */
> +struct thermal_cooling_device *thermal_cooling_device_register(char *type,
> +		       void *devdata, struct thermal_cooling_device_ops *ops)
> +{
> +	struct thermal_cooling_device *cdev;
> +	struct thermal_zone_device *pos;
> +	int result;
> +
> +	if (strlen(type) >= THERMAL_NAME_LENGTH)
> +		return NULL;
> +
> +	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> +		!ops->set_cur_state)
> +		return NULL;
> +
> +	cdev = kzalloc(sizeof(struct thermal_cooling_device), GFP_KERNEL);
> +	if (!cdev)
> +		return NULL;
> +
> +	result = get_idr(&thermal_cdev_idr, &thermal_idr_lock, &cdev->id);
> +	if (result) {
> +		kfree(cdev);
> +		return NULL;
> +	}
> +
> +	strcpy(cdev->type, type);
> +	cdev->ops = ops;
> +	cdev->device.class = &thermal_class;
> +	cdev->devdata = devdata;
> +	sprintf(cdev->device.bus_id, "cooling_device%d", cdev->id);
> +	result = device_register(&cdev->device);
> +	if (result) {
> +		release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
> +		kfree(cdev);
> +		return NULL;
> +	}
> +
> +	/* sys I/F */
> +	if (type) {
> +		result = device_create_file(&cdev->device,
> +					    &dev_attr_cdev_type);
> +		if (result)
> +			goto unregister;
> +	}
> +
> +	result = device_create_file(&cdev->device, &dev_attr_max_state);
> +	if (result)
> +		goto unregister;
> +
> +	result = device_create_file(&cdev->device, &dev_attr_cur_state);
> +	if (result)
> +		goto unregister;
> +
> +	mutex_lock(&thermal_list_lock);
> +	list_add(&cdev->node, &thermal_cdev_list);
> +	list_for_each_entry(pos, &thermal_tz_list, node) {
> +		if (!pos->ops->bind)
> +			continue;
> +		result = pos->ops->bind(pos, cdev);
> +		if (result)
> +			break;
> +
> +	}
> +	mutex_unlock(&thermal_list_lock);
> +
> +	if (!result)
> +		return cdev;
> +
> +      unregister:

Hidden label placement.  Please check all labels.


> +	release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
> +	device_unregister(&cdev->device);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(thermal_cooling_device_register);
> +
> +/**
> + * thermal_cooling_device_unregister - removes the registered thermal cooling device
> + *

No "blank" (" *") line allowed between function name-description and the
function parameters.

> + * @cdev:	the thermal cooling device to remove.
> + *
> + * thermal_cooling_device_unregister() must be called when the device is no
> + * longer needed.
> + */
> +void thermal_cooling_device_unregister(struct
> +				       thermal_cooling_device
> +				       *cdev)
> +{
...
> +}
> +EXPORT_SYMBOL(thermal_cooling_device_unregister);
> +
> +/**
> + * thermal_zone_device_register - register a new thermal zone device
> + * @type:	the thermal zone device type
> + * @trips:	the number of trip points the thermal zone support
> + * @devdata:	private device data
> + * @ops:	standard thermal zone device callbacks
> + *
> + * thermal_zone_device_unregister() must be called when the device is no
> + * longer needed.
> + */
> +struct thermal_zone_device *thermal_zone_device_register(char *type,
> +					int trips, void *devdata,
> +					struct thermal_zone_device_ops *ops)
> +{
> +	struct thermal_zone_device *tz;
> +	struct thermal_cooling_device *pos;
> +	int result;
> +	int count;
> +
> +	if (strlen(type) >= THERMAL_NAME_LENGTH)
> +		return NULL;
> +
> +	if (trips > THERMAL_MAX_TRIPS || trips < 0)
> +		return NULL;
> +
> +	if (!ops || !ops->get_temp)
> +		return NULL;
> +
> +	tz = kzalloc(sizeof(struct thermal_zone_device), GFP_KERNEL);
> +	if (!tz)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&tz->cooling_devices);
> +	idr_init(&tz->idr);
> +	mutex_init(&tz->lock);
> +	result = get_idr(&thermal_tz_idr, &thermal_idr_lock, &tz->id);
> +	if (result) {
> +		kfree(tz);
> +		return NULL;
> +	}
> +
> +	strcpy(tz->type, type);
> +	tz->ops = ops;
> +	tz->device.class = &thermal_class;
> +	tz->devdata = devdata;
> +	tz->trips = trips;
> +	sprintf(tz->device.bus_id, "thermal_zone%d", tz->id);
> +	result = device_register(&tz->device);
> +	if (result) {
> +		release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
> +		kfree(tz);
> +		return NULL;
> +	}
> +
> +	/* sys I/F */
> +	if (type) {
> +		result = device_create_file(&tz->device, &dev_attr_type);
> +		if (result)
> +			goto unregister;
> +	}
> +
> +	result = device_create_file(&tz->device, &dev_attr_temp);
> +	if (result)
> +		goto unregister;
> +
> +	if (ops->get_mode) {
> +		result = device_create_file(&tz->device, &dev_attr_mode);
> +		if (result)
> +			goto unregister;
> +	}
> +
> +	for (count = 0; count < trips; count++) {
> +		TRIP_POINT_ATTR_ADD(&tz->device, count, result);
> +		if (result)
> +			goto unregister;
> +	}
> +
> +	mutex_lock(&thermal_list_lock);
> +	list_add_tail(&tz->node, &thermal_tz_list);
> +	if (ops->bind)
> +		list_for_each_entry(pos, &thermal_cdev_list, node) {
> +			result = ops->bind(tz, pos);
> +			if (result)
> +				break;
> +		}
> +	mutex_unlock(&thermal_list_lock);
> +
> +	if (!result)
> +		return tz;
> +
> +      unregister:

Hidden label.

> +	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
> +	device_unregister(&tz->device);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(thermal_zone_device_register);
> +
> +/**
> + * thermal_device_unregister - removes the registered thermal zone device
> + *

No "blank" line here.

> + * @tz: the thermal zone device to remove
> + */
> +void thermal_zone_device_unregister(struct thermal_zone_device *tz)
> +{
> +	struct thermal_cooling_device *cdev;
> +	struct thermal_zone_device *pos = NULL;
> +	int count;
> +
> +	if (!tz)
> +		return;
> +
> +	mutex_lock(&thermal_list_lock);
> +	list_for_each_entry(pos, &thermal_tz_list, node)
> +	    if (pos == tz)
> +		break;
> +	if (pos != tz) {
> +		/* thermal zone device not found */
> +		mutex_unlock(&thermal_list_lock);
> +		return;
> +	}
> +	list_del(&tz->node);
> +	if (tz->ops->unbind)
> +		list_for_each_entry(cdev, &thermal_cdev_list, node)
> +		    tz->ops->unbind(tz, cdev);
> +	mutex_unlock(&thermal_list_lock);
> +
> +	if (tz->type[0])
> +		device_remove_file(&tz->device, &dev_attr_type);
> +	device_remove_file(&tz->device, &dev_attr_temp);
> +	if (tz->ops->get_mode)
> +		device_remove_file(&tz->device, &dev_attr_mode);
> +
> +	for (count = 0; count < tz->trips; count++)
> +		TRIP_POINT_ATTR_REMOVE(&tz->device, count);
> +
> +	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
> +	idr_destroy(&tz->idr);
> +	mutex_destroy(&tz->lock);
> +	device_unregister(&tz->device);
> +	return;
> +}
> +EXPORT_SYMBOL(thermal_zone_device_unregister);


---
~Randy
