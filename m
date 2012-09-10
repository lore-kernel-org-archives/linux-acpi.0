From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCHv3 06/15] Thermal: Add thermal governor registration APIs
Date: Mon, 10 Sep 2012 16:28:08 +0800
Message-ID: <1347265688.1682.1078.camel@rui.sh.intel.com>
References: <1346500296-25200-1-git-send-email-durgadoss.r@intel.com>
	 <1346500296-25200-7-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1496 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374Ab2IJI1S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Sep 2012 04:27:18 -0400
In-Reply-To: <1346500296-25200-7-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, eduardo.valentin@ti.com

On =E5=85=AD, 2012-09-01 at 17:21 +0530, Durgadoss R wrote:
> This patch creates a structure to hold platform
> thermal governor information, and provides APIs
> for individual thermal governors to register/unregister
> with the Thermal framework.
>=20
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |   90 +++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/thermal.h       |   16 ++++++++
>  2 files changed, 106 insertions(+)
>=20
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_=
sys.c
> index a642d1c..541da47 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -49,7 +49,86 @@ static DEFINE_MUTEX(thermal_idr_lock);
> =20
>  static LIST_HEAD(thermal_tz_list);
>  static LIST_HEAD(thermal_cdev_list);
> +static LIST_HEAD(thermal_governor_list);
> +
>  static DEFINE_MUTEX(thermal_list_lock);
> +static DEFINE_MUTEX(thermal_governor_lock);
> +
> +static struct thermal_governor *__find_governor(const char *name)
> +{
> +	struct thermal_governor *pos;
> +
> +	list_for_each_entry(pos, &thermal_governor_list, governor_list)
> +		if (!strnicmp(name, pos->name, THERMAL_NAME_LENGTH))
> +			return pos;
> +
I'm wondering if we should return NULL here or not.
because you are invoking tz->governor->throttle() without any checking.
if there is no matched governor, fall back to the default one instead.

> +	return NULL;
> +}
> +
> +int thermal_register_governor(struct thermal_governor *governor)
> +{
> +	int err;
> +	const char *name;
> +	struct thermal_zone_device *pos;
> +
> +	if (!governor)
> +		return -EINVAL;
> +
> +	mutex_lock(&thermal_governor_lock);
> +
> +	err =3D -EBUSY;
> +	if (__find_governor(governor->name) =3D=3D NULL) {
> +		err =3D 0;
> +		list_add(&governor->governor_list, &thermal_governor_list);
> +	}
> +
> +	mutex_lock(&thermal_list_lock);
> +
> +	list_for_each_entry(pos, &thermal_tz_list, node) {
> +		if (pos->governor)
> +			continue;
> +		if (pos->tzp)
> +			name =3D pos->tzp->governor_name;
> +		else
> +			name =3D DEFAULT_THERMAL_GOVERNOR;
> +		if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH))
> +			pos->governor =3D governor;
> +	}
> +
> +	mutex_unlock(&thermal_list_lock);
> +	mutex_unlock(&thermal_governor_lock);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(thermal_register_governor);
> +
> +void thermal_unregister_governor(struct thermal_governor *governor)
> +{
> +	struct thermal_zone_device *pos;
> +
> +	if (!governor)
> +		return;
> +
> +	mutex_lock(&thermal_governor_lock);
> +
> +	if (__find_governor(governor->name) =3D=3D NULL)
> +		goto exit;
> +
> +	mutex_lock(&thermal_list_lock);
> +
> +	list_for_each_entry(pos, &thermal_tz_list, node) {
> +		if (!strnicmp(pos->governor->name, governor->name,
> +						THERMAL_NAME_LENGTH))
> +			pos->governor =3D NULL;
> +	}
> +
> +	mutex_unlock(&thermal_list_lock);
> +	list_del(&governor->governor_list);
> +exit:
> +	mutex_unlock(&thermal_governor_lock);
> +	return;
> +}
> +EXPORT_SYMBOL_GPL(thermal_unregister_governor);
> =20
>  static int get_idr(struct idr *idr, struct mutex *lock, int *id)
>  {
> @@ -1439,6 +1518,16 @@ struct thermal_zone_device *thermal_zone_devic=
e_register(const char *type,
>  	if (result)
>  		goto unregister;
> =20
> +	/* Update 'this' zone's governor information */
> +	mutex_lock(&thermal_governor_lock);
> +
> +	if (tz->tzp)

what if tzp->governor_name is not set, usually this mean the platform
driver wants to use the default governor.
so the code should be
	 if (tz->tzp && tz->tzp->governor_name[0])

thanks,
rui
> +		tz->governor =3D __find_governor(tz->tzp->governor_name);
> +	else
> +		tz->governor =3D __find_governor(DEFAULT_THERMAL_GOVERNOR);
> +
> +	mutex_unlock(&thermal_governor_lock);
> +
>  	result =3D thermal_add_hwmon_sysfs(tz);
>  	if (result)
>  		goto unregister;
> @@ -1502,6 +1591,7 @@ void thermal_zone_device_unregister(struct ther=
mal_zone_device *tz)
>  	if (tz->ops->get_mode)
>  		device_remove_file(&tz->device, &dev_attr_mode);
>  	remove_trip_attrs(tz);
> +	tz->governor =3D NULL;
> =20
>  	thermal_remove_hwmon_sysfs(tz);
>  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 58cb1c0..6182bd5 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -46,6 +46,9 @@
>  #define THERMAL_GENL_VERSION                    0x01
>  #define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_group"
> =20
> +/* Default Thermal Governor: Does Linear Throttling */
> +#define DEFAULT_THERMAL_GOVERNOR	"step_wise"
> +
>  struct thermal_zone_device;
>  struct thermal_cooling_device;
> =20
> @@ -158,6 +161,7 @@ struct thermal_zone_device {
>  	unsigned int forced_passive;
>  	const struct thermal_zone_device_ops *ops;
>  	const struct thermal_zone_params *tzp;
> +	struct thermal_governor *governor;
>  	struct list_head thermal_instances;
>  	struct idr idr;
>  	struct mutex lock; /* protect thermal_instances list */
> @@ -165,6 +169,14 @@ struct thermal_zone_device {
>  	struct delayed_work poll_queue;
>  };
> =20
> +/* Structure that holds thermal governor information */
> +struct thermal_governor {
> +	char name[THERMAL_NAME_LENGTH];
> +	int (*throttle)(struct thermal_zone_device *tz, int trip);
> +	struct list_head	governor_list;
> +	struct module		*owner;
> +};
> +
>  /* Structure that holds binding parameters for a zone */
>  struct thermal_bind_params {
>  	struct thermal_cooling_device *cdev;
> @@ -189,6 +201,7 @@ struct thermal_bind_params {
> =20
>  /* Structure to define Thermal Zone parameters */
>  struct thermal_zone_params {
> +	char governor_name[THERMAL_NAME_LENGTH];
>  	int num_tbps;	/* Number of tbp entries */
>  	struct thermal_bind_params *tbp;
>  };
> @@ -219,6 +232,9 @@ int get_tz_trend(struct thermal_zone_device *, in=
t);
>  struct thermal_instance *get_thermal_instance(struct thermal_zone_de=
vice *,
>  		struct thermal_cooling_device *, int);
> =20
> +int thermal_register_governor(struct thermal_governor *);
> +void thermal_unregister_governor(struct thermal_governor *);
> +
>  #ifdef CONFIG_NET
>  extern int thermal_generate_netlink_event(u32 orig, enum events even=
t);
>  #else


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
