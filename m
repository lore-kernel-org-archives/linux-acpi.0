From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V4 07/13] Thermal: rename structure
 thermal_cooling_device_instance to thermal_instance
Date: Mon, 20 Aug 2012 18:47:38 +0300
Message-ID: <20120820154738.GH9833@besouro>
References: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
 <1343292083-2047-8-git-send-email-rui.zhang@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:49703 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752846Ab2HTPrq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2012 11:47:46 -0400
Received: by wibhq4 with SMTP id hq4so3381907wib.6
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 08:47:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343292083-2047-8-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Jul 26, 2012 at 04:41:17PM +0800, Zhang Rui wrote:
> This struct is used to describe the behavior for a thermal
> cooling device on a certain trip point for a certain thremal zone.
> 
> thermal_cooling_device_instance is not accurate, as a cooling device
> can be used for more than one trip point in one thermal zone device.
> 
> Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/thermal_sys.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index f3156c1..3d931c8 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -46,7 +46,7 @@ MODULE_LICENSE("GPL");
>   * a certain cooling device on a certain trip point
>   * in a certain thermal zone
>   */
> -struct thermal_cooling_device_instance {
> +struct thermal_instance {
>  	int id;
>  	char name[THERMAL_NAME_LENGTH];
>  	struct thermal_zone_device *tz;
> @@ -430,10 +430,10 @@ static ssize_t
>  thermal_cooling_device_trip_point_show(struct device *dev,
>  				       struct device_attribute *attr, char *buf)
>  {
> -	struct thermal_cooling_device_instance *instance;
> +	struct thermal_instance *instance;
>  
>  	instance =
> -	    container_of(attr, struct thermal_cooling_device_instance, attr);
> +	    container_of(attr, struct thermal_instance, attr);
>  
>  	if (instance->trip == THERMAL_TRIPS_NONE)
>  		return sprintf(buf, "-1\n");
> @@ -716,7 +716,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
>  					int temp, int trip_temp, int trip)
>  {
>  	enum thermal_trend trend;
> -	struct thermal_cooling_device_instance *instance;
> +	struct thermal_instance *instance;
>  	struct thermal_cooling_device *cdev;
>  	long state, max_state;
>  
> @@ -812,8 +812,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  				     struct thermal_cooling_device *cdev,
>  				     unsigned long upper, unsigned long lower)
>  {
> -	struct thermal_cooling_device_instance *dev;
> -	struct thermal_cooling_device_instance *pos;
> +	struct thermal_instance *dev;
> +	struct thermal_instance *pos;
>  	struct thermal_zone_device *pos1;
>  	struct thermal_cooling_device *pos2;
>  	unsigned long max_state;
> @@ -844,7 +844,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  		return -EINVAL;
>  
>  	dev =
> -	    kzalloc(sizeof(struct thermal_cooling_device_instance), GFP_KERNEL);
> +	    kzalloc(sizeof(struct thermal_instance), GFP_KERNEL);
>  	if (!dev)
>  		return -ENOMEM;
>  	dev->tz = tz;
> @@ -909,7 +909,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
>  				       int trip,
>  				       struct thermal_cooling_device *cdev)
>  {
> -	struct thermal_cooling_device_instance *pos, *next;
> +	struct thermal_instance *pos, *next;
>  
>  	mutex_lock(&tz->lock);
>  	list_for_each_entry_safe(pos, next, &tz->cooling_devices, node) {
> @@ -1095,7 +1095,7 @@ EXPORT_SYMBOL(thermal_cooling_device_unregister);
>  static void thermal_zone_trip_update(struct thermal_zone_device *tz,
>  				     int trip, long temp)
>  {
> -	struct thermal_cooling_device_instance *instance;
> +	struct thermal_instance *instance;
>  	struct thermal_cooling_device *cdev = NULL;
>  	unsigned long cur_state, max_state;
>  	long trip_temp;
> -- 
> 1.7.9.5
> 
