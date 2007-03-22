From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 8/8] [-mm] ACPI: add ACPI thermal_zone sysfs interface
Date: Thu, 22 Mar 2007 00:58:30 -0400
Message-ID: <200703220058.30374.lenb@kernel.org>
References: <1174382500.8833.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42758 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933151AbXCVE7s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Mar 2007 00:59:48 -0400
In-Reply-To: <1174382500.8833.87.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 20 March 2007 05:21, Zhang Rui wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Add ACPI thermal_zone sysfs interface.
> 
> Required attributes:
> Attribute	Mode	Description
> state		RO	state of the current thermal zone
> 			(ok/passive/active[x]/hot/critical)
> cooling_mode	RW	the cooling policy of the current thermal zone.
> 			0x00 = active, 0x01 = passive, 0xff = critical.
> polling_freq	RW	
> temperature	RO	temperature of the current thermal zone.(celsius)
> critical_temp	RW	critical trip point where OSPM must perform a
> 			critical shutdown
> 
> Optional attributes:
> Attribute	Mode	Description
> hot_temp	RW	critical trip point where OSPM may choose to
> 			transition the system into S4	
> passive_temp	RW	the passive cooling policy threshold value
> passive_tc1	RO	thermal constant for passive cooling
> passive_tc2	RO	thermal constant for passive cooling
> passive_tsp	RO	thermal sampling period for passive cooling
> active0_temp	RW	active cooling policy threshold value
> ...
> active9_temp	RW	active cooling policy threshold value
> 
> Syslinks to cooling devices(dynamic, optional):
> passive_cooling_device0
> ...
> passive_cooling_device9
> 
> active0_cooling_device0
> ...
> active0_cooling_device9
> ...
> ...
> active9_cooling_device0
> ...
> active9_cooling_device9
> 

I think this is an improvement over the procfs thermal_zone/*/trip_points
file, which confuses a lot of people with its format.

-Len

> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/thermal.c |  713 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 622 insertions(+), 91 deletions(-)
> 
> Index: linux-2.6.21-rc4-mm1/drivers/acpi/thermal.c
> ===================================================================
> --- linux-2.6.21-rc4-mm1.orig/drivers/acpi/thermal.c	2007-03-20 16:16:23.000000000 +0800
> +++ linux-2.6.21-rc4-mm1/drivers/acpi/thermal.c	2007-03-20 16:30:21.000000000 +0800
> @@ -83,19 +83,6 @@ MODULE_PARM_DESC(tzp, "Thermal zone poll
>  static int acpi_thermal_add(struct acpi_device *device);
>  static int acpi_thermal_remove(struct acpi_device *device, int type);
>  static int acpi_thermal_resume(struct acpi_device *device);
> -static int acpi_thermal_state_open_fs(struct inode *inode, struct file *file);
> -static int acpi_thermal_temp_open_fs(struct inode *inode, struct file *file);
> -static int acpi_thermal_trip_open_fs(struct inode *inode, struct file *file);
> -static ssize_t acpi_thermal_write_trip_points(struct file *,
> -					      const char __user *, size_t,
> -					      loff_t *);
> -static int acpi_thermal_cooling_open_fs(struct inode *inode, struct file *file);
> -static ssize_t acpi_thermal_write_cooling_mode(struct file *,
> -					       const char __user *, size_t,
> -					       loff_t *);
> -static int acpi_thermal_polling_open_fs(struct inode *inode, struct file *file);
> -static ssize_t acpi_thermal_write_polling(struct file *, const char __user *,
> -					  size_t, loff_t *);
>  
>  static struct acpi_driver acpi_thermal_driver = {
>  	.name = "thermal",
> @@ -176,44 +163,6 @@ struct acpi_thermal {
>  	struct timer_list timer;
>  };
>  
> -static const struct file_operations acpi_thermal_state_fops = {
> -	.open = acpi_thermal_state_open_fs,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -};
> -
> -static const struct file_operations acpi_thermal_temp_fops = {
> -	.open = acpi_thermal_temp_open_fs,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -};
> -
> -static const struct file_operations acpi_thermal_trip_fops = {
> -	.open = acpi_thermal_trip_open_fs,
> -	.read = seq_read,
> -	.write = acpi_thermal_write_trip_points,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -};
> -
> -static const struct file_operations acpi_thermal_cooling_fops = {
> -	.open = acpi_thermal_cooling_open_fs,
> -	.read = seq_read,
> -	.write = acpi_thermal_write_cooling_mode,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -};
> -
> -static const struct file_operations acpi_thermal_polling_fops = {
> -	.open = acpi_thermal_polling_open_fs,
> -	.read = seq_read,
> -	.write = acpi_thermal_write_polling,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -};
> -
>  /* --------------------------------------------------------------------------
>                               Thermal Zone Management
>     -------------------------------------------------------------------------- */
> @@ -305,15 +254,25 @@ static int acpi_thermal_set_cooling_mode
>  	return 0;
>  }
>  
> +static int acpi_thermal_cooling_device_update(struct acpi_thermal *thermal, int state,
> +						  struct acpi_handle_list *new_devices);
> +static int acpi_thermal_sysfs_update(struct acpi_thermal *thermal, struct acpi_thermal_state *old_state);
>  static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
>  {
>  	acpi_status status = AE_OK;
>  	int i = 0;
> +	struct acpi_handle_list devices;
> +	struct acpi_thermal_state state;
>  
>  
>  	if (!tz)
>  		return -EINVAL;
>  
> +	state.hot = tz->trips.hot.flags.valid;
> +	state.passive= tz->trips.passive.flags.valid;
> +	for (state.active_index = 0; state.active_index < ACPI_THERMAL_MAX_ACTIVE &&
> +		tz->trips.active[state.active_index].flags.valid; state.active_index ++);
> +
>  	/* Critical Shutdown (required) */
>  
>  	status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL,
> @@ -374,7 +333,7 @@ static int acpi_thermal_get_trip_points(
>  
>  		status =
>  		    acpi_evaluate_reference(tz->device->handle, "_PSL", NULL,
> -					    &tz->trips.passive.devices);
> +					    &devices);
>  		if (ACPI_FAILURE(status))
>  			tz->trips.passive.flags.valid = 0;
>  
> @@ -386,6 +345,13 @@ static int acpi_thermal_get_trip_points(
>  					  tz->trips.passive.temperature));
>  	}
>  
> +	if (!tz->trips.passive.flags.valid)
> +		devices.count = 0;
> +	status = acpi_thermal_cooling_device_update(tz, -1, &devices);
> +	if (status)
> +		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
> +				  "Passive cooling device update failed!\n"));
> +
>  	/* Active: Fans, etc. (optional) */
>  
>  	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
> @@ -396,22 +362,35 @@ static int acpi_thermal_get_trip_points(
>  		    acpi_evaluate_integer(tz->device->handle, name, NULL,
>  					  &tz->trips.active[i].temperature);
>  		if (ACPI_FAILURE(status))
> -			break;
> -
> -		name[2] = 'L';
> -		status =
> -		    acpi_evaluate_reference(tz->device->handle, name, NULL,
> -					    &tz->trips.active[i].devices);
> -		if (ACPI_SUCCESS(status)) {
> -			tz->trips.active[i].flags.valid = 1;
> -			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> -					  "Found active threshold [%d]:[%lu]\n",
> -					  i, tz->trips.active[i].temperature));
> -		} else
> -			ACPI_EXCEPTION((AE_INFO, status,
> -					"Invalid active threshold [%d]", i));
> +			tz->trips.active[i].flags.valid = 0;
> +		else {
> +			name[2] = 'L';
> +			status =
> +			    acpi_evaluate_reference(tz->device->handle, name, NULL,
> +						    &devices);
> +			if (ACPI_SUCCESS(status)) {
> +				tz->trips.active[i].flags.valid = 1;
> +				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> +						  "Found active threshold [%d]:[%lu]\n",
> +						  i, tz->trips.active[i].temperature));
> +			} else {
> +				tz->trips.active[i].flags.valid = 0;
> +				ACPI_EXCEPTION((AE_INFO, status,
> +						"Invalid active threshold [%d]", i));
> +			}
> +		}
> +		if (!tz->trips.active[i].flags.valid)
> +			devices.count = 0;
> +		status = acpi_thermal_cooling_device_update(tz, i, &devices);
> +		if (status)
> +			ACPI_DEBUG_PRINT((ACPI_DB_WARN,
> +				  	"Active[%d] cooling device update failed!\n", i));
>  	}
>  
> +	if(acpi_thermal_sysfs_update(tz, &state))
> +		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
> +		  		"Trip point sysfs update failed!\n"));
> +
>  	return 0;
>  }
>  
> @@ -771,9 +750,495 @@ static void acpi_thermal_check(void *dat
>  }
>  
>  /* --------------------------------------------------------------------------
> -                              FS Interface (/proc)
> +                              FS Interface (/sys)
>     -------------------------------------------------------------------------- */
> +static ssize_t
> +acpi_thermal_state_show(struct acpi_device *dev, char *buf)
> +{
> +	struct acpi_thermal *thermal = acpi_driver_data(dev);
> +	int result = 0;
> +
> +	if (!thermal->state.critical && !thermal->state.hot && !thermal->state.passive
> +	    && !thermal->state.active)
> +		result = sprintf(buf, "ok\n");
> +	else {
> +		if (thermal->state.critical)
> +			result += sprintf(buf, "critical ");
> +		if (thermal->state.hot)
> +			result += sprintf(buf, "hot ");
> +		if (thermal->state.passive)
> +			result += sprintf(buf, "passive ");
> +		if (thermal->state.active)
> +			result += sprintf(buf, "active[%d]", thermal->state.active_index);
> +		sprintf(buf, "\n");
> +	}
> +	return result;
> +}
> +static ACPI_DEVICE_ATTR(state, 0444, acpi_thermal_state_show, NULL);
> +
> +static ssize_t
> +acpi_thermal_temperature_show(struct acpi_device *dev, char *buf)
> +{
> +	struct acpi_thermal *thermal = acpi_driver_data(dev);
> +	int result = 0;
> +
> +	result = acpi_thermal_get_temperature(thermal);
> +	if (!result)
> +		return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(thermal->temperature));
> +	else
> +		return result;
> +}
> +static ACPI_DEVICE_ATTR(temperature, 0444, acpi_thermal_temperature_show, NULL);
> +
> +static ssize_t
> +acpi_thermal_cooling_mode_show(struct acpi_device *dev, char *buf)
> +{
> +	struct acpi_thermal *thermal = acpi_driver_data(dev);
> +
> +	if (!thermal)
> +		return -EINVAL;
> +
> +	if (thermal->flags.cooling_mode)
> +		return sprintf(buf, "0x%02x\n",	  thermal->cooling_mode);
> +
> +	return 0;
> +}
> +
> +static ssize_t
> +acpi_thermal_cooling_mode_store(struct acpi_device *dev,	const char *buf, size_t count)
> +{
> +	struct acpi_thermal *thermal = acpi_driver_data(dev);
> +	u32 mode;
> +	char *end;
> +	int ret = 0;
> +
> +	mode = simple_strtoul(buf, &end, 0);
> +	if (*end == '\0')
> +		return -EINVAL;
> +
> +	if (thermal->flags.cooling_mode){
> +		ret = acpi_thermal_set_cooling_mode(thermal, mode);
> +		if (ret)
> +			return ret;
> +		acpi_thermal_check(thermal);
> +		return count;
> +	}
> +	else
> +		return -ENODEV;
> +}
> +static ACPI_DEVICE_ATTR(cooling_mode, 0644, acpi_thermal_cooling_mode_show, acpi_thermal_cooling_mode_store);
> +
> +static ssize_t
> +acpi_thermal_polling_freq_show(struct acpi_device *dev, char *buf)
> +{
> +	struct acpi_thermal *thermal = acpi_driver_data(dev);
> +
> +	if (thermal->polling_frequency)
> +		return sprintf(buf, "%lu\n", (thermal->polling_frequency / 10));
> +
> +	return 0;
> +}
> +
> +static ssize_t
> +acpi_thermal_polling_freq_store(struct acpi_device *dev, const char *buf, size_t count)
> +{
> +	struct acpi_thermal *thermal = acpi_driver_data(dev);
> +	unsigned long freq;
> +	char * end;
> +	int ret = 0;
> +
> +	freq = simple_strtoul(buf, &end, 0);
> +	if (*end == '\0')
> +		return -EINVAL;
> +
> +	ret = acpi_thermal_set_polling(thermal, freq);
> +	if (ret)
> +		return ret;
> +
> +	acpi_thermal_check(thermal);
> +	return count;
> +}
> +static ACPI_DEVICE_ATTR(polling_freq, 0644, acpi_thermal_polling_freq_show, acpi_thermal_polling_freq_store);
> +
> +static ssize_t
> +acpi_thermal_passive_tc1_show(struct acpi_device *dev, char *buf)
> +{
> +	struct acpi_thermal *thermal = acpi_driver_data(dev);
> +
> +	if (!thermal)
> +		return -EINVAL;
> +
> +	if (thermal->trips.passive.flags.valid)
> +		return sprintf(buf, "%ld\n", thermal->trips.passive.tc1);
> +	else
> +		return -ENODEV;
> +}
> +static ACPI_DEVICE_ATTR(passive_tc1, 0444, acpi_thermal_passive_tc1_show, NULL);
> +
> +static ssize_t
> +acpi_thermal_passive_tc2_show(struct acpi_device *dev, char *buf)
> +{
> +	struct acpi_thermal *thermal = acpi_driver_data(dev);
> +
> +	if (!thermal)
> +		return -EINVAL;
> +
> +	if (thermal->trips.passive.flags.valid)
> +		return sprintf(buf, "%ld\n", thermal->trips.passive.tc2);
> +	else
> +		return -ENODEV;
> +}
> +static ACPI_DEVICE_ATTR(passive_tc2, 0444, acpi_thermal_passive_tc2_show, NULL);
> +
> +static ssize_t
> +acpi_thermal_passive_tsp_show(struct acpi_device *dev, char *buf)
> +{
> +	struct acpi_thermal *thermal = acpi_driver_data(dev);
> +
> +	if (!thermal)
> +		return -EINVAL;
> +
> +	if (thermal->trips.passive.flags.valid)
> +		return sprintf(buf, "%ld\n", thermal->trips.passive.tsp);
> +	else
> +		return -ENODEV;
> +}
> +static ACPI_DEVICE_ATTR(passive_tsp, 0444, acpi_thermal_passive_tsp_show, NULL);
> +
> +typedef ssize_t (*trip_point_show)(struct acpi_thermal *thermal,
> +				   int type, int state, char*buf);
> +typedef ssize_t (*trip_point_store)(struct acpi_thermal *thermal, int type,
> +				    int state, const char *buf, size_t count);
> +
> +struct acpi_thermal_trip_point_attr {
> +	struct	device_attribute attr;
> +	int	type;
> +	int	state;
> +	trip_point_show	show;
> +	trip_point_store	store;
> +};
> +
> +#define ACPI_THERMAL_TRIP_POINT_CRITICAL	0
> +#define ACPI_THERMAL_TRIP_POINT_HOT	1
> +#define ACPI_THERMAL_TRIP_POINT_PASSIVE	2
> +#define ACPI_THERMAL_TRIP_POINT_ACTIVE	3
> +
> +static ssize_t
> +acpi_thermal_trip_point_show(struct acpi_thermal *thermal,
> +				   int type, int state, char*buf)
> +{
> +	ssize_t result = -ENODEV;
> +
> +	switch(type) {
> +	case ACPI_THERMAL_TRIP_POINT_CRITICAL:
> +		if (thermal->trips.critical.flags.valid)
> +			result = sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(thermal->trips.critical.temperature));
> +		break;
> +	case ACPI_THERMAL_TRIP_POINT_HOT:
> +		if (thermal->trips.hot.flags.valid)
> +			result = sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(thermal->trips.hot.temperature));
> +		break;
> +	case ACPI_THERMAL_TRIP_POINT_PASSIVE:
> +		if (thermal->trips.passive.flags.valid)
> +			result = sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(thermal->trips.passive.temperature));
> +		break;
> +	case ACPI_THERMAL_TRIP_POINT_ACTIVE:
> +		if (thermal->trips.active[state].flags.valid) {
> +			if (state >= 0 && state < ACPI_THERMAL_MAX_ACTIVE)
> +				result = sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(thermal->trips.active[state].temperature));
> +			else
> +				result = -EINVAL;
> +		}
> +		break;
> +	default:
> +		result = -EINVAL;
> +	}
> +
> +	return result;
> +}
> +
> +static ssize_t
> +acpi_thermal_trip_point_store(struct acpi_thermal *thermal, int type,
> +				    int state, const char *buf, size_t count)
> +{
> +	char *end;
> +	u32 val;
> +	ssize_t result = -ENODEV;
> +
> +	val = simple_strtol(buf, &end, 0);
> +	if (*end == '\0')
> +		return -EINVAL;
> +
> +	switch(type) {
> +	case ACPI_THERMAL_TRIP_POINT_CRITICAL:
> +		if (thermal->trips.critical.flags.valid){
> +			thermal->trips.critical.temperature = CELSIUS_TO_KELVIN(val);
> +			result = count;
> +		}
> +		break;
> +	case ACPI_THERMAL_TRIP_POINT_HOT:
> +		if (thermal->trips.hot.flags.valid){
> +			thermal->trips.hot.temperature = CELSIUS_TO_KELVIN(val);
> +			result = count;
> +		}
> +		break;
> +	case ACPI_THERMAL_TRIP_POINT_PASSIVE:
> +		if (thermal->trips.passive.flags.valid){
> +			thermal->trips.passive.temperature = CELSIUS_TO_KELVIN(val);
> +			result = count;
> +		}
> +		break;
> +	case ACPI_THERMAL_TRIP_POINT_ACTIVE:
> +		if (thermal->trips.active[state].flags.valid){
> +			if (state >= 0 && state < ACPI_THERMAL_MAX_ACTIVE) {
> +				thermal->trips.active[state].temperature = CELSIUS_TO_KELVIN(val);
> +				result = count;
> +			}
> +			else
> +				result = -EINVAL;
> +		}
> +		break;
> +	default:
> +		result = -EINVAL;
> +	}
>  
> +	return result;
> +}
> +
> +static ssize_t _trip_point_show(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct acpi_thermal_trip_point_attr *thermal_attr = container_of(attr, struct acpi_thermal_trip_point_attr, attr);
> +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> +	struct acpi_thermal *thermal = acpi_driver_data(acpi_dev);
> +
> +	if (!thermal_attr->store)
> +		return -EINVAL;
> +
> +	return thermal_attr->show(thermal, thermal_attr->type, thermal_attr->state, buf);
> +}
> +static ssize_t _trip_point_store(struct device *dev, struct device_attribute *attr,
> +			 const char *buf, size_t count)
> +{
> +	struct acpi_thermal_trip_point_attr *thermal_attr = container_of(attr, struct acpi_thermal_trip_point_attr, attr);
> +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> +	struct acpi_thermal *thermal = acpi_driver_data(acpi_dev);
> +
> +	if (!thermal_attr->store)
> +		return -EINVAL;
> +
> +	return thermal_attr->store(thermal, thermal_attr->type, thermal_attr->state, buf, count);
> +}
> +
> +#define ACPI_THERMAL_TRIP_POINT(_name, _type, _state)	\
> +struct acpi_thermal_trip_point_attr _name##_attr =	\
> +{				\
> +	.attr = __ATTR(_name, 0644, _trip_point_show, _trip_point_store),	\
> +	.type = _type,	\
> +	.state = _state,	\
> +	.show = acpi_thermal_trip_point_show,		\
> +	.store = acpi_thermal_trip_point_store,	\
> +}
> +
> +
> +static ACPI_THERMAL_TRIP_POINT(critical_temp, ACPI_THERMAL_TRIP_POINT_CRITICAL, 0);
> +static ACPI_THERMAL_TRIP_POINT(hot_temp, ACPI_THERMAL_TRIP_POINT_HOT, 0);
> +static ACPI_THERMAL_TRIP_POINT(passive_temp, ACPI_THERMAL_TRIP_POINT_PASSIVE, 0);
> +static ACPI_THERMAL_TRIP_POINT(active0_temp, ACPI_THERMAL_TRIP_POINT_ACTIVE, 0);
> +static ACPI_THERMAL_TRIP_POINT(active1_temp, ACPI_THERMAL_TRIP_POINT_ACTIVE, 1);
> +static ACPI_THERMAL_TRIP_POINT(active2_temp, ACPI_THERMAL_TRIP_POINT_ACTIVE, 2);
> +static ACPI_THERMAL_TRIP_POINT(active3_temp, ACPI_THERMAL_TRIP_POINT_ACTIVE, 3);
> +static ACPI_THERMAL_TRIP_POINT(active4_temp, ACPI_THERMAL_TRIP_POINT_ACTIVE, 4);
> +static ACPI_THERMAL_TRIP_POINT(active5_temp, ACPI_THERMAL_TRIP_POINT_ACTIVE, 5);
> +static ACPI_THERMAL_TRIP_POINT(active6_temp, ACPI_THERMAL_TRIP_POINT_ACTIVE, 6);
> +static ACPI_THERMAL_TRIP_POINT(active7_temp, ACPI_THERMAL_TRIP_POINT_ACTIVE, 7);
> +static ACPI_THERMAL_TRIP_POINT(active8_temp, ACPI_THERMAL_TRIP_POINT_ACTIVE, 8);
> +static ACPI_THERMAL_TRIP_POINT(active9_temp, ACPI_THERMAL_TRIP_POINT_ACTIVE, 9);
> +
> +static struct device_attribute *thermal_default_attr[] =
> +{
> +	GET_DEV_ATTR(state),
> +	GET_DEV_ATTR(temperature),
> +	GET_DEV_ATTR(cooling_mode),
> +	GET_DEV_ATTR(polling_freq),
> +	GET_DEV_ATTR(critical_temp),
> +	NULL,
> +};
> +
> +static struct device_attribute *thermal_optional_attr[] =
> +{
> +	GET_DEV_ATTR(hot_temp),
> +	GET_DEV_ATTR(passive_temp),
> +	GET_DEV_ATTR(passive_tc1),
> +	GET_DEV_ATTR(passive_tc2),
> +	GET_DEV_ATTR(passive_tsp),
> +	GET_DEV_ATTR(active0_temp),
> +	GET_DEV_ATTR(active1_temp),
> +	GET_DEV_ATTR(active2_temp),
> +	GET_DEV_ATTR(active3_temp),
> +	GET_DEV_ATTR(active4_temp),
> +	GET_DEV_ATTR(active5_temp),
> +	GET_DEV_ATTR(active6_temp),
> +	GET_DEV_ATTR(active7_temp),
> +	GET_DEV_ATTR(active8_temp),
> +	GET_DEV_ATTR(active9_temp),
> +};
> +
> +static int acpi_thermal_add_sysfs(struct acpi_device* device)
> +{
> +	int result = 0;
> +
> +	result = acpi_device_add_sysfs(device, thermal_default_attr);
> +
> +	/*
> +	 * optional trip point attributes (hot/passive/active)
> +	 * and syslinks to cooling devices both are dynamic
> +	 */
> +
> +	return result;
> +}
> +
> +static void acpi_thermal_remove_sysfs(struct acpi_device* device)
> +{
> +	struct acpi_thermal *thermal = acpi_driver_data(device);
> +	struct acpi_handle_list new_devices;
> +	int i = 0;
> +
> +	acpi_device_remove_sysfs(device, thermal_default_attr);
> +
> +	/*
> +	 * remove syslinks to cooling devices
> +	 */
> +	new_devices.count = 0;
> +
> +	if (thermal->trips.passive.flags.valid)
> +		acpi_thermal_cooling_device_update(thermal, -1, &new_devices);
> +
> +
> +	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
> +		if (thermal->trips.active[i].flags.valid)
> +			acpi_thermal_cooling_device_update(thermal, i, &new_devices);
> +
> +	/*
> +	 * remove optional trip point attributes
> +	 */
> +	if (thermal->trips.hot.flags.valid )
> +		device_remove_file(&device->dev, thermal_optional_attr[0]);
> +
> +	if (thermal->trips.passive.flags.valid)
> +		for (i = 0; i < 4; i++)
> +			device_remove_file(&device->dev, thermal_optional_attr[1+i]);
> +
> +
> +	for(i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
> +		if ((thermal->trips.active[i].flags.valid))
> +			device_remove_file(&device->dev, thermal_optional_attr[5+i]);
> +
> +	return ;
> +}
> +
> +static int acpi_thermal_cooling_device_update(struct acpi_thermal* thermal, int state,
> +						  struct acpi_handle_list *new_devices)
> +{
> +	struct acpi_device *device = thermal->device;
> +	struct acpi_handle_list *old_devices;
> +	struct acpi_device *cooling_device;
> +	char buf[24];
> +	int i = 0;
> +	int result = 0;
> +
> +	if (!device || !new_devices)
> +		return -EINVAL;
> +
> +	if (state == -1) {
> +		sprintf(buf, "passive_cooling_device0");
> +		old_devices = &thermal->trips.passive.devices;
> +	}
> +	else
> +		if (state >= 0 && state < ACPI_THERMAL_MAX_ACTIVE) {
> +			sprintf(buf, "active%d_cooling_device0", state);
> +			old_devices = &thermal->trips.active[state].devices;
> +		}
> +		else
> +			return -EINVAL;
> +
> +	for (i = 0; i < old_devices->count || i < new_devices->count; i++) {
> +		if (i >= old_devices->count)
> +			old_devices->handles[i] = NULL;
> +		if (i >= new_devices->count)
> +			new_devices->handles[i] = NULL;
> +		if (new_devices->handles[i] != old_devices->handles[i]) {
> +			buf[22] = '0'+i;
> +
> +			if (i < old_devices->count && old_devices->handles[i])
> +				sysfs_remove_link(&device->dev.kobj, buf);
> +
> +			if (i < new_devices->count && new_devices->handles[i]) {
> +				acpi_bus_get_device(new_devices->handles[i], &cooling_device);
> +				result = sysfs_create_link(&device->dev.kobj, &cooling_device->dev.kobj, buf);
> +				if (result)
> +					return result;
> +			}
> +			old_devices->handles[i] = new_devices->handles[i];
> +		}
> +	}
> +	old_devices->count = new_devices->count;
> +
> +	return result;
> +}
> +
> +static int acpi_thermal_trip_point_update(struct device *dev, struct device_attribute *attr, int type)
> +{
> +	int result =0;
> +
> +	if (type)
> +		result = device_create_file(dev, attr);
> +	else
> +		device_remove_file(dev, attr);
> +
> +	return result;
> +}
> +
> +static int acpi_thermal_sysfs_update(struct acpi_thermal *thermal, struct acpi_thermal_state *old_state)
> +{
> +	struct acpi_device *device = thermal->device;
> +	int result = 0;
> +	int i = 0;
> +
> +	if (thermal->trips.hot.flags.valid != old_state->hot) {
> +		result = acpi_thermal_trip_point_update(&device->dev, thermal_optional_attr[0],
> +							thermal->trips.hot.flags.valid);
> +		if (result)
> +			goto done;
> +	}
> +
> +	if (thermal->trips.passive.flags.valid != old_state->passive)
> +		for (i = 0; i < 4; i++) {
> +			result = acpi_thermal_trip_point_update(&device->dev, thermal_optional_attr[1+i],
> +								thermal->trips.passive.flags.valid);
> +			if (result)
> +				goto done;
> +		}
> +
> +	for(i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
> +	{
> +		if ((thermal->trips.active[i].flags.valid && i >= old_state->active_index) ||
> +			(!thermal->trips.active[i].flags.valid && i < old_state->active_index)) {
> +			result = acpi_thermal_trip_point_update(&device->dev, thermal_optional_attr[5+i],
> +								thermal->trips.active[i].flags.valid);
> +			if (result)
> +				goto done;
> +		}
> +	}
> +
> +    done:
> +	return result;
> +}
> +
> +/* --------------------------------------------------------------------------
> +                              FS Interface (/proc)
> +   -------------------------------------------------------------------------- */
> +#ifdef CONFIG_ACPI_PROCFS
>  static struct proc_dir_entry *acpi_thermal_dir;
>  
>  static int acpi_thermal_state_seq_show(struct seq_file *seq, void *offset)
> @@ -838,6 +1303,7 @@ static int acpi_thermal_temp_open_fs(str
>  static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
>  {
>  	struct acpi_thermal *tz = seq->private;
> +	struct acpi_device *device;
>  	int i = 0;
>  	int j = 0;
>  
> @@ -860,9 +1326,8 @@ static int acpi_thermal_trip_seq_show(st
>  			   tz->trips.passive.tc1, tz->trips.passive.tc2,
>  			   tz->trips.passive.tsp);
>  		for (j = 0; j < tz->trips.passive.devices.count; j++) {
> -
> -			seq_printf(seq, "0x%p ",
> -				   tz->trips.passive.devices.handles[j]);
> +			acpi_bus_get_device(tz->trips.passive.devices.handles[j], &device);
> +  			seq_printf(seq, "%4.4s ", acpi_device_bid(device));
>  		}
>  		seq_puts(seq, "\n");
>  	}
> @@ -873,9 +1338,10 @@ static int acpi_thermal_trip_seq_show(st
>  		seq_printf(seq, "active[%d]:               %ld C: devices=",
>  			   i,
>  			   KELVIN_TO_CELSIUS(tz->trips.active[i].temperature));
> -		for (j = 0; j < tz->trips.active[i].devices.count; j++)
> -			seq_printf(seq, "0x%p ",
> -				   tz->trips.active[i].devices.handles[j]);
> +		for (j = 0; j < tz->trips.active[i].devices.count; j++) {
> +			acpi_bus_get_device(tz->trips.active[i].devices.handles[j], &device);
> +  			seq_printf(seq, "%4.4s ", acpi_device_bid(device));
> +		}
>  		seq_puts(seq, "\n");
>  	}
>  
> @@ -1067,7 +1533,45 @@ acpi_thermal_write_polling(struct file *
>  	return count;
>  }
>  
> -static int acpi_thermal_add_fs(struct acpi_device *device)
> +static const struct file_operations acpi_thermal_state_fops = {
> +	.open = acpi_thermal_state_open_fs,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static const struct file_operations acpi_thermal_temp_fops = {
> +	.open = acpi_thermal_temp_open_fs,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static const struct file_operations acpi_thermal_trip_fops = {
> +	.open = acpi_thermal_trip_open_fs,
> +	.read = seq_read,
> +	.write = acpi_thermal_write_trip_points,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static const struct file_operations acpi_thermal_cooling_fops = {
> +	.open = acpi_thermal_cooling_open_fs,
> +	.read = seq_read,
> +	.write = acpi_thermal_write_cooling_mode,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static const struct file_operations acpi_thermal_polling_fops = {
> +	.open = acpi_thermal_polling_open_fs,
> +	.read = seq_read,
> +	.write = acpi_thermal_write_polling,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static int acpi_thermal_add_procfs(struct acpi_device *device)
>  {
>  	struct proc_dir_entry *entry = NULL;
>  
> @@ -1141,7 +1645,7 @@ static int acpi_thermal_add_fs(struct ac
>  	return 0;
>  }
>  
> -static int acpi_thermal_remove_fs(struct acpi_device *device)
> +static int acpi_thermal_remove_procfs(struct acpi_device *device)
>  {
>  
>  	if (acpi_device_dir(device)) {
> @@ -1162,6 +1666,26 @@ static int acpi_thermal_remove_fs(struct
>  	return 0;
>  }
>  
> +static int acpi_thermal_procfs_init(void)
> +{
> +	acpi_thermal_dir = proc_mkdir(ACPI_THERMAL_CLASS, acpi_root_dir);
> +	if (!acpi_thermal_dir)
> +		return -ENODEV;
> +	acpi_thermal_dir->owner = THIS_MODULE;
> +
> +	return 0;
> +}
> +
> +static int acpi_thermal_procfs_exit(void)
> +{
> +	remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
> +
> +	return 0;
> +}
> +#else
> +declare_acpi_device_procfs(thermal);
> +#endif
> +
>  /* --------------------------------------------------------------------------
>                                   Driver Interface
>     -------------------------------------------------------------------------- */
> @@ -1283,10 +1807,14 @@ static int acpi_thermal_add(struct acpi_
>  	if (result)
>  		goto end;
>  
> -	result = acpi_thermal_add_fs(device);
> +	result = acpi_thermal_add_sysfs(device);
>  	if (result)
>  		goto end;
>  
> +	result = acpi_thermal_add_procfs(device);
> +	if (result)
> +		goto procfs_error;
> +
>  	init_timer(&tz->timer);
>  
>  	acpi_thermal_check(tz);
> @@ -1296,19 +1824,22 @@ static int acpi_thermal_add(struct acpi_
>  					     acpi_thermal_notify, tz);
>  	if (ACPI_FAILURE(status)) {
>  		result = -ENODEV;
> -		goto end;
> +		goto notify_error;
>  	}
>  
>  	printk(KERN_INFO PREFIX "%s [%s] (%ld C)\n",
>  	       acpi_device_name(device), acpi_device_bid(device),
>  	       KELVIN_TO_CELSIUS(tz->temperature));
>  
> -      end:
> -	if (result) {
> -		acpi_thermal_remove_fs(device);
> -		kfree(tz);
> -	}
> +	goto end;
>  
> +  notify_error:
> +	acpi_thermal_remove_procfs(device);
> +  procfs_error:
> +	acpi_thermal_remove_sysfs(device);
> +  end:
> +	if (result)
> +		kfree(tz);
>  	return result;
>  }
>  
> @@ -1347,7 +1878,9 @@ static int acpi_thermal_remove(struct ac
>  		acpi_thermal_active(tz);
>  	}
>  
> -	acpi_thermal_remove_fs(device);
> +	acpi_thermal_remove_procfs(device);
> +
> +	acpi_thermal_remove_sysfs(device);
>  
>  	kfree(tz);
>  	return 0;
> @@ -1390,15 +1923,14 @@ static int __init acpi_thermal_init(void
>  {
>  	int result = 0;
>  
> +	result = acpi_thermal_procfs_init();
> +	if (result)
> +		return result;
>  
> -	acpi_thermal_dir = proc_mkdir(ACPI_THERMAL_CLASS, acpi_root_dir);
> -	if (!acpi_thermal_dir)
> -		return -ENODEV;
> -	acpi_thermal_dir->owner = THIS_MODULE;
> -
> +	acpi_thermal_driver.owner = THIS_MODULE;
>  	result = acpi_bus_register_driver(&acpi_thermal_driver);
>  	if (result < 0) {
> -		remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
> +		acpi_thermal_procfs_exit();
>  		return -ENODEV;
>  	}
>  
> @@ -1407,10 +1939,9 @@ static int __init acpi_thermal_init(void
>  
>  static void __exit acpi_thermal_exit(void)
>  {
> -
>  	acpi_bus_unregister_driver(&acpi_thermal_driver);
>  
> -	remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
> +	acpi_thermal_procfs_exit();
>  
>  	return;
>  }
> 
