From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: use integers rather than strings for thermal
	values
Date: Fri, 28 Nov 2008 10:52:41 +0800
Message-ID: <1227840761.2684.21.camel@rzhang-dt>
References: <20081127174813.GA24258@srcf.ucam.org>
	 <20081127174956.GB24258@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58305 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbYK1CyB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Nov 2008 21:54:01 -0500
In-Reply-To: <20081127174956.GB24258@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Thomas, Sujith" <sujith.thomas@intel.com>

On Fri, 2008-11-28 at 01:49 +0800, Matthew Garrett wrote:
> The thermal API currently uses strings to pass values to userspace. This makes
> it difficult to use from within the kernel. Change the interface to use
> integers and fix up the ACPI consumers.

> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>

> ---
> 
> Resend - managed to get Len's address wrong the first time.
> 
>  drivers/acpi/fan.c               |   20 +++++---
>  drivers/acpi/processor_thermal.c |   20 +++++----
>  drivers/acpi/thermal.c           |   80 +++++++++++++++++++++------------
>  drivers/acpi/video.c             |   22 +++++----
>  drivers/misc/intel_menlow.c      |   29 ++++--------
>  drivers/thermal/thermal_sys.c    |   91 ++++++++++++++++++++++++++++++++-----
>  include/linux/thermal.h          |   32 ++++++++++---
>  7 files changed, 198 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index eaaee16..ae41cf3 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -68,31 +68,35 @@ static struct acpi_driver acpi_fan_driver = {
>  };
> 
>  /* thermal cooling device callbacks */
> -static int fan_get_max_state(struct thermal_cooling_device *cdev, char *buf)
> +static int fan_get_max_state(struct thermal_cooling_device *cdev, unsigned long
> +                            *state)
>  {
>         /* ACPI fan device only support two states: ON/OFF */
> -       return sprintf(buf, "1\n");
> +       *state = 1;
> +       return 0;
>  }
> 
> -static int fan_get_cur_state(struct thermal_cooling_device *cdev, char *buf)
> +static int fan_get_cur_state(struct thermal_cooling_device *cdev, unsigned long
> +                            *state)
>  {
>         struct acpi_device *device = cdev->devdata;
> -       int state;
>         int result;
> +       int acpi_state;
> 
>         if (!device)
>                 return -EINVAL;
> 
> -       result = acpi_bus_get_power(device->handle, &state);
> +       result = acpi_bus_get_power(device->handle, &acpi_state);
>         if (result)
>                 return result;
> 
> -       return sprintf(buf, "%s\n", state == ACPI_STATE_D3 ? "0" :
> -                        (state == ACPI_STATE_D0 ? "1" : "unknown"));
> +       *state = (acpi_state == ACPI_STATE_D3 ? 0 :
> +                (acpi_state == ACPI_STATE_D0 ? 1 : -1));
> +       return 0;
>  }
> 
>  static int
> -fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned int state)
> +fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
>  {
>         struct acpi_device *device = cdev->devdata;
>         int result;
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> index b1eb376..0e47e29 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -373,7 +373,8 @@ static int acpi_processor_max_state(struct acpi_processor *pr)
>         return max_state;
>  }
>  static int
> -processor_get_max_state(struct thermal_cooling_device *cdev, char *buf)
> +processor_get_max_state(struct thermal_cooling_device *cdev,
> +                       unsigned long *state)
>  {
>         struct acpi_device *device = cdev->devdata;
>         struct acpi_processor *pr = acpi_driver_data(device);
> @@ -381,28 +382,29 @@ processor_get_max_state(struct thermal_cooling_device *cdev, char *buf)
>         if (!device || !pr)
>                 return -EINVAL;
> 
> -       return sprintf(buf, "%d\n", acpi_processor_max_state(pr));
> +       *state = acpi_processor_max_state(pr);
> +       return 0;
>  }
> 
>  static int
> -processor_get_cur_state(struct thermal_cooling_device *cdev, char *buf)
> +processor_get_cur_state(struct thermal_cooling_device *cdev,
> +                       unsigned long *cur_state)
>  {
>         struct acpi_device *device = cdev->devdata;
>         struct acpi_processor *pr = acpi_driver_data(device);
> -       int cur_state;
> 
>         if (!device || !pr)
>                 return -EINVAL;
> 
> -       cur_state = cpufreq_get_cur_state(pr->id);
> +       *cur_state = cpufreq_get_cur_state(pr->id);
>         if (pr->flags.throttling)
> -               cur_state += pr->throttling.state;
> -
> -       return sprintf(buf, "%d\n", cur_state);
> +               *cur_state += pr->throttling.state;
> +       return 0;
>  }
> 
>  static int
> -processor_set_cur_state(struct thermal_cooling_device *cdev, unsigned int state)
> +processor_set_cur_state(struct thermal_cooling_device *cdev,
> +                       unsigned long state)
>  {
>         struct acpi_device *device = cdev->devdata;
>         struct acpi_processor *pr = acpi_driver_data(device);
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 073ff09..f24c7cc 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -946,7 +946,8 @@ static void acpi_thermal_check(void *data)
>  /* sys I/F for generic thermal sysfs support */
>  #define KELVIN_TO_MILLICELSIUS(t) (t * 100 - 273200)
> 
> -static int thermal_get_temp(struct thermal_zone_device *thermal, char *buf)
> +static int thermal_get_temp(struct thermal_zone_device *thermal,
> +                           unsigned long *temp)
>  {
>         struct acpi_thermal *tz = thermal->devdata;
>         int result;
> @@ -958,25 +959,28 @@ static int thermal_get_temp(struct thermal_zone_device *thermal, char *buf)
>         if (result)
>                 return result;
> 
> -       return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(tz->temperature));
> +       *temp = KELVIN_TO_MILLICELSIUS(tz->temperature);
> +       return 0;
>  }
> 
>  static const char enabled[] = "kernel";
>  static const char disabled[] = "user";
>  static int thermal_get_mode(struct thermal_zone_device *thermal,
> -                               char *buf)
> +                               enum thermal_device_mode *mode)
>  {
>         struct acpi_thermal *tz = thermal->devdata;
> 
>         if (!tz)
>                 return -EINVAL;
> 
> -       return sprintf(buf, "%s\n", tz->tz_enabled ?
> -                       enabled : disabled);
> +       *mode = tz->tz_enabled ? THERMAL_DEVICE_ENABLED :
> +               THERMAL_DEVICE_DISABLED;
> +
> +       return 0;
>  }
> 
>  static int thermal_set_mode(struct thermal_zone_device *thermal,
> -                               const char *buf)
> +                               enum thermal_device_mode mode)
>  {
>         struct acpi_thermal *tz = thermal->devdata;
>         int enable;
> @@ -987,9 +991,9 @@ static int thermal_set_mode(struct thermal_zone_device *thermal,
>         /*
>          * enable/disable thermal management from ACPI thermal driver
>          */
> -       if (!strncmp(buf, enabled, sizeof enabled - 1))
> +       if (mode == THERMAL_DEVICE_ENABLED)
>                 enable = 1;
> -       else if (!strncmp(buf, disabled, sizeof disabled - 1))
> +       else if (mode == THERMAL_DEVICE_DISABLED)
>                 enable = 0;
>         else
>                 return -EINVAL;
> @@ -1005,7 +1009,7 @@ static int thermal_set_mode(struct thermal_zone_device *thermal,
>  }
> 
>  static int thermal_get_trip_type(struct thermal_zone_device *thermal,
> -                                int trip, char *buf)
> +                                int trip, enum thermal_trip_type *type)
>  {
>         struct acpi_thermal *tz = thermal->devdata;
>         int i;
> @@ -1014,27 +1018,35 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
>                 return -EINVAL;
> 
>         if (tz->trips.critical.flags.valid) {
> -               if (!trip)
> -                       return sprintf(buf, "critical\n");
> +               if (!trip) {
> +                       *type = THERMAL_TRIP_CRITICAL;
> +                       return 0;
> +               }
>                 trip--;
>         }
> 
>         if (tz->trips.hot.flags.valid) {
> -               if (!trip)
> -                       return sprintf(buf, "hot\n");
> +               if (!trip) {
> +                       *type = THERMAL_TRIP_HOT;
> +                       return 0;
> +               }
>                 trip--;
>         }
> 
>         if (tz->trips.passive.flags.valid) {
> -               if (!trip)
> -                       return sprintf(buf, "passive\n");
> +               if (!trip) {
> +                       *type = THERMAL_TRIP_PASSIVE;
> +                       return 0;
> +               }
>                 trip--;
>         }
> 
>         for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
>                 tz->trips.active[i].flags.valid; i++) {
> -               if (!trip)
> -                       return sprintf(buf, "active%d\n", i);
> +               if (!trip) {
> +                       *type = THERMAL_TRIP_ACTIVE;
> +                       return 0;
> +               }
>                 trip--;
>         }
> 
> @@ -1042,7 +1054,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
>  }
> 
>  static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
> -                                int trip, char *buf)
> +                                int trip, unsigned long *temp)
>  {
>         struct acpi_thermal *tz = thermal->devdata;
>         int i;
> @@ -1051,31 +1063,39 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
>                 return -EINVAL;
> 
>         if (tz->trips.critical.flags.valid) {
> -               if (!trip)
> -                       return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
> -                               tz->trips.critical.temperature));
> +               if (!trip) {
> +                       *temp = KELVIN_TO_MILLICELSIUS(
> +                               tz->trips.critical.temperature);
> +                       return 0;
> +               }
>                 trip--;
>         }
> 
>         if (tz->trips.hot.flags.valid) {
> -               if (!trip)
> -                       return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
> -                                       tz->trips.hot.temperature));
> +               if (!trip) {
> +                       *temp = KELVIN_TO_MILLICELSIUS(
> +                               tz->trips.hot.temperature);
> +                       return 0;
> +               }
>                 trip--;
>         }
> 
>         if (tz->trips.passive.flags.valid) {
> -               if (!trip)
> -                       return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
> -                                       tz->trips.passive.temperature));
> +               if (!trip) {
> +                       *temp = KELVIN_TO_MILLICELSIUS(
> +                               tz->trips.passive.temperature);
> +                       return 0;
> +               }
>                 trip--;
>         }
> 
>         for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
>                 tz->trips.active[i].flags.valid; i++) {
> -               if (!trip)
> -                       return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
> -                                       tz->trips.active[i].temperature));
> +               if (!trip) {
> +                       *temp = KELVIN_TO_MILLICELSIUS(
> +                               tz->trips.active[i].temperature);
> +                       return 0;
> +               }
>                 trip--;
>         }
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index baa4419..5b2f1f3 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -357,32 +357,36 @@ static struct output_properties acpi_output_properties = {
> 
> 
>  /* thermal cooling device callbacks */
> -static int video_get_max_state(struct thermal_cooling_device *cdev, char *buf)
> +static int video_get_max_state(struct thermal_cooling_device *cdev, unsigned
> +                              long *state)
>  {
>         struct acpi_device *device = cdev->devdata;
>         struct acpi_video_device *video = acpi_driver_data(device);
> 
> -       return sprintf(buf, "%d\n", video->brightness->count - 3);
> +       *state = video->brightness->count - 3;
> +       return 0;
>  }
> 
> -static int video_get_cur_state(struct thermal_cooling_device *cdev, char *buf)
> +static int video_get_cur_state(struct thermal_cooling_device *cdev, unsigned
> +                              long *state)
>  {
>         struct acpi_device *device = cdev->devdata;
>         struct acpi_video_device *video = acpi_driver_data(device);
>         unsigned long long level;
> -       int state;
> +       int offset;
> 
>         acpi_video_device_lcd_get_level_current(video, &level);
> -       for (state = 2; state < video->brightness->count; state++)
> -               if (level == video->brightness->levels[state])
> -                       return sprintf(buf, "%d\n",
> -                                      video->brightness->count - state - 1);
> +       for (offset = 2; offset < video->brightness->count; offset++)
> +               if (level == video->brightness->levels[offset]) {
> +                       *state = video->brightness->count - offset - 1;
> +                       return 0;
> +               }
> 
>         return -EINVAL;
>  }
> 
>  static int
> -video_set_cur_state(struct thermal_cooling_device *cdev, unsigned int state)
> +video_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
>  {
>         struct acpi_device *device = cdev->devdata;
>         struct acpi_video_device *video = acpi_driver_data(device);
> diff --git a/drivers/misc/intel_menlow.c b/drivers/misc/intel_menlow.c
> index 27b7662..29432a5 100644
> --- a/drivers/misc/intel_menlow.c
> +++ b/drivers/misc/intel_menlow.c
> @@ -57,8 +57,8 @@ MODULE_LICENSE("GPL");
>   * In that case max_cstate would be n-1
>   * GTHS returning '0' would mean that no bandwidth control states are supported
>   */
> -static int memory_get_int_max_bandwidth(struct thermal_cooling_device *cdev,
> -                                       unsigned long *max_state)
> +static int memory_get_max_bandwidth(struct thermal_cooling_device *cdev,
> +                                   unsigned long *max_state)
>  {
>         struct acpi_device *device = cdev->devdata;
>         acpi_handle handle = device->handle;
> @@ -83,22 +83,12 @@ static int memory_get_int_max_bandwidth(struct thermal_cooling_device *cdev,
>         return 0;
>  }
> 
> -static int memory_get_max_bandwidth(struct thermal_cooling_device *cdev,
> -                                   char *buf)
> -{
> -       unsigned long value;
> -       if (memory_get_int_max_bandwidth(cdev, &value))
> -               return -EINVAL;
> -
> -       return sprintf(buf, "%ld\n", value);
> -}
> -
>  static int memory_get_cur_bandwidth(struct thermal_cooling_device *cdev,
> -                                   char *buf)
> +                                   unsigned long *value)
>  {
>         struct acpi_device *device = cdev->devdata;
>         acpi_handle handle = device->handle;
> -       unsigned long long value;
> +       unsigned long long result;
>         struct acpi_object_list arg_list;
>         union acpi_object arg;
>         acpi_status status = AE_OK;
> @@ -108,15 +98,16 @@ static int memory_get_cur_bandwidth(struct thermal_cooling_device *cdev,
>         arg.type = ACPI_TYPE_INTEGER;
>         arg.integer.value = MEMORY_ARG_CUR_BANDWIDTH;
>         status = acpi_evaluate_integer(handle, MEMORY_GET_BANDWIDTH,
> -                                      &arg_list, &value);
> +                                      &arg_list, &result);
>         if (ACPI_FAILURE(status))
>                 return -EFAULT;
> 
> -       return sprintf(buf, "%llu\n", value);
> +       *value = result;
> +       return 0;
>  }
> 
>  static int memory_set_cur_bandwidth(struct thermal_cooling_device *cdev,
> -                                   unsigned int state)
> +                                   unsigned long state)
>  {
>         struct acpi_device *device = cdev->devdata;
>         acpi_handle handle = device->handle;
> @@ -126,7 +117,7 @@ static int memory_set_cur_bandwidth(struct thermal_cooling_device *cdev,
>         unsigned long long temp;
>         unsigned long max_state;
> 
> -       if (memory_get_int_max_bandwidth(cdev, &max_state))
> +       if (memory_get_max_bandwidth(cdev, &max_state))
>                 return -EFAULT;
> 
>         if (state > max_state)
> @@ -142,7 +133,7 @@ static int memory_set_cur_bandwidth(struct thermal_cooling_device *cdev,
>                                   &temp);
> 
>         printk(KERN_INFO
> -              "Bandwidth value was %d: status is %d\n", state, status);
> +              "Bandwidth value was %ld: status is %d\n", state, status);
>         if (ACPI_FAILURE(status))
>                 return -EFAULT;
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index fe07462..7bcf322 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -104,22 +104,36 @@ static ssize_t
>  temp_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>         struct thermal_zone_device *tz = to_thermal_zone(dev);
> +       long temperature;
> +       int ret;
> 
>         if (!tz->ops->get_temp)
>                 return -EPERM;
> 
> -       return tz->ops->get_temp(tz, buf);
> +       ret = tz->ops->get_temp(tz, &temperature);
> +
> +       if (ret)
> +               return ret;
> +
> +       return sprintf(buf, "%ld\n", temperature);
>  }
> 
>  static ssize_t
>  mode_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>         struct thermal_zone_device *tz = to_thermal_zone(dev);
> +       enum thermal_device_mode mode;
> +       int result;
> 
>         if (!tz->ops->get_mode)
>                 return -EPERM;
> 
> -       return tz->ops->get_mode(tz, buf);
> +       result = tz->ops->get_mode(tz, &mode);
> +       if (result)
> +               return result;
> +
> +       return sprintf(buf, "%s\n", mode == THERMAL_DEVICE_ENABLED ? "enabled"
> +                      : "disabled");
>  }
> 
>  static ssize_t
> @@ -132,7 +146,13 @@ mode_store(struct device *dev, struct device_attribute *attr,
>         if (!tz->ops->set_mode)
>                 return -EPERM;
> 
> -       result = tz->ops->set_mode(tz, buf);
> +       if (!strncmp(buf, "enabled", sizeof("enabled")))
> +               result = tz->ops->set_mode(tz, THERMAL_DEVICE_ENABLED);
> +       else if (!strncmp(buf, "disabled", sizeof("disabled")))
> +               result = tz->ops->set_mode(tz, THERMAL_DEVICE_DISABLED);
> +       else
> +               result = -EINVAL;
> +
>         if (result)
>                 return result;
> 
> @@ -144,7 +164,8 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
>                      char *buf)
>  {
>         struct thermal_zone_device *tz = to_thermal_zone(dev);
> -       int trip;
> +       enum thermal_trip_type type;
> +       int trip, result;
> 
>         if (!tz->ops->get_trip_type)
>                 return -EPERM;
> @@ -152,7 +173,22 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
>         if (!sscanf(attr->attr.name, "trip_point_%d_type", &trip))
>                 return -EINVAL;
> 
> -       return tz->ops->get_trip_type(tz, trip, buf);
> +       result = tz->ops->get_trip_type(tz, trip, &type);
> +       if (result)
> +               return result;
> +
> +       switch (type) {
> +       case THERMAL_TRIP_CRITICAL:
> +               return sprintf(buf, "critical");
> +       case THERMAL_TRIP_HOT:
> +               return sprintf(buf, "hot");
> +       case THERMAL_TRIP_PASSIVE:
> +               return sprintf(buf, "passive");
> +       case THERMAL_TRIP_ACTIVE:
> +               return sprintf(buf, "active");
> +       default:
> +               return sprintf(buf, "unknown");
> +       }
>  }
> 
>  static ssize_t
> @@ -160,7 +196,8 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
>                      char *buf)
>  {
>         struct thermal_zone_device *tz = to_thermal_zone(dev);
> -       int trip;
> +       int trip, ret;
> +       long temperature;
> 
>         if (!tz->ops->get_trip_temp)
>                 return -EPERM;
> @@ -168,7 +205,12 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
>         if (!sscanf(attr->attr.name, "trip_point_%d_temp", &trip))
>                 return -EINVAL;
> 
> -       return tz->ops->get_trip_temp(tz, trip, buf);
> +       ret = tz->ops->get_trip_temp(tz, trip, &temperature);
> +
> +       if (ret)
> +               return ret;
> +
> +       return sprintf(buf, "%ld\n", temperature);
>  }
> 
>  static DEVICE_ATTR(type, 0444, type_show, NULL);
> @@ -236,8 +278,13 @@ thermal_cooling_device_max_state_show(struct device *dev,
>                                       struct device_attribute *attr, char *buf)
>  {
>         struct thermal_cooling_device *cdev = to_cooling_device(dev);
> +       unsigned long state;
> +       int ret;
> 
> -       return cdev->ops->get_max_state(cdev, buf);
> +       ret = cdev->ops->get_max_state(cdev, &state);
> +       if (ret)
> +               return ret;
> +       return sprintf(buf, "%ld\n", state);
>  }
> 
>  static ssize_t
> @@ -245,8 +292,13 @@ thermal_cooling_device_cur_state_show(struct device *dev,
>                                       struct device_attribute *attr, char *buf)
>  {
>         struct thermal_cooling_device *cdev = to_cooling_device(dev);
> +       unsigned long state;
> +       int ret;
> 
> -       return cdev->ops->get_cur_state(cdev, buf);
> +       ret = cdev->ops->get_cur_state(cdev, &state);
> +       if (ret)
> +               return ret;
> +       return sprintf(buf, "%ld\n", state);
>  }
> 
>  static ssize_t
> @@ -255,10 +307,10 @@ thermal_cooling_device_cur_state_store(struct device *dev,
>                                        const char *buf, size_t count)
>  {
>         struct thermal_cooling_device *cdev = to_cooling_device(dev);
> -       int state;
> +       unsigned long state;
>         int result;
> 
> -       if (!sscanf(buf, "%d\n", &state))
> +       if (!sscanf(buf, "%ld\n", &state))
>                 return -EINVAL;
> 
>         if (state < 0)
> @@ -312,13 +364,20 @@ static DEVICE_ATTR(name, 0444, name_show, NULL);
>  static ssize_t
>  temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> +       long temperature;
> +       int ret;
>         struct thermal_hwmon_attr *hwmon_attr
>                         = container_of(attr, struct thermal_hwmon_attr, attr);
>         struct thermal_zone_device *tz
>                         = container_of(hwmon_attr, struct thermal_zone_device,
>                                        temp_input);
> 
> -       return tz->ops->get_temp(tz, buf);
> +       ret = tz->ops->get_temp(tz, &temperature);
> +
> +       if (ret)
> +               return ret;
> +
> +       return sprintf(buf, "%ld\n", temperature);
>  }
> 
>  static ssize_t
> @@ -330,8 +389,14 @@ temp_crit_show(struct device *dev, struct device_attribute *attr,
>         struct thermal_zone_device *tz
>                         = container_of(hwmon_attr, struct thermal_zone_device,
>                                        temp_crit);
> +       long temperature;
> +       int ret;
> +
> +       ret = tz->ops->get_trip_temp(tz, 0, &temperature);
> +       if (ret)
> +               return ret;
> 
> -       return tz->ops->get_trip_temp(tz, 0, buf);
> +       return sprintf(buf, "%ld\n", temperature);
>  }
> 
> 
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 917707e..4cb3292 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -31,23 +31,39 @@
>  struct thermal_zone_device;
>  struct thermal_cooling_device;
> 
> +enum thermal_device_mode {
> +       THERMAL_DEVICE_DISABLED = 0,
> +       THERMAL_DEVICE_ENABLED,
> +};
> +
> +enum thermal_trip_type {
> +       THERMAL_TRIP_ACTIVE = 0,
> +       THERMAL_TRIP_PASSIVE,
> +       THERMAL_TRIP_HOT,
> +       THERMAL_TRIP_CRITICAL,
> +};
> +
>  struct thermal_zone_device_ops {
>         int (*bind) (struct thermal_zone_device *,
>                      struct thermal_cooling_device *);
>         int (*unbind) (struct thermal_zone_device *,
>                        struct thermal_cooling_device *);
> -       int (*get_temp) (struct thermal_zone_device *, char *);
> -       int (*get_mode) (struct thermal_zone_device *, char *);
> -       int (*set_mode) (struct thermal_zone_device *, const char *);
> -       int (*get_trip_type) (struct thermal_zone_device *, int, char *);
> -       int (*get_trip_temp) (struct thermal_zone_device *, int, char *);
> +       int (*get_temp) (struct thermal_zone_device *, unsigned long *);
> +       int (*get_mode) (struct thermal_zone_device *,
> +                        enum thermal_device_mode *);
> +       int (*set_mode) (struct thermal_zone_device *,
> +               enum thermal_device_mode);
> +       int (*get_trip_type) (struct thermal_zone_device *, int,
> +               enum thermal_trip_type *);
> +       int (*get_trip_temp) (struct thermal_zone_device *, int,
> +                             unsigned long *);
>         int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *);
>  };
> 
>  struct thermal_cooling_device_ops {
> -       int (*get_max_state) (struct thermal_cooling_device *, char *);
> -       int (*get_cur_state) (struct thermal_cooling_device *, char *);
> -       int (*set_cur_state) (struct thermal_cooling_device *, unsigned int);
> +       int (*get_max_state) (struct thermal_cooling_device *, unsigned long *);
> +       int (*get_cur_state) (struct thermal_cooling_device *, unsigned long *);
> +       int (*set_cur_state) (struct thermal_cooling_device *, unsigned long);
>  };
> 
>  #define THERMAL_TRIPS_NONE -1
> 
> --
> Matthew Garrett | mjg59@srcf.ucam.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

