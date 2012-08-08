From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [PATCH V4 05/13] Thermal: Remove tc1/tc2 in generic thermal layer.
Date: Wed, 8 Aug 2012 17:06:04 +0300
Message-ID: <CAGF5oy9DMdCFL41dGD8CBq_+VT_dTtsTrVjdTphmmxFdNr2j9g@mail.gmail.com>
References: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
	<1343292083-2047-6-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:46893 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754763Ab2HHOGG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Aug 2012 10:06:06 -0400
Received: by obc16 with SMTP id 16so1290060obc.20
        for <linux-acpi@vger.kernel.org>; Wed, 08 Aug 2012 07:06:05 -0700 (PDT)
In-Reply-To: <1343292083-2047-6-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

Hello Rui,

On Thu, Jul 26, 2012 at 11:41 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> Remove tc1/tc2 in generic thermal layer.
> .get_trend() callback starts to take effect from this patch.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

I believe you have to refresh this patch. At least it is not applying
on 3.6-rc1. With minor changes I could check it though.

> ---
>  drivers/acpi/thermal.c                   |    5 +----
>  drivers/platform/x86/acerhdf.c           |    2 +-
>  drivers/platform/x86/intel_mid_thermal.c |    2 +-
>  drivers/thermal/spear_thermal.c          |    2 +-
>  drivers/thermal/thermal_sys.c            |   24 ++++++------------------
>  include/linux/thermal.h                  |    5 +----

Again, simple thing here is that it would be good if you include in
your patch the change on omap-thermal-common.c:
drivers/staging/omap-thermal/omap-thermal-common.c: In function
'omap_thermal_expose_sensor':
drivers/staging/omap-thermal/omap-thermal-common.c:251: error: too
many arguments to function 'thermal_zone_device_register'
make[3]: *** [drivers/staging/omap-thermal/omap-thermal-common.o] Error 1
make[2]: *** [drivers/staging/omap-thermal] Error 2
make[1]: *** [drivers/staging] Error 2
make[1]: *** Waiting for unfinished jobs....

And looks like you missed the psy_register_thermal (power_supply_core.c):

drivers/power/power_supply_core.c: In function 'psy_register_thermal':
drivers/power/power_supply_core.c:204: error: too many arguments to
function 'thermal_zone_device_register'
make[2]: *** [drivers/power/power_supply_core.o] Error 1
make[1]: *** [drivers/power] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....


FYR:
diff --git a/drivers/power/power_supply_core.c
b/drivers/power/power_supply_core.c
index 08cc8a3..2436f13 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -201,7 +201,7 @@ static int psy_register_thermal(struct power_supply *psy)
        for (i = 0; i < psy->num_properties; i++) {
                if (psy->properties[i] == POWER_SUPPLY_PROP_TEMP) {
                        psy->tzd = thermal_zone_device_register(psy->name, 0, 0,
-                                       psy, &psy_tzd_ops, 0, 0, 0, 0);
+                                       psy, &psy_tzd_ops, 0, 0);
                        if (IS_ERR(psy->tzd))
                                return PTR_ERR(psy->tzd);
                        break;
diff --git a/drivers/staging/omap-thermal/omap-thermal-common.c
b/drivers/staging/omap-thermal/omap-thermal-common.c
index c1f00c6..b4cd6cc 100644
--- a/drivers/staging/omap-thermal/omap-thermal-common.c
+++ b/drivers/staging/omap-thermal/omap-thermal-common.c
@@ -248,7 +248,7 @@ int omap_thermal_expose_sensor(struct omap_bandgap
*bg_ptr, int id,
        /* Create thermal zone */
        data->omap_thermal = thermal_zone_device_register(domain,
                                OMAP_TRIP_NUMBER, 0, data, &omap_thermal_ops,
-                               0, FAST_TEMP_MONITORING_RATE, 0, 0);
+                               0, FAST_TEMP_MONITORING_RATE);
        if (IS_ERR_OR_NULL(data->omap_thermal)) {
                dev_err(bg_ptr->dev, "thermal zone device is NULL\n");
                return PTR_ERR(data->omap_thermal);

Apart from the compilation issues and the needed patch refresh, I am
good with the patch. And thanks for pushing this forward.

>  6 files changed, 11 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 0c49e42..0c755d2 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -895,15 +895,12 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
>                 tz->thermal_zone =
>                         thermal_zone_device_register("acpitz", trips, 0, tz,
>                                                      &acpi_thermal_zone_ops,
> -                                                    tz->trips.passive.tc1,
> -                                                    tz->trips.passive.tc2,
>                                                      tz->trips.passive.tsp*100,
>                                                      tz->polling_frequency*100);
>         else
>                 tz->thermal_zone =
>                         thermal_zone_device_register("acpitz", trips, 0, tz,
> -                                                    &acpi_thermal_zone_ops,
> -                                                    0, 0, 0,
> +                                                    &acpi_thermal_zone_ops, 0,
>                                                      tz->polling_frequency*100);
>         if (IS_ERR(tz->thermal_zone))
>                 return -ENODEV;
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index a207466..84c5688 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -662,7 +662,7 @@ static int acerhdf_register_thermal(void)
>                 return -EINVAL;
>
>         thz_dev = thermal_zone_device_register("acerhdf", 1, 0, NULL,
> -                                             &acerhdf_dev_ops, 0, 0, 0,
> +                                             &acerhdf_dev_ops, 0,
>                                               (kernelmode) ? interval*1000 : 0);
>         if (IS_ERR(thz_dev))
>                 return -EINVAL;
> diff --git a/drivers/platform/x86/intel_mid_thermal.c b/drivers/platform/x86/intel_mid_thermal.c
> index 2b2c212..6e309dd 100644
> --- a/drivers/platform/x86/intel_mid_thermal.c
> +++ b/drivers/platform/x86/intel_mid_thermal.c
> @@ -499,7 +499,7 @@ static int mid_thermal_probe(struct platform_device *pdev)
>                         goto err;
>                 }
>                 pinfo->tzd[i] = thermal_zone_device_register(name[i],
> -                               0, 0, td_info, &tzd_ops, 0, 0, 0, 0);
> +                               0, 0, td_info, &tzd_ops, 0, 0);
>                 if (IS_ERR(pinfo->tzd[i])) {
>                         kfree(td_info);
>                         ret = PTR_ERR(pinfo->tzd[i]);
> diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
> index 69a55d4..b55840a 100644
> --- a/drivers/thermal/spear_thermal.c
> +++ b/drivers/thermal/spear_thermal.c
> @@ -148,7 +148,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
>         writel_relaxed(stdev->flags, stdev->thermal_base);
>
>         spear_thermal = thermal_zone_device_register("spear_thermal", 0, 0,
> -                               stdev, &ops, 0, 0, 0, 0);
> +                               stdev, &ops, 0, 0);
>         if (IS_ERR(spear_thermal)) {
>                 dev_err(&pdev->dev, "thermal zone device is NULL\n");
>                 ret = PTR_ERR(spear_thermal);
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 68c93d4..a70ed4c 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -335,9 +335,6 @@ passive_store(struct device *dev, struct device_attribute *attr,
>                 tz->passive_delay = 0;
>         }
>
> -       tz->tc1 = 1;
> -       tz->tc2 = 1;
> -
>         tz->forced_passive = state;
>
>         thermal_zone_device_update(tz);
> @@ -718,13 +715,12 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
>  static void thermal_zone_device_passive(struct thermal_zone_device *tz,
>                                         int temp, int trip_temp, int trip)
>  {
> -       int trend = 0;
> +       enum thermal_trend trend;
>         struct thermal_cooling_device_instance *instance;
>         struct thermal_cooling_device *cdev;
>         long state, max_state;
>
> -       if (!tz->ops->get_trend ||
> -           tz->ops->get_trend(tz, trip, (enum thermal_trend *)&trend)) {
> +       if (!tz->ops->get_trend || tz->ops->get_trend(tz, trip, &trend)) {
>                 /*
>                  * compare the current temperature and previous temperature
>                  * to get the thermal trend, if no special requirement
> @@ -747,11 +743,8 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
>         if (temp >= trip_temp) {
>                 tz->passive = true;
>
> -               trend = (tz->tc1 * (temp - tz->last_temperature)) +
> -                       (tz->tc2 * (temp - trip_temp));
> -
>                 /* Heating up? */
> -               if (trend > 0) {
> +               if (trend == THERMAL_TREND_RAISING) {
>                         list_for_each_entry(instance, &tz->cooling_devices,
>                                             node) {
>                                 if (instance->trip != trip)
> @@ -762,7 +755,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
>                                 if (state++ < max_state)
>                                         cdev->ops->set_cur_state(cdev, state);
>                         }
> -               } else if (trend < 0) { /* Cooling off? */
> +               } else if (trend == THERMAL_TREND_DROPPING) { /* Cooling off? */
>                         list_for_each_entry(instance, &tz->cooling_devices,
>                                             node) {
>                                 if (instance->trip != trip)
> @@ -1288,8 +1281,6 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
>   * @mask:      a bit string indicating the writeablility of trip points
>   * @devdata:   private device data
>   * @ops:       standard thermal zone device callbacks
> - * @tc1:       thermal coefficient 1 for passive calculations
> - * @tc2:       thermal coefficient 2 for passive calculations
>   * @passive_delay: number of milliseconds to wait between polls when
>   *                performing passive cooling
>   * @polling_delay: number of milliseconds to wait between polls when checking
> @@ -1297,13 +1288,12 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
>   *                driven systems)
>   *
>   * thermal_zone_device_unregister() must be called when the device is no
> - * longer needed. The passive cooling formula uses tc1 and tc2 as described in
> - * section 11.1.5.1 of the ACPI specification 3.0.
> + * longer needed. The passive cooling depends on the .get_trend() return value.
>   */
>  struct thermal_zone_device *thermal_zone_device_register(char *type,
>         int trips, int mask, void *devdata,
>         const struct thermal_zone_device_ops *ops,
> -       int tc1, int tc2, int passive_delay, int polling_delay)
> +       int passive_delay, int polling_delay)
>  {
>         struct thermal_zone_device *tz;
>         struct thermal_cooling_device *pos;
> @@ -1339,8 +1329,6 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
>         tz->device.class = &thermal_class;
>         tz->devdata = devdata;
>         tz->trips = trips;
> -       tz->tc1 = tc1;
> -       tz->tc2 = tc2;
>         tz->passive_delay = passive_delay;
>         tz->polling_delay = polling_delay;
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index a01e3e6..d18dcf6 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -115,8 +115,6 @@ struct thermal_zone_device {
>         struct thermal_attr *trip_hyst_attrs;
>         void *devdata;
>         int trips;
> -       int tc1;
> -       int tc2;
>         int passive_delay;
>         int polling_delay;
>         int temperature;
> @@ -163,8 +161,7 @@ enum {
>  #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
>
>  struct thermal_zone_device *thermal_zone_device_register(char *, int, int,
> -               void *, const struct thermal_zone_device_ops *, int tc1,
> -               int tc2, int passive_freq, int polling_freq);
> +               void *, const struct thermal_zone_device_ops *, int, int);
>  void thermal_zone_device_unregister(struct thermal_zone_device *);
>
>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
> --
> 1.7.9.5
>



-- 

Eduardo Valentin
