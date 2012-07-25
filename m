From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RESEND 10/16] Thermal: rename structure thermal_cooling_device_instance to thermal_instance
Date: Wed, 25 Jul 2012 22:32:37 +0200
Message-ID: <201207252232.38116.rjw@sisk.pl>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com> <1343182273-32096-11-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:57149 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801Ab2GYU0y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 16:26:54 -0400
In-Reply-To: <1343182273-32096-11-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, July 25, 2012, Zhang Rui wrote:
> This struct is used to describe the behavior for a thermal
> cooling device on a certain trip point for a certain thremal zone.
> 
> thermal_cooling_device_instance is not accurate, as a cooling device
> can be used for more than one trip point in one thermal zone device.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  drivers/thermal/thermal_sys.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index cc1b192..6f245c8 100644
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
> @@ -731,7 +731,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
>  					int temp, int trip_temp, int trip)
>  {
>  	enum thermal_trend trend;
> -	struct thermal_cooling_device_instance *instance;
> +	struct thermal_instance *instance;
>  	struct thermal_cooling_device *cdev;
>  	long state, max_state;
>  
> @@ -816,8 +816,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
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
> @@ -848,7 +848,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  		return -EINVAL;
>  
>  	dev =
> -	    kzalloc(sizeof(struct thermal_cooling_device_instance), GFP_KERNEL);
> +	    kzalloc(sizeof(struct thermal_instance), GFP_KERNEL);
>  	if (!dev)
>  		return -ENOMEM;
>  	dev->tz = tz;
> @@ -913,7 +913,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
>  				       int trip,
>  				       struct thermal_cooling_device *cdev)
>  {
> -	struct thermal_cooling_device_instance *pos, *next;
> +	struct thermal_instance *pos, *next;
>  
>  	mutex_lock(&tz->lock);
>  	list_for_each_entry_safe(pos, next, &tz->cooling_devices, node) {
> @@ -1099,7 +1099,7 @@ EXPORT_SYMBOL(thermal_cooling_device_unregister);
>  static void thermal_zone_trip_update(struct thermal_zone_device *tz,
>  				     int trip, long temp)
>  {
> -	struct thermal_cooling_device_instance *instance;
> +	struct thermal_instance *instance;
>  	struct thermal_cooling_device *cdev = NULL;
>  	unsigned long cur_state, max_state;
>  	long trip_temp;
> 

