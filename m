From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 3/4] ACPI: Remove redundant NULL checks in acpi drivers
Date: Mon, 14 Sep 2009 13:39:01 -0600
Message-ID: <200909141339.02441.bjorn.helgaas@hp.com>
References: <1252944569-29799-1-git-send-email-alan-jenkins@tuffmail.co.uk> <1252944569-29799-4-git-send-email-alan-jenkins@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:47680 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756828AbZINTjA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 15:39:00 -0400
In-Reply-To: <1252944569-29799-4-git-send-email-alan-jenkins@tuffmail.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Monday 14 September 2009 10:09:28 am Alan Jenkins wrote:
> The acpi device callbacks add, start, remove, suspend and resume can
> never be called with a NULL acpi_device. Each callsite in acpi/scan.c
> has to dereference the device in order to get the ops structure, e.g.
> 
>     struct acpi_device *acpi_dev = to_acpi_device(dev);
>     struct acpi_driver *acpi_drv = acpi_dev->driver;
> 
>     if (acpi_drv && acpi_drv->ops.suspend)
>         return acpi_drv->ops.suspend(acpi_dev, state);
> 
> Remove all checks for acpi_dev == NULL within these callbacks.
> 
> Also remove the checks for acpi_driver_data(acpi_dev) == NULL. None of
> these checks could fail unless the driver does something strange
> (which none of them do), the acpi core did something terribly wrong,
> or we have a memory corruption issue. If this does happen then it's
> best to dereference the pointer and crash noisily.
> 
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Minor comments below.

> ---
>  drivers/acpi/ac.c                       |   18 ++++--------------
>  drivers/acpi/acpi_memhotplug.c          |   11 ++---------
>  drivers/acpi/battery.c                  |   16 +++++-----------
>  drivers/acpi/container.c                |    8 +-------
>  drivers/acpi/ec.c                       |    6 +-----
>  drivers/acpi/fan.c                      |   12 ------------
>  drivers/acpi/power.c                    |   17 ++---------------
>  drivers/acpi/processor_core.c           |    7 +------
>  drivers/acpi/sbs.c                      |    7 +------
>  drivers/acpi/sbshc.c                    |    9 +--------
>  drivers/acpi/thermal.c                  |   19 +++----------------
>  drivers/acpi/video.c                    |   14 ++------------
>  drivers/hwmon/hp_accel.c                |    6 ------
>  drivers/platform/x86/asus-laptop.c      |    6 ------
>  drivers/platform/x86/asus_acpi.c        |    6 ------
>  drivers/platform/x86/eeepc-laptop.c     |    5 -----
>  drivers/platform/x86/fujitsu-laptop.c   |    6 ------
>  drivers/platform/x86/intel_menlow.c     |    6 ------
>  drivers/platform/x86/panasonic-laptop.c |    9 ---------
>  19 files changed, 23 insertions(+), 165 deletions(-)
> 
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 98b9690..7725bda 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -256,11 +256,8 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
>  static int acpi_ac_add(struct acpi_device *device)
>  {
>  	int result = 0;
> -	struct acpi_ac *ac = NULL;
> -
> +	struct acpi_ac *ac;
>  
> -	if (!device)
> -		return -EINVAL;
>  
>  	ac = kzalloc(sizeof(struct acpi_ac), GFP_KERNEL);
>  	if (!ac)
> @@ -306,11 +303,9 @@ static int acpi_ac_add(struct acpi_device *device)
>  
>  static int acpi_ac_resume(struct acpi_device *device)
>  {
> -	struct acpi_ac *ac;
> +	struct acpi_ac *ac = acpi_driver_data(device);
>  	unsigned old_state;
> -	if (!device || !acpi_driver_data(device))
> -		return -EINVAL;
> -	ac = acpi_driver_data(device);
> +
>  	old_state = ac->state;
>  	if (acpi_ac_get_state(ac))
>  		return 0;
> @@ -323,13 +318,8 @@ static int acpi_ac_resume(struct acpi_device *device)
>  
>  static int acpi_ac_remove(struct acpi_device *device, int type)
>  {
> -	struct acpi_ac *ac = NULL;
> -
> -
> -	if (!device || !acpi_driver_data(device))
> -		return -EINVAL;
> +	struct acpi_ac *ac = acpi_driver_data(device);
>  
> -	ac = acpi_driver_data(device);
>  
>  #ifdef CONFIG_ACPI_SYSFS_POWER
>  	if (ac->charger.dev)
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 28ccdbc..71085b9 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -401,11 +401,8 @@ static void acpi_memory_device_notify(acpi_handle handle, u32 event, void *data)
>  static int acpi_memory_device_add(struct acpi_device *device)
>  {
>  	int result;
> -	struct acpi_memory_device *mem_device = NULL;
> -
> +	struct acpi_memory_device *mem_device;
>  
> -	if (!device)
> -		return -EINVAL;
>  
>  	mem_device = kzalloc(sizeof(struct acpi_memory_device), GFP_KERNEL);
>  	if (!mem_device)
> @@ -450,13 +447,9 @@ static int acpi_memory_device_add(struct acpi_device *device)
>  
>  static int acpi_memory_device_remove(struct acpi_device *device, int type)
>  {
> -	struct acpi_memory_device *mem_device = NULL;
> +	struct acpi_memory_device *mem_device = acpi_driver_data(device);
>  
>  
> -	if (!device || !acpi_driver_data(device))
> -		return -EINVAL;
> -
> -	mem_device = acpi_driver_data(device);
>  	kfree(mem_device);
>  
>  	return 0;
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 3f4602b..90e39d9 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -840,9 +840,8 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
>  static int acpi_battery_add(struct acpi_device *device)
>  {
>  	int result = 0;
> -	struct acpi_battery *battery = NULL;
> -	if (!device)
> -		return -EINVAL;
> +	struct acpi_battery *battery;
> +
>  	battery = kzalloc(sizeof(struct acpi_battery), GFP_KERNEL);
>  	if (!battery)
>  		return -ENOMEM;
> @@ -870,11 +869,8 @@ static int acpi_battery_add(struct acpi_device *device)
>  
>  static int acpi_battery_remove(struct acpi_device *device, int type)
>  {
> -	struct acpi_battery *battery = NULL;
> +	struct acpi_battery *battery = acpi_driver_data(device);
>  
> -	if (!device || !acpi_driver_data(device))
> -		return -EINVAL;
> -	battery = acpi_driver_data(device);
>  #ifdef CONFIG_ACPI_PROCFS_POWER
>  	acpi_battery_remove_fs(device);
>  #endif
> @@ -889,10 +885,8 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
>  /* this is needed to learn about changes made in suspended state */
>  static int acpi_battery_resume(struct acpi_device *device)
>  {
> -	struct acpi_battery *battery;
> -	if (!device)
> -		return -EINVAL;
> -	battery = acpi_driver_data(device);
> +	struct acpi_battery *battery = acpi_driver_data(device);
> +
>  	battery->update_time = 0;
>  	acpi_battery_update(battery);
>  	return 0;
> diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
> index 642bb30..30c4700 100644
> --- a/drivers/acpi/container.c
> +++ b/drivers/acpi/container.c
> @@ -97,11 +97,6 @@ static int acpi_container_add(struct acpi_device *device)
>  	struct acpi_container *container;
>  
>  
> -	if (!device) {
> -		printk(KERN_ERR PREFIX "device is NULL\n");
> -		return -EINVAL;
> -	}
> -
>  	container = kzalloc(sizeof(struct acpi_container), GFP_KERNEL);
>  	if (!container)
>  		return -ENOMEM;
> @@ -120,9 +115,8 @@ static int acpi_container_add(struct acpi_device *device)
>  static int acpi_container_remove(struct acpi_device *device, int type)
>  {
>  	acpi_status status = AE_OK;
> -	struct acpi_container *pc = NULL;
> +	struct acpi_container *pc = acpi_driver_data(device);
>  
> -	pc = acpi_driver_data(device);
>  	kfree(pc);
>  	return status;
>  }
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index add6621..5e93ae3 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -837,13 +837,9 @@ static int acpi_ec_add(struct acpi_device *device)
>  
>  static int acpi_ec_remove(struct acpi_device *device, int type)
>  {
> -	struct acpi_ec *ec;
> +	struct acpi_ec *ec = acpi_driver_data(device);
>  	struct acpi_ec_query_handler *handler, *tmp;
>  
> -	if (!device)
> -		return -EINVAL;
> -
> -	ec = acpi_driver_data(device);
>  	ec_remove_handlers(ec);
>  	mutex_lock(&ec->lock);
>  	list_for_each_entry_safe(handler, tmp, &ec->list, node) {
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index f419849..d40e214 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -244,9 +244,6 @@ static int acpi_fan_add(struct acpi_device *device)
>  	int state = 0;
>  	struct thermal_cooling_device *cdev;
>  
> -	if (!device)
> -		return -EINVAL;
> -
>  	strcpy(acpi_device_name(device), "Fan");
>  	strcpy(acpi_device_class(device), ACPI_FAN_CLASS);
>  
> @@ -300,9 +297,6 @@ static int acpi_fan_remove(struct acpi_device *device, int type)
>  {
>  	struct thermal_cooling_device *cdev = acpi_driver_data(device);
>  
> -	if (!device || !cdev)
> -		return -EINVAL;
> -
>  	acpi_fan_remove_fs(device);
>  	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
>  	sysfs_remove_link(&cdev->device.kobj, "device");
> @@ -313,9 +307,6 @@ static int acpi_fan_remove(struct acpi_device *device, int type)
>  
>  static int acpi_fan_suspend(struct acpi_device *device, pm_message_t state)
>  {
> -	if (!device)
> -		return -EINVAL;
> -
>  	acpi_bus_set_power(device->handle, ACPI_STATE_D0);
>  
>  	return AE_OK;
> @@ -326,9 +317,6 @@ static int acpi_fan_resume(struct acpi_device *device)
>  	int result = 0;
>  	int power_state = 0;
>  
> -	if (!device)
> -		return -EINVAL;
> -
>  	result = acpi_bus_get_power(device->handle, &power_state);
>  	if (result) {
>  		printk(KERN_ERR PREFIX
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index e86603f..2c3d844 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -639,9 +639,6 @@ static int acpi_power_add(struct acpi_device *device)
>  	struct acpi_buffer buffer = { sizeof(acpi_object), &acpi_object };
>  
>  
> -	if (!device)
> -		return -EINVAL;
> -
>  	resource = kzalloc(sizeof(struct acpi_power_resource), GFP_KERNEL);
>  	if (!resource)
>  		return -ENOMEM;
> @@ -695,15 +692,10 @@ static int acpi_power_add(struct acpi_device *device)
>  
>  static int acpi_power_remove(struct acpi_device *device, int type)
>  {
> -	struct acpi_power_resource *resource = NULL;
> +	struct acpi_power_resource *resource = acpi_driver_data(device);
>  	struct list_head *node, *next;
>  
>  
> -	if (!device || !acpi_driver_data(device))
> -		return -EINVAL;
> -
> -	resource = acpi_driver_data(device);
> -
>  	acpi_power_remove_fs(device);
>  
>  	mutex_lock(&resource->resource_lock);
> @@ -722,14 +714,9 @@ static int acpi_power_remove(struct acpi_device *device, int type)
>  static int acpi_power_resume(struct acpi_device *device)
>  {
>  	int result = 0, state;
> -	struct acpi_power_resource *resource = NULL;
> +	struct acpi_power_resource *resource = acpi_driver_data(device);
>  	struct acpi_power_reference *ref;
>  
> -	if (!device || !acpi_driver_data(device))
> -		return -EINVAL;
> -
> -	resource = acpi_driver_data(device);
> -
>  	result = acpi_power_get_state(device->handle, &state);
>  	if (result)
>  		return result;
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index c2d4d6e..38ad5ef 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -888,13 +888,8 @@ err_free_cpumask:
>  
>  static int acpi_processor_remove(struct acpi_device *device, int type)
>  {
> -	struct acpi_processor *pr = NULL;
> -
> -
> -	if (!device || !acpi_driver_data(device))
> -		return -EINVAL;
> +	struct acpi_processor *pr = acpi_driver_data(device);
>  
> -	pr = acpi_driver_data(device);
>  
>  	if (pr->id >= nr_cpu_ids)
>  		goto free;
> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index 52b9db8..4c7ab39 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -960,12 +960,9 @@ static int acpi_sbs_add(struct acpi_device *device)
>  
>  static int acpi_sbs_remove(struct acpi_device *device, int type)
>  {
> -	struct acpi_sbs *sbs;
> +	struct acpi_sbs *sbs = acpi_driver_data(device);
>  	int id;
>  
> -	if (!device)
> -		return -EINVAL;
> -	sbs = acpi_driver_data(device);
>  	if (!sbs)
>  		return -EINVAL;
>  	mutex_lock(&sbs->lock);
> @@ -996,8 +993,6 @@ static void acpi_sbs_rmdirs(void)
>  static int acpi_sbs_resume(struct acpi_device *device)
>  {
>  	struct acpi_sbs *sbs;
> -	if (!device)
> -		return -EINVAL;

Nit: I'd pull the sbs initialization up and use acpi_driver_data()
as in acpi_sbs_remove().  And add a blank line.

>  	sbs = device->driver_data;
>  	acpi_sbs_callback(sbs);
>  	return 0;
> diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
> index 8d89337..9e06e9c 100644
> --- a/drivers/acpi/sbshc.c
> +++ b/drivers/acpi/sbshc.c
> @@ -262,9 +262,6 @@ static int acpi_smbus_hc_add(struct acpi_device *device)
>  	unsigned long long val;
>  	struct acpi_smb_hc *hc;
>  
> -	if (!device)
> -		return -EINVAL;
> -
>  	status = acpi_evaluate_integer(device->handle, "_EC", NULL, &val);
>  	if (ACPI_FAILURE(status)) {
>  		printk(KERN_ERR PREFIX "error obtaining _EC.\n");
> @@ -296,12 +293,8 @@ extern void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit);
>  
>  static int acpi_smbus_hc_remove(struct acpi_device *device, int type)
>  {
> -	struct acpi_smb_hc *hc;
> -
> -	if (!device)
> -		return -EINVAL;
> +	struct acpi_smb_hc *hc = acpi_driver_data(device);
>  
> -	hc = acpi_driver_data(device);
>  	acpi_ec_remove_query_handler(hc->ec, hc->query_bit);
>  	kfree(hc);
>  	return 0;
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 65f6781..fca61a1 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -1361,12 +1361,9 @@ static void acpi_thermal_guess_offset(struct acpi_thermal *tz)
>  static int acpi_thermal_add(struct acpi_device *device)
>  {
>  	int result = 0;
> -	struct acpi_thermal *tz = NULL;
> +	struct acpi_thermal *tz;
>  
>  
> -	if (!device)
> -		return -EINVAL;
> -
>  	tz = kzalloc(sizeof(struct acpi_thermal), GFP_KERNEL);
>  	if (!tz)
>  		return -ENOMEM;
> @@ -1408,12 +1405,7 @@ end:
>  
>  static int acpi_thermal_remove(struct acpi_device *device, int type)
>  {
> -	struct acpi_thermal *tz = NULL;
> -
> -	if (!device || !acpi_driver_data(device))
> -		return -EINVAL;
> -
> -	tz = acpi_driver_data(device);
> +	struct acpi_thermal *tz = acpi_driver_data(device);
>  
>  	acpi_thermal_remove_fs(device);
>  	acpi_thermal_unregister_thermal_zone(tz);
> @@ -1424,15 +1416,10 @@ static int acpi_thermal_remove(struct acpi_device *device, int type)
>  
>  static int acpi_thermal_resume(struct acpi_device *device)
>  {
> -	struct acpi_thermal *tz = NULL;
> +	struct acpi_thermal *tz = acpi_driver_data(device);
>  	int i, j, power_state, result;
>  
>  
> -	if (!device || !acpi_driver_data(device))
> -		return -EINVAL;
> -
> -	tz = acpi_driver_data(device);
> -
>  	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
>  		if (!(&tz->trips.active[i]))
>  			break;
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index f405807..576a600 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -2207,15 +2207,10 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
>  static int instance;
>  static int acpi_video_resume(struct acpi_device *device)
>  {
> -	struct acpi_video_bus *video;
> +	struct acpi_video_bus *video = acpi_driver_data(device);
>  	struct acpi_video_device *video_device;
>  	int i;
>  
> -	if (!device || !acpi_driver_data(device))
> -		return -EINVAL;
> -
> -	video = acpi_driver_data(device);
> -
>  	for (i = 0; i < video->attached_count; i++) {
>  		video_device = video->attached_array[i].bind_info;
>  		if (video_device && video_device->backlight)
> @@ -2351,13 +2346,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
>  
>  static int acpi_video_bus_remove(struct acpi_device *device, int type)
>  {
> -	struct acpi_video_bus *video = NULL;
> -
> -
> -	if (!device || !acpi_driver_data(device))
> -		return -EINVAL;
> +	struct acpi_video_bus *video = acpi_driver_data(device);
>  
> -	video = acpi_driver_data(device);
>  
>  	acpi_video_bus_stop_devices(video);
>  	acpi_video_bus_put_devices(video);
> diff --git a/drivers/hwmon/hp_accel.c b/drivers/hwmon/hp_accel.c
> index 6679854..c8d3c88 100644
> --- a/drivers/hwmon/hp_accel.c
> +++ b/drivers/hwmon/hp_accel.c
> @@ -275,9 +275,6 @@ static int lis3lv02d_add(struct acpi_device *device)
>  {
>  	int ret;
>  
> -	if (!device)
> -		return -EINVAL;
> -
>  	lis3_dev.bus_priv = device;
>  	lis3_dev.init = lis3lv02d_acpi_init;
>  	lis3_dev.read = lis3lv02d_acpi_read;
> @@ -315,9 +312,6 @@ static int lis3lv02d_add(struct acpi_device *device)
>  
>  static int lis3lv02d_remove(struct acpi_device *device, int type)
>  {
> -	if (!device)
> -		return -EINVAL;
> -
>  	lis3lv02d_joystick_disable();
>  	lis3lv02d_poweroff(&lis3_dev);

Same basic issue as the kfree comments below; the fact that this
remove method doesn't reference "device" is a symptom of a driver
structure problem (beyond the scope of this patch, obviously).

> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
> index b39d2bb..8af43e9 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -1240,9 +1240,6 @@ static int asus_hotk_add(struct acpi_device *device)
>  {
>  	int result;
>  
> -	if (!device)
> -		return -EINVAL;
> -
>  	pr_notice("Asus Laptop Support version %s\n",
>  	       ASUS_LAPTOP_VERSION);
>  
> @@ -1306,9 +1303,6 @@ end:
>  
>  static int asus_hotk_remove(struct acpi_device *device, int type)
>  {
> -	if (!device || !acpi_driver_data(device))
> -		return -EINVAL;
> -
>  	kfree(hotk->name);
>  	kfree(hotk);

Separate issue: we should kfree acpi_driver_data(device) here,
not "hotk".  In general, the "remove" should deal with per-device
data, not globals.  This driver only deals with a single instance,
so they happen to be the same in this case, but you have to read
more of the driver to verify that.

>  
> diff --git a/drivers/platform/x86/asus_acpi.c b/drivers/platform/x86/asus_acpi.c
> index ddf5240..25a7d57 100644
> --- a/drivers/platform/x86/asus_acpi.c
> +++ b/drivers/platform/x86/asus_acpi.c
> @@ -1334,9 +1334,6 @@ static int asus_hotk_add(struct acpi_device *device)
>  	acpi_status status = AE_OK;
>  	int result;
>  
> -	if (!device)
> -		return -EINVAL;
> -
>  	printk(KERN_NOTICE "Asus Laptop ACPI Extras version %s\n",
>  	       ASUS_ACPI_VERSION);
>  
> @@ -1392,9 +1389,6 @@ end:
>  
>  static int asus_hotk_remove(struct acpi_device *device, int type)
>  {
> -	if (!device || !acpi_driver_data(device))
> -		return -EINVAL;
> -
>  	asus_hotk_remove_fs(device);
>  
>  	kfree(hotk);

The kfree comment above applies here, too.

> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
> index da3c08b..e7f14a4 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -1194,8 +1194,6 @@ static int eeepc_hotk_add(struct acpi_device *device)
>  	struct device *dev;
>  	int result;
>  
> -	if (!device)
> -		return -EINVAL;
>  	pr_notice(EEEPC_HOTK_NAME "\n");
>  	ehotk = kzalloc(sizeof(struct eeepc_hotk), GFP_KERNEL);
>  	if (!ehotk)
> @@ -1276,9 +1274,6 @@ fail_platform_driver:
>  
>  static int eeepc_hotk_remove(struct acpi_device *device, int type)
>  {
> -	if (!device || !acpi_driver_data(device))
> -		return -EINVAL;
> -
>  	eeepc_backlight_exit();
>  	eeepc_rfkill_exit();
>  	eeepc_input_exit();

The current upstream version of this function also has the kfree
issue.  You're patching a different version, so it might be fixed
there already.  But it seems like all these hotkey drivers (and the
accelerometer driver) use the same pattern of assuming they'll only
see a single device, and then they make assumptions like "hotk ==
acpi_driver_data(device)".  That's just a bad example for people
to follow, and might not even be true for things like accelerometers
where you could imagine having more than one.

> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index f35aee5..2ab0318 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -657,9 +657,6 @@ static int acpi_fujitsu_add(struct acpi_device *device)
>  	struct input_dev *input;
>  	int error;
>  
> -	if (!device)
> -		return -EINVAL;
> -
>  	fujitsu->acpi_handle = device->handle;
>  	sprintf(acpi_device_name(device), "%s", ACPI_FUJITSU_DEVICE_NAME);
>  	sprintf(acpi_device_class(device), "%s", ACPI_FUJITSU_CLASS);
> @@ -813,9 +810,6 @@ static int acpi_fujitsu_hotkey_add(struct acpi_device *device)
>  	int error;
>  	int i;
>  
> -	if (!device)
> -		return -EINVAL;
> -
>  	fujitsu_hotkey->acpi_handle = device->handle;
>  	sprintf(acpi_device_name(device), "%s",
>  		ACPI_FUJITSU_HOTKEY_DEVICE_NAME);
> diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
> index 29432a5..58de8fd 100644
> --- a/drivers/platform/x86/intel_menlow.c
> +++ b/drivers/platform/x86/intel_menlow.c
> @@ -156,9 +156,6 @@ static int intel_menlow_memory_add(struct acpi_device *device)
>  	acpi_handle dummy;
>  	struct thermal_cooling_device *cdev;
>  
> -	if (!device)
> -		return -EINVAL;
> -
>  	status = acpi_get_handle(device->handle, MEMORY_GET_BANDWIDTH, &dummy);
>  	if (ACPI_FAILURE(status))
>  		goto end;
> @@ -200,9 +197,6 @@ static int intel_menlow_memory_remove(struct acpi_device *device, int type)
>  {
>  	struct thermal_cooling_device *cdev = acpi_driver_data(device);
>  
> -	if (!device || !cdev)
> -		return -EINVAL;
> -
>  	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
>  	sysfs_remove_link(&cdev->device.kobj, "device");
>  	thermal_cooling_device_unregister(cdev);
> diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
> index fe7cf01..953b60c 100644
> --- a/drivers/platform/x86/panasonic-laptop.c
> +++ b/drivers/platform/x86/panasonic-laptop.c
> @@ -588,9 +588,6 @@ static int acpi_pcc_hotkey_resume(struct acpi_device *device)
>  	struct pcc_acpi *pcc = acpi_driver_data(device);
>  	acpi_status status = AE_OK;
>  
> -	if (device == NULL || pcc == NULL)
> -		return -EINVAL;
> -
>  	ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Sticky mode restore: %d\n",
>  			  pcc->sticky_mode));
>  
> @@ -604,9 +601,6 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
>  	struct pcc_acpi *pcc;
>  	int num_sifr, result;
>  
> -	if (!device)
> -		return -EINVAL;
> -
>  	num_sifr = acpi_pcc_get_sqty(device);
>  
>  	if (num_sifr > 255) {
> @@ -703,9 +697,6 @@ static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type)
>  {
>  	struct pcc_acpi *pcc = acpi_driver_data(device);
>  
> -	if (!device || !pcc)
> -		return -EINVAL;
> -
>  	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
>  
>  	backlight_device_unregister(pcc->backlight);


